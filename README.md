# 🍔 Food Delivery App (Flutter + Firebase)

A learning-based Food Delivery Mobile Application built using **Flutter** and **Firebase**.  
This project was inspired by Shivam Gupta’s tutorial, with custom enhancements including **Razorpay payment integration**.

---

## 🚀 Features

- 🔐 User Authentication (Firebase Auth)
- 🏬 Browse Food Items
- 💳 Secure Payment Integration using Razorpay
- ☁️ Real-time Data Storage with Firebase Firestore
- 📦 Order Placement & Order History

---

## 🛠 Tech Stack

- **Frontend:** Flutter, Dart  
- **Backend / Database:** Firebase  
  - Firebase Authentication  
  - Cloud Firestore  
- **Payment Gateway:** Razorpay  
- **State Management:** setState  
- **Tools:** VS Code, Git  

---

## 💡 Key Enhancements (My Contribution)

- Replaced Stripe (used in tutorial) with **Razorpay Payment Gateway**
- Implemented payment success & failure callbacks
- Integrated Firebase Authentication & Firestore database
- Managed full application state using **setState**
- Customized UI flow and validation logic

---

## 📂 Getting Started

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/gokilavani-dev/food_app.git
cd food_app
2️⃣ Install Dependencies
flutter pub get

3️⃣ Firebase Setup

Create a Firebase project in Firebase Console

Enable Email/Password Authentication

Create a Cloud Firestore Database

Download and add:

google-services.json → android/app/

Configure Firebase in main.dart

4️⃣ Razorpay Setup

Create a Razorpay account

Generate API keys

Add keys securely inside the project
⚠️ Do not commit secret keys to GitHub

5️⃣ Run the App
flutter run

🎓 Learning Source

Inspired by Shivam Gupta’s Flutter Food Delivery Tutorial
https://www.youtube.com/watch?v=en8H2re8Njs

⚠️ Disclaimer

This project was developed for educational and portfolio purposes only.
