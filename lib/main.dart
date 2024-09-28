import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 18), // Updated
        ),
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'F to C'; // Initial conversion type
  String _convertedValue = '';
  List<String> _conversionHistory = [];

  // Conversion formulas
  double _fahrenheitToCelsius(double fahrenheit) => (fahrenheit - 32) * 5 / 9;
  double _celsiusToFahrenheit(double celsius) => celsius * 9 / 5 + 32;

  // Perform the conversion
  void _convertTemperature() {
    double inputValue = double.tryParse(_controller.text) ?? 0.0;
    double result;

    if (_conversionType == 'F to C') {
      result = _fahrenheitToCelsius(inputValue);
    } else {
      result = _celsiusToFahrenheit(inputValue);
    }

    setState(() {
      _convertedValue = result.toStringAsFixed(2);
      _conversionHistory.add(
          '$_conversionType: ${inputValue.toStringAsFixed(1)} => $_convertedValue');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field with some styling
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                labelStyle: TextStyle(fontSize: 20, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            // Conversion type selection (F to C or C to F)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: DropdownButton<String>(
                value: _conversionType,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    _conversionType = newValue!;
                  });
                },
                items: <String>['F to C', 'C to F']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 18)),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),

            // Convert button with styling
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.blueAccent, // Updated from `primary`
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _convertTemperature,
              child: Text(
                'Convert',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Display the converted temperature
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Text(
                'Converted Value: $_convertedValue',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),

            // Conversion history
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: ListView.builder(
                  itemCount: _conversionHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.history, color: Colors.blue),
                      title: Text(
                        _conversionHistory[index],
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
