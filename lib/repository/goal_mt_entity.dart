
class GoalMtEntity {
  String gid;
  String title;
  String descrip;
  int times;
  String frequency;
  int term;
  int reOpen;
  DateTime sdate;
  DateTime? edate;

  GoalMtEntity({
    required this.gid,
    required this.title,
    required this.descrip,
    required this.times,
    required this.frequency,
    required this.term,
    this.reOpen = 0,
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

  factory GoalMtEntity.fromMap(Map<String, dynamic> map) {
    return GoalMtEntity(
      gid: map['gid'],
      title: map['title'],
      descrip: map['descrip'],
      times: map['times'],
      frequency: map['frequency'],
      term: map['term'],
      reOpen: map['reOpen'] ?? 0,
      sdate: DateTime.parse(map['sdate']),
      edate: map['edate'] != null ? DateTime.parse(map['edate']) : null,
    );
  }

}