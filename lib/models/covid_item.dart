class Covid_item {
  final String txn_date;
  final String province;
  final int new_case;
  final int total_case;
  final int new_case_excludeabroad;
  final int total_case_excludeabroad;
  final int new_death;
  final int total_death;
  final String update_date;

  Covid_item({
    required this.new_case_excludeabroad,
    required this.total_case_excludeabroad,
    required this.new_death,
    required this.total_death,
    required this.update_date,
    required this.txn_date,
    required this.province,
    required this.new_case,
    required this.total_case,
  });

  factory Covid_item.fromJson(Map<String, dynamic> json) {
    return Covid_item(
      txn_date: json['txn_date'],
      province: json['province'],
      new_case: json['new_case'],
      total_case: json['total_case'],
      total_case_excludeabroad: json['total_case_excludeabroad'],
      total_death: json['total_death'],
      new_case_excludeabroad: json['new_case_excludeabroad'],
      update_date: json['update_date'],
      new_death: json['new_death'],
    );
  }

  Covid_item.fromJson2(Map<String, dynamic> json)
      : txn_date = json['txn_date'],
        province = json['province'],
        new_case = json['new_case'],
        total_case = json['total_case'],
        total_case_excludeabroad = json['total_case_excludeabroad'],
        total_death = json['total_death'],
        new_case_excludeabroad = json['new_case_excludeabroad'],
        update_date = json['update_date'],
        new_death = json['new_death'];

  @override
  String toString() {
    return '$txn_date : $province : $new_case คน $total_case คน '
        '$new_case_excludeabroad คน $total_case_excludeabroad คน '
        '$new_death คน $total_death คน $update_date';
  }
}
