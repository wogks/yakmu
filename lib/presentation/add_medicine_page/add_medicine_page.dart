import 'dart:io';

import 'package:alyak/util/dory_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final TextEditingController _nameController = TextEditingController();

  File? _pickedImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const CloseButton(
          color: Colors.black,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '무슨 약이고?',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: largeSpace),
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: CupertinoButton(
                      padding: _pickedImage == null ? null : EdgeInsets.zero,
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              //세이프애리어로 감쌈
                              return SafeArea(
                                child: Padding(
                                  padding: pagePadding,
                                  child: Column(
                                    //크기를 최대한 줄여줌
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera)
                                              .then((xfile) {
                                            if (xfile != null) {
                                              setState(() {
                                                _pickedImage = File(xfile.path);
                                              });
                                            }
                                            //뭔가 동작을 하면 끄는 코드
                                            Navigator.maybePop(context);
                                          });
                                        },
                                        child: const Text('카메라로 촬영'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery)
                                              .then((xfile) {
                                            if (xfile != null) {
                                              setState(() {
                                                _pickedImage = File(xfile.path);
                                              });
                                            }
                                            //뭔가 동작을 하면 끄는 코드
                                            Navigator.maybePop(context);
                                          });
                                        },
                                        child: const Text('앨범에서 가져오기'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: _pickedImage == null
                          ? const Icon(
                              CupertinoIcons.photo_camera_solid,
                              size: 30,
                              color: Colors.white,
                            )
                          : CircleAvatar(
                              foregroundImage: FileImage(_pickedImage!),
                              radius: 40,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: largeSpace + regularSpace),
                Text(
                  '약 이름',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextFormField(
                  controller: _nameController,
                  maxLength: 20,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    hintText: '아빠가 먹을 약 이름을 여기다가 써.',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    contentPadding: textfieldContentPadding,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonBoxPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.subtitle1,
              ),
              onPressed: () {},
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }
}
