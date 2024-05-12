import 'package:favorite_movie/constants/dialog.app.dart';
import 'package:flutter/material.dart';

class DialogDeleteAccount extends StatelessWidget {
  const DialogDeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogApp(
      child: Column(
        children: [
          const Text(
            "Delete account",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF335a3e),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Are you sure you want to delete your account?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 117, 31),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                    )),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF335a3e),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text('OK', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
