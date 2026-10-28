import 'package:be_detectives/ui/home/logo_app_bar.dart';
import 'package:be_detectives/ui/home/register_button.dart';
import 'package:be_detectives/ui/navbars/menu_navbar.dart';
import 'package:be_detectives/utils/text_strings.dart';
import 'package:flutter/material.dart';
import 'mail_button.dart';
import 'package:be_detectives/ui/transaction/paypal_gateway.dart';

class ConnectionMenu extends StatefulWidget {
  ConnectionMenu({Key key}) : super(key: key);

  @override
  _ConnectionMenu createState() => _ConnectionMenu();
}

class _ConnectionMenu extends State<ConnectionMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: LogoAppBar(context: context),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Flexible(
          child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * .1,
                top: MediaQuery.of(context).size.height * .1,
              ),
              child: _generateConnectionTitle()),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .05),
        Column(
          children: [
            // const FacebookButton(),
            // const SizedBox(height: 30.0),
            // const GoogleButton(),
            // const SizedBox(height: 30.0),
            // const AppleButton(),
            // const SizedBox(height: 30.0),
            const RegisterButton(),
            const SizedBox(height: 30.0),
            const MailButton(),
          ],
        ),
      ]),
      bottomNavigationBar: MenuNavBar(
          containerColor: Theme.of(context).primaryColor,
          boxDecoColor: Theme.of(context).backgroundColor),
    );
  }

  _generateConnectionTitle() {
    List<String> titleParts = TextsStrings.connectOrCreateAccount.split(" ");
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Text(titleParts[0],
                style: Theme.of(context).textTheme.headline1)),
        Flexible(
          child: Row(
            children: [
              Flexible(
                child: Text("${titleParts[1]} ",
                    style: Theme.of(context).textTheme.headline2),
              ),
              for (int i = 2; i < titleParts.length - 1; i++)
                Text("${titleParts[i]} ",
                    style: Theme.of(context).textTheme.headline4),
            ],
          ),
        ),
        Flexible(
          child: Text("${titleParts[titleParts.length - 1]} ",
              style: Theme.of(context).textTheme.headline4),
        ),
        /* Développé par Samuel
        FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PaypalPayment(
                  onFinish: (number) async {
                    // payment done
                    print('order id: ' + number);
                  },
                ),
              ),
            );
          },
          tooltip: "Paypal form",
          child: Icon(Icons.payment_sharp),
        )
        */
      ],
    );
  }
}
