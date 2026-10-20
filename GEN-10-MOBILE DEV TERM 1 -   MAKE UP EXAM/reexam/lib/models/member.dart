enum Member {
  alex(name: "Alex", imagePath: 'assets/avatars/Alex.png'),
  daniel(name: "Daniel", imagePath: 'assets/avatars/Daniel.png'),
  ethan(name: "Ethan", imagePath: 'assets/avatars/Ethan.png'),
  jacob(name: "Jacob", imagePath: 'assets/avatars/Jacob.png'),
  noah(name: "Noah", imagePath: 'assets/avatars/Noah.png'),
  mia(name: "Mia", imagePath: 'assets/avatars/Mia.png'),
  ;

  const Member({required this.name, required this.imagePath});

  final String name;
  final String imagePath;
}
