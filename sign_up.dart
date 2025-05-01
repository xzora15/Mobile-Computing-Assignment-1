import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Make sure this is imported
import 'sign_in.dart';
import 'sign_up_success.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isGoogleLoading = false;
  bool _termsAgreed = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _handleGoogleSignUp() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Sign-in aborted
        setState(() {
          _isGoogleLoading = false;
        });
        return;
      }

      setState(() {
        _isGoogleLoading = false;
      });

      // Navigate to success screen after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpSuccessScreen()),
      );
    } catch (error) {
      setState(() {
        _isGoogleLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-Up Failed', style: TextStyle(fontFamily: 'Nunito')),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  void _validateAndSignUp() {
    if (_nameController.text.isEmpty) {
      _showMessage('Please enter your name');
    } else if (_emailController.text.isEmpty || !_isValidEmail(_emailController.text)) {
      _showMessage('Please enter a valid email address');
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage('Passwords do not match');
    } else if (_passwordController.text.length < 8) {
      _showMessage('Password must be at least 8 characters');
    } else if (!_termsAgreed) {
      _showMessage('Please agree to the terms and conditions');
    } else {
      // Proceed to the success screen if all validations pass
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpSuccessScreen()),
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(fontFamily: 'Nunito'))),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Terms and Conditions", style: TextStyle(fontFamily: 'Nunito')),
        content: SingleChildScrollView(
          child: Text("Insert your Terms and Conditions here.", style: TextStyle(fontFamily: 'Nunito')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Close", style: TextStyle(fontFamily: 'Nunito')),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Privacy Policy", style: TextStyle(fontFamily: 'Nunito')),
        content: SingleChildScrollView(
          child: Text("Insert your Privacy Policy here.", style: TextStyle(fontFamily: 'Nunito')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Close", style: TextStyle(fontFamily: 'Nunito')),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: TextStyle(fontFamily: 'Nunito'),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool obscure, VoidCallback toggle) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(fontFamily: 'Nunito'),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
      ),
    );
  }

  Widget _buildAgreement() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _termsAgreed,
          onChanged: (value) {
            setState(() {
              _termsAgreed = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'I agree to the ',
              style: TextStyle(color: Colors.black, fontFamily: 'Nunito'),
              children: [
                TextSpan(
                  text: 'Terms and Conditions',
                  style: TextStyle(color: Colors.blue, fontFamily: 'Nunito'),
                  recognizer: TapGestureRecognizer()..onTap = _showTermsDialog,
                ),
                TextSpan(text: ' and ', style: TextStyle(fontFamily: 'Nunito')),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(color: Colors.blue, fontFamily: 'Nunito'),
                  recognizer: TapGestureRecognizer()..onTap = _showPrivacyPolicyDialog,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9F6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Sign up',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF224137),
                      fontFamily: 'Nunito')),
              SizedBox(height: 12),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                width: 374,
                height: 1,
                color: Color(0xFFE5E5E5),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignInScreen()),
                            ),
                            child: Center(
                              child: Text('Sign In',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Sign Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Nunito')),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                height: 2,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildTextField(_nameController, 'Name'),
                    SizedBox(height: 20),
                    _buildTextField(_emailController, 'Email Address'),
                    SizedBox(height: 20),
                    _buildPasswordField(_passwordController, 'Password', _obscurePassword, () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    }),
                    SizedBox(height: 20),
                    _buildPasswordField(_confirmPasswordController, 'Confirm Password', _obscureConfirmPassword, () {
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                    }),
                    SizedBox(height: 20),
                    _buildAgreement(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _validateAndSignUp,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('SIGN UP',
                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Colors.white)),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('or', style: TextStyle(fontFamily: 'Nunito')),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 10),
                    OutlinedButton.icon(
                      icon: Icon(Icons.g_translate, color: Colors.blue),
                      label: Text(_isGoogleLoading ? 'Signing up with Google...' : 'Sign up with Google',
                          style: TextStyle(fontFamily: 'Nunito')),
                      onPressed: _isGoogleLoading ? null : _handleGoogleSignUp,
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Already have an account?', style: TextStyle(fontFamily: 'Nunito')),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignInScreen()),
                      ),
                      child: Text('Sign In', style: TextStyle(fontFamily: 'Nunito')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
