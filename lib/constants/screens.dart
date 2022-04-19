enum Screens{
  root,
  login,
  signup,
  mainScreen,
  home,
  profile,
  competition,
  AccountSettings,
  support,
  craetePost,
  comments,
  Posts,
  notification,
  otherProfile,
  searchbar,
  IneedAsmookOptions,
  BooksLists,
  HarryPotterBook,
  TwilightBook,
  HowToStopBook,
  ThePowerBook,
  GeniusFoodBook
}
extension ScreenExtension on Screens{
  String get value{
    switch(this){
      case Screens.root:
        return "/";
      case Screens.login:
        return "/login";
      case Screens.signup:
        return "/signup";
      case Screens.mainScreen:
        return "/mainScreen";
      case Screens.competition:
        return "/competition";
      case Screens.profile:
        return "/profile";
      case Screens.AccountSettings:
        return "/accountSettings";
      case Screens.craetePost:
        return "/craetePost";
      case Screens.home:
        return "/home";
      case Screens.comments:
        return "/comments";
      case Screens.Posts:
        return "/posts";
      case Screens.support:
        return "/support";
      case Screens.notification:
        return "/notification";
      case Screens.otherProfile:
        return "/otherProfile";
      case Screens.IneedAsmookOptions:
        return "/IneedAsmookOptions";
      case Screens.BooksLists:
        return "/BooksLists";
      case Screens.HarryPotterBook:
        return "/HarryPotterBook";
      case Screens.TwilightBook:
        return "/TwilightBook";
      case Screens.HowToStopBook:
        return "/HowToStopBook";
      case Screens.ThePowerBook:
        return "/ThePowerBook";
      case Screens.GeniusFoodBook:
        return "/GeniusFood";
      case Screens.searchbar:
        return "/searchbar";
      default:
        return "/";
      
    }
  }
}