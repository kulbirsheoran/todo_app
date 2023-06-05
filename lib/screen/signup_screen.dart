import 'package:flutter/material.dart';
import 'package:todo_app/constant/routes_const.dart';
import 'package:todo_app/constant/string_constants.dart';
import 'package:todo_app/screen/login_screen.dart';
import 'package:todo_app/sharedPreference//local_data_saver.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConstant.validatorInputNameSignIpScreen;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            hintText: StringConstant.nameHintTextSignUpScreen,
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(color: Colors.white),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.person,
                                color: Colors.greenAccent,
                              ),
                              onPressed: () {
                                nameController.clear();
                              },
                            )),
                        controller: nameController,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConstant.validatorInputEmailSignUpScreen;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: StringConstant.emailHintTextSignIpScreen,
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(color: Colors.green),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.email,
                                color: Colors.greenAccent,
                              ),
                              onPressed: () {
                                emailController.clear();
                              },
                            )),
                        controller: emailController,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConstant.validatorInputPasswordSignUpScreen;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            hintText: StringConstant.passwordHintTextSignIpScreen,
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(color: Colors.green),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.greenAccent,
                              ),
                              onPressed: () {
                                passwordController.clear();
                              },
                            )),
                        controller: passwordController,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringConstant.validatorInputConfirmPasswordSignUpScreen;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),
                            hintText: StringConstant.confirmPasswordHintTextSignIpScreen,
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(color: Colors.green),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.greenAccent,
                              ),
                              onPressed: () {
                                confirmPasswordController.clear();
                              },
                            )),
                        controller: confirmPasswordController,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(
                                25,
                              ),
                              color: Colors.white),
                          child: Center(
                              child: InkWell(
                                  child: const Text(
                                    StringConstant.signUpButtonSignUpScreen,
                                  ),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setData();
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                    }
                                  })),
                        ),
                      ),
                      InkWell(
                          child: const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text(
                              StringConstant.signInSignUpScreen,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => const LoginScreen()));
                          }),
                    ],
                  ),
                ),
              ),
            )));
  }

  Future<void> setData() async {
    await LocalDataSaver.saveName(nameController.text);
    await LocalDataSaver.savePassword(passwordController.text);
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
    Navigator.pushReplacementNamed(context, Routes.loginScreen);
  }
}
