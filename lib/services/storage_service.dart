import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/loyalty_card.dart';

class StorageService {
  static const String _cardsBoxName = 'loyalty_cards';
  late Box<LoyaltyCard> _cardsBox;
  static bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) {
      return;
    }

    try {
      await Hive.initFlutter();
      
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(LoyaltyCardAdapter());
      }
      
      _cardsBox = await Hive.openBox<LoyaltyCard>(_cardsBoxName);
      _isInitialized = true;
    } catch (e) {
      print('Error initializing Hive: $e');
      rethrow;
    }
  }

  Future<void> addCard(LoyaltyCard card) async {
    await _cardsBox.put(card.id, card);
  }

  Future<void> updateCard(LoyaltyCard card) async {
    await _cardsBox.put(card.id, card);
  }

  Future<void> deleteCard(String id) async {
    await _cardsBox.delete(id);
  }

  List<LoyaltyCard> getAllCards() {
    return _cardsBox.values.toList();
  }

  LoyaltyCard? getCard(String id) {
    return _cardsBox.get(id);
  }

  Stream<List<LoyaltyCard>> watchCards() {
    return _cardsBox.watch().map((_) => getAllCards());
  }

  Future<void> clearAll() async {
    await _cardsBox.clear();
  }
} 