import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration(String label)
      : super(
            labelText: label,
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            filled: true,
            isCollapsed: true,
            fillColor: Colors.white,
            hoverColor: const Color(0xFFF3F3F8),
            labelStyle: const TextStyle(color: Color(0xFF0C131F), fontSize: 15),
            floatingLabelStyle: const TextStyle(color: Color(0xFF0C131F), fontSize: 16),
            helperStyle: const TextStyle(color: Color(0xFF0C131F)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.orange, width: 1),
            ));
}
