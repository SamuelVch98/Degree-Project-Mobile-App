// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
        fields[0] as String,
        fields[1] as String,
        fields[2] as String,
        fields[3] as String,
        fields[4] as double,
        fields[5] as String,
        fields[6] as String,
        fields[7] as String,
        fields[8] as String,
        fields[9] as String,
        fields[10] as String,
        fields[11] as String,
        fields[12] as String);
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.cmd)
      ..writeByte(1)
      ..write(obj.business)
      ..writeByte(2)
      ..write(obj.itemName)
      ..writeByte(3)
      ..write(obj.itemNumber)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.currencyCode)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.firstName)
      ..writeByte(8)
      ..write(obj.lastName)
      ..writeByte(9)
      ..write(obj.customUrl)
      ..writeByte(10)
      ..write(obj.paypalReturn)
      ..writeByte(11)
      ..write(obj.cancelReturnUrl)
      ..writeByte(12)
      ..write(obj.paypalUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJSON(Map<String, dynamic> json) {
  return Transaction(
      json['cmd'] as String,
      json['business'] as String,
      json['item_name'] as String,
      json['item_number'] as String,
      json['amount'] as double,
      json['currency_code'] as String,
      json['email'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['custom'] as String,
      json['return'] as String,
      json['cancel_return'] as String,
      json['paypal_url'] as String);
}

Map<String, dynamic> _$TransactionToJSON(Transaction instance) =>
    <String, dynamic>{
      'cmd': instance.cmd,
      'business': instance.business,
      'item_name': instance.itemName,
      'item_number': instance.itemNumber,
      'amount': instance.amount,
      'currency_code': instance.currencyCode,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'custom': instance.customUrl,
      'return': instance.paypalReturn,
      'cancel_return': instance.cancelReturnUrl,
    };

// *************************************a*************************************
// Own methods
// **************************************************************************

Map<String, dynamic> _$TransactionCreated(int acquirerId) {
  return {
    "params": {"acquirer_id": acquirerId}
  };
}
