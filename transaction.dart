import 'package:be_detectives/utils/datas_strings.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  String cmd;

  @HiveField(1)
  String business;

  @HiveField(2)
  String itemName;

  @HiveField(3)
  String itemNumber;

  @HiveField(4)
  double amount;

  @HiveField(5)
  String currencyCode;

  @HiveField(6)
  String email;

  @HiveField(7)
  String firstName;

  @HiveField(8)
  String lastName;

  @HiveField(9)
  String customUrl;

  @HiveField(10)
  String paypalReturn;

  @HiveField(11)
  String cancelReturnUrl;

  @HiveField(12)
  String paypalUrl;

  Transaction(
      [this.cmd,
      this.business,
      this.itemName,
      this.itemNumber,
      this.amount,
      this.currencyCode,
      this.email,
      this.firstName,
      this.lastName,
      this.customUrl,
      this.paypalReturn,
      this.cancelReturnUrl,
      this.paypalUrl]);

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJSON(json);

  static Map<String, dynamic> getTransactionCreated(int acquirerId) =>
      _$TransactionCreated(acquirerId);

  static Map<String, dynamic> toJson(Transaction transaction) =>
      _$TransactionToJSON(transaction);
  @override
  String toString() {
    return 'command : $cmd\n'
        'business email: $business\n'
        'item name: $itemName\n'
        'item number: $itemNumber\n'
        'amount: $amount\n'
        'currency code: $currencyCode\n'
        'email: $email\n'
        'first name: $firstName\n'
        'last name: $lastName\n'
        'custom url: $customUrl\n'
        'paypal return: $paypalReturn\n'
        'cancel url: $cancelReturnUrl\n'
        'paypal url: $paypalUrl\n';
  }
}
