import 'package:FlutterGalleryApp/models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    user.addFriends([
      User(email: "oreshka.net@mail.ru", name: "den sa", phone: "+79991112233")
    ]);

    print(user.toString());

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exists");
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this email already exists");
    }

    return user;
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) {
      return users[login];
    } else {
      throw Exception("A user is not exists");
    }
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this phone already exists");
    }

    return user;
  }

  User findUserByFullName(String fullName) {
    User user;
    users.forEach((key, value) => {if (value.name == fullName) user = value});
    if (user == null) throw Exception("A user not find by full name");
    return user;
  }

  User findUserInFriends(String login, User user) {
    User userByLogin = getUserByLogin(login);
    if (!userByLogin.friends.contains(user)) {
      throw Exception("${user.login} is not a friend of the login");
    }

    return user;
  }

  void setFriends(String login, List<User> friends) {
    User user = getUserByLogin(login);
    user.addFriends(friends);
  }

  List<User> importUsers(List<String> csvUserList) {
    List<User> userList = [];
    csvUserList.forEach((element) {
      List<String> csvUser =
          element.split(";").map((element1) => element1.trim()).toList();
      userList
          .add(User(name: csvUser[0], email: csvUser[1], phone: csvUser[2]));
    });

    return userList;
  }
}
