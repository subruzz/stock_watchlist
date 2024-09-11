import 'package:flutter/material.dart';
import 'package:stock_watchlist/utils/constants/ui_const.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController _searchController;
  final ValueChanged<String> _onSearchChanged;

  const SearchTextField({
    super.key,
    required TextEditingController searchController,
    required ValueChanged<String> onSearchChanged,
  })  : _searchController = searchController,
        _onSearchChanged = onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        prefixIcon: const Icon(
          Icons.search,
          color: kGreyColor,
        ),
        hintText: 'Search for stocks...',
        hintStyle: const TextStyle(
          color: kGreyColor,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: kGreyColor.withOpacity(.2),
      ),
      onChanged: _onSearchChanged,
    );
  }
}
