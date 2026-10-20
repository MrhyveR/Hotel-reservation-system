# language: uk
Функціонал: Бронювання номерів у готелі

  Передумова:
    Дано в каталозі є RoomType "Standard" з base_price 100 і RoomType "Deluxe" з base_price 200
    І є Room "101" і "102" типу "Standard" та Room "201" типу "Deluxe"
    І є Facility "Wi-Fi" і "Balcony"
    І поточна дата — 2026-11-01

  # ---------- Пошук ----------

  @SC-01 @REQ-01 @UC-01
  Сценарій: Пошук повертає лише вільні номери
    Дано Room "101" має Booking зі статусом "confirmed" на 2026-11-10…2026-11-13
    Коли Guest шукає номери з check_in 2026-11-11 і check_out 2026-11-12
    Тоді результат містить Room "102" і "201"
    І результат не містить Room "101"

  @SC-02 @REQ-01 @UC-01
  Сценарій: День виїзду попереднього гостя вільний для нового заїзду
    Дано Room "101" має Booking зі статусом "confirmed" на 2026-11-10…2026-11-13
    Коли Guest шукає номери з check_in 2026-11-13 і check_out 2026-11-15
    Тоді результат містить Room "101"

  @SC-03 @REQ-02 @UC-01
  Сценарій: Пошук за кількома зручностями вимагає всі
    Дано Room "101" пов'язана з "Wi-Fi" і "Balcony"
    І Room "102" пов'язана лише з "Wi-Fi"
    Коли Guest шукає номери на вільні дати із зручностями "Wi-Fi" і "Balcony"
    Тоді результат містить Room "101"
    І результат не містить Room "102"

  @SC-04 @REQ-03 @UC-02
  Сценарій: Період, де check_out не пізніший за check_in, відхиляється
    Коли Guest шукає номери з check_in 2026-11-10 і check_out 2026-11-10
    Тоді система відхиляє пошук і повідомляє про некоректний період

  @SC-05 @REQ-04 @UC-02
  Сценарій: Заїзд у минулому відхиляється
    Коли Guest шукає номери з check_in 2026-10-31 і check_out 2026-11-03
    Тоді система відхиляє пошук і повідомляє про минулу дату

  # ---------- Створення бронювання ----------

  @SC-06 @REQ-05 @UC-03
  Сценарій: Новий гість бронює вільний номер
    Дано Guest з email "ann@example.com" не існує
    Коли Guest подає full_name "Ann", email "ann@example.com", phone "+380501112233" і бронює Room "101" на 2026-11-10…2026-11-13
    Тоді створено Guest "ann@example.com"
    І створено Booking зі статусом "confirmed" для Room "101", пов'язаний із цим Guest

  @SC-07 @REQ-06 @UC-03
  Сценарій: Повторне бронювання тим самим email не створює дубліката гостя
    Дано існує Guest з email "ann@example.com"
    Коли Guest подає email "Ann@Example.com" і бронює Room "102" на 2026-11-20…2026-11-22
    Тоді створено Booking, пов'язаний з існуючим Guest
    І кількість Guest з email "ann@example.com" дорівнює 1

  @SC-08 @REQ-07 @UC-03
  Сценарій: Бронювання з перетином періоду відхиляється
    Дано Room "101" має Booking зі статусом "confirmed" на 2026-11-10…2026-11-13
    Коли Guest бронює Room "101" на 2026-11-12…2026-11-14
    Тоді система відхиляє бронювання
    І нового Booking не створено

  @SC-09 @REQ-09 @UC-03
  Структура сценарію: Некоректні контактні дані відхиляються
    Коли Guest подає full_name "<full_name>", email "<email>", phone "<phone>" і бронює Room "101" на вільні дати
    Тоді система відхиляє бронювання і вказує поле "<поле>"

    Приклади:
      | full_name | email           | phone         | поле      |
      |           | ann@example.com | +380501112233 | full_name |
      | Ann       | ann-at-example  | +380501112233 | email     |
      | Ann       | ann@example.com |               | phone     |
      | Ann       | ann@example.com | 12-ab         | phone     |

  @SC-10 @REQ-10 @UC-03 @UC-04
  Сценарій: Після бронювання показується вартість
    Коли Guest бронює Room "101" (RoomType "Standard") на 2026-11-10…2026-11-13
    Тоді система показує вартість проживання 300

  # ---------- Скасування ----------

  @SC-11 @REQ-11 @UC-06
  Сценарій: Guest скасовує своє бронювання за id та email
    Дано існує Booking зі статусом "confirmed" для Guest "ann@example.com"
    Коли Guest надає id цього Booking та email "ann@example.com" і скасовує бронювання
    Тоді Booking отримує статус "cancelled"

  @SC-12 @REQ-12 @UC-06
  Структура сценарію: Чужий email або неіснуючий id дають однакову відмову
    Дано існує Booking зі статусом "confirmed" для Guest "ann@example.com"
    Коли Guest надає id "<id>" та email "<email>" і скасовує бронювання
    Тоді система відхиляє скасування з повідомленням "Бронювання не знайдено"
    І статус існуючого Booking лишається "confirmed"

    Приклади:
      | id                 | email           |
      | id цього Booking   | bob@example.com |
      | неіснуючий id      | ann@example.com |

  @SC-13 @REQ-13 @UC-06
  Структура сценарію: Бронювання не у статусі confirmed не скасовується
    Дано існує Booking зі статусом "<статус>" для Guest "ann@example.com"
    Коли Guest надає id цього Booking та email "ann@example.com" і скасовує бронювання
    Тоді система відхиляє скасування
    І статус Booking лишається "<статус>"

    Приклади:
      | статус      |
      | checked_in  |
      | checked_out |
      | cancelled   |

  @SC-14 @REQ-14 @UC-06
  Сценарій: Receptionist скасовує підтверджене бронювання
    Дано існує Booking зі статусом "confirmed"
    Коли Receptionist скасовує це бронювання
    Тоді Booking отримує статус "cancelled"

  @SC-15 @REQ-15 @UC-01 @UC-06
  Сценарій: Скасований період знову з'являється в пошуку
    Дано Room "101" має Booking зі статусом "cancelled" на 2026-11-10…2026-11-13
    Коли Guest шукає номери з check_in 2026-11-10 і check_out 2026-11-13
    Тоді результат містить Room "101"

  # ---------- Заселення і виселення ----------

  @SC-16 @REQ-16 @UC-07
  Сценарій: Заселення підтвердженого бронювання в день заїзду
    Дано існує Booking зі статусом "confirmed" на 2026-11-01…2026-11-03
    Коли Receptionist реєструє заселення
    Тоді Booking отримує статус "checked_in"

  @SC-17 @REQ-17 @UC-07
  Сценарій: Заселення скасованого бронювання відхиляється
    Дано існує Booking зі статусом "cancelled" на 2026-11-01…2026-11-03
    Коли Receptionist реєструє заселення
    Тоді система відхиляє операцію
    І статус Booking лишається "cancelled"

  @SC-18 @REQ-18 @UC-07
  Сценарій: Заселення раніше дати заїзду відхиляється
    Дано існує Booking зі статусом "confirmed" на 2026-11-05…2026-11-07
    Коли Receptionist реєструє заселення
    Тоді система відхиляє операцію
    І статус Booking лишається "confirmed"

  @SC-19 @REQ-15 @UC-08
  Сценарій: Виселення завершує проживання
    Дано існує Booking зі статусом "checked_in"
    Коли Receptionist реєструє виселення
    Тоді Booking отримує статус "checked_out"

  # ---------- Сповіщення ----------

  @SC-20 @REQ-20 @UC-03 @UC-05
  Сценарій: Після бронювання до Email Service передається лист-підтвердження
    Коли Guest "ann@example.com" створює Booking для Room "101" на 2026-11-10…2026-11-13
    Тоді Email Service отримує email "ann@example.com" та room_number "101", check_in 2026-11-10 і check_out 2026-11-13

  @SC-21 @REQ-21 @UC-05 @UC-06
  Сценарій: Після скасування до Email Service передається лист про скасування
    Дано існує Booking зі статусом "confirmed" для Guest "ann@example.com"
    Коли Receptionist скасовує це бронювання
    Тоді Email Service отримує email "ann@example.com" та room_number, check_in і check_out цього Booking для листа про скасування

  @SC-22 @REQ-22 @UC-05
  Сценарій: Недоступний Email Service не скасовує бронювання
    Дано Email Service недоступний
    Коли Guest створює Booking для Room "101" на 2026-11-10…2026-11-13
    Тоді Booking існує зі статусом "confirmed"
    І Guest бачить повідомлення, що лист не надіслано

  # ---------- Каталог ----------

  @SC-23 @REQ-23 @UC-10
  Сценарій: Administrator створює RoomType
    Коли Administrator створює RoomType "Suite" з base_price 350
    Тоді RoomType "Suite" збережено

  @SC-24 @REQ-24 @UC-11
  Сценарій: Administrator створює Room
    Коли Administrator створює Room з room_number "301", floor 3 і RoomType "Deluxe"
    Тоді Room "301" збережено

  @SC-25 @REQ-25 @UC-11
  Сценарій: Дублікат room_number відхиляється
    Коли Administrator створює Room з room_number "101", floor 1 і RoomType "Standard"
    Тоді система відхиляє створення
    І Room з room_number "101" лишається один

  @SC-26 @REQ-26 @UC-12
  Сценарій: Administrator пов'язує Facility з Room
    Коли Administrator пов'язує Facility "Wi-Fi" з Room "201"
    Тоді зв'язок Room "201" — Facility "Wi-Fi" збережено

  @SC-27 @REQ-27 @UC-11
  Сценарій: Room із активним бронюванням не видаляється
    Дано Room "101" має Booking зі статусом "confirmed"
    Коли Administrator видаляє Room "101"
    Тоді система відхиляє видалення
    І Room "101" та її Booking існують

  @SC-28 @REQ-28 @UC-09
  Сценарій: Staff бачить перелік бронювань
    Дано існує Booking для Guest "Ann", Room "101", 2026-11-10…2026-11-13, статус "confirmed"
    Коли Staff відкриває перелік бронювань
    Тоді рядок містить full_name "Ann", room_number "101", check_in 2026-11-10, check_out 2026-11-13 і status "confirmed"