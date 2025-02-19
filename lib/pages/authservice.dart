// import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Authservice {
  final supabase = Supabase.instance.client;

  User? get currentUser => supabase.auth.currentUser;

}