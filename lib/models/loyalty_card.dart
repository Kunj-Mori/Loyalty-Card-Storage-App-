import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'loyalty_card.g.dart';

@HiveType(typeId: 0)
class LoyaltyCard extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String merchantName;

  @HiveField(2)
  final String cardNumber;

  @HiveField(3)
  final String barcode;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? expiryDate;

  @HiveField(6)
  final bool isActive;

  LoyaltyCard({
    String? id,
    required this.merchantName,
    required this.cardNumber,
    required this.barcode,
    DateTime? createdAt,
    this.expiryDate,
    this.isActive = true,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  factory LoyaltyCard.fromJson(Map<String, dynamic> json) {
    return LoyaltyCard(
      id: json['id'],
      merchantName: json['merchantName'],
      cardNumber: json['cardNumber'],
      barcode: json['barcode'],
      createdAt: DateTime.parse(json['createdAt']),
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchantName': merchantName,
      'cardNumber': cardNumber,
      'barcode': barcode,
      'createdAt': createdAt.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'isActive': isActive,
    };
  }

  LoyaltyCard copyWith({
    String? merchantName,
    String? cardNumber,
    String? barcode,
    DateTime? expiryDate,
    bool? isActive,
  }) {
    return LoyaltyCard(
      id: id,
      merchantName: merchantName ?? this.merchantName,
      cardNumber: cardNumber ?? this.cardNumber,
      barcode: barcode ?? this.barcode,
      createdAt: createdAt,
      expiryDate: expiryDate ?? this.expiryDate,
      isActive: isActive ?? this.isActive,
    );
  }
} 