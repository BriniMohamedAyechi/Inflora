import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class getImage extends StatelessWidget {
  const getImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker =ImagePicker();
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.lightGreen,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Selection d'image",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height:10 ,),
          Row(
            children: [
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async{
                    final result = await picker.pickImage(source: ImageSource.camera);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              ),
              SizedBox(width: 10,),
              CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async{
                    final result = await picker.pickImage(source: ImageSource.gallery);
                    Navigator.of(context).pop(File(result!.path));
                  },
                ),
              )
            ],
          )

        ],
      ),

    );
  }
}
