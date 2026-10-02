# Специфікація ER-моделі (Hotel-reservation-system)

## Критерії прийняття
* Промт для AI: "Згенеруй Mermaid erDiagram на основі наведених сутностей та зв'язків. Модель має бути в 3NF. Не створюй фізичних сполучних таблиць для зв'язків багато-до-багатьох, використовуй виключно синтаксис Mermaid }|--|{."
* **Типізація ID**: Усі ідентифікатори (ID) повинні мати єдиний тип даних `uuid`.
* **Нормалізація**: Модель знаходиться у Третій нормальній формі (3NF).
* **Чисті M:N зв'язки**: Не створюй фізичних сполучних таблиць для зв'язку багато-до-багатьох, використовуй виключно синтаксис Mermaid `}|--|{`.
* **Асоціативні сутності**: Створюються лише тоді, коли зв'язок несе власні атрибути.

## Сутності та атрибути
1. **Guest (Гість)**
   - `id` (uuid) - primary key
   - `email` (string)
   - `phone` (string)
   - `full_name` (string)

2. **RoomType (Тип номеру)**
   - `id` (uuid) - primary key
   - `name` (string)
   - `base_price` (number)

3. **Room (Номер)**
   - `id` (uuid) - primary key
   - `room_number` (string)
   - `floor` (number)
   - `type_id` (uuid) - foreign key

4. **Facility (Зручність)**
   - `id` (uuid) - primary key
   - `name` (string)
   - `description` (string)

5. **Booking (Бронювання)**
   - `id` (uuid) - primary key
   - `guest_id` (uuid) - foreign key
   - `room_id` (uuid) - foreign key
   - `check_in` (date)
   - `check_out` (date)
   - `status` (string)

## Зв'язки
* **RoomType ↔ Room**: (1:N)
* **Room ↔ Facility**: (M:N)
* **Guest ↔ Booking**: (1:N)
* **Room ↔ Booking**: (1:N)