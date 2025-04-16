import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form widget needs a key thats why
  final Order _order = Order();
  String? _validateItem(String value) {
    return value.isEmpty ? 'Item required' : null;
  }

  String? _validateQuantity(String value) {
    int? _valueAsInt = value.isEmpty ? 0 : int.tryParse(value);
    return _valueAsInt == 0 ? 'At least one item is required' : null;
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item: ${_order.item} \n Quantity: ${_order.quantity}"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Validation")),
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Coffee',
                        labelText: 'Item',
                      ),
                      validator: (value) => _validateItem(value!),
                      onSaved: (value) => _order.item = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '2',
                        labelText: 'Quantity',
                      ),
                      validator: (value) => _validateQuantity(value!),
                      onSaved:
                          (value) => _order.quantity = int.tryParse(value!),
                    ),
                    Divider(color: Colors.black, height: 60),
                    ElevatedButton(
                      onPressed: _submitOrder,
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ), // holds the landing page for the app(it returns an app)
    );
  }
}

class Order {
  String? item;
  int? quantity;
}
