import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_method.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_Screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    if (_image == null) {
      showSnackBar("Add Image on Avatar", context);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _usernameController.text,
        file: _image!);

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      //navigo alla home controllando se è mobile o web
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const LoginScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //lt flex serve per mandare giù tutto
              Flexible(child: Container(), flex: 1),
              // svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              //lt inserisco quì un widget circular per inserire l'avatar
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/1053/1053244.png?w=360"),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ))
                ],
              ),
              const SizedBox(height: 24),
              //text field username
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: "Enter Your UserName",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              //text field
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter Your Email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Enter Your Password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),
              //text field username
              TextFieldInput(
                textEditingController: _bioController,
                hintText: "Enter Your Bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              //inkwell è un area cliccabile
              InkWell(
                onTap: signUpUser,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : Container(
                        child: const Text("Sign Up"),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          color: blueColor,
                        ),
                      ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Return to login press?  "),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
