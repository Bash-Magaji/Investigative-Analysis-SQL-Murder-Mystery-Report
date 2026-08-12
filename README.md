
<img width="1774" height="887" alt="SQL Investigative Analytics" src="https://github.com/user-attachments/assets/993aa2f1-c38a-4021-a855-acc0c55416db" />


**1. Introduction**

This report documents a structured SQL-based criminal investigation conducted using the SQL City Police Department database. The objective was to identify the perpetrator of a murder that occurred on January 15, 2018, in SQL City and subsequently determine the individual who orchestrated the crime. Through a systematic process involving data retrieval, filtering, table joins, and investigative analysis, the investigation successfully identified Jeremy Bowers as the murderer and Miranda Priestly as the mastermind behind the crime. Although presented as a fictional investigation, this project mirrors real-world applications of SQL in:

•	Digital forensics

•	Law enforcement intelligence

•	Fraud detection

•	Insurance investigations

•	Compliance and audit analytics

•	Relational database querying

The investigation demonstrates how structured query language transforms fragmented records into actionable intelligence through logical filtering and relational analysis.

**Background**

The SQL City Police Department reported a murder that occurred on January 15, 2018, within SQL City. The original crime scene report had been misplaced, requiring investigators to reconstruct the case using information stored within the police database.

**Objective**

The objectives of this investigation were:

1.	Retrieve the crime scene report. 

2.	Identify and interview witnesses. 

3.	Determine the murder suspect. 

4.	Verify the suspect using supporting evidence. 

5.	Identify the individual who commissioned the murder. 

**Database Overview**

The investigation relied on several interconnected tables within the SQL City Police Department database.

**Table**                                   **Purpose**

crime_scene_report                        Crime incident records

Person                                    Personal identification and addresses

Interview                                 Witness and suspect statements

get_fit_now_member                        Gym membership records

get_fit_now_check_in                      Gym attendance logs

drivers_license                           Vehicle and physical descriptions

facebook_event_checkin                    Event attendance history

Income                                    Financial records

The relational nature of these tables enabled evidence to be linked through unique identifiers such as person_id, license_id, and membership_id.

**2. Investigation Methodology**

The investigation followed a structured data analysis approach:

1.	Crime scene report retrieval. 

2.	Witness identification. 

3.	Witness interview analysis. 

4.	Suspect identification through gym membership records. 

5.	Verification using gym attendance records. 

6.	Vehicle registration analysis. 

7.	Suspect confirmation through table joins. 

8.	Interrogation transcript analysis. 

9.	Identification of the mastermind through event attendance and demographic profiling. 

**3. Crime Scene Report Analysis**

**Query Executed**

The first step involved retrieving the crime scene report matching the known details:

•	Crime Type: Murder 

•	Date: January 15, 2018 

•	Location: SQL City 

SELECT *

FROM crime_scene_report

WHERE crime_type = 'murder'

AND date = 20180115

AND city = 'SQL City';

**Findings**

The report revealed that:

•	Two witnesses observed critical details related to the crime. 

•	The witnesses were located using address-based clues provided in the report. 

**4. Witness Identification**

**Witness 1:** Last House on Northwestern Drive

**Query:**

FROM person

WHERE address_street_name = 'Northwestern Dr'

ORDER BY address_number DESC;

**Result**

Name	ID

Morty Schapiro	14887

**Witness 2**: Annabel on Franklin Avenue

**Query:**

SELECT *

FROM person

WHERE name LIKE 'Annabel%'

AND address_street_name = 'Franklin Ave';

**Result**

Name	ID

Annabel Miller	16371

**5. Witness Interview**

**Interview Retrieval**

SELECT *

FROM interview

WHERE person_id IN (14887,16371);

**Key Statements**

**Morty Schapiro**

**Reported:**

•	Heard a gunshot. 

•	Saw a man fleeing the scene. 

•	The individual carried a Get Fit Now Gym bag. 

•	Membership number began with "48Z". 

•	The bag was exclusive to Gold Members. 

•	The suspect drove a vehicle with plate number containing "H42W". 

**Annabel Miller**

**Reported:**

•	Personally witnessed the murder. 

•	Recognized the suspect from Get Fit Now Gym. 

•	Saw him at the gym on January 9, 2018. 

**6. Suspect Identification** 

**Query**

SELECT *

FROM get_fit_now_member

WHERE id LIKE '48Z%'

AND membership_status = 'gold';

**Results**

Suspect	Membership ID	Person ID

Joe Germuska	48Z7A	28819

Jeremy Bowers	48Z55	67318

A third member, Tomas Baisley (48Z38), was excluded because he held a Silver membership, contradicting witness testimony.

**7. Verification Using Gym Check-In Records**

**Query**

SELECT *

FROM get_fit_now_check_in

WHERE membership_id IN ('48Z7A','48Z55','48Z38')

AND check_in_date = 20180109;

**Findings**

Name	Check-in Date

Joe Germuska	Present

Jeremy Bowers	Present

Tomas Baisley	Not Present

This confirmed that only Joe Germuska and Jeremy Bowers matched both witness statements.

**8. Vehicle Registration Analysis**

**Witness Vehicle Description**

The suspect's license plate contained:

H42W

**Query**

SELECT *

FROM drivers_license

WHERE plate_number LIKE '%H42W%'

AND gender = 'male';

**Results**

License ID	Plate Number

423327	0H42W2

664760	4H42WR

**9. Suspect Confirmation**

To associate vehicle records with individuals, a join was performed between the drivers_license and person tables.

**Query**

SELECT

dl.age,

dl.height,

dl.hair_color,

dl.eye_color,

dl.gender,

dl.plate_number,

dl.car_make,

dl.car_model,

p.name,

p.id

FROM drivers_license dl

LEFT JOIN person p

ON dl.id = p.license_id;

**Matching Results**

Cross-referencing gym membership records and vehicle ownership revealed:

Name	Membership ID	Plate Number
Jeremy Bowers	48Z55	0H42W2

Conclusion

All evidence aligned with Jeremy Bowers, confirming him as the murderer.

**Phase Two: Identifying the Mastermind**

**10. Interrogation of Jeremy Bowers**

**Query**

SELECT *

FROM interview

WHERE person_id = 67318;

**Jeremy's Statement**

Jeremy admitted that:

•	He was hired to commit the murder. 

•	The employer was a wealthy woman. 

•	She had: 

o	Red hair. 

o	Height between 65 and 67 inches. 

o	Drove a Tesla Model S. 

•	She attended the SQL Symphony Concert three times in December 2017. 

**11. Suspect Profiling**

**Query**

SELECT *

FROM full_details

WHERE height BETWEEN 65 AND 67

AND hair_color = 'red'

AND car_make = 'Tesla'

AND car_model = 'Model S'

AND gender = 'female';

**Results**

Name	Person ID

Red Korb	78881

Regina George	90700

Miranda Priestly	99716


**12. Event Attendance Verification**

**Query**

SELECT *

FROM facebook_event_checkin

WHERE person_id IN ('78881','90700','99716');

**Findings**

Only one suspect attended the SQL Symphony Concert exactly three times in December 2017:

Name	Attendance Dates

Miranda Priestly	Dec 6, Dec 12, Dec 29

**13. Financial Validation**

Income records further confirmed Miranda Priestly's profile as a wealthy individual.

**Query**

SELECT *

FROM income

WHERE annual_income >= 310000;

**Result**

Miranda Priestly met the financial profile described by Jeremy.


**Final Findings**

**Murderer Identified**

**Attribute	Value*

Name	**Jeremy Bowers**

Person ID	67318

Gym Membership	48Z55

Vehicle Plate	0H42W2

Jeremy Bowers matched all witness descriptions, gym records, and vehicle evidence, conclusively identifying him as the individual who committed the murder.

**Mastermind Identified**

**Attribute	Value*

Name	**Miranda Priestly**

Person ID	99716

Vehicle	Tesla Model S

Hair Color	Red

Height	65–67 inches

Concert Attendance	3 times in December 2017

Miranda Priestly matched every characteristic provided by Jeremy Bowers and was identified as the individual who orchestrated the murder.

**Conclusion**

Through the application of SQL querying techniques including filtering, pattern matching, record linkage, joins, and behavioral verification, the investigation successfully reconstructed the murder case. Evidence gathered from witness testimony, gym membership records, attendance logs, vehicle registrations, interview transcripts, event participation records, and income data led to the identification of:
•	Jeremy Bowers as the murderer. 
•	Miranda Priestly as the individual who commissioned the crime. 
This investigation demonstrates the effectiveness of relational database analysis in solving complex investigative cases and highlights how SQL can be used as a powerful tool for forensic data analysis and evidence-based decision-making.
