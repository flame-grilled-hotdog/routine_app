class GoalProgressEntity {
   String gid;
   DateTime udate;

  GoalProgressEntity({
    required this.gid,
    required this.udate,
  });

  Map<String, dynamic> toMap() {
    return {
      'gid': gid,
      'udate': udate.toIso8601String(),
    };
  }

  factory GoalProgressEntity.fromMap(Map<String, dynamic> map) {
    return GoalProgressEntity(
      gid: map['gid'],
      udate: DateTime.parse(map['udate']),
    );
  }
}