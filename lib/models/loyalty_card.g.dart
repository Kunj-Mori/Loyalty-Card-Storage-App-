// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_card.dart';

class LoyaltyCardAdapter extends TypeAdapter<LoyaltyCard> {
  @override
  final int typeId = 0;

  @override
  LoyaltyCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoyaltyCard(
      id: fields[0] as String,
      merchantName: fields[1] as String,
      cardNumber: fields[2] as String,
      barcode: fields[3] as String,
      createdAt: fields[4] as DateTime,
      expiryDate: fields[5] as DateTime?,
      isActive: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LoyaltyCard obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.merchantName)
      ..writeByte(2)
      ..write(obj.cardNumber)
      ..writeByte(3)
      ..write(obj.barcode)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.expiryDate)
      ..writeByte(6)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoyaltyCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
} 