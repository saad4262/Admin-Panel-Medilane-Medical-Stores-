import 'dart:io';
import 'package:adminpanel1medilane/res/app_style/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/colors/app_color.dart';
import '../../res/media-queries/media_query.dart';
import '../../res/routes/routes_name.dart';
import '../../res/widgets/custom_button.dart';
import '../../view_models/auth_vm/auth_vm.dart';
import '../dashboard/dashboard.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final authController = Get.put(AuthController2());
  final authController2 = Get.put(AuthController3());



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQueryHelper(context);


    return Scaffold(

      backgroundColor:  Color(0xff234F68),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(() => AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    authController.isLogin.value ? "Login" : "Signup",
                    style: AppStyle.headings2,
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   authController.isLogin.value ? "Lets Signin" : "Sign up to get started",
                  //   style: AppStyle.descriptions.copyWith(fontSize: 12),
                  // ),
                  // const SizedBox(height: 24),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        child: child,
                      ),
                    ),
                    child: authController.isLogin.value
                        ? const SizedBox.shrink()
                        : GestureDetector(
                      key: const ValueKey('profileImage'),
                      onTap: authController2.pickImage,
                      child: Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: authController2.selectedImage.value != null
                              ? FileImage(authController2.selectedImage.value!)
                          as ImageProvider
                              : (authController2.profileImage.value.isNotEmpty
                              ? NetworkImage(authController2.profileImage.value)
                              : AssetImage("assets/images/person1.png")
                          as ImageProvider),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 400),
                    crossFadeState: authController.isLogin.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        TextField(
                          controller: authController.storeNameController,
                          decoration: InputDecoration(
                            hintText: "Medical Store Name",
                            hintStyle: AppStyle.descriptions,



                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            prefixIcon: Icon(Icons.store,color: Colors.grey,),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.red.shade300),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  TextField(
                    controller: authController.emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: AppStyle.descriptions,


                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      prefixIcon: Icon(Icons.email,color: Colors.grey,),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: authController.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                     hintText: "Password",
                      hintStyle: AppStyle.descriptions,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xff234F68), width: 2), // Blue color when focused
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red.shade300),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 400),
                    crossFadeState: authController.isLogin.value
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        TextField(
                          controller: authController.confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            hintStyle: AppStyle.descriptions,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color:Color(0xff234F68), width: 2), // Blue color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.red, width: 2), // Red color for error
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.red.shade300),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child:Obx(() =>  CustomButton(

                      text: authController.isLogin.value ? "Login" : "Sign Up",


                      onPressed: () async {
                        File profileImageFile = File(authController2.profileImage.value); // Create File from String path

                        authController2.isLoading.value = true;

                        if (authController.isLogin.value) {
                          // Login flow
                          bool isSuccess = await authController2.login(
                            authController.emailController.text.trim(),
                            authController.passwordController.text.trim(),
                          );

                          authController2.isLoading.value = false;

                          if (isSuccess) {
                            Get.off(() => AdminDashboard());
                          } else {
                            Get.snackbar("Error", "Invalid login credentials", backgroundColor: Colors.red);
                          }

                        } else {
                          // Sign up flow
                          await authController2.signUp(
                            authController.storeNameController.text.trim(),
                            authController.emailController.text.trim(),
                            authController.passwordController.text.trim(),
                            authController.confirmPasswordController.text.trim(),
                            profileImageFile,
                          );

                          authController2.isLoading.value = false;

                          if (authController2.user.value != null) {
                            Get.offNamed(RouteName.HomeScreen); // Go to home
                          } else {
                            Get.snackbar("Error", "Sign up failed", backgroundColor: Colors.red);
                          }
                        }
                      },

                      isLoading: authController.isLoading.value,
                      color: AppColor.greenMain,
                      textColor: AppColor.whiteColor,
                      borderRadius: 12,
                      isFullWidth: false,
                      height: mediaQuery.height(7),
                      width: mediaQuery.width(70),
                    )),

                    // child: ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(vertical: 14),
                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    //   ),
                    //   onPressed: authController.isLoading.value
                    //       ? null
                    //       : authController.handleAuth,
                    //   child: authController.isLoading.value
                    //       ? const CircularProgressIndicator(color: Colors.white)
                    //       : Text(
                    //     authController.isLogin.value ? "Login" : "Sign Up",
                    //     style: const TextStyle(fontSize: 16),
                    //   ),
                    // ),
                  ),
                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      authController.isLogin.toggle();
                    },
                    child: Text(
                      authController.isLogin.value
                          ? "Don't have an account? Sign Up"
                          : "Already have an account? Login",
                      style:AppStyle.descriptions.copyWith(color: Color(0xff234F68)),

                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class AuthController2 extends GetxController {
  var isLogin = true.obs;
  var isLoading = false.obs;
  var profileImage = Rx<File?>(null);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final storeNameController = TextEditingController();

  final picker = ImagePicker();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  Future<void> handleAuth() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final storeName = storeNameController.text.trim();

    if (!isValidEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return;
    }

    if (!isLogin.value && password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;

    if (isLogin.value) {
      await login(email, password);
    } else {
      await signUp(
        email: email,
        password: password,
        name: storeName,
        profileImage: profileImage.value?.path,
      );
    }

    isLoading.value = false;
  }

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // fake delay
    Get.snackbar('Login', 'Logged in as $email');
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    String? profileImage,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // fake delay
    Get.snackbar('Sign Up', 'Account created for $email');
  }
}




class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If still waiting for connection, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If user is logged in, go to dashboard
        if (snapshot.hasData) {
          return AdminDashboard();
        }

        // If no user, show the auth screen
        return AuthScreen();
      },
    );
  }
}
