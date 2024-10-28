import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_admin/admin_dashboard.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isLoading = false;

  String? email, password;

  final _formKey = GlobalKey<FormState>();
//  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: (16)),
              const Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 34,
                  ),
                ),
              ),
              const SizedBox(height: (16)),
              const Center(
                child: Text(
                  'Admin Login',
                  style: TextStyle(),
                ),
              ),
              const SizedBox(height: (24)),
              buildEmailField(),
              const SizedBox(height: (16)),
              buildPasswordField(),
              const SizedBox(height: (16)),
              isLoading
                  ? const SpinKitCircle(
                      color: Colors.amber,
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (emailCtrl.text == 'admin' &&
                            passwordCtrl.text == 'admin123') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Admin(),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(msg: 'You can have access');
                        }
                      },
                      child: const Text('Login'),
                    ),
              const SizedBox(height: (48)),
            ],
          )),
        ),
      ),
    );
  }

  // loginwithFirebase() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     try {
  //       final credential =
  //           await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailCtrl.text,
  //         password: passwordCtrl.text,
  //       );
  //       User? user = credential.user;
  //       user = _auth.currentUser;
  //       if (user != null) {
  //         box!.put('login', true);
  //         gotToHomeScreen();
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'user-not-found') {
  //         Utils.toastMessage('No user found');
  //         print('No user found for that email.');
  //       } else if (e.code == 'wrong-password') {
  //         Utils.toastMessage('wrong passwords');

  //         print('Wrong password provided for that user.');
  //       }
  //     } finally {
  //       setState(() {
  //         isLoading = false; // Hide loading indicator
  //       });
  //     }
  //   } else {
  //     Utils.toastMessage('Something went wrong');

  //     setState(() {
  //       isLoading = false; // Hide loading indicator
  //     });
  //   }
  // }

  // gotToHomeScreen() {
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, Routes.homeRoute, (Route route) => false);
  // }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: emailCtrl,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {
        email = newValue;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is required';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black45),
        ),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: passwordCtrl,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) {
        password = newValue;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is empty';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.password),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black87),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black87),
        ),
      ),
    );
  }
}
