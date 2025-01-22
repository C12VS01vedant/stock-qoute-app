import 'package:app/core/constant/app_strings.dart';
import 'package:app/core/constant/borders/app_borders.dart';
import 'package:app/core/constant/enums/auth_type.dart';
import 'package:app/core/constant/enums/button_type.dart';

import 'package:app/core/constant/enums/custom_typography_styles.dart';
import 'package:app/core/constant/icons/app_icons_path.dart';
import 'package:app/core/utils/themes/fonts/app_typography.dart';
import 'package:app/core/utils/widgets/Icons/custom_icon.dart';
import 'package:app/core/utils/widgets/Texts/custom_text.dart';
import 'package:app/core/utils/themes/colors/colorgraphy.dart';
import 'package:app/core/utils/themes/sizes/app_image_sizes.dart';
import 'package:app/core/utils/themes/sizes/app_sizes.dart';
import 'package:app/core/utils/widgets/buttons/custom_elevated_button.dart';
import 'package:app/core/utils/widgets/buttons/custom_text_button.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final AuthMode authMode; // Current mode (login or sign-up)
  final Future<void> Function(String email, String password, [String? username])
      onSubmit;
  final VoidCallback toggleAuthMode;

  const AuthForm({
    Key? key,
    required this.authMode,
    required this.onSubmit,
    required this.toggleAuthMode,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  
  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = widget.authMode == AuthMode.signUp
        ? _usernameController.text.trim()
        : null;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onSubmit(email, password, username);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Authentication failed. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSignUp = widget.authMode == AuthMode.signUp;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: CustomIcon(
                  svgPath: AppIcons.appIcon,
                  size: AppImageSizes.large,
                  borderRadius: AppBorders.medium,
                ),
              ),
              const SizedBox(height: AppSizes.extraLarge),
              // App title
              Center(
                child: CustomText(
                  text: AppStrings.appName,
                  typographyStyle: CustomTypographyStyle.heading,
                  textColor: AppColors().titleTextColor,
                ),
              ),
              const SizedBox(height: 28),
              CustomText(
                text: AppStrings.enterCredentialsmsg,
                typographyStyle: CustomTypographyStyle.subheading,
                textColor: AppColors().primaryColor,
                customFontSize: 18,
              ),
              const SizedBox(height: 8),
              // Username field (only for sign-up)
              if (isSignUp)
                _buildInputField(
                  controller: _usernameController,
                  labelText: 'Username',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
              // Email field
              _buildInputField(
                controller: _emailController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              // Password field
              _buildInputField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Submit button
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Center(
                  child: CustomElevatedButton(
                      label: isSignUp ? 'Sign Up' : 'Login',
                      type: ButtonType.secondary,
                      onPressed: _submit),

                  // child: ElevatedButton(
                  //   onPressed: _submit,
                  //   child: Text(isSignUp ? 'Sign Up' : 'Login'),
                  // ),
                ),
              const SizedBox(height: 8.0),

              // Toggle mode
              Center(
                child: CustomTextButton(
                  label: isSignUp
                      ? 'Already have an account? Login'
                      : 'Don’t have an account? Sign Up',
                  onPressed: widget.toggleAuthMode,
                  type: ButtonType.primary,
                  textColor: AppColors().buttonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable Input Field Builder
  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
