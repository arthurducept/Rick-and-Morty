import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'chip_list.dart';

class FiltersModal extends StatefulWidget {
  final String selectedStatus;

  final String selectedGender;

  final String selectedSpecies;
  final Function(String, String, String)? onSaved;

  const FiltersModal({
    super.key,
    this.selectedStatus = "",
    this.selectedGender = "",
    this.selectedSpecies = "",
    this.onSaved,
  });

  @override
  State<FiltersModal> createState() => _FiltersModalState();
}

class _FiltersModalState extends State<FiltersModal> {
  late String _selectedStatus;

  late String _selectedGender;

  late String _selectedSpecies;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
    _selectedGender = widget.selectedGender;
    _selectedSpecies = widget.selectedSpecies;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Filtres',
              style: TextStyle(
                  color: CupertinoDynamicColor.resolve(
                      CupertinoColors.label, context),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Sélectionnez les filtres à appliquer',
              style: TextStyle(
                  color: CupertinoDynamicColor.resolve(
                      CupertinoColors.secondaryLabel, context),
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            ChipList(
              title: 'Statut',
              labels: const ['Vivant', 'Mort', 'Inconnu'],
              selected: _selectedStatus,
              onTap: (label) => setState(() {
                if (_selectedStatus == label) {
                  _selectedStatus = '';
                } else {
                  _selectedStatus = label;
                }
              }),
            ),
            ChipList(
                title: 'Genre',
                labels: const ['Homme', 'Femme', 'Sans genre', 'Inconnu'],
                selected: _selectedGender,
                onTap: (label) => setState(() {
                      if (_selectedGender == label) {
                        _selectedGender = '';
                      } else {
                        _selectedGender = label;
                      }
                    })),
            ChipList(
                title: 'Espèce',
                labels: const ['Humain', 'Alien'],
                selected: _selectedSpecies,
                onTap: (label) => setState(() {
                      if (_selectedSpecies == label) {
                        _selectedSpecies = '';
                      } else {
                        _selectedSpecies = label;
                      }
                    })),
            Container(
              margin: const EdgeInsets.only(top: 24),
              alignment: Alignment.center,
              child: CupertinoButton.filled(
                  child: Text('Enregistrer',
                      style: TextStyle(
                          color: CupertinoDynamicColor.resolve(
                              CupertinoColors.white, context))),
                  onPressed: () {
                    if (dotenv.get('FLUTTER_APP_DEBUG') == 'true') {
                      debugPrint('Enregistrer button pressed');
                    }
                    widget.onSaved?.call(
                        _selectedStatus, _selectedGender, _selectedSpecies);
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
