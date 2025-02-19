import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weconnect/logreg.dart/login.dart';
import 'package:weconnect/pages/createpost.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}
class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Supabase.instance.client.auth.onAuthStateChange,
     builder: (context, snapshot){
      //Loading
      if(snapshot.connectionState ==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }
      //Check for any valid sessions
      final session = snapshot.hasData? snapshot.data!.session: null;

      if(session != null){
        return const Createpostpage();

      }else {
        return const Loginpage();
      }
     }
     );
  }
}