class GoogleFacebookModel {
  String _id;
  String _email;
  String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String _image;
  String _accountType;

  GoogleFacebookModel(this._id, this._name, this._email, this._image, this._accountType);

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get accountType => _accountType;

  set accountType(String value) {
    _accountType = value;
  }
}
