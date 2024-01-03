

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fireStorage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';


class UserPhotoUpdate extends StatefulWidget {
  const UserPhotoUpdate({Key? key}) : super(key: key);

  @override
  State<UserPhotoUpdate> createState() => _UserPhotoUpdateState();
}

class _UserPhotoUpdateState extends State<UserPhotoUpdate> {


  final ImagePicker _picker = ImagePicker();
  final AppLogic _appLogic = AppLogic();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? _passportImage;
  List selectedPassportImage = [];
  List passportImagePath = [];
  String passportImageFireStoreUrl = "";

  bool isLoading = false;

  _pickPassportImage()async {
    double width = MediaQuery.of(context).size.width - 10;
    double height = MediaQuery.of(context).size.height - 20;
    XFile? image = await _picker
        .pickImage(source: ImageSource.gallery, maxWidth: width, maxHeight: height);
    String _extension = path.extension(image!.path).toLowerCase();
    if (!_extension.contains('.jpg') &&
        !_extension.contains('.jpeg') &&
        !_extension.contains('.png')) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Image File is invalid'),
        backgroundColor: Color(0xFFCD212A),
      ));

    }

    if (mounted) {
      setState(() {
        _passportImage = File(image.path);
        selectedPassportImage.insert(0, _passportImage);
      });

    }
  }


  // Save image to fireStore
  Future savePassportImageToStorage({required File fileImage, required String fileName, required String imageCategory}) async {
    fireStorage.Reference reference = fireStorage.FirebaseStorage.instance
        .ref()
        .child("images").child(_auth.currentUser!.uid)..child(imageCategory).child(fileName);
    fireStorage.UploadTask uploadTask = reference.putFile(fileImage);
    fireStorage.TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() {})
        .catchError((error) => error);
    var url = await taskSnapshot.ref.getDownloadURL();
    if(mounted){
      setState(() {
        passportImageFireStoreUrl = url;
      });

    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: isLoading ? Colors.white : Colors.greenAccent,
      backgroundColor: Colors.white,
      body: isLoading ? const LoadingIndicator() : SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: ListView(
            children:  [

              const SizedBox(height: 50,),

              const Center(child: Text("Update Profile Photo", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),)),

              const SizedBox(height: 40,),

              GestureDetector(
                onTap: (){
                  _pickPassportImage();
                },
                child: selectedPassportImage.isEmpty  ? Container(
                  height: 130,
                  width: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainColor,

                  ),

                  child:  const Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Browse Gallery", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                      Icon(Icons.photo_camera_back_outlined, size: 50, color: Colors.white,),
                    ],
                  ),),
                ) :

                Center(
                  child: Container(
                    padding: const EdgeInsets.all(4), // Border width
                    decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(50), // Image radius
                        child: InstaImageViewer(child: Image.file(_passportImage!, fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                ),
              ),



              const SizedBox(height: 100,),
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectedPassportImage.isEmpty ? const SizedBox():
                  Flexible(
                    child: ButtonWidget(width: 200, title: "Retake Photo", onTap: (){
                      _pickPassportImage();
                    },),
                  ),

                  const SizedBox(width: 8,),

                  selectedPassportImage.isEmpty ? Flexible(child: ButtonWidget(title: "Save", width: 200,
                    onTap: (){
                      Fluttertoast.showToast(msg: "Please select an Image");
                    },))
                      : Flexible(
                    child: ButtonWidget(title: "Save", width: 200,
                      onTap: ()async{
                        setState(() {
                          isLoading = true;
                        });
                        DateTime dateTime = DateTime.now();
                        var time = DateFormat.jm().format(dateTime);
                        await savePassportImageToStorage(
                            imageCategory: "passport",
                            fileImage: _passportImage!,
                            fileName: "${time.toString()}${_passportImage!.path.toString()}");


                        setState(() {
                          UserConsts.photo = passportImageFireStoreUrl;
                        });
                        UserPreferences.setProfilePhoto(profilePhoto: passportImageFireStoreUrl);

                        _appLogic.updateUserDetails(field: "photo",
                          context: context,
                          fieldValue: passportImageFireStoreUrl,
                          stopLoading: (){
                            setState(() {
                              isLoading = false;
                            });
                          },
                        );

                      },),
                  ),
                ],
              ),


              const SizedBox(height: 20,),


            ],
          ),
        ),
      ),
    );
  }
}


