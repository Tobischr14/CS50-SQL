-- Keep a log of any SQL queries you execute as you solve the mystery.


-- get the right crime scene report
select * from crime_scene_reports
where year == 2021 and month = 7 and day = 28 and street == "Humphrey Street";
-- -> hint: 3 interview reports mentioning "bakery"
-- time of theft 10:15am


-- get interviews mentioned in the crime scene report
select * from interviews
where year == 2021 and month = 7 and day = 28 and transcript like "%bakery%";
-- hint: check security footage of bakery parking lot within 10min after theft
-- hint: thief was at the atm on Leggett Street the same morning withdrawing money
-- hint: thief called for less than 1 min, thief planning earliest flight out of Fiftyville tomorrow, purchase by other person on the phone


-- get personal information about bankaccount holders doing withdrawal the same morning
    -- 1. get account_numbers from atm transactions
    -- 2. get person_id from bank_account informations
    -- 3. get personal information about bank_account holders
select * from people
where id in
(
    select person_id from bank_accounts
    where account_number in
    (
        select account_number from atm_transactions
        where year == 2021 and month = 7 and day = 28 and atm_location == "Leggett Street" and transaction_type == "withdraw"
    )
);

-- check security footage at barking lot of bakery within 10 min after theft
    -- get numberplates
select * from bakery_security_logs
where year == 2021 and month = 7 and day = 28 and hour = 10 and minute between 15 and 25;


-- combine numberplates and personal information from atm withdrawal
select * from people
where id in
(
    select person_id from bank_accounts
    where account_number in
    (
        select account_number from atm_transactions
        where year == 2021 and month = 7 and day = 28 and atm_location == "Leggett Street" and transaction_type == "withdraw"
    )
)
and license_plate in
(
    select license_plate from bakery_security_logs
    where year == 2021 and month = 7 and day = 28 and hour = 10 and minute between 15 and 25
);
-- => 4 possible thiefs: iman luca diana bruce


-- check first flight next morning
-- select city from airports
-- where id =
-- (
    -- select destination_airport_id from flights
    select * from flights
    where origin_airport_id ==
    (
        select id from airports
        where city == "Fiftyville"

    )
    and year == 2021 and month = 7 and day = 29
    order by hour, minute
    limit 1;
-- );
-- =>destination = New York City, flight id = 36


-- get passenger in flight which is in 4 potential thiefs from above
select name from people
where passport_number in
(
    select passport_number from passengers
    where flight_id = 36
)
and id in
(
    select person_id from bank_accounts
    where account_number in
    (
        select account_number from atm_transactions
        where year == 2021 and month = 7 and day = 28 and atm_location == "Leggett Street" and transaction_type == "withdraw"
    )
)
and license_plate in
(
    select license_plate from bakery_security_logs
    where year == 2021 and month = 7 and day = 28 and hour = 10 and minute between 15 and 25
);
-- => 2 potential thiefs left (thief and accomplice): bruce and luca


-- check phone calls for thief as caller and accomplice as receiver
select name, caller from phone_calls
join people
on caller = phone_number
where year == 2021 and month = 7 and day = 28 and duration < 60 and caller in
(
    select phone_number from people
    where passport_number in
    (
        select passport_number from passengers
        where flight_id = 36
    )
    and id in
    (
        select person_id from bank_accounts
        where account_number in
        (
            select account_number from atm_transactions
            where year == 2021 and month = 7 and day = 28 and atm_location == "Leggett Street" and transaction_type == "withdraw"
        )
    )
    and license_plate in
    (
        select license_plate from bakery_security_logs
        where year == 2021 and month = 7 and day = 28 and hour = 10 and minute between 15 and 25
    )
);
-- => thief is bruce
