class Profile {
  final String firstname;
  final String lastname;

  Profile(this.firstname, this.lastname);

  Map<String, dynamic> toJson() => {'firstname': firstname, 'lastname': lastname};
  factory Profile.fromJson(Map<String, dynamic> json) => Profile(json['firstname'], json['lastname']);
}
