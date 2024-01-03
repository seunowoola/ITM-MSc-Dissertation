import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';



class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.title, this.onTap, this.subtitle}) : super(key: key);

  final String title;
  final Function () ? onTap;
  final String ? subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: Colors.white70.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600,
                      color: Colors.grey, fontSize: 16),),

                  const SizedBox(height: 2,),

                  Text(subtitle!, style: const TextStyle(fontWeight: FontWeight.w400,
                    color: Colors.grey, fontSize: 10,)),
                ],
              ),

             GestureDetector(
                  onTap: onTap,
                  child: const Icon(Icons.edit, color: buttonColors, size: 20,),
              ),

            ],
          ),),
      ),
    );
  }
}
