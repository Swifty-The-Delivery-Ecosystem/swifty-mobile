// location_modal.dart

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
          enabled: selectedLocation != 'BH1',
        ),
        ListTile(
          title: Text('BH2'),
          onTap: () => onLocationSelected('BH2'),
          enabled: selectedLocation != 'BH2',
        ),
        ListTile(
          title: Text('GH1'),
          onTap: () => onLocationSelected('GH1'),
          enabled: selectedLocation != 'GH1',
        ),
        ListTile(
          title: Text('GH2'),
          onTap: () => onLocationSelected('GH2'),
          enabled: selectedLocation != 'GH2',
        ),
        // Add more options as needed
      ],
    );
  }
}

int getLocationId(String locationName) {
  switch (locationName) {
    case 'BH1':
      return 1;
    case 'BH2':
      return 2;
    case 'GH1':
      return 3;
    case 'GH2':
      return 4;
    default:
      return 1; // Default to BH1 if the location name is not recognized
  }
}
