import 'package:flutter/material.dart';

class AlphabetDragAndDrop extends StatefulWidget {
  @override
  _AlphabetDragAndDropState createState() => _AlphabetDragAndDropState();
}

class _AlphabetDragAndDropState extends State<AlphabetDragAndDrop> {
  List<String> word = "inner".split('');
  List<String> shuffledWord = [];
  Map<String, String?> containerValues = {};
  String generatedWord = "";

  @override
  void initState() {
    super.initState();
    shuffledWord = List.from(word)..shuffle(); // Shuffle the letters
  }

  @override
  Widget build(BuildContext context) {
    bool allContainersFilled = word.every((char) => containerValues[char] != null);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: shuffledWord.map((char) {
              return Expanded(
                child: Draggable<String>(
                  data: char,
                  child: Container(
                    height: 50,
                    width: double.infinity/shuffledWord.length,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      char,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  feedback: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      char,
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: word.map((char) {
              return Expanded(
                child: DragTarget<String>(
                  builder: (BuildContext context, List<String?> incoming, List rejected) {
                    return Container(
                      width: double.infinity/shuffledWord.length,
                      height: 50,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        containerValues[char] ?? '',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    );
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (data) {
                    setState(() {
                      containerValues[char] = data;
                      generatedWord = word.map((c) => containerValues[c] ?? "").join();
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: allContainersFilled ? () => print("Generated Word: $generatedWord") : null,
          style: ButtonStyle(
            backgroundColor: allContainersFilled
                ? MaterialStateProperty.all<Color>(Colors.green)
                : MaterialStateProperty.all<Color>(Colors.grey),
          ),
          child: Text("Generate Word"),
        ),
        SizedBox(height: 20),
        Text("Original Word: ${word.join()}"),
        Text("Generated Word: $generatedWord"),
      ],
    );
  }
}