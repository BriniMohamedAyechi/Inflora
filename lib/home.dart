import 'package:authentification/plantModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'addPlant.dart';
import 'game1/main3.dart';
import 'game2/gameScreen.dart';
import 'game3/main2.dart';



class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}
void main2() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Phoenix(child: const ProviderScope(child: MindGame())));
}
Future<void> main3() async {
  // Ensures that all bindings are initialized
  // before was start calling hive and flame code
  // dealing with platform channels.
  WidgetsFlutterBinding.ensureInitialized();

  // Makes the game full screen and landscape only.
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  // Initializes hive and register the adapters.
  await initHive();
  runApp(const DinoRunApp());
}
class _homePageState extends State<homePage> {
  final searchController = TextEditingController();
  String result="";
  List<Plant> plantsrefreshed = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SpeedDial(
          overlayColor: Colors.white,
          backgroundColor: Colors.lightGreen,
          animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                    child: Icon(Icons.logout,color: Colors.white,),
                    label: 'Se deconectez',
                  backgroundColor: Colors.lightGreen,
                  onTap: (){
                      showDialog(
                        context: context,
                        builder: (context)=> AlertDialog(
                          title: Text('Vous êtes sur de déconnectez ?'),
                          actions: [
                            TextButton(
                              child: Text('Oui'),
                              onPressed: (){
                                FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('Non'),
                              onPressed: ()=>Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text('Je ne suis pas sur'),
                              onPressed: (){main3();},
                            )
                          ],
                        )
                      );
                  }

                ),
                SpeedDialChild(
                    child: Icon(Icons.add,color: Colors.white,),
                    backgroundColor: Colors.lightGreen,
                    label: 'Ajouter une plante',
                    onTap: (){Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => addPlant()));}
                ),

          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Nos Plantes',style: TextStyle(color: Colors.white),),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 20,),
              child: GestureDetector(
                onDoubleTap: (){
                  main2();
                },
                child: Text(
                  "La liste des plantes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.lightGreen),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged:(value){
                  setState(() {
                    result=value;
                  });

                },
                  controller: searchController,
                  cursorColor: Colors.green,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.lightGreen)),
                    hintText: "Entrez le nom de plante",
                    icon: Icon(Icons.search, size: 20, color: Colors.lightGreen),
                    filled: true,
                    fillColor: Colors.white,
                    enabled: true,
                    contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.lightGreen),
                      borderRadius: new BorderRadius.circular(20),
                    ),
                  )
              ),
            ),
            MaterialButton(
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(20.0))),
                minWidth: 100,
                elevation: 5.0,
                height: 40,
                child: Text("chercher",style: TextStyle(fontSize: 24,color: Colors.white),),
              onPressed: () {
                  if (result.toLowerCase()=="xo"){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => game2Screen()));
                  }
              },

            ),
            SizedBox(height: 20,),
            SingleChildScrollView(
              child: SingleChildScrollView(
                child: StreamBuilder<List<Plant>>(
                              stream: readPlants(),
                              builder: (context,snapshot){
                                if(snapshot.hasError){
                                  print(snapshot);
                                  return Text('Something went wrong');
                                }
                                else if(snapshot.hasData){
                                  final plants=snapshot.data!;
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: plants.map(buildPlant).toList(),
                                    ),

                                  );

                                }

                                else{
                                  return Center(child: CircularProgressIndicator(),);
                                }

                              },
                            ),
              ),
            ),
          ],
        ),
      ),

      );


  }
  Widget buildPlant(Plant plant)=>SingleChildScrollView(
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.lightGreen,width: 3
            )
          ),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Row(children:[
                      Text('${plant.name}'.toUpperCase(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.lightGreen),),
                      SizedBox(width: 20,),
                     SizedBox(height: 30,),
                    ]),
                  ),
                  Column(
                    children: [
                      Text('${plant.description}'),
                      SizedBox(height: 20,),
                      Image.network('${plant.image}')

                    ],
                  )
                ],
              ),
            ),
            onTap: () {
            },
          ),
        ),
      ),
    ),
  );
Stream<List<Plant>>readPlants() =>
    FirebaseFirestore.instance.collection('plants').snapshots().map((snapshot) =>
      snapshot.docs.map((doc) =>Plant.fromJson(doc.data() )).toList() );


}

