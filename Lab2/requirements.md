# Вимоги (EARS)

Шаблони: `WHEN <тригер>, система SHALL <реакція>` · `WHILE <стан>, система SHALL <реакція>` · `IF <тригер>, THEN система SHALL <реакція>` · `Система SHALL <реакція>` (постійна). Назви сутностей і атрибутів - як у моделі Завдання 1. Правила домену (активне бронювання, період, статуси) - у [`spec.md`](spec.md).

## Пошук

- **REQ-01** [Event-driven] WHEN Guest або Receptionist задає `check_in` і `check_out`, система SHALL показати всі `Room`, для яких немає активного `Booking` із періодом, що перетинається із заданим.
- **REQ-02** [Event-driven] WHEN до пошуку додано одну або кілька `Facility`, система SHALL показати лише `Room`, пов'язані з усіма обраними `Facility`.
- **REQ-03** [Unwanted] IF `check_out` не пізніший за `check_in`, THEN система SHALL відхилити пошук і повідомити про некоректний період.
- **REQ-04** [Unwanted] IF `check_in` раніший за поточну дату, THEN система SHALL відхилити пошук і повідомити про минулу дату.

## Створення бронювання

- **REQ-05** [Event-driven] WHEN Guest або Receptionist подає `full_name`, `email`, `phone`, `Room`, `check_in` і `check_out` для вільного `Room`, система SHALL створити `Booking` зі статусом `confirmed`, пов'язаний з `Guest`.
- **REQ-06** [Event-driven] WHEN подані дані містять `email`, що збігається без урахування регістру з `email` існуючого `Guest`, система SHALL пов'язати `Booking` із цим `Guest` і не створювати нового.
- **REQ-07** [Unwanted] IF для `Room` існує активний `Booking` із періодом, що перетинається, THEN система SHALL відхилити бронювання і не створювати `Booking`.
- **REQ-08** [Ubiquitous] Система SHALL виконувати перевірку перетину періодів і створення `Booking` як одну неподільну операцію.
- **REQ-09** [Unwanted] IF `full_name`, `email` або `phone` порожні, `email` не має вигляду `<текст>@<домен з крапкою>` або `phone` не складається з необов'язкового `+` і 10–15 цифр, THEN система SHALL відхилити бронювання і вказати некоректне поле.
- **REQ-10** [Event-driven] WHEN `Booking` створено, система SHALL показати вартість проживання в одиницях `base_price`, обчислену як (`check_out` − `check_in`) у днях × `RoomType.base_price`, а також унікальний id створеного `Booking`.

## Скасування

- **REQ-11** [Event-driven] WHEN Guest надає id `Booking` та `email`, що збігається з `email` його `Guest`, а `Booking` має статус `confirmed`, система SHALL встановити статус `cancelled`.
- **REQ-12** [Unwanted] IF Guest надає `email`, що не збігається з `email` `Guest` цього `Booking`, або id неіснуючого `Booking`, THEN система SHALL відхилити скасування з однаковим повідомленням для обох випадків.
- **REQ-13** [Unwanted] IF `Booking` має статус `checked_in`, `checked_out` або `cancelled`, THEN система SHALL відхилити скасування.
- **REQ-14** [Event-driven] WHEN Receptionist скасовує `Booking` зі статусом `confirmed`, система SHALL встановити статус `cancelled`.
- **REQ-15** [State-driven] WHILE `Booking` має статус `cancelled` або `checked_out`, система SHALL вважати його період вільним для `Room`.

## Заселення і виселення

- **REQ-16** [Event-driven] WHEN Receptionist реєструє заселення для `Booking` зі статусом `confirmed`, а поточна дата належить `[check_in, check_out)`, система SHALL встановити статус `checked_in`.
- **REQ-17** [Unwanted] IF Receptionist реєструє заселення для `Booking` зі статусом, відмінним від `confirmed`, THEN система SHALL відхилити операцію.
- **REQ-18** [Unwanted] IF Receptionist реєструє заселення, а поточна дата не належить `[check_in, check_out)`, THEN система SHALL відхилити операцію.
- **REQ-19** [Event-driven] WHEN Receptionist реєструє виселення для `Booking` зі статусом `checked_in`, система SHALL встановити статус `checked_out`.

## Сповіщення

- **REQ-20** [Event-driven] WHEN `Booking` створено, система SHALL передати Email Service `email` гостя, id `Booking` та `room_number`, `check_in`, `check_out` цього `Booking` для листа-підтвердження.
- **REQ-21** [Event-driven] WHEN `Booking` отримав статус `cancelled`, система SHALL передати Email Service `email` гостя, id `Booking` та `room_number`, `check_in`, `check_out` цього `Booking` для листа про скасування.
- **REQ-22** [Unwanted] IF Email Service недоступний, THEN система SHALL залишити `Booking` без змін і повідомити особі, яка діяла, що лист не надіслано.

## Каталог

- **REQ-23** [Event-driven] WHEN Administrator створює `RoomType` з `name` і `base_price` більшим за 0, система SHALL зберегти `RoomType`.
- **REQ-24** [Event-driven] WHEN Administrator створює `Room` з `room_number`, `floor` та існуючим `RoomType`, система SHALL зберегти `Room`.
- **REQ-25** [Unwanted] IF `room_number` уже існує, THEN система SHALL відхилити створення `Room`.
- **REQ-26** [Event-driven] WHEN Administrator пов'язує `Facility` із `Room`, система SHALL зберегти цей зв'язок.
- **REQ-27** [Unwanted] IF Administrator видаляє `Room`, для якого існує будь-який `Booking` (активний, скасований чи завершений), THEN система SHALL відхилити видалення, щоб захистити зовнішній ключ `Booking.room_id` та зберегти історію.
- **REQ-29** [Event-driven] WHEN Administrator створює `Facility` з `name` і `description`, система SHALL зберегти `Facility`.

## Перегляд

- **REQ-28** [Event-driven] WHEN Staff відкриває перелік бронювань, система SHALL показати `full_name`, `room_number`, `check_in`, `check_out` і `status` кожного `Booking`.
- **REQ-29** [Event-driven] WHEN Administrator створює `Facility` з `name`, система SHALL зберегти `Facility`.