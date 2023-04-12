import 'package:flutter/material.dart';
import 'package:sport_house/ui/theme/app_colors.dart';

class HomeScreenSearchBox extends StatelessWidget {
  final VoidCallback onSearchTap;
  final Function(String?)? onTextChange;
  final TextEditingController? controller;

  const HomeScreenSearchBox({
    Key? key,
    required this.onSearchTap,
    this.controller,
    this.onTextChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppColors.white400),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onTextChange,
              readOnly: false,
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
                contentPadding: const EdgeInsets.all(10.0),
                fillColor: AppColors.white400,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: InkWell(
              onTap: onSearchTap,
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0), color: Colors.blue.shade600),
                child: const Center(child: Icon(Icons.search_outlined, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
