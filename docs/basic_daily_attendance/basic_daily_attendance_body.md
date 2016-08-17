3rd party Daily Attendance Recording
====================================

1. What's the business problem?
-------------------------------

Allow schools to securely provide SIS information to the Attendance
product of their choice, and also to allow school attendance records to
be published to a jurisdictional data hub.
**[More...](#businessdriver)**

 

2. Use Case Description & Pre-Conditions
----------------------------------------

A 3rd Party Daily Attendance application connects to HITS as a
jurisdiction hub, collecting the relevant information and publishing
back attendance records to the centralised system.
{#DailyAttendancehow-toHITS-Assumptions}

#### Assumptions:

3rd Party Vendor is a current supplier of a Student Attendance product
in schools or has knowledge of Student attendance reporting processes in
K-12 Schools. {#DailyAttendancehow-toHITS-Pre-Conditions}

#### Pre-Conditions:

-   Vendor has access to HITs
-   HITs has been provisioned with School Data
-   Vendor has mapped the relevant SIF Objects to their systems:

    StudentPersonal

    StudentSchoolEnrolment

    CalendarDate

    CalendarSummary

    StudentDailyAttendance

    StudentAttendanceSummary

    StudentAttendanceTimeList

(Note that some of these objects are proposed for SIF 1.4 and are
therefore not in the SIF 1.3 schema.)

Here is [**a draft XSD schema for SIF
1.4**](http://kb.nsip.edu.au/download/attachments/13960456/SIF_Message1.4_3.x_current.zip),
further information on
**[StudentAttendanceTimeList](http://kb.nsip.edu.au/download/attachments/13960401/DSWG_V1.4_ChangeProposal_StudentAttendanceTimeList_0.5.pdf)**,
and a detailed description of the **[Attendance Baseline
Profile](http://kb.nsip.edu.au/download/attachments/13960401/Daily+Attendance+Baseline+Profile+v09.pdf)**.)
{#DailyAttendancehow-toHITS-Usecaseworkflowsummary}

#### Usecase workflow summary:

1.  Join

2.  Consume

3.  Process

4.  Provide

5.  Assurance
{#DailyAttendancehow-toHITS-Assurance}

#### Assurance:

The SIF/XML data sent by the 3rd Party app to the Jurisdiction Zone
for the app must satisfy the following conditions:

-   Must be able to respond to requests for all StudentDailyAttendance
    records within a School

-   Must be able to respond to requests for all StudentDailyAttendance
    records within a School and a nominated date range

-   Must be able to respond to requests for all StudentDailyAttendance
    records for a nominated Student

-   Must be able to respond to requests for all StudentDailyAttendance
    records for a nominated Student and a nominated date range

-   Must be able to respond to requests for all StudentAttendanceSummary
    records within a School

-   Must be able to respond to requests for all StudentAttendanceSummary
    records for a nominated Student and a nominated date range

-   Must be able to respond to requests for all
    StudentAttendanceTimeList records within a School

-   Must be able to respond to requests for all
    StudentAttendanceTimeList records within a School and a nominated
    date range

-   Must be able to respond to requests for all
    StudentAttendanceTimeList records for a nominated Student

-   Must be able to respond to requests for all
    StudentAttendanceTimeList records for a nominated Student and a
    nominated date range

Note that in some deployments, only StudentDailyAttendance records, only
StudentAttendanceSummary records, or only StudentAttendanceTimeList
records may be required.

**[More...](#assurance)**


3. Join required School Zone.
-----------------------------

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1")
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz")
-   Jurisdiction Zone authorises read access to objects in the
    Jurisdiction Zone for the School ("HITS Zone 1 Authn")

 

4. Consume Base Data from HITS.
-------------------------------

Vendor-facing (pull); HITS
represents the Jurisdiction and is the data source for seed
information.

Consume:

-   on the Jurisdiction-established Zone for the App, Third party
    app  accesses all StudentPersonal records which are in a
    StudentSchoolEnrollment relationship with the given School RefId.
-    on the Jurisdiction-established Zone for the App,
    Third party app accesses all
    CalendarSummary objects linked to the given School RefId, and all
    CalendarDate objects linked to the given CalendarSummary objects.
    (In some deployments, calendar information about schools is already
    held centrally. For those deployments, this step is skipped.)
-   Third party app ingests the relevant SIF Objects.

The following is a list of calls that need to be made to consume the
required information:

1.  Get SchoolInfos - http://.../SchoolInfos  (HITS should determine the
    URLs eg http://hits.nsip.edu.au/SchoolInfos -
    access this information from your Dashboard.)
2.  Get StudentSchoolEnrollments - http://.../StudentSchoolEnrollments
3.  Get StudentPersonals  -  http:// .../StudentPersonals
    (linked to school via StudentSchoolEnrollment; eg: equivalent
    to  http:// .../SchoolInfo/\\{REFID}/StudentSchoolEnrollments/{REFID}/StudentPersonals)
4.  Get CalendarDates  -    http:// .../CalendarDates
5.  Get CalendarSummarys  -  http:// .../CalendarSummarys

Endpoints may support additional queries for retreiving data - refer to
**[Query-by-example or service paths?](/docs/common/qbe_or_service_paths.md)** for HITS
guidance on queries.

 

5. Process in 3rd Party Application.
--------------------------------------

3rd Party App uses the consumed data to produce a schedule. The
definition and automation of this process is out of scope of HITs.

Steps:

-   Third party app processes information and gathers Student Attendance
    Information
-   Third party application creates return Student Daily Attendance
    objects specific to the School

 

6. Provide Authoritative Data
-----------------------------

Prior to providing:  

   Third party expresses return
information in SIF/XML:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1")
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz")
-   Jurisdiction-established Zone authorises write access to objects in
    the Jurisdiction Zone for the School ("HITS Zone 1 Authn")
-   Following is provided by the 3^rd^ Party App back to HITs;
    1.  Post StudentDailyAttendance to http:// .../StudentDailyAttendances
    2.  Post StudentAttendanceSummary to http:// .../StudentAttendanceSummarys
    3.  Post StudentAttendanceTimeList to
        http://.../StudentAttendanceTimeLists

 

7. Assurance: Self – Confirmation of Use Case Support
-----------------------------------------------------

1.  Validate StudentDailyAttendance records
2.  Validate StudentAttendanceSummary records
3.  Validate StudentAttendanceTimeList records

 

 
-

 
-

------------------------------------------------------------------------

More information... {#DailyAttendancehow-toHITS-Moreinformation}
-------------------

#### What is the business problem this Use Case is trying to solve? {#businessdriver}

In brief:

-   Allow schools secure access to SIS information
-   Allow schools to use the Attendance product of their choice
-   Allow  3rd  Party Daily Attendance apps automated access
    to base information
-   Allow  3rd  Party Daily Attendance apps to publish school
    attendance records to a jurisdictional hub.

Schools currently use third-party attendance applications locally to
supplement their Student Information System (SIS). The seed information
for recording of attendance is held in the School's SIS and usually
exported locally with little security.

As jurisdictions centralise systems, 3rd Party Vendors have the
opportunity to seed their product/s from a quality assured data hub
using automated feeds, rather than manual updates from the school.
 3rd  Party Vendors are also expected to provide information
directly back to the centralised system through an automated feed,
rather than having the information mediated through the school. 

This use case shows how  3rd  party attendance vendors can
connect to a centralised data hub to securely access to the required
information and publish back the Daily Attendance records to the
centralised data hub.

#### []()Assurance - Usecase preconditions

 The following conditions also must be
met:

    Must be
able to post to the Zone an update to a well-formed
StudentDailyAttendance object, as defined below.

-    Any
    SIF object published by the App must be valid against the SIF-AU 1.3
    schema
-    All SIF objects posted by the
    Attendance App must have referential integrity. Any RefId contained
    in the SIF object must refer to a SIF object provisioned to
    the App—e.g. SchoolInfo, StudentPersonal, CalendarDate).This
    condition applies recursively to all additional SIF objects posted
    by the App. The test of this condition is done only when the App
    indicates that it has finished publishing to the Zone the objects
    required for the test.

For
the purposes of validation, a new StudentDailyAttendance object is
well-formed if:

-    If the provided CalendarDate object
    indicates that a date is not counted toward student attendance
    (CalendarDate/StudentAttendance/CountsTowardsAttendance), then
    either no StudentDailyAttendance record is generated for that date,
    or else the StudentDailyAttendance/AttendanceStatus value in the
    object is "NA" (not applicable)
-    All mandatory elements of the
    StudentDailyAttendance object are provided
-    The StudentDailyAttendance object
    points to a valid StudentPersonal and SchoolInfo object

 For the purposes of validation, a new
StudentAttendanceSummary object is well-formed if it satisfies the
following requirements:

-    All mandatory elements of the
    StudentAttendanceSummary object are provided.

For the purposes of validation, a new StudentAttendanceTimeList object
is well-formed if it satisfies the following requirements:

-   All mandatory elements of the StudentAttendanceTimeList  object
    are provided.
-   The StudentAttendanceTimeList  object
    points to a valid StudentPersonal and SchoolInfo object
