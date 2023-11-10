class UserResponseEntity {
  int status;
  String message;
  UserDataEntity data;

  UserResponseEntity(
      {required this.status, required this.message, required this.data});
}

class UserDataEntity {
  String iduser;
  String userName;
  String userEmail;
  String userFoto;
  String userAsalSekolah;
  DateTime dateCreate;
  String jenjang;
  String userGender;
  String userStatus;
  String kelas;

  UserDataEntity({
    required this.iduser,
    required this.userName,
    required this.userEmail,
    required this.userFoto,
    required this.userAsalSekolah,
    required this.dateCreate,
    required this.jenjang,
    required this.userGender,
    required this.userStatus,
    required this.kelas,
  });
}
