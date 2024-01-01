import 'package:flutter/material.dart';

class LocationModal extends StatelessWidget {
  final Function(String) onLocationSelected;
  final String selectedLocation;

  const LocationModal({
    Key? key,
    required this.onLocationSelected,
    required this.selectedLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text('BH1'),
          onTap: () => onLocationSelected('BH1'),
          enabled: selectedLocation != 'BH1', // Disable if already selected
        ),
        ListTile(
          title: Text('BH2'),
          onTap: () => onLocationSelected('BH2'),
          enabled: selectedLocation != 'BH2', // Disable if already selected
        ),
        ListTile(
          title: Text('GH1'),
          onTap: () => onLocationSelected('GH1'),
          enabled: selectedLocation != 'GH1', // Disable if already selected
        ),
        // Add more options as needed
      ],
    );
  }
}
