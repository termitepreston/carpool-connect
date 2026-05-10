import 'package:flutter_test/flutter_test.dart';
import 'package:models/models.dart';

void main() {
  test('User creation test', () {
    const user = User(
      id: '1',
      phone: '+251911000000',
      name: 'Test User',
      currentRole: UserRole.commuter,
    );
    expect(user.name, 'Test User');
    expect(user.currentRole, UserRole.commuter);
  });
}
