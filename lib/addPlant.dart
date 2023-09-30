import 'package:authentification/plantModel.dart';
import 'package:authentification/storageService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_alert_dialog/h_alert_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

import 'getImage.dart';
import 'home.dart';

class addPlant extends StatefulWidget {
  const addPlant({Key? key}) : super(key: key);

  @override
  State<addPlant> createState() => _addPlantState();
}

class _addPlantState extends State<addPlant> {
  final plantnameController = TextEditingController();
  final categoryController = TextEditingController();
  final imageController = TextEditingController();
  final waterController = TextEditingController();
  final lightController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final List<String> items = [
    "Peu d'arrosage",
    'Arrosage modérer',
    "Beacoup d'arrosage",
  ];
  final List<String> items2 = [
    "Peu de lumiére",
    'Moderment de lumiére',
    "Beacoup de lumiére",
  ];
  String? selectedValue;
  String? selectedValue2;
  String? imageUrl;
  File? image;
  bool loading= false;
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text('Ajouter votre plante',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Ajouter votre plante',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: plantnameController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.lightGreen)),
                  hintText: "Nom Plante",
                  icon: Icon(Icons.comment, size: 20, color: Colors.lightGreen),
                  fillColor: Colors.white,
                  filled: true,
                  enabled: true,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: categoryController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.lightGreen)),
                  hintText: "Categorie",
                  icon:
                      Icon(Icons.category, size: 20, color: Colors.lightGreen),
                  filled: true,
                  fillColor: Colors.white,
                  enabled: true,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 235 ),
                child: Text(
                  "Quantité d'eau",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.lightGreen),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            "Choisir la quantité d'eau",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.water_drop,
                    ),
                    iconSize: 14,
                    buttonHeight: 55,
                    buttonWidth: 310,
                    buttonPadding: EdgeInsets.only(left: 20, right: 20),
                    buttonDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    buttonElevation: 2,
                    itemHeight: 50,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: 140,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200 ),
                child: Text(
                  "Quantité de lumiére",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.lightGreen),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            "Choisir la quantité du lumiére",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items2
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue2,
                    onChanged: (value) {
                      setState(() {
                        selectedValue2 = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.light,
                    ),
                    iconSize: 14,
                    buttonHeight: 55,
                    buttonWidth: 310,
                    buttonPadding: EdgeInsets.only(left: 20, right: 20),
                    buttonDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                      Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),

                    buttonElevation: 2,
                    itemHeight: 50,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: 155,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.lightGreen)),
                  hintText: "Prix",
                  icon: Icon(Icons.price_change,
                      size: 20, color: Colors.lightGreen),
                  filled: true,
                  fillColor: Colors.white,
                  enabled: true,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 5,
                controller: descriptionController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.lightGreen)),
                  icon: Icon(Icons.description,
                      size: 20, color: Colors.lightGreen),
                  filled: true,
                  fillColor: Colors.white,
                  enabled: true,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120 ),
                child: Text(
                  "Sélectioner l'image du plante",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.lightGreen),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      image != null? Container(
                        width: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.file(image!,
                            height: 100,
                            width: 300,
                          ),
                        )
                      )
                          : loading? CircularProgressIndicator(semanticsLabel:'Veuiler Patientez',) : Text("Image de plante")
                    ],
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton.icon(
                    label: Text("Selectioner l'image",style: TextStyle(color: Colors.white),),
                    icon: Icon(Icons.upload,color: Colors.white,),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.lightGreen)
                              )
                          )
                      ),
                    onPressed: () async{
                      final data = await showModalBottomSheet(
                        context: context,
                        builder: (ctx){
                        return getImage();
                        }
                      );
                      if(data!= null ){
                        loading=true;
                        setState(() {

                        });
                      }
                      String? urlImage= await uploadImage(data, 'images');
                      setState(() {
                        imageUrl=urlImage;
                        image=data;

                      });


                    }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: MaterialButton(
                        color: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        minWidth: 200,
                        elevation: 5.0,
                        height: 40,
                        child: Text("Terminé",style: TextStyle(fontSize: 24,color: Colors.white),),
                        onPressed: () async{
                          await createPlant().whenComplete(() =>
                              HAlertDialog.showCustomAlertBox(
                                context: context,
                                backgroundColor: Colors.lightGreen,
                                title: 'Success',
                                description:
                                'Vos information on eté enregistré avec succés',
                                icon: Icons.done,
                                iconSize: 32,
                                iconColor: Colors.green,
                                titleFontFamily: 'Raleway',
                                titleFontSize: 22,
                                titleFontColor: Colors.black54,
                                descriptionFontFamily: 'Raleway',
                                descriptionFontColor: Colors.black45,
                                descriptionFontSize: 18,
                                timerInSeconds: 3,
                              )).whenComplete(() => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => homePage())));
                        },
                    ),
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future selecImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result == null) return;
  }

  Future createPlant() async {
    final docUser = FirebaseFirestore.instance.collection('plants').doc();
    final plant = Plant(
      id: docUser.id,
      name: plantnameController.text.trim(),
      category: categoryController.text.trim(),
      image: imageUrl,
      light: selectedValue2,
      water: selectedValue,
      price: priceController.text.trim(),
      description: descriptionController.text.trim(),
    );
    final json = plant.toJson();
    await docUser.set(json);
  }
  Future<String?> uploadImage(File file,String path) async{
    String image=path;
        try{
      Reference ref = FirebaseStorage.instance.ref().child(path+"/"+image);
        UploadTask upload =ref.putFile(file);
        await upload.whenComplete(() => null);
        return await ref.getDownloadURL();
        }
        catch(e){
          return null;

        }

  }
}
/*async {
final results = await FilePicker.platform.pickFiles(
allowMultiple: false, type: FileType.image);
if (results == null) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text("pas de selection d'iamge")));
return null;
}
final path = results?.files.single.path!;
final fileName = results.files.single.name;
print(path);
print(fileName);
storage.uploadFile(path!, fileName).then((value) => print('done'));
},*/