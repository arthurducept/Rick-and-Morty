import 'package:flutter/cupertino.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(8.0),
              ),
              placeholder: 'Search',
              prefix: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(CupertinoIcons.search),
              ),
              clearButtonMode: OverlayVisibilityMode.editing,
              autocorrect: false,
            ),
          ),
        ],
      ),
    );
  }
}
