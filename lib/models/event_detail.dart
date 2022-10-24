class EventDetail {
  String? id;
  String _description;
  String _date;
  String _startTime;
  String _endTime;
  String _speaker;
  String _isFavorite;

  EventDetail(this.id, this._description, this._date, this._startTime,
      this._endTime, this._speaker, this._isFavorite);

  String get description => _description;
  String get date => _date;
  String get startTime => _startTime;
  String get endTime => _endTime;
  String get speaker => _speaker;
  // ignore: unnecessary_getters_setters
  String get isFavorite => _isFavorite;
  set isFavorite(String s) {
    _isFavorite = s;
  }

  EventDetail.fromMap(Map<String, dynamic> eventDetail)
      : id = eventDetail['id'],
        _date = eventDetail['date'],
        _description = eventDetail['description'],
        _startTime = eventDetail['start_time'],
        _endTime = eventDetail['end_time'],
        _speaker = eventDetail['speaker'],
        _isFavorite = eventDetail['is_favorite'].toString();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['description'] = _description;
    map['date'] = _date;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['speaker'] = _speaker;
    map['is_favorite'] = _isFavorite == "true";
    return map;
  }
}
