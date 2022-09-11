import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:quiz/profile/profile_data_screen.dart';
import 'package:quiz/settings/assets_paths.dart';
import 'package:quiz/settings/staticVariables.dart';
import 'package:quiz/settings/text_variables.dart';
import 'package:quiz/splash.dart';
import 'package:quiz/questions_screen/questionaries_pool_screen.dart';
import 'package:quiz/reviewSesion/test_settings.dart';
import 'package:quiz/settings/text_settings.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late CollectionReference<Map<String, dynamic>> db =
      FirebaseFirestore.instance.collection(collectionAppUsers);
  var currentUser = FirebaseAuth.instance.currentUser;
  List<String> images = [
    imgCreateTest,
    imgTestPNG,
    imgGrowth,
    imgSearching,
    imgTestOfweek,
  ];
  List<String> des = [
    "Historias ir mentecato simpatica la exclusiva.  ",
    "Empenarse levantate negarselo gr olvidando oh no. ",
    "Restaurar sonadores declaraba artistico su el.",
    "Ahi mal contaduria partiquina cualquiera las.  ",
    // "Curador chi analogo conatos por son gas. Non pierna mil pintor esa pensar diario nacido van. ",
    // "Ahi mal contaduria partiquina cualquiera las. Iba las redor reino fin taner salio segun meras. ",
    // "Curador chi analogo conatos por son gas. Non pierna mil pintor esa pensar diario nacido van. ",
  ];

  _ProfileViewState();

  // Widget customcard(String langname, String img, String des) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(
  //       vertical: 15,
  //       horizontal: 15,
  //     ),
  //     child: InkWell(
  //       onTap: () {
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(
  //             builder: (context) => const QuestionariesPage()));
  //       },
  //       child: Material(
  //         color: Colors.indigoAccent,
  //         elevation: 10,
  //         borderRadius: BorderRadius.circular(25),
  //         child: Column(
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 vertical: 10,
  //               ),
  //               child: Material(
  //                 elevation: 5,
  //                 borderRadius: BorderRadius.circular(100),
  //                 child: SizedBox(
  //                   height: 60,
  //                   width: 60,
  //                   child: ClipOval(
  //                       child: Image(
  //                     fit: BoxFit.cover,
  //                     image: AssetImage(
  //                       img,
  //                     ),
  //                   )),
  //                 ),
  //               ),
  //             ),
  //             Center(
  //               child: Text(
  //                 langname,
  //                 style: const TextStyle(
  //                   fontSize: 25,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.all(20),
  //               child: Text(
  //                 des,
  //                 style: const TextStyle(
  //                   fontSize: 20,
  //                   color: Colors.white,
  //                 ),
  //                 maxLines: 10,
  //                 textAlign: TextAlign.center,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      backgroundColor: GFColors.DARK,
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // children: <Widget>[
              // InkWell(
              //   onTap: () {},
              //   child: SvgPicture.asset('assets/images/crearTest.png'),
              // ),
              // const Padding(
              // padding: EdgeInsets.only(bottom: ),
              // child: Center(
              //   child: Text(
              //     'To keep library size small and code clean we manage example on different repository. which includes clear usage of each and every component that we provide in GetWidget library. Please have a look there.',
              //     style: TextStyle(
              //       fontSize: 16,
              //       color: GFColors.WHITE,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // ),
            //   GFButton(
            //       size: GFSize.LARGE,
            //       text: 'View on Github',
            //       textStyle: const TextStyle(
            //         fontSize: 16,
            //         color: GFColors.WHITE,
            //       ),
            //       icon: SvgPicture.asset(
            //         crearTest,
            //         height: 100,
            //       ),
            //       color: Color.fromARGB(255, 16, 220, 159),
            //       blockButton: true,
            //       onPressed: () {}),
            // ],
            // [
            //   _Button(
            //     color: Colors.grey.shade600,
            //     image: AssetImage(crearTest),
            //     text: logEmail,
            //     onPressed: () {},
            //   )
            // ],
          ),
        ),
      ),

      // ListView(

      // children: <Widget>[
      //   // customcard("TEST DE LA SEMANA", images[4], des[3]),
      //   // customcard("CREAR TEST", images[0], des[0]),
      //   // customcard("TESTS ANTERIORES", images[1], des[1]),
      //   // customcard("DESEMPEÑO", images[2], des[2]),
      //   // customcard("NOTAS", images[4], des[4]),
      //   // customcard("REINICIAR", images[5], des[5]),
      //   // customcard("AYUDA!", images[6], des[6]),
      // ],
      // ),
      drawer: SizedBox(
        width: 275,
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder(
                  stream: db
                      .doc(currentUser?.uid)
                      .collection(callectionProfileView)
                      .doc(userDataAppUsers)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final document = snapshot.data as DocumentSnapshot;
                    return DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.indigo,
                      ),
                      child: Text(
                        bienvenido + document[name],
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfileMyData()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.person)),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: ProfileItemsTextSettings(myData)),
                      ],
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.poll_rounded)),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: ProfileItemsTextSettings(historialUso)),
                      ],
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.badge)),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: ProfileItemsTextSettings(membreshipInfo)),
                      ],
                    ),
                  )),
              // const SizedBox(height: 5),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: Divider(color: Colors.grey.shade500),
              // ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const TestSettings()),
                        (route) => false);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.settings_accessibility)),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: ProfileItemsTextSettings(confTestText)),
                      ],
                    ),
                  )),
              // TextButton(
              //     onPressed: () {},
              //     child: Container(
              //       padding: const EdgeInsets.only(),
              //       child: Row(
              //         children: [
              //           const Align(
              //               alignment: Alignment.centerLeft,
              //               child: Icon(Icons.settings)),
              //           Container(
              //               margin: const EdgeInsets.only(left: 7),
              //               child: const ProfileItemsTextSettings(
              //                   'Configuracion general')),
              //         ],
              //       ),
              //     )),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(color: Colors.grey.shade500),
              ),
              TextButton(
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.info_sharp)),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: ProfileItemsTextSettings(aboutUs)),
                      ],
                    ),
                  )),
              // TextButton(
              //     onPressed: () {},
              //     child: Container(
              //       padding: const EdgeInsets.only(),
              //       child: Row(
              //         children: [
              //           const Align(
              //               alignment: Alignment.centerLeft,
              //               child: Icon(Icons.warning_amber)),
              //           Container(
              //               margin: const EdgeInsets.only(left: 7),
              //               child: const ProfileItemsTextSettings('Reiniciar')),
              //         ],
              //       ),
              //     )),
              TextButton(
                  onPressed: () {},
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.live_help_rounded)),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: ProfileItemsTextSettings(helpText)),
                      ],
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SplashScreen()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(),
                    child: Row(
                      children: [
                        const Align(
                            alignment: Alignment.bottomLeft,
                            child: Icon(Icons.output_outlined)),
                        Container(
                            margin: const EdgeInsets.only(left: 7),
                            child: ProfileItemsTextSettings(logOutText)),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Color color;
  final ImageProvider image;
  final String text;
  final VoidCallback onPressed;

  const _Button({
    required this.color,
    required this.image,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SizedBox(
      width: screenSize.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: color),
                borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              // const SizedBox(width: 10),
              Image(
                image: image,
                width: 60,
              ),
              // const SizedBox(width: 5),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(text, style: TextStyle(color: color, fontSize: 20)),
                  // const SizedBox(width: 40),
                ],
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
