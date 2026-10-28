import 'dart:io';

import 'package:async/async.dart';
import 'package:be_detectives/data/models/question.dart';
import 'package:be_detectives/data/models/statistic.dart';
import 'package:be_detectives/data/models/user.dart';
import 'package:be_detectives/data/models/character.dart';
import 'package:be_detectives/data/models/clue.dart';
import 'package:be_detectives/data/models/map.dart';
import 'package:be_detectives/data/models/scenario.dart';
import 'package:be_detectives/data/models/transaction.dart';
import 'package:flutter/material.dart';

abstract class Repository {
  Future<Result<User>> login(User user);
  Future<bool> register(User user);
  Future<Result<List<Scenario>>> getAllScenarios(int partnerId,
      {List<int> alreadyStoredScenariosId});
  Future<Result<List<Character>>> getCharactersFromScenario(int scenarioId);
  Future<Result<List<Clue>>> getCluesFromScenario(int scenarioId);
  Future<Result<MapScenario>> getMapFromScenario(int scenarioId);
  Future<Result<List<Question>>> getQuestionsFromScenario(int scenarioId);
  Future<bool> addScenarioStatisticForUser(
      Statistic stat, int scenarioId, int userId);

/* Développé par Samuel
  Future<Transaction> getTransactionCreated(int orderId, int acquirerId);
  Future<String> getPaypalHttp(Transaction transaction);
*/
}
