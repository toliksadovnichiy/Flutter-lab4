Future<String> printMessage(var message) {
  return Future.delayed(const Duration(seconds: 4), () => message);
}

// void doSomeWork() {
//   Future<String> future = printMessage("Some message");
//   future.then((value) => print(value)).catchError((err) => print(err));
// }

Future<void> doSomeWork() async {
  var future = await printMessage("Some message");
  print(future);
}

void main() {
  doSomeWork();
  print("Doing some things...");
}
