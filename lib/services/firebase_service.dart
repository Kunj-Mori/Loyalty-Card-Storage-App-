import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/loyalty_card.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Authentication methods
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createUserWithEmailAndPassword(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Basic Database operations
  Future<void> saveCard(LoyaltyCard card) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cards')
        .doc(card.id)
        .set(card.toJson());
  }

  Future<void> deleteCard(String cardId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cards')
        .doc(cardId)
        .delete();
  }

  Future<List<LoyaltyCard>> getAllCards() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('cards')
        .get();

    return snapshot.docs
        .map((doc) => LoyaltyCard.fromJson(doc.data()))
        .toList();
  }

  // Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null;
  
  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;
} 