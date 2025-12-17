import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {

  // Default settings
  static const defautName = "New grocery";
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();
  }

  @override
  void dispose() {
    
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    // Will be implemented later - Reset all fields to the initial values
    setState(() {
      _nameController.text = defautName;
      _quantityController.text = defaultQuantity.toString();
      _selectedCategory = defaultCategory;
    });
  }

  void onAdd() {
    // Will be implemented later - Create and return the new grocery
    if(_nameController.text.trim().isEmpty && int.tryParse(_quantityController.text)! <= 0 && int.tryParse(_quantityController.text) == null) {
      return;
    }
    Navigator.of(context).pop(Grocery(
      id: DateTime.now().toString(),
      name: _nameController.text,
      quantity: int.parse(_quantityController.text),
      category: _selectedCategory,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Name')),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(label: Text('Quantity')),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<GroceryCategory>(
                    initialValue: _selectedCategory,
                    items: [...GroceryCategory.values.map((cat) => DropdownMenuItem(
                      value: cat,
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: cat.color,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(cat.label),
                        ],
                        ),
                      ))],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onReset, child: const Text('Reset')),
                ElevatedButton(
                  onPressed: onAdd,
                  child: const Text('Add Item'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}