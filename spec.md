# Специфікація ER-моделі (Hotel-reservation-system)

## Критерії прийняття
* Промт для AI: "Згенеруй Mermaid erDiagram на основі наведених сутностей."
* **Типізація ID**: Усі ідентифікатори (ID) повинні мати єдиний тип даних `uuid`.
* Модель знаходиться у Третій нормальній формі (3NF).

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

5. **RoomFacility (Сполучна таблиця)**
   - `room_id` (uuid) - foreign key
   - `facility_id` (uuid) - foreign key

6. **Booking (Бронювання)**
   - `id` (uuid) - primary key
   - `guest_id` (uuid) - foreign key
   - `room_id` (uuid) - foreign key
   - `check_in` (date)
   - `check_out` (date)
   - `status` (string)