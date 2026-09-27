import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/core/services/preferences_manger.dart';

import '../../core/constants/storage_key.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;

  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;

  late final TextEditingController motivationQuoteController;

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(
      text: widget.motivationQuote,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('User Details')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 8),
                CustomTextFormField(
                  controller: userNameController,
                  title: 'User Name',
                  hintText: 'Abdalrhman Mohemd',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter User Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: motivationQuoteController,
                  title: "Motivation Quote",
                  hintText: "One task at a time. One step closer.",
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Motivation Quote";
                    }
                    return null;
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      PreferencesManger().setString(
                        StorageKey.username,
                        userNameController.value.text,
                      );
                      PreferencesManger().setString(
                        'motivation_quote',
                        motivationQuoteController.value.text,
                      );

                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Color(0XFFFFFCFC),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.sizeH(24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
