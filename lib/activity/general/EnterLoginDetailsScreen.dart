import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infootprints_ebook/activity/cubit/auth_cubit.dart';
import 'package:infootprints_ebook/activity/cubit/auth_state.dart';
import 'package:infootprints_ebook/activity/general/OtpScreen.dart';
import 'package:infootprints_ebook/main.dart';

class EnterLoginDetails extends StatefulWidget {
  const EnterLoginDetails({super.key});

  @override
  State<EnterLoginDetails> createState() => _EnterLoginDetailsState();
}

class _EnterLoginDetailsState extends State<EnterLoginDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "   Let's sign you in.   ",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "   Enter your phone number to get OTP   ",
                style: TextStyle(
                    fontSize: 30,
                    color: CupertinoColors.systemGrey,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    contentPadding: EdgeInsets.symmetric(horizontal: 25),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Palette.kToDark,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: CupertinoColors.systemGrey,
                        width: 2.0,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthCodeSentState) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute<void>(
                        builder: (BuildContext context) => OtpScreen(
                          phoneNumber: phoneController.text,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Visibility(
                    visible: (phoneController.text.length == 10) ? true : false,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          String phoneNumber = "+91" + phoneController.text;
                          BlocProvider.of<AuthCubit>(context)
                              .sendOTP(phoneNumber);
                        }),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
