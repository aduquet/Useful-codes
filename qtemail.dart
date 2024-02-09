class MirEirOptionsRegisterUser extends StatefulWidget {
  const MirEirOptionsRegisterUser({super.key});

  @override
  State<MirEirOptionsRegisterUser> createState() =>
      _MirEirOptionsRegisterUserState();
}

class _MirEirOptionsRegisterUserState extends State<MirEirOptionsRegisterUser> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: mainPurple,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 40,
              ),
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: TextSettingCentre(
                text: appName,
                TextColor: lavenderColor,
                textSize: 30,
                maxlines: 1,
                fontF: notoSansSemiBold,
              ),
            ),
          ),
          body: SizedBox(
            width: screenSize.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Test MIR Seleccionado',
                                          style: TextStyle(
                                              color: blackColor,
                                              fontSize: 20,
                                              fontFamily: notoSansSemiBold,
                                              fontWeight: FontWeight.w600)),
                                      content: Text('Esta seguro?',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: notoSansSemiBold,
                                          )),
                                      backgroundColor: lavenderColor,
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: mainPurple,
                                                  fontSize: 16,
                                                  fontFamily: notoSansSemiBold,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              AddingTestTypeFirebaseRegisterUser(
                                                  'MIR');
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginWithEmail(),
                                              ));
                                            },
                                            child: Text(
                                              'Estoy seguro!',
                                              style: TextStyle(
                                                  color: pinkColor,
                                                  fontSize: 16,
                                                  fontFamily: notoSansSemiBold,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                barrierDismissible: false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: screenSize.height * 0.2,
                            width: screenSize.width * 0.4,
                            decoration: BoxDecoration(
                                color: lavenderColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: greyColor)),
                            child: Image(
                              image: AssetImage(mirImg),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                        ),
                        SizedBox(width: screenSize.width * 0.07),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Test EIR Seleccionado',
                                          style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 1),
                                              fontSize: 20,
                                              fontFamily: notoSansSemiBold,
                                              fontWeight: FontWeight.w600)),
                                      content: Text('Esta seguro?',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: notoSansSemiBold,
                                          )),
                                      backgroundColor: lavenderColor,
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: mainPurple,
                                                  fontSize: 16,
                                                  fontFamily: notoSansSemiBold,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              AddingTestTypeFirebaseRegisterUser(
                                                  'EIR');
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginWithEmail(),
                                              ));
                                            },
                                            child: Text(
                                              'Estoy seguro!',
                                              style: TextStyle(
                                                  color: pinkColor,
                                                  fontSize: 16,
                                                  fontFamily: notoSansSemiBold,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ],
                                    ),
                                barrierDismissible: false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: screenSize.height * 0.2,
                            width: screenSize.width * 0.4,
                            decoration: BoxDecoration(
                                color: lavenderColor,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: greyColor)),
                            child: Image(
                              image: AssetImage(eirImg),
                              fit: BoxFit.cover,
                              height: 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
