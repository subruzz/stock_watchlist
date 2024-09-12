
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watchlist/model/stock_model.dart';
import 'package:stock_watchlist/views/widgets/common_widgets/dialog.dart';
import 'package:stock_watchlist/views/widgets/common_widgets/messenger.dart';
import '../../../cubit/watchlist/watchlist_cubit.dart';
import '../../../cubit/watchlist/watchlist_state.dart';

class AddToWatchlistButton extends StatelessWidget {
  const AddToWatchlistButton({super.key, required this.stock});

  final StockModel stock;

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistCubit, WatchlistState>(
      listener: (context, state) {
        if (state is WatchlistActionSuccess) {
          Messenger.showSnackBar(message: state.message);
        } else if (state is WatchlistError) {
          Messenger.showSnackBar(message: state.message, );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.blue, size: 24),
          onPressed: () {
            showCustomDialog(
              context,
              'Add to Watchlist',
              'Add',
              'Do you want to add this to your watchlist?',
              () => context.read<WatchlistCubit>().addToWatchlist(stock),
            );
          },
          tooltip: 'Add to Watchlist',
        ),
      ),
    );
  }
}