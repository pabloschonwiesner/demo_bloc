import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> alert(BuildContext context, { String title = '', String message = ''}) async {
    await showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          content: Text(message, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),                
              ),
              child: const Text('OK'),
              onPressed: () => Navigator.pop<bool>(context, false), 
            ),
          ]
        );
      }
    );
  }

  static Future<bool> confirm(BuildContext context, {String title = '', String message = ''} ) async {
    final response = await showDialog(
      context: context, 
      builder: ( context ) {
        return AlertDialog(          
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          content: Text(message, style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 15)),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),                
              ),
              child: const Text('No', style: TextStyle(color: AppColors.primary)),
              onPressed: () => Navigator.pop<bool>(context, false), 
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary),                
              ),
              child: const Text('Sí'),
              onPressed: () => Navigator.pop<bool>(context, true), 
            ),
          ],
        );
      }
    );
    return response ?? false;
  }
}