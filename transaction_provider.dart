import 'dart:convert';
import 'dart:io';

import 'package:be_detectives/data/api/rest_repository.dart';
import 'package:be_detectives/data/models/transaction.dart';
import 'package:be_detectives/domain/repository/repository.dart';
import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  final Repository _repository = RestRepository();
  Transaction transaction;
  String html;

  Future<Transaction> createTransactionFromOrder(
      int orderId, int acquirerId) async {
    transaction =
        (await _repository.getTransactionCreated(orderId, acquirerId));
    return transaction;
  }

  Future<String> getHTMLToDisplayPaypalPage(Transaction transaction) async {
    html = await _repository.getPaypalHttp(transaction);
    return html;
  }
}
