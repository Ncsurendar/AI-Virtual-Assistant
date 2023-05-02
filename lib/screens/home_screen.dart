import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class HomeScreen extends StatefulWidget
{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
  TextEditingController userInputTextEditingController = TextEditingController();
  final SpeechToText speechToTextInstance = SpeechToText();
  String recordedAudioString = "";

  void initializeSpeechToText() async
  {
    await speechToTextInstance.initialize();

    setState(() {

    });
  }

  void startListeningNow() async
  {
    FocusScope.of(context).unfocus();
    await speechToTextInstance.listen(onResult: onSpeechToTextResult);

    setState(() {

    });

  }

  void stopListeningNow() async
  {
    await speechToTextInstance.stop();

    setState(() {

    });
  }

  void onSpeechToTextResult(SpeechRecognitionResult recognitionResult)
  {
    recordedAudioString = recognitionResult.recognizedWords;
    
    print("Speech Result:");
    print(recordedAudioString);

  }

  @override
  void initState() {
    super.initState();

    initializeSpeechToText();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: ()
        {

        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            "images/3 - sound.png"
          ),
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent.shade100,
                Colors.deepPurple,
              ]
            )
          ),
        ),
        title: Image.asset(
          "images/3 - logo.png",
          width: 140,
        ),
        titleSpacing: 10,
        elevation: 12,
        actions: [

          //chat
          Padding(
            padding: const EdgeInsets.only(right: 4, top: 4),
            child: InkWell(
              onTap: ()
              {

              },
              child: const Icon(
                Icons.chat,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),

          //image
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 4),
            child: InkWell(
              onTap: ()
              {

              },
              child: const Icon(
                Icons.image,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              //image
              Center(
                child: InkWell(
                  onTap: ()
                  {
                    speechToTextInstance.isListening
                        ? stopListeningNow()
                        : startListeningNow();

                  },
                  child: Image.asset(
                      "images/3 - assistant-icon.png",
                    height: 300,
                    width: 300,
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),


              //text field with a button
              Row(
                children: [

                  //text field
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: TextField(
                        controller: userInputTextEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "How can I assist You?",
                        ),

                      ),
                    ),

                  ),

                  const SizedBox(width: 10,),

                  //button
                  InkWell(
                    onTap: ()
                    {
                      print("Send User Input");

                    },
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.deepPurpleAccent
                      ),
                      duration: const Duration(
                        milliseconds: 1000,
                      ),
                      curve: Curves.bounceInOut,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30,

                      ),
                    ),
                  ),

                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
