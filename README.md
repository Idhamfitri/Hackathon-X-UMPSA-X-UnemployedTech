# HACKATHON X UMPSA
## Group: UNEMPLOYED TECH
## SELF CARE MOBILE APPLICATION
Introduction In alignment with Sustainable Development Goal 3 (SDG 3) on Health and Well-being, SelfCare is a mobile application designed to foster mental and emotional well-being for users, particularly students and young adults facing daily challenges. The app offers a safe space for users to reflect, manage, and enhance their mental health through features that encourage self-awareness and positive habits. SelfCare provides a versatile journal for recording thoughts and feelings, a chatbox powered by AI for confidential problem-sharing, a mood tracker to help users express their emotions, and a personalised feed of motivational quotes to inspire and uplift. Each feature is crafted to support a holistic approach to self-care, enabling users to explore self-reflection and mental resilience in a user-friendly digital environment.

## Features
-Acc management - this feature is mainly focused on creating , and recovery of user account, there are login , sign up , and account recovery involved . User need to fill in their username and password before accessing the apps. If user don't have any account, user can sign up , There is a databases implemented to store the information locally. If user forgot their password, user can click the ‘forgot password’ text for account recovery purpose. User need to fill their email and the system will send link for password changes.

-Chat with Zecki - This module is a chat application integrating Google’s Gemini AI for interactive and personalised user engagement. It allows users to share thoughts and express their feelings openly ,and chat like real friends . Users that are introverted will totally fine to use these apps. The application initialises the Gemini AI model and provides a chat-like experience where users' input and AI suggestions are displayed sequentially with custom UI elements. The layout is user-friendly with conversation bubbles for easy readability, a text field for input, and an elegant button for sending messages. Error handling is included to ensure smooth interaction, with memory management to clear unused data for optimised performance.

-Qoutes Page - In the Quotes of the Day feature of SelfCare, users have access to an expansive library of motivational quotes tailored to support their emotional and mental well-being. This feature is powered by Gemini AI, which dynamically generates unique quotes daily. Users can choose from categories such as Inspiration, Relationship, Stress, Self-Care, Study, Spiritual, and Islamic.

Once a category is selected, a unique quote appears, which users can like or copy for personal use or sharing. This feature provides a tailored, uplifting experience, encouraging users to find motivation and insight that resonates with them each day.

-Journal - In the Journal feature of SelfCare, users can write their memories or stories about their day and it will be stored in the database provided by SQLite tools. Users can write their journal title and express their feelings below. Clicking the save journal button will send the data to the table created in the database. In the main screen of the journal feature, journals that are made by the user will appear in the ListView of the card. Users can click the card to see the journal that the user made in the past day. There is also a date state in the Journal to keep track when the user is happy or sad. All the journals are connected to the database. There are also delete functions in this feature so that users can delete bad memories.

## Tools
Flutter Flutter is the primary framework for building the app on both Android and iOS. We chose Flutter because it has Cross-Platform Capability. Flutter allows us to write a single codebase that runs on both Android and iOS, saving time and resources. Secondly, Rich UI Components. Flutter's extensive widget library makes it easy to create visually appealing interfaces, which is crucial for an app focused on mental wellness and user engagement. Last but not least, Flutter has Fast Development. Hot reload and an active developer community make Flutter an ideal choice for rapid prototyping and iteration.

SQLite SQLite is used as the app’s local database solution for securely storing user data. The choice of SQLite was based on Lightweight and Efficient. As a self-contained, serverless database, SQLite fits perfectly in a mobile app where users need quick, offline access to data. Data Persistence is the second feature in this tool. SQLite ensures that journal entries and user inputs are safely stored, even when the app is closed and reopened. Seamless Integration with Flutter in SQLite works well using plugins such as sqflite, allowing straightforward database setup and usage.

## Dart

Key features that it has that make Dart as our choice is Optimised for UI. Dart’s syntax is clean and readable, making it easy to work with widgets and create expressive, structured UIs. It’s tailored for building complex and responsive interfaces, which is ideal for applications like your self-care app. Just-in-Time (JIT) and Ahead-of-Time (AOT) Compilation in Dart allows for hot reload, making development faster as you can immediately see code changes in the app without a full restart. AOT compilation means Dart compiles to native machine code, optimising performance and reducing startup time for release versions. Dart has robust support for Asynchronous Programming with async and await, making it easier to handle tasks like database operations, network requests, or file reads efficiently without freezing the app’s interface.

## API

In this project , We are implementing Gemini AI in the system by integrating API keys from Gemini AI website to our code.
path of the API key : lib (folder) => first=app(folder) => Quotes (folder) => quotes (files) 
                      lib (folder) => first=app(folder) => Zecki (file) 
-You need to create an API key followed by Gemini AI dependency :

To know more about API can refer …. -Since this API key is free tier , there is limited use per day.
Before running this code , make sure to replace the current API key with your own API key on the code , follow the comment instruction in the code to replace.
