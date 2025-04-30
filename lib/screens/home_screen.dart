import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/loyalty_card_bloc.dart';
import '../models/loyalty_card.dart';
import '../widgets/loyalty_card_widget.dart';
import 'add_card_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Loyalty Cards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sorting options
            },
          ),
        ],
      ),
      body: BlocBuilder<LoyaltyCardBloc, LoyaltyCardState>(
        builder: (context, state) {
          if (state is LoyaltyCardInitial) {
            context.read<LoyaltyCardBloc>().add(LoadCards());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoyaltyCardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoyaltyCardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LoyaltyCardBloc>().add(LoadCards());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is LoyaltyCardLoaded) {
            if (state.cards.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.credit_card_outlined, size: 48),
                    const SizedBox(height: 16),
                    const Text('No loyalty cards yet'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCardScreen(),
                          ),
                        );
                      },
                      child: const Text('Add Your First Card'),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<LoyaltyCardBloc>().add(LoadCards());
              },
              child: ListView.builder(
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  final card = state.cards[index];
                  return LoyaltyCardWidget(
                    card: card,
                    onTap: () {
                      // TODO: Navigate to card details screen
                    },
                    onDelete: () {
                      _showDeleteConfirmation(context, card);
                    },
                  );
                },
              ),
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCardScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, LoyaltyCard card) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Card'),
        content: Text('Are you sure you want to delete the ${card.merchantName} card?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<LoyaltyCardBloc>().add(DeleteCard(card.id));
    }
  }
} 