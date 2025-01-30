import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  var text = '''##  To-Do List App  
**Organize your life, one task at a time.**  


## Description  
This app is your personal task manager, helping you stay on top of your goals and deadlines.



## Features  
- Add, edit, and delete tasks.  
- Organize tasks into categories.  
- Set reminders for important deadlines.  x


## Version  
**1.0.0** 



## Developed by  
**Nityen**  


---

## Contact Us  
📧 **Email:** [nityendroid@gmail.com](mailto:nityendroid@gmai)

---

## Terms and Policies  

- [Privacy Policy](https://yourwebsite.com/privacy)  
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
        child: Markdown(data: text),
      ),
    );
  }
}
