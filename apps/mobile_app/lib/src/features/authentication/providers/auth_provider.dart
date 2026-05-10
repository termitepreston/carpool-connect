import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  Future<User?> build() async {
    AppLogger.info('Auth: Initializing and showing splash for 6s...');
    await Future.delayed(const Duration(seconds: 6));
    return null;
  }

  Future<void> sendOtp(String phone) async {
    AppLogger.info('Auth: sendOtp initiated');
    state = const AsyncLoading();
    try {
      await MockBackend.sendOtp(phone);
      state = const AsyncData(null);
    } catch (e, st) {
      AppLogger.error('Auth: sendOtp failed', e, st);
      state = AsyncError(e, st);
    }
  }

  Future<void> verifyOtp(String phone, String code) async {
    AppLogger.info('Auth: verifyOtp initiated');
    state = const AsyncLoading();
    try {
      final user = await MockBackend.verifyOtp(phone, code);
      AppLogger.info('Auth: verifyOtp successful, user logged in');
      state = AsyncData(user);
    } catch (e, st) {
      AppLogger.error('Auth: verifyOtp failed', e, st);
      state = AsyncError(e, st);
    }
  }

  Future<void> setupProfile(String name, UserRole role) async {
    AppLogger.info('Auth: setupProfile initiated');
    final currentUser = state.value;
    if (currentUser == null) return;
    state = const AsyncLoading();
    try {
      final user = await MockBackend.setupProfile(
        id: currentUser.id,
        name: name,
        role: role,
      );
      AppLogger.info('Auth: setupProfile successful');
      state = AsyncData(user);
    } catch (e, st) {
      AppLogger.error('Auth: setupProfile failed', e, st);
      state = AsyncError(e, st);
    }
  }

  void switchRole(UserRole newRole) {
    AppLogger.info('Auth: switchRole to $newRole');
    final user = state.value;
    if (user != null) {
      state = AsyncData(user.copyWith(currentRole: newRole));
    }
  }

  void logout() {
    AppLogger.info('Auth: logged out');
    state = const AsyncData(null);
  }
}
