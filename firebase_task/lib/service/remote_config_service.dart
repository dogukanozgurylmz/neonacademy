import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  late final FirebaseRemoteConfig _remoteConfig;

  void init() {
    _remoteConfig = FirebaseRemoteConfig.instance;
  }

  Future<void> setupRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));
  }

  Future<void> defaultSettings() async {
    await _remoteConfig.setDefaults(const {
      "addpost": true,
    });
  }

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  bool showAddPost() {
    return _remoteConfig.getBool('addpost');
  }
}
