import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController _searchController;
  final ValueChanged<String> _onSearchChanged;
  final ValueListenable isSearchEmpty;
  const SearchTextField({
    super.key,
    required TextEditingController searchController,
    required ValueChanged<String> onSearchChanged,
    required this.isSearchEmpty,
  })  : _searchController = searchController,
        _onSearchChanged = onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: _searchController,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.blue.shade400,
        ),
        suffixIcon: ValueListenableBuilder(
          valueListenable: isSearchEmpty,
          builder: (context, value, child) {
            return !value
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.blue.shade400,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  )
                : const SizedBox.shrink();
          },
        ),
        hintText: 'Search for stocks...',
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(.8),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.blue.shade100, width: 1.0),
        ),
      ),
      onChanged: _onSearchChanged,
      style: const TextStyle(fontSize: 16.0),
      cursorColor: Colors.blue.shade400,
    );
  }
}
