import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/loyalty_card.dart';
import '../services/storage_service.dart';

// Events
abstract class LoyaltyCardEvent {}

class LoadCards extends LoyaltyCardEvent {}

class AddCard extends LoyaltyCardEvent {
  final LoyaltyCard card;
  AddCard(this.card);
}

class UpdateCard extends LoyaltyCardEvent {
  final LoyaltyCard card;
  UpdateCard(this.card);
}

class DeleteCard extends LoyaltyCardEvent {
  final String cardId;
  DeleteCard(this.cardId);
}

// States
abstract class LoyaltyCardState {}

class LoyaltyCardInitial extends LoyaltyCardState {}

class LoyaltyCardLoading extends LoyaltyCardState {}

class LoyaltyCardLoaded extends LoyaltyCardState {
  final List<LoyaltyCard> cards;
  LoyaltyCardLoaded(this.cards);
}

class LoyaltyCardError extends LoyaltyCardState {
  final String message;
  LoyaltyCardError(this.message);
}

// BLoC
class LoyaltyCardBloc extends Bloc<LoyaltyCardEvent, LoyaltyCardState> {
  final StorageService _storageService;

  LoyaltyCardBloc(this._storageService) : super(LoyaltyCardInitial()) {
    on<LoadCards>(_onLoadCards);
    on<AddCard>(_onAddCard);
    on<UpdateCard>(_onUpdateCard);
    on<DeleteCard>(_onDeleteCard);
  }

  Future<void> _onLoadCards(LoadCards event, Emitter<LoyaltyCardState> emit) async {
    emit(LoyaltyCardLoading());
    try {
      final cards = _storageService.getAllCards();
      emit(LoyaltyCardLoaded(cards));
    } catch (e) {
      emit(LoyaltyCardError('Failed to load cards: ${e.toString()}'));
    }
  }

  Future<void> _onAddCard(AddCard event, Emitter<LoyaltyCardState> emit) async {
    emit(LoyaltyCardLoading());
    try {
      await _storageService.addCard(event.card);
      final cards = _storageService.getAllCards();
      emit(LoyaltyCardLoaded(cards));
    } catch (e) {
      emit(LoyaltyCardError('Failed to add card: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateCard(UpdateCard event, Emitter<LoyaltyCardState> emit) async {
    emit(LoyaltyCardLoading());
    try {
      await _storageService.updateCard(event.card);
      final cards = _storageService.getAllCards();
      emit(LoyaltyCardLoaded(cards));
    } catch (e) {
      emit(LoyaltyCardError('Failed to update card: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteCard(DeleteCard event, Emitter<LoyaltyCardState> emit) async {
    emit(LoyaltyCardLoading());
    try {
      await _storageService.deleteCard(event.cardId);
      final cards = _storageService.getAllCards();
      emit(LoyaltyCardLoaded(cards));
    } catch (e) {
      emit(LoyaltyCardError('Failed to delete card: ${e.toString()}'));
    }
  }
} 