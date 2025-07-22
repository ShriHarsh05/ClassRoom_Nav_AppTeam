import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LocationSearchDropdown extends StatelessWidget {
  final String label;
  final Function(String) onLocationSelected;
  final List<String> suggestions;
  final String? initialValue;

  const LocationSearchDropdown({
    Key? key,
    required this.label,
    required this.onLocationSelected,
    required this.suggestions,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      // Set initial text in the text field
      controller: TextEditingController(text: initialValue),
      builder: (context, controller, focusNode) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
          ),
        );
      },
      suggestionsCallback: (pattern) {
        if (pattern.isEmpty) {
          return <
            String
          >[]; // <--- CHANGE: Return an empty List instead of Iterable.empty()
        }
        // Convert the Iterable returned by .where() to a List using .toList()
        return suggestions
            .where(
              (location) =>
                  location.toLowerCase().contains(pattern.toLowerCase()),
            )
            .toList(); // <--- CHANGE: Add .toList() here
      },
      itemBuilder: (context, suggestion) {
        return ListTile(title: Text(suggestion));
      },
      onSelected: (suggestion) {
        onLocationSelected(suggestion);
      },
      emptyBuilder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'No matching locations found',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
      decorationBuilder: (context, child) {
        return Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8.0),
          child: child,
        );
      },
    );
  }
}
