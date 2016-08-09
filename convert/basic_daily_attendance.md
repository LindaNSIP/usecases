What you need before you start: 
===============================

-   Apply for a HITS testing account at <info@nsip.edu.au>
-   This will give you access to your own testing environment 
-   Your testing environment will provide you with all necessary
    authentication and access tokens to work with the HITS API.

A basic knowledge of SIF REST.

-   Here is [some information from the SIF
    Association](https://www.sifassociation.org/Resources/Developer-Resources/SIF-3-0/Pages/SIF-3.0-Infrastructure.aspx){.external-link}.
-   Here is [a short (1-day) course in developing with SIF 3
    REST](http://kb.nsip.edu.au/display/SATWI/SIF+3+Bootcamp+online).

You need to know [how to work with a usecase in
HITS](working-use-case-hits)

You need to know [how to access the HITS API](working-use-case-hits)

If you get stuck: drop us a line at <info@nsip.edu.au>

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

#### Assumptions: {#DailyAttendancehow-toHITS-Assumptions}

3^rd^ Party Vendor is a current supplier of a Student Attendance product
in schools or has knowledge of Student attendance reporting processes in
K-12 Schools.  <span style="color: rgb(51,51,51);"> </span>

#### <span style="color: rgb(51,51,51);">Pre-Conditions:</span> {#DailyAttendancehow-toHITS-Pre-Conditions}

-   Vendor has access to HITs
-   HITs has been provisioned with School Data
-   Vendor has mapped the relevant SIF Objects to their systems:\
    StudentPersonal\
    StudentSchoolEnrolment\
    CalendarDate\
    CalendarSummary\
    StudentDailyAttendance\
    StudentAttendanceSummary<span style="color: rgb(51,51,51);">
    </span>\
    StudentAttendanceTimeList

(Note that some of these objects are proposed for SIF 1.4 and are
therefore not in the SIF 1.3 schema.\
Here is [**a draft XSD schema for SIF
1.4**](http://kb.nsip.edu.au/download/attachments/13960456/SIF_Message1.4_3.x_current.zip),
further information on
**[StudentAttendanceTimeList](http://kb.nsip.edu.au/download/attachments/13960401/DSWG_V1.4_ChangeProposal_StudentAttendanceTimeList_0.5.pdf)**,
and a detailed description of the **[Attendance Baseline
Profile](http://kb.nsip.edu.au/download/attachments/13960401/Daily+Attendance+Baseline+Profile+v09.pdf)**.)

#### <span style="color: rgb(51,51,51);">Usecase workflow summary:</span> {#DailyAttendancehow-toHITS-Usecaseworkflowsummary}

1.  Join

2.  Consume

3.  Process

4.  Provide

5.  Assurance

#### <span style="color: rgb(51,51,51);">Assurance:</span> {#DailyAttendancehow-toHITS-Assurance}

The SIF/XML data sent by the 3^rd^ Party app to the Jurisdiction Zone
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

[More...](#assurance)
---------------------

 

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

<span style="color: rgb(51,51,51);">Vendor-facing (pull); HITS
represents the Jurisdiction and is the data source for seed
information.</span>

<span style="color: rgb(51,51,51);">Consume:</span>

-   on the Jurisdiction-established Zone for the App, <span>Third party
    app</span> accesses all StudentPersonal records which are in a
    StudentSchoolEnrollment relationship with the given School RefId.
-   <span>on the Jurisdiction-established Zone for the App,
    </span><span>Third party app</span><span> accesses </span>all
    CalendarSummary objects linked to the given School RefId, and all
    CalendarDate objects linked to the given CalendarSummary objects.
    (In some deployments, calendar information about schools is already
    held centrally. For those deployments, this step is skipped.)
-   Third party app ingests the relevant SIF Objects.

The following is a list of calls that need to be made to consume the
required information:

1.  Get SchoolInfos - http://.../SchoolInfos  (HITS should determine the
    URLs eg <span
    class="external-link">http://hits.nsip.edu.au/SchoolInfos</span> -
    access this information from your Dashboard.)
2.  Get StudentSchoolEnrollments - <span
    style="color: rgb(51,51,51);"><span
    style="font-size: 12.006383895874px; line-height: 20.0063037872314px;">http://</span>.../StudentSchoolEnrollments</span>
3.  Get StudentPersonals <span style="color: rgb(51,51,51);">- <span
    style="font-size: 12.006383895874px; line-height: 20.0063037872314px;">http://</span>.../StudentPersonals
    (linked to school via StudentSchoolEnrollment; eg: equivalent
    to <span
    style="font-size: 12.006383895874px; line-height: 20.0063037872314px;">http://</span>.../SchoolInfo/\\{REFID}/StudentSchoolEnrollments/{REFID}/StudentPersonals)</span>
4.  Get CalendarDates <span style="color: rgb(51,51,51);">-</span> <span
    class="external-link"><span
    style="font-size: 12.006383895874px; line-height: 20.0063037872314px;">http://</span>.../CalendarDates</span>
5.  Get CalendarSummarys <span style="color: rgb(51,51,51);">- <span
    style="font-size: 12.006383895874px; line-height: 20.0063037872314px;">http://</span>.../CalendarSummarys</span>

Endpoints may support additional queries for retreiving data - refer to
**[Query-by-example or service paths?](qbe-or-service-paths)** for HITS
guidance on queries.

 

5. Process in 3^rd^ Party Application.
--------------------------------------

3rd Party App uses the consumed data to produce a schedule. The
definition and automation of this process is out of scope of HITs.\
Steps:

-   Third party app processes information and gathers Student Attendance
    Information
-   Third party application creates return Student Daily Attendance
    objects specific to the School

 

**6. Provide Authoritative Data**

Prior to providing:<span style="color: rgb(51,51,51);"> </span>

<span style="color: rgb(51,51,51);"> </span>Third party expresses return
information in SIF/XML:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1")
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz")
-   Jurisdiction-established Zone authorises write access to objects in
    the Jurisdiction Zone for the School ("HITS Zone 1 Authn")
-   Following is provided by the 3^rd^ Party App back to HITs;
    1.  Post StudentDailyAttendance to <span
        style="font-size: 12.006383895874px; line-height: 20.0063037872314px;">http://</span>.../StudentDailyAttendances
    2.  Post StudentAttendanceSummary to <span
        style="font-size: 12.006383895874px; line-height: 20.0063037872314px;">http://</span>.../StudentAttendanceSummarys
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
-   Allow <span>3rd</span> Party Daily Attendance apps automated access
    to base information
-   Allow <span>3rd</span> Party Daily Attendance apps to publish school
    attendance records to a jurisdictional hub.

Schools currently use third-party attendance applications locally to
supplement their Student Information System (SIS). The seed information
for recording of attendance is held in the School's SIS and usually
exported locally with little security.

As jurisdictions centralise systems, 3rd Party Vendors have the
opportunity to seed their product/s from a quality assured data hub
using automated feeds, rather than manual updates from the school.
<span>3rd</span> Party Vendors are also expected to provide information
directly back to the centralised system through an automated feed,
rather than having the information mediated through the school. 

This use case shows how <span>3rd</span> party attendance vendors can
connect to a centralised data hub to securely access to the required
information and publish back the Daily Attendance records to the
centralised data hub.

#### []()Assurance - Usecase preconditions

<span style="color: rgb(0,0,0);">The following conditions also must be
met:</span>

<span style="color: rgb(0,0,0);"> </span><span
style="color: rgb(0,0,0);font-size: 10.0pt;line-height: 13.0pt;">Must be
able to post to the Zone an update to a well-formed
StudentDailyAttendance object, as defined below.</span>

-   <span
    style="color: rgb(0,0,0);font-size: 10.0pt;line-height: 13.0pt;">Any
    SIF object published by the App must be valid against the SIF-AU 1.3
    schema</span>
-   <span style="color: rgb(0,0,0);">All SIF objects posted by the
    Attendance App must have referential integrity. Any RefId contained
    in the SIF object must refer to a SIF object provisioned to
    the App—e.g. SchoolInfo, StudentPersonal, CalendarDate).This
    condition applies recursively to all additional SIF objects posted
    by the App. The test of this condition is done only when the App
    indicates that it has finished publishing to the Zone the objects
    required for the test.</span>

<span
style="color: rgb(0,0,0);font-size: 10.0pt;line-height: 13.0pt;background-color: transparent;">For
the purposes of validation, a new StudentDailyAttendance object is
well-formed if:</span>

-   <span style="color: rgb(0,0,0);">If the provided CalendarDate object
    indicates that a date is not counted toward student attendance
    (CalendarDate/StudentAttendance/CountsTowardsAttendance), then
    either no StudentDailyAttendance record is generated for that date,
    or else the StudentDailyAttendance/AttendanceStatus value in the
    object is "NA" (not applicable)</span>
-   <span style="color: rgb(0,0,0);">All mandatory elements of the
    StudentDailyAttendance object are provided</span>
-   <span style="color: rgb(0,0,0);">The StudentDailyAttendance object
    points to a valid StudentPersonal and SchoolInfo object</span>

<span style="color: rgb(0,0,0);">For the purposes of validation, a new
StudentAttendanceSummary object is well-formed if it satisfies the
following requirements:</span>

-   <span style="color: rgb(0,0,0);">All mandatory elements of the
    StudentAttendanceSummary object are provided.</span>

For the purposes of validation, a new StudentAttendanceTimeList object
is well-formed if it satisfies the following requirements:

-   All mandatory elements of the <span
    style="font-size: 13.0080003738403px; line-height: 20.0063037872314px;">StudentAttendanceTimeList</span> object
    are provided.
-   The <span
    style="font-size: 13.0080003738403px; line-height: 20.0063037872314px;">StudentAttendanceTimeList</span> object
    points to a valid StudentPersonal and SchoolInfo object

