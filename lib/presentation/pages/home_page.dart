import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_clean_architecture/common/state_enum.dart';
import 'package:trivia_clean_architecture/presentation/provider/number_trivia_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    Future.microtask(
        () => Provider.of<NumberTriviaNotifier>(context, listen: false)..fetchRandomNumberTrivia());

    super.initState();
  }

  @override
  void dispose() {
    _numberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trivia Number Description"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<NumberTriviaNotifier>(builder: (context, data, child) {
                final state = data.triviaState;

                if (state == RequestState.empty) {
                  return const SizedBox();
                }

                if (state == RequestState.loading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state == RequestState.loaded) {
                  final trivia = data.trivia;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        trivia.number.toString(),
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          trivia.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      "Unknown error",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              }),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Number is empty';
                          }
                          return null;
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Input a number',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Provider.of<NumberTriviaNotifier>(context, listen: false)
                                  .fetchConcreteNumberTrivia(
                                      int.tryParse(_numberController.text) ?? 0);
                            }
                          },
                          child: const Text('Search'),
                        ),
                        ElevatedButton(
                          onPressed: () => Provider.of<NumberTriviaNotifier>(context, listen: false)
                            ..fetchRandomNumberTrivia(),
                          child: const Text('Random Number'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
