import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/servicer/shared_pref.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/home/page/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? path;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              const Gap(10),
              const Text("Complete Your Profile"),
              const Gap(86),

              Row(children: const [Text("Profile Image")]),

              const Gap(21),

              Stack(
                children: [
                  CircleAvatar(
                    radius: 82,
                    backgroundImage: path != null
                        ? FileImage(File(path!)) as ImageProvider
                        : const AssetImage("assets/images/user 1.png"),
                  ),

                  if (path != null)
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            path = null;
                          });
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.backgroundColor,
                          child: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                ],
              ),

              const Gap(40),

              Row(
                children: [
                  const Gap(30),

                  GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );

                      if (image != null) {
                        setState(() {
                          path = image.path;
                        });
                      }
                    },
                    child: ImageContainer(title: "From Camera"),
                  ),

                  const Gap(10),

                  GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                      );

                      if (image != null) {
                        setState(() {
                          path = image.path;
                        });
                      }
                    },
                    child: ImageContainer(title: "From Gallery"),
                  ),
                ],
              ),

              const Gap(40),

              Row(children: [Text("Your Name", style: TextStyles.caption2)]),

              const Gap(10),

              TextField(
                decoration: InputDecoration(
                  hintText: "Enter name",
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () async {
                    if (path == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select photo")),
                      );
                      return;
                    }

                    if (name == null || name!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter name")),
                      );
                      return;
                    }

                    await SharedPrefHelper.saveName(name!);
                    await SharedPrefHelper.saveImage(path!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Let’s Start!",
                    style: TextStyles.title.copyWith(
                      color: AppColors.backgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String title;

  const ImageContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.accentColor,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyles.caption1.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
