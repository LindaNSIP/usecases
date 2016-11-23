Basic Daily Attendance use case, new format
===========================================

This TOC uses as an example the Basic Daily Attendance
(see <http://hits.dev.nsip.edu.au/site/basic-daily-attendance> for the
HITS how-to on this usecase).

Policy context
--------------

### \
Introduction

### Purpose: intended business outcomes

At an individual level, at school level: To track the extent to which
students are meeting their obligation to attend school, and to signal
the need for intervention where this is not the case.

At an aggregate level, at school system and national level: To flag to
education providers and government the schools and areas where
attendance expectations are not being met, and to signal the need for
larger scale intervention in those areas.

### Context: business motivation

Schools are required to meet their duty of care obligation to students,
by ensuring that they are attending school unless there are compelling
reasons for them not to.

Failure of students to attend school without justification is a major
indicator of students being at risk of not completing their education.
Government departments have a responsibility to detect such risk and
intervene as appropriate, both at an individual level, and at an
aggregate level (targeting schools or socioeconomic groups). 

Tracking Attendance is used for a variety of operational, accountability
and strategic purposes, and for educational research.

### Authorising environment-Legislation, agreement etc

Education providers in each state and jurisdiction are required by law
to determine the whereabouts of each student on each school day. There
is also a legal obligation on guardians to ensure that students under
their care attend school.

The National Education Agreement of COAG identifies student attendance
rates as a key measure of engagement, and as a performance indicator in
the National Education Reform Agreement (NERA), the National Indigenous
Reform Agreement (NIRA), the Report on Government Services (ROGS) and
the Measurement Framework for Schooling in Australia. 

Compliance with federal reporting requirements is a precondition for
ongoing funding support to schools from the government.

### Governance, oversight: business accountability 

National standards for attendance are prepared by the Student Attendance
Data subgroup of ACARA, with representation from all jurisdictions and
sectors.  

### Data exchange summary

 ![](media/image1.tmp){width="5.208333333333333in"
height="9.64586942257218in"}

 

### Business rules summary 

Attendance for national reporting is calculated as the ratio of
full-time equivalent of student-days to the total number of possible
student days. There are 19 categories of absence defined nationally,
with decisions for each as to how they are to be considered in the
absence calculation.

There is variation between school authorities as to :

-   the granularity of absence (0.5 vs two decimal places)

-   the categories of absence recognised

-   whether attendance is tracked for students enrolled in multiple
    schools in the same sector

-   whether time fractions for attendance are calculated at the school
    or centrally (based on detailed in-and-out times)

-   whether attendance is reported by exception, or including both
    attendances and absences.

### Privacy considerations summary

Attendance data gathered at the school level, and passed on to school
systems, is extremely sensitive (reasons for absence); data storage and
transfer needs to be handled appropriately.

The aggregated attendance data passed on to government agencies is of
low sensitivity; no special safeguards are called for.

 Business implementation 
-------------------------

This section deals with implementation questions at the business rules
level.

###  What data is exchanged? 

#### Description of the data (entity types)

**StudentPersonal** records identify the students whose attendance is
being tracked. Demographic attributes of the students may be required in
order to provide reports correlating those attributes. The nationally
required attributes are: geolocation, sector, sex, year level,
indigenous status. 

Attendance records track the attendance of students in school at various
levels of granularity:

-   **StudentPeriodAttendance **tracks  attendance at the level of
    individual periods for individual students. Period attendance is out
    of scope of this use case.

-   **StudentAttendanceTimeList** tracks attendance at the level of
    parts of the day for individual students.

-   **StudentDailyAttendance** tracks attendance at the level of the
    day for individual students (with fractions to quantify
    partial attendance).

-   **StudentAttendanceSummary** tracks attendance at the level of a
    half year or year for individual students

-   **SystemAttendanceSummary** (not a SIF object) tracks attendance at
    the level of a half year or year across a cohort of students, at the
    level of individual schools or a school system.

#### Data relationships

&lt;diagram&gt;

#### Authoritative source

The authoritative source for StudentPersonal is the school SMS.

The authoritative source for attendance unit records are the attendance
tracking applications deployed in schools. This information is stored in
the SMS, from where it is propagated on. 

#### Stakeholders

-   School: Attendance package vendor, school IT staff, home group
    teacher, school principal

-   School system: school system IT staff, school system operations
    staff, school system business owners

-   National:  reporting group

#### Downstream destinations

##### National 

##### School system

##### School

#### Data recipients at unit level

-   School systems (where present)

-   Education researchers (deidentified)

#### Data recipients at aggregate level

-   Australian government. The reports generated based on this data
    includes:

<!-- -->

-   -    National Education Agreement (NEA) performance report(s)

<!-- -->

-   -   National Report on Schooling in Australia

    -   National Indigenous Reform Agreement (NIRA)

    -   Report on Government Services (ROGS)

    -   School-level attendance data on the My School website. 

#### Data quality and timeliness

##### Timeliness

The Australian government census of attendance data is annual,
aggregated over Semester 1.

School systems that undertake censuses of attendance gather data at
least annually.

Schools require daily attendance promptly, but not necessarily
immediately. It has been acceptable in the past for attendance systems
to deliver attendance results with a delay of a few days, in batch form.
In particular, the justification for absences may be edited as more
information is available in the days following the absence.

##### Quality

There is some tolerance of error in the national-level aggregate
reports, as the attendance census is meant to be indicative, and applied
at aggregate level.

#### Are there national and local definitions? 

##### National

National definitions for attendance are provided in the *National
Standards for Student Attendance Data Reporting*, published by ACARA.
These have been introduced in 2014, to enable nationally comparable
attendance rates, by imposing uniform calculation practices and data
collection.

##### School system

##### School

### What are the business rules for this data exchange?

##### National 

The national reporting requirements calculate attendance for full-time
students only at state/territory level. (If a student attends multiple
schools in a state, their attendance can be split pro rata between those
schools.) 

Attendance is calculated as the ratio of full-time equivalent of
student-days to the total number of possible student days.

Schools are only included in attendance reporting if they fall within
the NSSC definition of a school: their major activity is providing
education, and students can enrol in the school for a minimum of four
continuous weeks.

Part-day absences are to be reported as either 0.5 or to two decimal
places, depending on individual school arrangements.

The National Standards define 19 categories of absence, whether each
should be counted as absences for attendance reporting, and whether the
absence should be included in the possible school day count.

##### School system

Students enrolled full time at state level but across multiple schools
in the same sector are excluded from Qld government, all Catholic and
independent schools. 

School systems typically have absence categories that do not coincide
with the national absence categories. All school systems need to provide
mappings from their local categories to the national categories. Not all
national absence categories are applicable locally.

Schools have the option of providing school systems with data in
aggregated form, instead of unit records. Typically schools will opt to
provide unit records, as they do not have the internal capability to
perform the aggregations at the different levels required for systemic
and national reporting. 

VIC and WA report part-day absences consistently as 0.5.

School systems will vary as to whether they require schools to calculate
the percentages of attendance for part-day attendance, or whether they
will undertake those calculations centrally. If the former is the case,
then an object like StudentDailyAttendance is adequate. If the latter is
the case, then schools must provide all times in and out for a student
during the day; in that case, an object like StudentAttendanceTimeList
is required.

School systems will vary as to whether attendance is reported by schools
only by exception (the school only submits records for days when the
student has been absent), or completely (both presences and absences).
NSW DEC for example requires the latter. 

School systems will normalise attendance results received from different
attendance packages, so that they can be aggregated and compared
consistently.

##### School

In the absence of a school system, individual non-systemic schools have
to comply with the requirements of national reporting on their own.

#### Localisation

&lt;local rules for data exchange, self inserted by school systems
authorities and others who have localised versions of this use case&gt;

### How are data sources accessed?

&lt;list how data sources area accessed&gt;

### What are the privacy implications of this data exchange?

Consider the questions on [this
page](file:///C:\display\SIFOG\Privacy+framework+questions) in
establishing privacy measures. Many are specific to your local
configuration, but some questions and answers will be common to all
instances of this use case.

#### Privacy framework questions

##### Data collection

1.  Specific to use case instance; recommend primary purpose only

2.  StudentPersonal, StudentDailyAttendance, StudentAttendanceSummary, StudentAttendanceTimeList.
    Highly sensitive demographic or personal information within Student
    Personal is not required.

3.  Specific to use case instance; recommend No

##### Data storage and access

1.  Information should be stored in same State/Territory as it was
    sourced, given sensitivity 

2.  Some protection needed, given sensitivity; at minimum
    password access.

3.  Specific to use case instance; if on cloud, tenancy access
    must apply.

4.  Specific to use case instance; recommend Yes

5.  Specific to use case instance; recommend SSL/TLS per SIF protocol

6.  Homeroom teacher, principal, other teachers of the student on
    as-needs basis.

    1.  Access should be logged.

    2.  Specific to use case instance

    3.  Specific to use case instance

    4.  Working with children check recommended

    5.  Analytics may be subcontracted; if they are, anonymisation
        recommended

    6.  Specific to use case instance

##### Data and Metadata Retention

1.  Specific to use case instance

2.  Data should be retained for entire school year, to allow revision of
    annual report. Data may be deleted after end of school year; data
    must be deleted at termination of contract, or on request by school.
    Protocol for deletion request must be agreed to by school.

3.  Copy of information MAY be provided by vendor to school; not strong
    requirement

4.  On termination of contract, all data must be returned to school and
    deleted from vendor systems

##### Development and Change Management Process

1.  Provider should follow standardised processes for code change
    management

2.  Specific to use case instance

3.  Provider should notify school of changes in information handling

##### Audits and Standards

1.  Provider must allow security & privacy audit by school 

2.  Provider should have security operations externally audited

3.  Provider should comply with external standard

##### Test and Development Environments

1.  Live student data should not be used in non-production environments

2.  Non-production environments need not be as secure as production

##### Data Breach, Incident Investigation and Response

1.  At minimum, school informed immediately, will require escalation
    from principal

2.  Vendor must have logging capability agreed with school, including
    making logs available to school and police

####  Key data elements privacy settings (Links)

##### Unit record level

At Unit Record level, the most sensitive attributes being transmitted
are:

-   StudentPersonal: Sex and Indigenous Status (Medium)

-   StudentDailyAttendance: AttendanceCode, AttendanceNote (Extreme)

##### Aggregate level

At the aggregate level, the objects are of low sensitivity: no
identifying information is passed along, and individual absence reasons
are suppressed.

#### Privacy implications

Absence information is associated with fully identified students. The
reasons why an individual student is absent may be embarrassing and need
to be kept private, especially if described in detail. Thus data
exchange between attendance applications and the school SMS must be
tightly secured. The school should ensure that the data gathered
by attendance applications cannot be compromised, or viewed by
unauthorised parties outside the school, and should be stored
accordingly.

Typically any aggregation of attendance data is done by the school
authority and not the student. That means that the data being passed
from the school to the school system is as sensitive as the information
passed from the attendance applications to the school SMS, with the
possible exception of attendance reason details. Highly sensitive
information about students is exchanged between schools and school
systems routinely; so no additional safeguards should need to be put in
place for attendance data.

The data passed on for attendance reporting is aggregated and
deidentified, and does not include any breakdown of reasons for absence.
This data does not present serious privacy implications.

Any unit data passed to education researchers must be deidentified, and
the demographic cohorts of students passed on must be large enough that
individual student identity may be recovered.

Technical implementation 
-------------------------

### Before you start 

-   Are you using the SIF Common Framework? It's a supported open source
    offering which can vastly simplify your SIF 3 development effort.\
    Try out the open source
    [Java](https://github.com/nsip/sif3-framework-java) or
    [.NET](https://github.com/nsip/sif3-framework-dotnet) framework. You
    may also find helpful this guide to using the framework with HITS.

-   Apply for a HITS testing account at <info@nsip.edu.au>. This will
    give you access to your own testing environment,\
    which provides all necessary authentication and access tokens to
    work with the HITS API.

 

### 1. Business problem

 Allow schools to securely provide SIS information to the Attendance
product of their choice, and also to allow school attendance records to
be published to a jurisdictional data hub.

### 2. Usecase description and pre-conditions

 A 3rd Party Daily Attendance application connects to HITS as a
jurisdiction hub, collecting the relevant information and publishing
back attendance records to the centralised system.r

####  Assumptions

3rd Party Vendor is a current supplier of a Student Attendance product
in schools or has knowledge of Student attendance reporting processes in
K-12 Schools.   

####  Pre-conditions 

-   Vendor has access to HITs

-   HITs has been provisioned with School Data

-   Vendor has mapped the relevant SIF Objects to their systems:\
    StudentPersonal\
    StudentSchoolEnrolment\
    CalendarDate\
    CalendarSummary\
    StudentDailyAttendance\
    StudentAttendanceSummary \
    StudentAttendanceTimeList

####  Usecase workflow summary

1.  Join

2.  Consume

3.  Process

4.  Provide

5.  Assurance

####  Assurance

 

The SIF/XML data sent by the 3rd Party app to the Jurisdiction Zone for
the app must be able to respond to requests for:

-   all StudentDailyAttendance records within a School

-   all StudentDailyAttendance records within a School and a nominated
    date range

-   all StudentDailyAttendance records for a nominated Student

-   all StudentDailyAttendance records for a nominated Student and a
    nominated date range

-   all StudentAttendanceSummary records within a School

-   all StudentAttendanceSummary records for a nominated Student and a
    nominated date range

-   all StudentAttendanceTimeList records within a School

-   all StudentAttendanceTimeList records within a School and a
    nominated date range

-   all StudentAttendanceTimeList records for a nominated Student

-   all StudentAttendanceTimeList records for a nominated Student and a
    nominated date range

 

Note that in some deployments, only StudentDailyAttendance records, only
StudentAttendanceSummary records, or only StudentAttendanceTimeList
records may be required.

 

### 3. Join required School Zone

 

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1")

-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz")

-   Jurisdiction Zone authorises read access to objects in the
    Jurisdiction Zone for the School ("HITS Zone 1 Authn")

 

### 4. Consume base data

Vendor-facing (pull); HITS represents the Jurisdiction and is the data
source for seed information.

Consume:

-   on the Jurisdiction-established Zone for the App, Third party
    app accesses all StudentPersonal records which are in a
    StudentSchoolEnrollment relationship with the given School RefId.

-   on the Jurisdiction-established Zone for the App, Third party
    app accesses all CalendarSummary objects linked to the given School
    RefId, and all CalendarDate objects linked to the given
    CalendarSummary objects. (In some deployments, calendar information
    about schools is already held centrally. For those deployments, this
    step is skipped.)

-   Third party app ingests the relevant SIF Objects.

The following is a list of calls that need to be made to consume the
required information:

1.  Get SchoolInfos - http://.../SchoolInfos  (HITS should determine the
    URLs eg <http://hits.nsip.edu.au/SchoolInfos> - access this
    information from your Dashboard.)

2.  Get StudentSchoolEnrollments - http://.../StudentSchoolEnrollments

3.  Get StudentPersonals - http://.../StudentPersonals (linked to school
    via StudentSchoolEnrollment; eg:
    equivalent to http://.../SchoolInfo/\\{REFID}/StudentSchoolEnrollments/{REFID}/StudentPersonals)

4.  Get CalendarDates - http://.../CalendarDates

5.  Get CalendarSummarys - http://.../CalendarSummarys

### 5. Process in 3rd party application

3rd Party App uses the consumed data to produce a schedule. The
definition and automation of this process is out of scope of HITs.\
\
Steps:

-   Third party app processes information and gathers Student Attendance
    Information

-   Third party application creates return Student Daily Attendance
    objects specific to the School

### 6. Provide authortitative data

Prior to providing: 

 Third party expresses return information in SIF/XML:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1")

-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz")

-   Jurisdiction-established Zone authorises write access to objects in
    the Jurisdiction Zone for the School ("HITS Zone 1 Authn")

-   Following is provided by the 3rd Party App back to HITs;

    1.  Post StudentDailyAttendance
        to http://.../StudentDailyAttendances

    2.  Post StudentAttendanceSummary
        to http://.../StudentAttendanceSummarys

    3.  Post StudentAttendanceTimeList to
        http://.../StudentAttendanceTimeLists

### 7. Assurance: Self-confirmation of usecase support 

1.  Validate StudentDailyAttendance records

2.  Validate StudentAttendanceSummary records

3.  Validate StudentAttendanceTimeList records 

### More information

 

#### What is the business problem this usecase addresses?

 

-   Allow schools secure access to SIS information

-   Allow schools to use the Attendance product of their choice

-   Allow 3rd Party Daily Attendance apps automated access to base
    information

-   Allow 3rd Party Daily Attendance apps to publish school attendance
    records to a jurisdictional hub.

Schools currently use third-party attendance applications locally to
supplement their Student Information System (SIS). The seed information
for recording of attendance is held in the School's SIS and usually
exported locally with little security.

As jurisdictions centralise systems, 3rd Party Vendors have the
opportunity to seed their product/s from a quality assured data hub
using automated feeds, rather than manual updates from the
school. 3rd Party Vendors are also expected to provide information
directly back to the centralised system through an automated feed,
rather than having the information mediated through the school. 

This use case shows how 3rd party attendance vendors can connect to a
centralised data hub to securely access to the required information and
publish back the Daily Attendance records to the centralised data hub.

**Assurance pre-conditions**

 The following conditions also must be met:

 Must be able to post to the Zone an update to a well-formed
StudentDailyAttendance object, as defined below.

-   Any SIF object published by the App must be valid against the SIF-AU
    1.3 schema

-   All SIF objects posted by the Attendance App must have
    referential integrity. Any RefId contained in the SIF object must
    refer to a SIF object provisioned to the App—e.g. SchoolInfo,
    StudentPersonal, CalendarDate).This condition applies recursively to
    all additional SIF objects posted by the App. The test of this
    condition is done only when the App indicates that it has finished
    publishing to the Zone the objects required for the test.

For the purposes of validation, a new StudentDailyAttendance object is
well-formed if:

-   If the provided CalendarDate object indicates that a date is not
    counted toward student attendance
    (CalendarDate/StudentAttendance/CountsTowardsAttendance), then
    either no StudentDailyAttendance record is generated for that date,
    or else the StudentDailyAttendance/AttendanceStatus value in the
    object is "NA" (not applicable)

-   All mandatory elements of the StudentDailyAttendance object are
    provided

-   The StudentDailyAttendance object points to a valid StudentPersonal
    and SchoolInfo object

For the purposes of validation, a new StudentAttendanceSummary object is
well-formed if it satisfies the following requirements:

-   All mandatory elements of the StudentAttendanceSummary object
    are provided.

 For the purposes of validation, a new StudentAttendanceTimeList object
is well-formed if it satisfies the following requirements:

-   All mandatory elements of the StudentAttendanceTimeList object
    are provided.

-   The StudentAttendanceTimeList object points to a valid
    StudentPersonal and SchoolInfo object


