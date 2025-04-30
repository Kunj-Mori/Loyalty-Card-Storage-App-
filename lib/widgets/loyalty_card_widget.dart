import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/loyalty_card.dart';

class LoyaltyCardWidget extends StatelessWidget {
  final LoyaltyCard card;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const LoyaltyCardWidget({
    Key? key,
    required this.card,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      card.merchantName,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: onDelete,
                      color: Colors.red,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Card Number: ${card.cardNumber}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              if (card.expiryDate != null) ...[
                Text(
                  'Expires: ${_formatDate(card.expiryDate!)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
              ],
              Center(
                child: card.barcode.startsWith('http')
                    ? QrImageView(
                        data: card.barcode,
                        version: QrVersions.auto,
                        size: 150.0,
                      )
                    : Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          card.barcode,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // TODO: Implement actual barcode generation
  Uint8List _generateBarcode(String data) {
    // This is a placeholder. You'll need to implement actual barcode generation
    // using a barcode generation library
    return Uint8List(0);
  }
} 