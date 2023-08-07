import 'firebase_runner.dart';

void enterData() {
  List<MeritBadge> badges = [
    MeritBadge(2, 'American Cultures', false, 5, Map()),
    MeritBadge(3, 'American Heritage', false, 6, Map()),
    MeritBadge(4, 'American Labor', false, 9, Map()),
    MeritBadge(5, 'Animal Science', false, 7, Map()),
    MeritBadge(6, 'Animation', false, 5, Map()),
    MeritBadge(7, 'Archaeology', false, 11, Map()),
    MeritBadge(8, 'Archery', false, 5, Map()),
    MeritBadge(9, 'Architecture', false, 5, Map()),
    MeritBadge(10, 'Art', false, 7, Map()),
    MeritBadge(11, 'Astronomy', false, 9, Map()),
    MeritBadge(12, 'Athletics', false, 6, Map()),
    MeritBadge(14, 'Automotive Maintenance', false, 12, Map()),
    MeritBadge(15, 'Aviation', false, 5, Map()),
    MeritBadge(16, 'Backpacking', false, 11, Map()),
    MeritBadge(17, 'Basketry', false, 3, Map()),
    MeritBadge(18, 'Bird Study', false, 11, Map()),
    MeritBadge(19, 'Bugling', false, 5, Map()),
    MeritBadge(20, 'Camping', true, 10, Map()),
    MeritBadge(21, 'Canoeing', false, 13, Map()),
    MeritBadge(23, 'Chemistry', false, 7, Map()),
    MeritBadge(24, 'Chess', false, 6, Map()),
    MeritBadge(26, 'Citizenship in the Community', true, 8, Map()),
    MeritBadge(27, 'Citizenship in the Nation', true, 8, Map()),
    MeritBadge(28, 'Citizenship in the World', true, 7, Map()),
    MeritBadge(29, 'Climbing', false, 12, Map()),
    MeritBadge(30, 'Coin Collecting', false, 10, Map()),
    MeritBadge(31, 'Collections', false, 7, Map()),
    MeritBadge(32, 'Communication', true, 9, Map()),
    MeritBadge(33, 'Composite Materials', false, 6, Map()),
    MeritBadge(35, 'Cooking', true, 7, Map()),
    MeritBadge(36, 'Crime Prevention', false, 9, Map()),
    MeritBadge(37, 'Cycling', false, 7, Map()),
    MeritBadge(38, 'Dentistry', false, 7, Map()),
    MeritBadge(39, 'Digital Technology', false, 9, Map()),
    MeritBadge(40, 'Disabilities Awareness', false, 7, Map()),
    MeritBadge(41, 'Dog Care', false, 10, Map()),
    MeritBadge(42, 'Drafting', false, 7, Map()),
    MeritBadge(43, 'Electricity', false, 11, Map()),
    MeritBadge(44, 'Electronics', false, 6, Map()),
    MeritBadge(45, 'Emergency Preparedness', true, 9, Map()),
    MeritBadge(46, 'Energy', false, 5, Map()),
    MeritBadge(47, 'Engineering', false, 9, Map()),
    MeritBadge(48, 'Entrepreneurship', false, 6, Map()),
    MeritBadge(49, 'Environmental Science', true, 6, Map()),
    MeritBadge(51, 'Family Life', true, 7, Map()),
    MeritBadge(52, 'Farm Mechanics', false, 4, Map()),
    MeritBadge(53, 'Fingerprinting', false, 5, Map()),
    MeritBadge(54, 'Fire Safety', false, 13, Map()),
    MeritBadge(55, 'First Aid', true, 14, Map()),
    MeritBadge(56, 'Fish and Wildlife Management', false, 8, Map()),
    MeritBadge(57, 'Fishing', false, 10, Map()),
    MeritBadge(58, 'Fly Fishing', false, 11, Map()),
    MeritBadge(59, 'Forestry', false, 8, Map()),
    MeritBadge(60, 'Game Design', false, 8, Map()),
    MeritBadge(61, 'Gardening', false, 8, Map()),
    MeritBadge(62, 'Genealogy', false, 9, Map()),
    MeritBadge(64, 'Geology', false, 3, Map()),
    MeritBadge(65, 'Golf', false, 8, Map()),
    MeritBadge(66, 'Graphic Arts', false, 7, Map()),
    MeritBadge(68, 'Hiking', true, 6, Map()),
    MeritBadge(69, 'Home Repairs', false, 6, Map()),
    MeritBadge(70, 'Horsemanship', false, 11, Map()),
    MeritBadge(71, 'Indian Lore', false, 5, Map()),
    MeritBadge(72, 'Insect Study', false, 12, Map()),
    MeritBadge(73, 'Inventing', false, 9, Map()),
    MeritBadge(74, 'Journalism', false, 5, Map()),
    MeritBadge(75, 'Kayaking', false, 8, Map()),
    MeritBadge(76, 'Landscape Architecture', false, 5, Map()),
    MeritBadge(77, 'Law', false, 11, Map()),
    MeritBadge(78, 'Leatherwork', false, 5, Map()),
    MeritBadge(79, 'Lifesaving', true, 17, Map()),
    MeritBadge(80, 'Mammal Study', false, 5, Map()),
    MeritBadge(81, 'Medicine', false, 10, Map()),
    MeritBadge(82, 'Metalwork', false, 3, Map()),
    MeritBadge(84, 'Model Design and Building', false, 6, Map()),
    MeritBadge(85, 'Motorboating', false, 3, Map()),
    MeritBadge(86, 'Moviemaking', false, 4, Map()),
    MeritBadge(87, 'Music', false, 5, Map()),
    MeritBadge(88, 'Nature', false, 5, Map()),
    MeritBadge(89, 'Nuclear Science', false, 8, Map()),
    MeritBadge(90, 'Oceanography', false, 9, Map()),
    MeritBadge(91, 'Orienteering', false, 10, Map()),
    MeritBadge(92, 'Painting', false, 8, Map()),
    MeritBadge(94, 'Personal Fitness', true, 9, Map()),
    MeritBadge(95, 'Personal Management', true, 10, Map()),
    MeritBadge(96, 'Pets', false, 4, Map()),
    MeritBadge(97, 'Photography', false, 8, Map()),
    MeritBadge(98, 'Pioneering', false, 13, Map()),
    MeritBadge(99, 'Plant Science', false, 8, Map()),
    MeritBadge(100, 'Plumbing', false, 4, Map()),
    MeritBadge(101, 'Pottery', false, 8, Map()),
    MeritBadge(102, 'Programming', false, 6, Map()),
    MeritBadge(103, 'Public Health', false, 7, Map()),
    MeritBadge(104, 'Public Speaking', false, 5, Map()),
    MeritBadge(105, 'Pulp and Paper', false, 8, Map()),
    MeritBadge(106, 'Radio', false, 5, Map()),
    MeritBadge(107, 'Railroading', false, 8, Map()),
    MeritBadge(108, 'Reading', false, 6, Map()),
    MeritBadge(109, 'Reptile and Amphibian Study', false, 10, Map()),
    MeritBadge(110, 'Rifle Shooting', false, 2, Map()),
    MeritBadge(111, 'Robotics', false, 7, Map()),
    MeritBadge(112, 'Rowing', false, 9, Map()),
    MeritBadge(113, 'Safety', false, 8, Map()),
    MeritBadge(114, 'Salesmanship', false, 7, Map()),
    MeritBadge(115, 'Scholarship', false, 3, Map()),
    MeritBadge(116, 'Scouting Heritage', false, 8, Map()),
    MeritBadge(118, 'Sculpture', false, 3, Map()),
    MeritBadge(120, 'Shotgun Shooting', false, 2, Map()),
    MeritBadge(122, 'Signs Signals and Codes', false, 10, Map()),
    MeritBadge(123, 'Skating', false, 2, Map()),
    MeritBadge(124, 'Small Boat Sailing', false, 5, Map()),
    MeritBadge(125, 'Snow Sports', false, 7, Map()),
    MeritBadge(126, 'Soil and Water Conservation', false, 7, Map()),
    MeritBadge(127, 'Space Exploration', false, 4, Map()),
    MeritBadge(128, 'Sports', false, 5, Map()),
    MeritBadge(129, 'Stamp Collecting', false, 8, Map()),
    MeritBadge(130, 'Sustainability', true, 6, Map()),
    MeritBadge(131, 'Surveying', false, 4, Map()),
    MeritBadge(132, 'Swimming', true, 8, Map()),
    MeritBadge(133, 'Textile', false, 6, Map()),
    MeritBadge(134, 'Theater', false, 5, Map()),
    MeritBadge(136, 'Traffic Safety', false, 5, Map()),
    MeritBadge(137, 'Truck Transportation', false, 10, Map()),
    MeritBadge(138, 'Veterinary Medicine', false, 6, Map()),
    MeritBadge(139, 'Water Sports', false, 7, Map()),
    MeritBadge(140, 'Weather', false, 11, Map()),
    MeritBadge(141, 'Welding', false, 7, Map()),
    MeritBadge(142, 'Whitewater', false, 12, Map()),
    MeritBadge(143, 'Wilderness Survival', false, 12, Map()),
    MeritBadge(144, 'Wood Carving', false, 7, Map()),
    MeritBadge(145, 'Woodwork', false, 7, Map()),
    MeritBadge(146, 'Healthcare Professions', false, 9, Map()),
    MeritBadge(147, 'Citizenship in Society', true, 11, Map())
  ];

  FirebaseRunner.inputBadges(badges);
}

class MeritBadge {
  final String name;
  final int id;
  final int numReqs;
  final bool isEagleRequired;
  final Map<int, bool> compReqs;

  MeritBadge(
      this.id, this.name, this.isEagleRequired, this.numReqs, this.compReqs);

  void setComp(int i, bool b) {
    compReqs[i] = b;
  }
}

class AllMeritBadges {
  static late Map<int, MeritBadge> allBadges;

  void setAllBadges() async {
    allBadges = await FirebaseRunner.setAllBadges();
    return;
  }
}
