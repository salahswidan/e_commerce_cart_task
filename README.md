# 🛒 E-Commerce Cart System (Flutter)

This is a simple cart system for an e-commerce app built with **Flutter**. The main purpose of this project is to demonstrate clean architecture, Object-Oriented Programming (OOP), and adherence to **SOLID principles**.

---

## 📌 Features

* Add products to cart
* Remove products from cart
* Increase/decrease item quantity
* Apply promo codes for discounts
* Calculate total price after applying discount
* Store cart data using `SharedPreferences`
* Clear separation between logic and UI

---

## 🎯 Design Decisions

### ✅ Layered Architecture

* **Model Layer**: Contains data classes such as `Product` and `CartItem`.
* **Service Layer**: Business logic is encapsulated in `CartService` which handles all operations on the cart.
* **Controller Layer**: `CartController` acts as the interface between the UI and the service layer.
* **View Layer**: Screens like `HomeView` and `CartView` only handle UI logic and get data via `Provider`.

### ✅ State Management

* Used `ChangeNotifier` with `Provider` for light and effective state management.

### ✅ Persistent Storage

* Cart items and total price are saved in `SharedPreferences`, making the cart persist across app restarts.

---

## 🧠 OOP Concepts Applied

| OOP Principle     | Usage                                                                                                    |
| ----------------- | -------------------------------------------------------------------------------------------------------- |
| **Encapsulation** | Business logic is encapsulated in `CartService`, UI cannot access internal state directly.               |
| **Abstraction**   | `DiscountStrategy` provides an abstract interface for different discount types.                          |
| **Inheritance**   | `PromoCode` and `NoDiscount` both extend `DiscountStrategy`.                                             |
| **Polymorphism**  | We can set any discount logic using the base `DiscountStrategy` type without knowing the concrete class. |

---

## 🧱 SOLID Principles Implementation

| SOLID Principle               | Application                                                                                                                                    |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| **S - Single Responsibility** | Each class has one responsibility: `CartService` for logic, `CartController` for connecting logic to UI, `PromoCode` for discount logic, etc.  |
| **O - Open/Closed**           | You can add new discount strategies without modifying existing code, by creating new subclasses of `DiscountStrategy`.                         |
| **L - Liskov Substitution**   | You can replace `NoDiscount` or `PromoCode` anywhere `DiscountStrategy` is expected.                                                           |
| **I - Interface Segregation** | We don’t use fat interfaces; each class only uses what it needs (e.g., promo logic separated in `DiscountStrategy`).                           |
| **D - Dependency Inversion**  | `CartController` depends on `CartService` abstraction, and `CartService` accepts `DiscountStrategy` from the outside. No hardcoded dependency. |



## 📁 Folder Structure (Brief)

```
lib/
├── controller/
│   └── cart_controller.dart
│   └── promo_code.dart
│   └── no_discount.dart
├── model/
│   └── cart_item_model.dart
│   └── product_model.dart
├── services/
│   └── cart_services.dart
├── views/
│   └── home_view.dart
│   └── cart_view.dart
```

---

## 🧑‍💻 Author

**Salah Swidan**


Flutter Developer
Email: [salahswidan212@gmail.com](mailto:salahswidan212@gmail.com)

