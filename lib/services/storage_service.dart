import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/loyalty_card.dart';

class StorageService {
  static const String _cardsBoxName = 'loyalty_cards';
  late Box<LoyaltyCard> _cardsBox;

  Future<void> init() async {
    try {
      await Hive.initFlutter();
      
      if (!Hive.isAdapterRegistered(0)) {  // Check if adapter is already registered
        Hive.registerAdapter(LoyaltyCardAdapter());
      }
      
      _cardsBox = await Hive.openBox<LoyaltyCard>(_cardsBoxName);
    } catch (e) {
      print('Error initializing Hive: $e');
      rethrow;  // Rethrow to handle in main
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