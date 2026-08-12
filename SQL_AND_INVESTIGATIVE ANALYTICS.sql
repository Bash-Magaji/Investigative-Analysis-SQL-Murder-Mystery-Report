

/* A crime has taken place and the detective needs your help. 
The detective gave you the crime scene report but you somehow lost it. 
You vaguely remembered the the crime was a murder that occured 
sometime on January 15, 2018 and that it took place in SQL City. 
Start by retrieving the correseponding crime scene report from the 
police department database */


-- Begin Investigation

/* Details:
   Crime Document lost - Crime scene report
   --information vaguely remembered;
     - Crime type - Murder
     - Date - January 15, 2018
     - Location - SQL City 

/ Police Department Database has been downloaded into the Server.

Start by retrieving the correseponding crime scene report 
from the police depertment database */

-- Retrieving the crime_scene_report

SELECT * FROM crime_scene_report
WHERE crime_type = 'murder' 
AND 
DATE = 20180115
AND 
city = 'SQL City'

/* Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave".*/

-- callout the person table

SELECT * FROM person

-- Retrieve the two witnesses

-- Retrieving the first witness details

SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC;

/* First witness 
Name - Morty Schapiro
ID - 14887
License_id - 118009
Address_number - 4919
Street_name - Northwestern Dr
Ssn - 111564949 */


-- Retrieving the second witness details

SELECT * FROM person
WHERE name LIKE 'Annabel%'
AND
address_street_name = 'Franklin Ave'

/* Second witness 
Name - Annabel Miller
ID - 16371
License_id - 490173
Address_number - 103
Street_name - Franklin Ave
Ssn - 318771143 */


-- Phase Two --
-- To interview the two witnesses

/* First witness 
Name - Morty Schapiro
ID - 14887
License_id - 118009
Address_number - 4919
Street_name - Northwestern Dr
Ssn - 111564949 

 Second witness 
Name - Annabel Miller
ID - 16371
License_id - 490173
Address_number - 103
Street_name - Franklin Ave
Ssn - 318771143 */

-- callout the Interview table

SELECT * FROM interview
WHERE person_id IN (14887,16371);

/* Morty Schapiro who is the first witness with the ID - 14887 said, 
I heard a gunshot and then saw a man run out. 
He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". 
Only gold members have those bags. 
The man got into a car with a plate that included "H42W".

While Annabel Miller, the second witness with ID - 16371 said, 
I saw the murder happen, and I recognized the killer from my gym 
when I was working out last week on January the 9th. 

Key details
Person is a "He", Gunshot, Gym, Get fit Now Gym, Membership number start with "48Z",  
Gold Member, Car plate number which include "H42W", January the 9th. */

-- callout the get_fit_now_member --

CREATE TABLE suspect AS (SELECT * FROM get_fit_now_member
WHERE id LIKE '48Z%' 
AND
membership_status = 'gold')

/* Now we have two main suspects who are on gold membership
Suspect one
Name: Joe Germuska, 
id - 48Z7A
person_id - 28819
membership_start_date - 20160305
membership_status - gold

Suspect two
Name: Jeremy Bowers, 
id - 48Z55
person_id - 67318
membership_start_date - 20160101
membership_status - gold

However, there is another person whose id has "48Z" 
but on silver membership status, indicating not only gold members have that id number.

Suspect three
Name: Tomas Baisley, 
id - 48Z38
person_id - 49550
membership_start_date - 20170203
membership_status - silver */

-- Callout the get_fit_now_check_in table to find thier checkin logs--

SELECT * FROM get_fit_now_check_in
WHERE membership_id IN('48Z7A','48Z55','48Z38')
AND
check_in_date = 20180109;

/* Joe Germuska with id - 48Z7A, checked in at 1600 and 
checked out at 1730 on January 9, 2018 while, Jeremy Bowers with id - 48Z55 also checked in at 1530 and 
checked out at 1700 on same date.

However, the investigation shows that Tomas Baisley with id - 48Z38 
who is a silver member did not check in this date 
therefore has been striked out of further investigation */

-- callout the drivers_license table for further investigation into the two suspects --

CREATE TABLE suspected_licenses AS (SELECT * FROM drivers_license
WHERE plate_number LIKE ('%H42W%') 
AND gender = 'male')

/* Suspected plate numbers
1. plate_number - 0H42W2, car_make - Chevrolet, car_model - Spark LS, License_id - 423327
age - 30, height - 70, eye_color - brown, hair_color - brown
2. plate_number - 4H42WR, car_make - Nissan, car_model - Altima, License_id - 664760
age - 21, height - 71, eye_color - black, hair_color - black */

SELECT * FROM drivers_license

/* In order to pinpoint who is actually the murder there is a need to match this information
with another table. Hence, joining the drivers license table and the person table together will give 
a full detail fo the suspects. */

CREATE TABLE Full_details AS (SELECT dl.age, dl.height, dl.hair_color, dl.eye_color, dl.gender,dl.plate_number, dl.car_make, dl.car_model,
        p.name,p.ssn,p.address_street_name,p.id
FROM drivers_license AS dl
LEFT JOIN person AS p
ON dl.id = p.license_id);


SELECT * FROM full_details
WHERE plate_number IN ('0H42W2','4H42WR')

-- the killer has been confirmed to be JEREMY BOWERS with plate_number 0H42W2

/* Congrats, you found the murderer! But wait, there's more... 
If you think you're up for a challenge, 
try querying the interview transcript of the murderer to find the real villain behind this crime.

-- PHASE THREE --

Find out who sent Jeremy

In order to find out the villian behind the murder, 
there is a need to pull the interview records to know what Jeremy said during his interview */

-- callout the interview table

SELECT * FROM interview

-- search for Jeremy Bowers id to see his transcript.

SELECT * FROM interview
WHERE person_id = 67318;

/* Jeremy in his interview said, I was hired by a woman with a lot of money. 
I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017. 

Key details

Hired by a woman, she's rich, Height is around 5'5" (65") or 5'7" (67"),
Hair color is red, car type is Tesla Model S.
event attended - symphony concert, 3 times in December 2017. */

-- callout the full_details table --

SELECT * FROM full_details

-- search for the first details --

SELECT * FROM full_details
WHERE height BETWEEN 65 AND 67
AND 
hair_color = 'red'
AND
car_make = 'Tesla'
AND 
car_model = 'Model S'
AND
gender = 'female'

/* Now we have three suspects that matches the discription Jeremy gave. They are;
1. Red Korb with id - 78881
2. Regina George with id - 90700
3. Miranda Priestly with id - 99716

To find who among these three suspects have attended the symphony event as described by Jeremy,
we find out from the facebook_event_checkin table. */

-- callout facebook_event_checkin table --

SELECT * FROM facebook_event_checkin
WHERE person_id IN ('78881','90700','99716')

/* Our vallian who sent Jeremy to commit murder is Miranda Priestly with id - 99716
she attended the SQL Symphony Concert 3 times in December 2017 (on the 6th, 12th and 29th).*/ 

SELECT * FROM income
WHERE ssn IN ('961388910','337169072','987756388')
AND annual_income >= 310000

/* Congrats, you found the brains behind the murder! 
Everyone in SQL City hails you as the greatest SQL detective of all time. 
Time to break out the champagne! */
