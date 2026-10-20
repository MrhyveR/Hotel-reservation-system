# Матриця трасування: вимога ↔ сценарій ↔ UC ↔ user story

| Вимога | Форма | Сценарії | Use Cases | User stories |
|---|---|---|---|---|
| REQ-01 - Пошук вільних номерів за періодом | Event-driven | SC-01, SC-02 | UC-01 | US-01 |
| REQ-02 - Фільтр за зручностями (усі обрані) | Event-driven | SC-03 | UC-01 | US-01 |
| REQ-03 - Відхилення некоректного періоду | Unwanted | SC-04 | UC-02 | US-01 |
| REQ-04 - Відхилення заїзду в минулому | Unwanted | SC-05 | UC-02 | US-01 |
| REQ-05 - Створення бронювання | Event-driven | SC-06 | UC-03 | US-02, US-05 |
| REQ-06 - Повторне використання Guest за email | Event-driven | SC-07 | UC-03 | US-02, US-05 |
| REQ-07 - Відхилення бронювання з перетином | Unwanted | SC-08 | UC-03 | US-02, US-05 |
| **REQ-08** - Неподільність перевірки й створення | Ubiquitous | **не покрито** | UC-03 | US-02, US-05 |
| REQ-09 - Відхилення некоректних контактних даних | Unwanted | SC-09 | UC-03 | US-02 |
| REQ-10 - Показ вартості | Event-driven | SC-10 | UC-03, UC-04 | US-02 |
| REQ-11 - Скасування гостем (id + email) | Event-driven | SC-11 | UC-06 | US-03 |
| REQ-12 - Однакова відмова для чужого email / неіснуючого id | Unwanted | SC-12 | UC-06 | US-03 |
| REQ-13 - Заборона скасування не-confirmed | Unwanted | SC-13 | UC-06 | US-03 |
| REQ-14 - Скасування працівником ресепшну | Event-driven | SC-14 | UC-06 | US-06 |
| REQ-15 - Скасований / завершений період вільний | State-driven | SC-15, SC-19 | UC-01, UC-06, UC-08 | US-06, US-08 |
| REQ-16 - Заселення | Event-driven | SC-16 | UC-07 | US-07 |
| REQ-17 - Відхилення заселення за статусом | Unwanted | SC-17 | UC-07 | US-07 |
| REQ-18 - Відхилення заселення за датою | Unwanted | SC-18 | UC-07 | US-07 |
| REQ-19 - Виселення | Event-driven | SC-19 | UC-08 | US-08 |
| REQ-20 - Лист-підтвердження | Event-driven | SC-20 | UC-03, UC-05 | US-04 |
| REQ-21 - Лист про скасування | Event-driven | SC-21 | UC-05, UC-06 | US-04 |
| REQ-22 - Недоступний Email Service | Unwanted | SC-22 | UC-05 | US-04 |
| REQ-23 - Створення RoomType | Event-driven | SC-23 | UC-10 | US-09 |
| REQ-24 - Створення Room | Event-driven | SC-24 | UC-11 | US-09 |
| REQ-25 - Відхилення дубліката room_number | Unwanted | SC-25 | UC-11 | US-09 |
| REQ-26 - Зв'язок Room ↔ Facility | Event-driven | SC-26 | UC-12 | US-10 |
| REQ-27 - Заборона видалення Room з активним Booking | Unwanted | SC-27 | UC-11 | US-09 |
| REQ-28 - Перелік бронювань | Event-driven | SC-28 | UC-09 | US-11 |

## Непокриті вимоги
- **REQ-08** (неподільність перевірки перетину й створення `Booking`). Перевіряється інтеграційним тестом із двома паралельними запитами.