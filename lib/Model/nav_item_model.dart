class NavItemModel {
  final String title;
  final String route;

  NavItemModel({required this.title, required this.route});
}

List<NavItemModel> bottonNavItems = [
  NavItemModel(title: 'Home', route: 'assets/icons/home.png'),
  NavItemModel(title: 'Videos', route: 'assets/icons/plus_button.png'),
  NavItemModel(title: 'Settings', route: 'assets/icons/user.png'),
];
