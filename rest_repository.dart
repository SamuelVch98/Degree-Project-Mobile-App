import 'package:async/async.dart';
import 'package:be_detectives/data/api/api_exception.dart';
import 'package:be_detectives/data/api/http_client.dart';
import 'package:be_detectives/data/api/repository_exception.dart';
import 'package:be_detectives/data/models/question.dart';
import 'package:be_detectives/data/models/statistic.dart';
import 'package:be_detectives/data/models/transaction.dart';
import 'package:be_detectives/domain/repository/repository.dart';
import 'package:be_detectives/data/models/user.dart';
import 'package:be_detectives/data/models/character.dart';
import 'package:be_detectives/data/models/clue.dart';
import 'package:be_detectives/data/models/map.dart';
import 'package:be_detectives/data/models/scenario.dart';
import 'package:flutter/material.dart';

class _Urls {
  // 192.168.50.29
  // 10.10.0.30
  // 10.0.2.2:8069
  static const baseUrl = 'http://10.0.2.2:8069/web/';
  static const login = "${baseUrl}session/authenticate";
  static const register = "${baseUrl}mobile_signup";
  static const search = "${baseUrl}dataset/search_read";

  /* Développé par Samuel
  static const transaction = "${baseUrl}payment/";
  */
}

class RestRepository extends Repository {
  final HttpClient _httpClient = HttpClient();

  // Generic method to transform a json object into the T type wanted
  Result<List<T>> _transformListObject<T>(dynamic listJson) {
    if (listJson.isNotEmpty) {
      return Result.value((listJson as List)
          .map((itemJson) => _fromJson<T>(itemJson as Map<String, dynamic>))
          .toList());
    } else {
      return Result.error("listJson is empty.");
    }
  }

  // Call the fromJson method of the T type
  static T _fromJson<T>(dynamic json) {
    if (T == Scenario) return Scenario.fromJson(json) as T;
    if (T == Character) return Character.fromJson(json) as T;
    if (T == Clue) return Clue.fromJson(json) as T;
    if (T == MapScenario) return MapScenario.fromJson(json) as T;
    if (T == Question) return Question.fromJson(json) as T;
    if (T == Transaction) return Transaction.fromJson(json) as T;
    if (T == User)
      return User.fromJson(json) as T;
    else
      throw Exception("Unknown class");
  }

/* Développé par Samuel
  @override
  Future<Transaction> getTransactionCreated(int orderId, int acquirerId) async {
    try {
      String completeRequest = _Urls.transaction + "$orderId";
      print(completeRequest);
      final transactionJSON = await _httpClient.postRequest(
          _Urls.transaction + "$orderId",
          Transaction.getTransactionCreated(acquirerId));
      print(transactionJSON['url']);
      Transaction createdTransaction = Transaction.fromJson(transactionJSON);
      print(createdTransaction);
      return createdTransaction;
    } on ConnectionException {
      return null;
    }
  }

  Future<String> getPaypalHttp(Transaction transaction) async {
    try {
      Map<String, dynamic> formData = Transaction.toJson(transaction);
      print(formData);
      print(transaction.paypalUrl);
      final httpResponse = await _httpClient.getRequestFormData(
          transaction.paypalUrl, Transaction.toJson(transaction));
      print(httpResponse);
      return httpResponse;
    } on ConnectionException {
      return null;
    }
  }
*/
  @override
  Future<Result<User>> login(User user) async {
    try {
      final Map<String, dynamic> response =
          await _httpClient.postRequest(_Urls.login, user.signIn(user));
      // If incorrect login form, response is null
      // Return an empty User to differenciate from exception's error
      if (response == null) return Result.value(User());
      // If correct login form, search for the user with the provided uid
      final List userLoggedIn = await _httpClient.postRequest(
          _Urls.search, User.getUserLoggedIn(response["partner_id"]));
      return Result.value(
          _transformListObject<User>(userLoggedIn).asValue.value.first);
    } on ConnectionException {
      // Return null if no internet connection available
      return null;
    }
  }

  @override
  Future<bool> register(User user) async {
    try {
      print(user.register(user));
      final Map<String, dynamic> response =
          await _httpClient.postRequest(_Urls.register, user.register(user));
      return Future<bool>.value(response["success"]);
    } on ConnectionException {
      return Future<bool>.value(false);
    }
  }

  @override
  Future<Result<List<Scenario>>> getAllScenarios(int partnerId,
      {List<int> alreadyStoredScenariosId}) async {
    try {
      List<Scenario> scenariosList = [];
      // If alreadyStoredScenariosId exists, we don't need to check wether the player possess scenarii
      // Since they're downloaded as soon as they're bought
      if (alreadyStoredScenariosId == null) {
        var temp;
        final List<dynamic> scenarioIdsListJson = (await _httpClient
                .postRequest(_Urls.search, User.getUserScenarios(partnerId)))[0]
            ["scenario_ids"];
        // Can't cast List<dynamic> as List<int> otherwise
        alreadyStoredScenariosId =
            scenarioIdsListJson.map((id) => id as int).toList();

        if (scenarioIdsListJson.isNotEmpty) {
          final scenariosListJson = await _httpClient.postRequest(
              _Urls.search,
              Scenario.fullyLoadScenarios(
                  scenariosId: alreadyStoredScenariosId));
          temp = _transformListObject<Scenario>(scenariosListJson);
        }
        // temp is not null if the player bought scenarii
        if (temp != null) scenariosList = temp.asValue.value;
      }
      final scenariosListJson = await _httpClient.postRequest(
          _Urls.search,
          Scenario.loadScenarios(
              scenariosIdToIgnore: alreadyStoredScenariosId));
      scenariosList.addAll(
          _transformListObject<Scenario>(scenariosListJson).asValue.value);

      if (scenariosList != null && scenariosList.length < 3)
        throw NotEnoughScenariiException();
      return Result.value(scenariosList);
    } on ConnectionException {
      return null;
    }
  }

  @override
  Future<Result<List<Character>>> getCharactersFromScenario(
      int scenarioId) async {
    try {
      final charactersListJson = await _httpClient.postRequest(
          _Urls.search, Character.loadCharacters(scenarioId));
      return _transformListObject<Character>(charactersListJson);
    } on ConnectionException {
      return null;
    }
  }

  @override
  Future<Result<List<Clue>>> getCluesFromScenario(int scenarioId) async {
    try {
      final cluesListJson = await _httpClient.postRequest(
          _Urls.search, Clue.loadClues(scenarioId));
      return _transformListObject<Clue>(cluesListJson);
    } on ConnectionException {
      return null;
    }
  }

  @override
  Future<Result<MapScenario>> getMapFromScenario(int scenarioId) async {
    try {
      final mapScenariosListJson = await _httpClient.postRequest(
          _Urls.search, MapScenario.loadMap(scenarioId));
      return Result.value(
          _transformListObject<MapScenario>(mapScenariosListJson)
              .asValue
              .value
              .first);
    } on ConnectionException {
      return null;
    }
  }

  @override
  Future<Result<List<Question>>> getQuestionsFromScenario(
      int scenarioId) async {
    try {
      final questionsListJson = await _httpClient.postRequest(
          _Urls.search, Question.loadQuestions(scenarioId));
      return _transformListObject<Question>(questionsListJson);
    } on ConnectionException {
      return null;
    }
  }

  @override
  Future<bool> addScenarioStatisticForUser(
      Statistic stat, int scenarioId, int userId) {
    // TODO: implement addScenarioStatisticForUser
    throw UnimplementedError();
  }
}
