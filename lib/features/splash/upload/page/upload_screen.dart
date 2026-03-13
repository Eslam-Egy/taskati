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
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Center(
                  child: Text(
                    "Complete Your Profile",
                    style: TextStyles.title,
                  ),
                ),
                const Gap(86),
                Text(
                  "Profile Image",
                  style: TextStyles.caption2,
                ),
                const Gap(21),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 82,
                        backgroundImage: path != null
                            ? FileImage(File(path!))
                            : const AssetImage("assets/images/user 1.png")
                                as ImageProvider,
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
                ),
                const Gap(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                      child: const ImageContainer(title: "From Camera"),
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
                      child: const ImageContainer(title: "From Gallery"),
                    ),
                  ],
                ),
                const Gap(40),
                Text(
                  "Your Name",
                  style: TextStyles.caption2,
                ),
                const Gap(10),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter name",
                    filled: true,
                    fillColor: AppColors.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Gap(40),
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
                          const SnackBar(
                            content: Text("Please select photo"),
                          ),
                        );
                        return;
                      }

                      if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter name"),
                          ),
                        );
                        return;
                      }

                      await SharedPrefHelper.saveName(nameController.text);
                      await SharedPrefHelper.saveImage(path!);

                      if (!context.mounted) return;

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
          style: TextStyles.caption1.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
