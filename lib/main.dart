import 'package:nocotine/Books/twilight.dart';
import 'package:nocotine/Books/genius_food.dart';
import 'package:nocotine/Books/harry_potter.dart';
import 'package:nocotine/Books/how_to_stop.dart';
import 'package:nocotine/Books/the_power_of.dart';
import 'package:nocotine/constants/screens.dart';
import 'package:nocotine/screens/IneedAsmoke_options_screen.dart';
import 'package:nocotine/screens/account_settings_screen.dart';
import 'package:nocotine/screens/books_lists_screen.dart';
import 'package:nocotine/screens/comments_screen.dart';
import 'package:nocotine/screens/competition_screen.dart';
import 'package:nocotine/screens/create_post_screen.dart';
import 'package:nocotine/screens/home_screen.dart';
import 'package:nocotine/screens/login_screen.dart';
import 'package:nocotine/screens/main_screen.dart';
import 'package:nocotine/screens/notification_screen.dart';
import 'package:nocotine/screens/other_profile_screen.dart';
import 'package:nocotine/screens/posts_screen.dart';
import 'package:nocotine/screens/profile_screen.dart';
import 'package:nocotine/screens/root_screen.dart';
import 'package:nocotine/screens/search_bar_screen.dart';
import 'package:nocotine/screens/signup_screen.dart';
import 'package:nocotine/screens/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //if app close and kill
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(const MyApp());
}
Future _backgroundMessageHandler(RemoteMessage message)async{
  print("==================_backgroundMessageHandler========================");
  print(message.notification?.body);
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Screens.root.value,
      routes: {
        Screens.root.value:(context)=>RootScreen(),
        Screens.login.value:(context)=>LoginScreen(),
        Screens.signup.value:(context)=>SignupScreen(),
        Screens.mainScreen.value:(context)=>MainScreen(),
        Screens.home.value:(context)=>HomeScreen(),
        Screens.profile.value:(context)=>ProfileScreen(),
        Screens.competition.value:(context)=>CompetitionScreen(),
        Screens.AccountSettings.value:(context)=>AccountSettingsScreen(),
        Screens.support.value:(context)=>SupportScreen(),
        Screens.craetePost.value:(context)=>CreatePostScreen(),
        Screens.comments.value:(context)=>CommentsScreen(),
        Screens.Posts.value:(context)=>PostsScreen(),
        Screens.notification.value:(context)=>NotificationScreen(),
        //Screens.otherProfile.value:(context)=>OtherProfileScreen(),
        Screens.searchbar.value:(context)=>SearchBar(),
        Screens.IneedAsmookOptions.value:(context)=>IneedAsmookOptions(),
        Screens.BooksLists.value:(context)=>BooksListsScreen(),
        Screens.HarryPotterBook.value:(context)=>HarryPotterBook(),
        Screens.TwilightBook.value:(context)=>TwilightBook(),
        Screens.HowToStopBook.value:(context)=>HowToStopBook(),
        Screens.ThePowerBook.value:(context)=>ThePowerBook(),
        Screens.GeniusFoodBook.value:(context)=>GeniusFoodBook(),
      },
    );
  }
}


