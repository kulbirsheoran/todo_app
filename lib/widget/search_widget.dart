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
      widget.onChange('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: _searchController,style: const TextStyle(fontSize: 18 ),
        onChanged: (value) {
          widget.onChange(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
          const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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

        ),
      ),
    );
  }
}
