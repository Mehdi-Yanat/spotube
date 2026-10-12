import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spotube/components/titlebar/titlebar.dart';

import 'package:spotube/hooks/configurators/use_window_listener.dart';
import 'package:spotube/provider/user_preferences/user_preferences_provider.dart';
import 'package:spotube/utils/platform.dart';
import 'package:titlebar_buttons/titlebar_buttons.dart';
import 'package:window_manager/window_manager.dart';

class WindowTitleBarButtons extends HookConsumerWidget {
  final Color? foregroundColor;
  const WindowTitleBarButtons({
    super.key,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    final preferences = ref.watch(userPreferencesProvider);
    final isMaximized = useState<bool?>(null);
    const type = ThemeType.auto;

    Future<void> onClose() async {
      await windowManager.close();
    }

    useWindowListener(
      onWindowMaximize: () {
        isMaximized.value = true;
      },
      onWindowUnmaximize: () {
        isMaximized.value = false;
      },
    );

    useEffect(() {
      if (kIsDesktop) {
        windowManager.isMaximized().then((value) {
          isMaximized.value = value;
        });
      }
      return null;
    }, []);

    if (!kTitlebarVisible || preferences.systemTitleBar) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedMinimizeButton(
          type: type,
          onPressed: windowManager.minimize,
        ),
        DecoratedMaximizeButton(
          type: type,
          onPressed: () async {
            if (await windowManager.isMaximized()) {
              await windowManager.unmaximize();
              isMaximized.value = false;
            } else {
              await windowManager.maximize();
              isMaximized.value = true;
            }
          },
        ),
        DecoratedCloseButton(
          type: type,
          onPressed: onClose,
        ),
      ],
    );
  }
}
