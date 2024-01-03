import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.title, required this.color, this.onTap});

  final String title;
  final Color color;
  final Function () ? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
