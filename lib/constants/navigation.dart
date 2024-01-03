import 'package:flutter/material.dart';


navigateToRoute(BuildContext context, dynamic routeClass) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => routeClass));
}


void navigateAndReplaceRoute(BuildContext? context, dynamic routeClass) {
  Navigator.pushReplacement(context!, MaterialPageRoute(builder: (context) => routeClass));
}

void navigateAndRemoveUntilRoute(BuildContext? context, dynamic routeClass) {
  Navigator.pushAndRemoveUntil(
      context!,
      MaterialPageRoute(builder: (context) => routeClass), (route) => false);
}

// goBackHome(BuildContext context) {
//   Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => const DashBoardView()),
//           (route) => false);
// }

goBack(BuildContext context, String val) {
  Navigator.of(context).pop(val);
}

