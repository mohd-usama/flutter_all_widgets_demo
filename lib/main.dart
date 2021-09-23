import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  bool valuefirst = false;
  bool boxcheckbox = false;
  bool drugcheckbox = false;
  bool drinkcheckbox = false;
  bool petcheckbox = false;
  bool smokecheckbox = false;

  String dropdownvalue = 'Select';
  var items =  ['Select','Male','Female'];

  String dropdownedu = 'Select Education';
  var edu =  ['Select Education','BTech','MCA','BCA','MTECH','BArch'];

  late File _image;
  final picker = ImagePicker();

  DateTime selectedDate = DateTime.now();
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  RangeValues _secondvalue = const RangeValues(25, 60);



  Future _imgFromCamera() async {

      final  image = await picker.getImage(source: ImageSource.camera);

      setState(() {

        _image = image as File ;
      });

  }

  Future _imgFromGallery() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {

      _image = image as File;
    });
  }


  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
        'Filters',
        style: TextStyle(color: Color(0xff000000),
        ),
      )),

      

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
          Container(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: EdgeInsets.only(right: 90,bottom: 10),
                  child: Text(
                    "I'm looking for a roommate at",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,),
                  ),
                ),
              )
          ),


            Container(

              alignment: Alignment.center,
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1, color: Colors.grey, style: BorderStyle.solid)),
                          child: TextField(

                  decoration: InputDecoration(
                      hintText: 'pick a location',
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                  onChanged: (value) {},
                ),
              ),
            ),


            Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20,),
                  child: Padding(
                    padding: EdgeInsets.only(right: 265,bottom: 10),
                    child: Text(
                      "Budget",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                    ),
                  ),
                )
            ),

            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 100,
                    divisions: 5,
                    //showLabels: true,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
              ),
            ),

          Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Row(
                children: <Widget>[
                  Text("0"),
                  Expanded(child: Text("")),
                  Text("80,000"),
                ],
              ),
            ),


            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                    Padding(
                    padding: EdgeInsets.only(),
                    child: Padding(
                    padding: EdgeInsets.only(right: 120,bottom: 10,top: 10),
                    child: Text(
                    "Gender",
                    style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
                    ),
                    ),
                    ),

                  DropdownButton(
                    value: dropdownvalue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items:items.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(items)
                      );
                    }
                    ).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),

            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,),

                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: this.valuefirst,
                        onChanged: (newValue) {
                          setState(() {
                            valuefirst = newValue!;
                          });
                        },
                      ),
                      Text('Show me profile who are moving drom my location\n'
                          'to my target location'  ,style: TextStyle(fontSize: 14.0), ),
                    ],
                  )
                ],
              ),
            ),


            Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20,),
                  child: Padding(
                    padding: EdgeInsets.only(right: 300,bottom: 10),
                    child: Text(
                      "Age",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                )
            ),

            Container(
              child: Padding(
                padding: EdgeInsets.only(),
                child: RangeSlider(
                  values: _secondvalue,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  //showLabels: true,
                  labels: RangeLabels(
                    _secondvalue.start.round().toString(),
                    _secondvalue.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _secondvalue = values;
                    });
                  },
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("18 yr"),
                  Expanded(child: Text("")),
                  Text("60 yr"),
                ],
              ),
            ),




            Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: EdgeInsets.only(right: 240,bottom: 10),
                    child: Text(
                      "Advance Filters",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                )
            ),


            Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Profile of people moving from my current location to my target location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0),
                    ),
                  )
            ),

            Container(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1, color: Colors.grey, style: BorderStyle.solid)),
                child: TextField(

                  decoration: InputDecoration(
                      hintText: 'Current Location',
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                  onChanged: (value) {},
                ),
              ),
            ),

            SizedBox(height: 10,),

            Container(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1, color: Colors.grey, style: BorderStyle.solid)),
                child: TextField(

                  decoration: InputDecoration(
                      hintText: 'Target Location',
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                  onChanged: (value) {},
                ),
              ),
            ),


            Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: EdgeInsets.only(right: 200,bottom: 10),
                    child: Text(
                      "Choose who you see",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                )
            ),

                Container(
                margin: new EdgeInsets.only(right: 20,left: 20,top:10),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1,color: Colors.black)
                ),

                child: CheckboxListTile(
                title: const Text('Aadhaar Verified Profile'),
                value: this.boxcheckbox,

                  onChanged: (newValue) {
                    setState(() {
                      boxcheckbox = newValue!;
                    });
                  }
                ),
            ),


            Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 20,),
                  child: Padding(
                    padding: EdgeInsets.only(right: 265,bottom: 10),
                    child: Text("Choose Date",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                )
            ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: new EdgeInsets.only(right: 20,left: 20),
                /*decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1,color: Colors.black)
                ),*/
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                            textStyle: TextStyle(
                            fontSize: 15,)),
                        onPressed: () {
                          selectDate(context);
                        },

                        child: Text("Choose Date"),
                      ),
                    ),
                  ],
                )
              ),


            Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: new EdgeInsets.only(right: 20,left: 20),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1,color: Colors.black)

                ),
                child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            ),



            Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 100,top: 20,bottom: 20),
                  child: Text(
                    "Education qualification: should be",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                )
            ),

              Padding(
                padding: new EdgeInsets.only(right: 20,left: 20),
                child: Container(
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only(right: 20,left: 20),

                decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1,color: Colors.black)
                ),
                  child: DropdownButton(
                    value: dropdownedu,
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                    items:edu.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(items)
                      );
                    }
                    ).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        dropdownedu = newValue!;
                      });
                    },
                  ),
                ),
              ),



            Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 60,top: 20,bottom: 20),
                  child: Text(
                    "I would like to be shown people looking",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                )
            ),

            Padding(
              padding: new EdgeInsets.only(right: 20,left: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only(right: 20,left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1,color: Colors.black)
                ),
                child: DropdownButton(
                  value: dropdownvalue,
                  iconSize: 36,
                  isExpanded: true,
                  underline: SizedBox(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  items:items.map((String items) {
                    return DropdownMenuItem(
                        value: items,
                        child: Text(items)
                    );
                  }
                  ).toList(),
                  onChanged: (String? newValue){
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),


            Container(
                child: Padding(
                  padding: EdgeInsets.only(right: 270,top: 20,bottom: 20),
                  child: Text(
                    "DealBreaker",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                )
            ),


            Container(
              margin: new EdgeInsets.only(right: 20,left: 20,top:10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1,color: Colors.black)
              ),

              child: CheckboxListTile(
                  title: const Text('Smoke'),
                  value: this.smokecheckbox,

                  onChanged: (newValue) {
                    setState(() {
                      smokecheckbox = newValue!;
                    });
                  }
              ),
            ),



            Container(
              margin: new EdgeInsets.only(right: 20,left: 20,top:10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1,color: Colors.black)
              ),

              child: CheckboxListTile(
                  title: const Text('Drug'),
                  value: this.drugcheckbox,

                  onChanged: (newValue) {
                    setState(() {
                      drugcheckbox = newValue!;
                    });
                  }
              ),
            ),



            Container(
              margin: new EdgeInsets.only(right: 20,left: 20,top:10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1,color: Colors.black)
              ),

              child: CheckboxListTile(
                  title: const Text('Drinking'),
                  value: this.drinkcheckbox,

                  onChanged: (newValue) {
                    setState(() {
                      drinkcheckbox= newValue!;
                    });
                  }
              ),
            ),



            Container(
              margin: new EdgeInsets.only(right: 20,left: 20,top:10,bottom: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1,color: Colors.black)
              ),

              child: CheckboxListTile(
                  title: const Text('Pets'),
                  value: this.petcheckbox,

                  onChanged: (newValue) {
                    setState(() {
                      petcheckbox = newValue!;
                    });
                  }
              ),
            ),
    ],
        ),
      ),

        bottomNavigationBar: BottomAppBar(

          color: Colors.white,
          shape: CircularNotchedRectangle(),

          child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
                    radius: 80,
                  ),
                ),


                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn2.iconfinder.com/data/icons/flaticons-stroke/16/loading-3-512.png'),
                    backgroundColor: Colors.white,
                    radius: 80,
                  ),
                ),

                IconButton(
                    icon: Icon(Icons.message,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: (){

                    }),
              ],
            ),
          ),
        ),

      drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: new ListView(

                children: <Widget>[
            UserAccountsDrawerHeader(
            accountName: Text("Usama"),
            accountEmail:Text("Usama@g.gcom"),


            currentAccountPicture: new GestureDetector(
              child: Stack(
              clipBehavior: Clip.none,
              children: [

                /*Container(
                  child: Center(
                  child:_image !="1"?
                  CircleAvatar(
                    child:Image.file(_image ,),
                    radius: 120.0,
            ):
                  Image.file(_image ,),
              ),
                ),*/
                /*Container(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    child:Image.file(_image ,),

                  ),
                ),*/
               /* CircleAvatar(
                  radius: 40.0,
                  child:Image.file(_image ,),
                  //NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                ),*/

                CircleAvatar(
                  radius: 100,
                  child: CircleAvatar(
                    radius:80,
                    backgroundImage: Image.file(_image,).image,
                  ),
                ),

                Positioned(
                   bottom: -20,
                   left: 25,
                    child: RawMaterialButton(
                      onPressed: () {
                        //getImage();
                        _showPicker(context);
                      },
                      elevation: 2.0,
                      fillColor: Color(0xFFFFFFFF),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.black,),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    )),
              ],
            ),
            ),



                decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image:NetworkImage("https://orig00.deviantart.net/20eb/f/2015/030/6/f/_minflat__dark_material_design_wallpaper__4k__by_dakoder-d8fjqzu.jpg")
                ),

            )
      ),


                  ListTile(
                    leading: Icon(Icons.home), title: Text("Home"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings), title: Text("Settings"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contacts), title: Text("Contact Us"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),


                ]
            ),
          ),
      )
    );
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
