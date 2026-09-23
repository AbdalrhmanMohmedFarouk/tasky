import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'package:tasky/core/services/preferences_manger.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withoutColor(
                        path: 'assets/icons/TakyIcon.svg',
                        width: 42,
                        height: 42,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(width: 5),
                      CustomSvgPicture.withoutColor(
                        path:
                            'assets/images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg',
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                  Text(
                    "Your productivity journey starts here.",
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  CustomSvgPicture.withoutColor(
                    path: 'assets/images/pana.svg',
                    width: 215,
                    height: 200,
                  ),
                  SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [SizedBox(height: 8)],
                  ),
                  SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomTextFormField(
                      controller: controller,
                      title: "Full Name",
                      hintText: "e.g. Abdalrahman Mohamed",
                      validator: (String? value) {
                        if (value?.isEmpty ?? false) {
                          return "Please Enter Your Full Name";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0XFF15B86C),
                        foregroundColor: Color(0XFFFFFCFC),
                        fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
                      ),
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          await PreferencesManger().setString(
                            StorageKey.username,
                            controller.value.text,
                          );
                          // final pref = await SharedPreferences.getInstance();
                          // await pref.setString('username', controller.value.text);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return MainScreen();
                              },
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please Enter Your Full Name"),
                            ),
                          );
                        }
                      },
                      child: Text("Let’s Get Started"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
