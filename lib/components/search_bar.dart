import 'package:flutter/cupertino.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSubmitted;

  const SearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: CupertinoDynamicColor.resolve(
          CupertinoColors.secondarySystemBackground,
          context,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.tertiarySystemBackground,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  placeholder: 'Search',
                  prefix: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Icon(CupertinoIcons.search),
                  ),
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                  onSubmitted: onSubmitted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
