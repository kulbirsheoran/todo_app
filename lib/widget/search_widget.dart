import 'package:flutter/material.dart';
import 'package:todo_app/constant/color_const.dart';
import 'package:todo_app/constant/string_constants.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) onChange;

  const SearchWidget(this.onChange,{Key? key}) : super(key: key);
  
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _searchController.text.isNotEmpty;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _showClearButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          widget.onChange(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            color: tdBlack,
          ),
          suffixIcon: _showClearButton
              ? IconButton(
            icon: const Icon(
              Icons.clear,
              color: tdBlack,
            ),
            onPressed: _clearSearch,
          )
              : null,
          hintText: StringConstant.searchHintTextHomePage,
          fillColor: tdBlack,
        ),
      ),
    );
  }
}