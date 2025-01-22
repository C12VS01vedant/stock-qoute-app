import 'package:app/core/constant/enums/auth_type.dart';
import 'package:app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app/features/authentication/presentation/widgets/auth_form.dart';
import 'package:app/features/stocks/presentation/screens/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBody extends StatefulWidget {
  final AuthMode? authMode;

  const AuthBody({
    Key? key,
    this.authMode,
  }) : super(key: key);

  @override
  _AuthBodyState createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  late AuthMode _authMode;

  @override
  void initState() {
    super.initState();
    _authMode = widget.authMode ?? AuthMode.login;
  }

  void _toggleAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.signUp ? AuthMode.login : AuthMode.signUp;
    });
  }

  Future<void> _onSubmit(String email, String password,
      [String? username]) async {
    final authBloc = context.read<AuthBloc>();

    if (_authMode == AuthMode.login) {
      authBloc.add(LoginEvent(email, password));
    } else if (_authMode == AuthMode.signUp && username != null) {
      authBloc.add(SignupEvent(username, email, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StockHomePage()));
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AuthForm(
            authMode: _authMode,
            onSubmit: _onSubmit,
            toggleAuthMode: _toggleAuthMode,
          ),
        ],
      ),
    );
  }
}
