
class GoalEntity {
  String gid;
  String title;
  String descrip;
  int times;
  String frequency;
  int term;
  DateTime sdate;
  DateTime? edate;

  GoalEntity({
    required this.gid,
    required this.title,
    required this.descrip,
    required this.times,
    required this.frequency,
    required this.term,
    required this.sdate,
    this.edate,
  });

  Map<String, dynamic> toMap() {
    return {
      'gid': gid,
      'title': title,
      'descrip': descrip,
      'times': times,
      'frequency': frequency,
      'term': term,
      'sdate': sdate.toIso8601String()
    };
  }

  factory GoalEntity.fromMap(Map<String, dynamic> map) {
    return GoalEntity(
      gid: map['gid'],
      title: map['title'],
      descrip: map['descrip'],
      times: map['times'],
      frequency: map['frequency'],
      term: map['term'],
      sdate: DateTime.parse(map['sdate']),
      edate: map['edate'] != null ? DateTime.parse(map['edate']) : null,
    );
  }

}