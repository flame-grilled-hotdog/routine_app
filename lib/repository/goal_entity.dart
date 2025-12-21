class GoalEntity {
  String id;
  String title;
  String descrip;
  int times;
  String frequency;
  int term;
  DateTime stime;
  DateTime etime;

  GoalEntity({
    required this.id,
    required this.title,
    required this.descrip,
    required this.times,
    required this.frequency,
    required this.term,
    required this.stime,
    required this.etime,
  });

}