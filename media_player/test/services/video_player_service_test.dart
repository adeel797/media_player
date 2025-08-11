import 'package:flutter_test/flutter_test.dart';
import 'package:media_player/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('VideoPlayerServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
