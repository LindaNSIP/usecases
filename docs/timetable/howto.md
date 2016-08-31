
## How to implement third party timetable provision


### 1. What's the business problem?


Allow schools to securely provide SIS information to the Timetabling
product of their choice, and also to allow timetable records (including
teaching groups and scheduled activities) to be published to a
jurisdictional data hub. 

**[More...](#what-business-problem-does-this-usecase-address)**

 

### 2. Usecase description & pre-conditions

A third party timetabling application connects to HITS as a jurisdiction
hub, collecting the relevant information and publishing back timetable
records to the centralised system.

#### Assumptions: {#Timetablehow-toHITS-Assumptions}

3^rd^ Party Vendor is a current supplier of a Timetabling product in
schools or has knowledge of Timetabling and scheduling processes in K-12
Schools.  <span> </span>

#### <span style="color: rgb(51,51,51);">Pre-Conditions:</span> {#Timetablehow-toHITS-Pre-Conditions}

-   Vendor has access to HITs
-   HITs has been provisioned with School Data
-   Vendor has mapped the relevant SIF Objects to their systems:\
    StudentPersonal\
    StudentSchoolEnrolment\
    StaffPersonal\
    StaffAssignment\
    RoomInfo\
    SchoolCourseInfo (optional)\
    TimeTableSubject\
    <span>TimeTable</span>\
    <span>TimeTableCell\
    TeachingGroup\
    ScheduledActivity (optional)</span>

(Here is more information on the **[Timetable Baseline
Profile](http://kb.nsip.edu.au/download/attachments/13960399/Timetable+Baseline+Profile+v011.pdf)**.)

#### <span style="color: rgb(51,51,51);">Usecase workflow summary:</span> {#Timetablehow-toHITS-Usecaseworkflowsummary}

1.  Join

2.  Consume

3.  Process

4.  Provide

5.  Assurance

#### <span style="color: rgb(51,51,51);">Assurance:</span> {#Timetablehow-toHITS-Assurance}

The SIF/XML data sent by the 3^rd^ Party app to the Jurisdiction Zone
for the app must satisfy the following conditions:

-   Must be able to respond to requests for all TimeTable records within
    a School

-   Must be able to respond to requests for all TimeTableCell records
    within a School

-   Must be able to respond to requests for all
    <span>TeachingGroup</span> records within a School

-   Must be able to respond to requests for all
    <span>ScheduledActivity</span> records within a School (optional)

The SchoolCourseInfo object is only required if the Timetabling
application will record the link between the School Course offering (as
distinct from the Timetable Subject) and the Teaching Group. This link
is optional, and application developers should check with the School
Authority on whether they need to provide it.

The ScheduledActivity object is designed for student activities that do
not involve classroom instruction, and/or that are not recurring; e.g.
excursions. They do not need to be implemented by a
TimeTablingApplication (and in fact they relate to scheduling rather
than timetabling); <span>application developers should check with the
School Authority on whether they need to provide it.</span>

<span>[More...](#usecase-preconditions-for-assurance)</span>
---------------------------------------------

 

3. Join school zone.
--------------------

<span>Join:</span>

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1")
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz")
-   Jurisdiction Zone authorises read access to objects in the
    Jurisdiction Zone for the School ("HITS Zone 1 Authn")

 

4. Consume base data from HITS.
-------------------------------

<span>Vendor-facing (pull); HITS represents the Jurisdiction and is the
data source for seed information.</span>

-   <span>Consume:</span>
-   on the Jurisdiction-established Zone for the App, Third party app
    accesses all StudentPersonal records which are in a
    StudentSchoolEnrollment relationship with the given School RefId
-   <span>on the Jurisdiction-established Zone for the App, Third party
    app accesses </span>all StaffPersonal records which are in a
    StaffAssignment relationship with the given School RefId
-   <span>on the Jurisdiction-established Zone for the App, Third party
    app accesses </span>all RoomInfo objects linked to the given
    School RefId.
-   on the Jurisdiction-established Zone for the App, Third party app
    accesses all TimeTableSubject objects linked to the given
    School RefId.
-   on the Jurisdiction-established Zone for the App, Third party app
    accesses all SchoolCourseInfo objects linked to the given
    School RefId. (optional)
-   <span style="font-size: 10.0pt;line-height: 13.0pt;">Third party app
    ingests the relevant SIF Objects.</span>

\
\[The following is a list of calls that need to be made to consume the
required information – and should happen automatically. Is this possible
in HITs?\]

1.  Get SchoolInfos: <span
    style="color: rgb(0,0,255);">http://.../SchoolInfos</span>
2.  Get StudentSchoolEnrollments: <span
    style="color: rgb(0,0,255);">http://.../</span><span>[StudentSchoolEnrollments]()</span>
3.  Get StudentPersonals: http://.../<span>[StudentPersonals]() (linked
    to school via StudentSchoolEnrollment; equivalent to
    [http://..../SchoolInfo/\\{REFID}/StudentSchoolEnrollments/{REFID}/StudentPersonals]() )</span>
4.  <span>Get StaffAssignments: http://.../StaffAssignments</span>
5.  Get StaffPersonals:
    [http://.../S](http://hits.nsip.edu.au/SchoolInfo/%7b%7d/CalendarDates){.external-link}taffPersonals
    (linked to school via StaffAssignment; equivalent to
    http://.../SchoolInfo/\\{REFID}/StaffAssignments/{REFID}/StaffPersonals )
6.  Get RoomInfos:<span> [http://.../RoomInfos]()</span>
7.  Get TimeTableSubjects: [http://.../TimeTableSubjects]()
8.  Get SchoolCourseInfos: [http://.../SchoolCourseInfos]()

Endpoints may support additional queries for retreiving data - refer to
**[Query-by-example or service paths?](qbe-or-service-paths)** for HITS
guidance on queries.

 

5. Process in 3^rd^ party application.
--------------------------------------

The third party app uses the consumed data to produce a timetable. The
definition and automation of this process is out of scope of HITs.\
Steps:

-   Third party app processes information and generates timetable
-   Third party application creates return timetabling objects specific
    to the School

 

**6. Provide authoritative data**

Prior to providing:<span> </span>

<span> </span>Third party expresses return information in SIF/XML:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1")
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz")
-   Jurisdiction-established Zone authorises write access to objects in
    the Jurisdiction Zone for the School ("HITS Zone 1 Authn")
-   Following is provided by the 3^rd^ Party App back to HITs;
    1.  Post TimeTable to URL http://.../TimeTables
    2.  Post TimeTableCell to URL http://../TimeTableCells
    3.  Post TeachingGroup to URL http://../TeachingGroups
    4.  Post ScheduledActivity to URL http://.../ScheduledActivitys

 

7. Self – confirm  usecase support
----------------------------------

1.  1.  Validate <span>TimeTable records</span>
    2.  Validate <span>TimeTableCell records </span>
    3.  <span>Validate TeachingGroup records</span>
    4.  <span>Validate ScheduledActivity records</span>

### More information {#Timetablehow-toHITS-Moreinformation}


#### What business problem does this usecase address?

In brief:

-   Allow schools secure access to SIS information
-   Allow schools to use the Timetabling product of their choice
-   Allow third party timetabling apps automated access to base
    information
-   Allow third party timetabling apps to publish a school's schedule to a
    jurisdictional hub.

Schools currently use third-party timetabling applications locally to
supplement their Student Information System (SIS). The seed information
for generating timetables is held in the School's SIS and usually
exported locally with little security. \
\
As jurisdictions centralise systems, third party vendors have the
opportunity to seed their product/s from a quality assured data hub
using automated feeds, rather than manual updates from the
school. Third party vendors are also expected to provide information
directly back to the centralised system through an automated feed,
rather than having the information mediated through the school. 

This use case shows how third party vendors can connect to a
centralised data hub to securely access to the required information and
publish back the timetable records to the centralised data hub.

#### Usecase preconditions for assurance

The following conditions also must be
met:

-   <span style="color: rgb(0,0,0);">Any SIF object published by the App
    must be valid against the SIF-AU 1.3 schema</span>
-   <span style="color: rgb(0,0,0);">All SIF objects posted by the
    Timetabling App must have referential integrity. Any RefId contained
    in the SIF object must refer either to a SIF object provisioned to
    the App—e.g. SchoolInfo, StudentPersonal, RoomInfo,
    TimeTableSubject), or to SIF object that has also been posted by the
    App to the Zone (e.g. TimeTableCell referring to TimeTable).This
    condition applies recursively to all additional SIF objects posted
    by the App. The test of this condition is done only when the App
    indicates that it has finished publishing to the Zone the objects
    required for the test.</span>

<span style="color: rgb(0,0,0);">For the purposes of validation, a new
TeachingGroup object is well-formed if:</span>

-   1.  All mandatory elements of the TeachingGroup object are provided
    2.  The TeachingGroup contains a TeachingGroupPeriodList
    3.  The TeachingGroupPeriodList references either
        TimeTableCellRefId, or a combination of RoomNumber, DayId, and
        either PeriodId or StartTime
    4.  <span style="font-size: 10.0pt;line-height: 13.0pt;">The
        TeachingGroup must contain a StudentList. The Students
        referenced in the StudentList must have StudentPersonal RefIds
        and Names corresponding to those supplied
        in provisioning.</span>
    5.  The TeachingGroup must contain a TeacherList. The Teachers
        referenced in the TeacherList must have StaffPersonal RefIds and
        Names corresponding to those supplied in provisioning.
    6.  The TeachingGroup must reference a SchoolInfo RefId. 

For the purposes of validation, a new TimeTableCell object is
well-formed if it satisfies the following requirements:

1.  All mandatory elements of the TimeTableCell object are provided\
     

-   <span style="font-size: 10.0pt;line-height: 13.0pt;">For the
    purposes of validation, an update to a TeachingGroup object can be a
    partially populated object, containing only the updated values,
    rather than a complete object</span>
-   <span style="font-size: 10.0pt;line-height: 13.0pt;">If an update to
    TeachingGroup involves any element <span>being added, changed, or
    deleted in</span> TeacherList, StudentList, or
    TeachingGroupPeriodList, then the entire list affected must be
    included in the object representation in the update request.</span>

 

 

 
