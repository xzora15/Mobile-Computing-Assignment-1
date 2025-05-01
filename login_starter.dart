import 'package:flutter/material.dart';
import 'sign_in.dart'; // <-- Import your sign_in.dart

class LoginStarter extends StatelessWidget {
  const LoginStarter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              SizedBox(height: 50), // space from top

              // Text "Choose which user"
              Text(
                'Choose which user',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  color: Color(0xFF224137),
                ),
              ),

              SizedBox(height: 20),

              // Line
              Container(
                width: double.infinity,
                height: 1,
                color: Color(0xFFE5E5E5),
              ),

              SizedBox(height: 40),

              // Rectangle 1 (Customer) - Now Clickable
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Container(
                  width: 310,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Color(0xFFECFBFA),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/image/user_1.png',
                          width: 82,
                          height: 82,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Customer',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w800,
                            fontSize: 30,
                            color: Color(0xFF224137),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Rectangle 2 (Admin) - Still static for now
              Container(
                width: 310,
                height: 230,
                decoration: BoxDecoration(
                  color: Color(0xFFECFBFA),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/admin_1.png',
                        width: 139,
                        height: 93,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Admin',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: Color(0xFF224137),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
