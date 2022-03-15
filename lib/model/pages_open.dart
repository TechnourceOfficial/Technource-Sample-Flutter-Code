class PagesOpen{
  String _content;
  String _file;

  String get file => _file;

  set file(String value) {
    _file = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  PagesOpen(this._content,this._file);
}