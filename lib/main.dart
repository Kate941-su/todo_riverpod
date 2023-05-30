import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 値（ここでは "Hello world"）を格納する「プロバイダ」を作成します。
// プロバイダを使うことで値のモックやオーバーライドが可能になります。
final helloWorldProvider = Provider((_) => 'Hello world');
final counterProvider = StateProvider((ref) => 0);

void main() {
  runApp(
    // プロバイダをウィジェットで利用するには、アプリ全体を
    // `ProviderScope` ウィジェットで囲む必要があります。
    // ここに各プロバイダのステート（状態）・値が格納されていきます。
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

// StatelessWidget の代わりに Riverpod の ConsumerWidget を継承します。


class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);
    StateController<int> counter = ref.watch(counterProvider.notifier);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer(builder: (context, ref, _) {
                final count = ref.watch(counterProvider);
                return Text(count.toString());
              })
            ],
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            counter.state++;
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
