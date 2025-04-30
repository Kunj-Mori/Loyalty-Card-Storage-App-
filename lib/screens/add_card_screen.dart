import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../bloc/loyalty_card_bloc.dart';
import '../models/loyalty_card.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _merchantNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _barcodeController = TextEditingController();
  DateTime? _expiryDate;

  @override
  void dispose() {
    _merchantNameController.dispose();
    _cardNumberController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  Future<void> _scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      if (barcode != '-1') {
        setState(() {
          _barcodeController.text = barcode;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error scanning barcode: $e')),
        );
      }
    }
  }

  Future<void> _selectExpiryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );

    if (picked != null) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final card = LoyaltyCard(
        merchantName: _merchantNameController.text,
        cardNumber: _cardNumberController.text,
        barcode: _barcodeController.text,
        expiryDate: _expiryDate,
      );

      context.read<LoyaltyCardBloc>().add(AddCard(card));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _merchantNameController,
              decoration: const InputDecoration(
                labelText: 'Merchant Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter merchant name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cardNumberController,
              decoration: const InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter card number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _barcodeController,
                    decoration: const InputDecoration(
                      labelText: 'Barcode',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please scan or enter barcode';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: _scanBarcode,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Expiry Date'),
              subtitle: Text(_expiryDate != null
                  ? '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'
                  : 'Not set'),
              trailing: const Icon(Icons.calendar_today),
              onTap: _selectExpiryDate,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Save Card'),
            ),
          ],
        ),
      ),
    );
  }
} 