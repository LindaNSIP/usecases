## Business implementation

This section deals with implementation questions at the business rules
level.

###  What data is exchanged? 

#### Description of the data relevant at a horizontal level (for school day-to-day business) 
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

-   **StudentAttendanceSummary** tracks attendance of a student at the level of a
    half year or year for individual students

#### Description of the data relevant for vertical reporting (entity types)

Vertical reporting involves reporting of the attendance for a cohort of students, 
which can be established by aggregating across the foregoing objects:

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

##### Timeliness for local use

Schools require daily attendance promptly, but not necessarily
immediately. It has been acceptable in the past for attendance systems
to deliver attendance results with a delay of a few days, in batch form.
In particular, the justification for absences may be edited as more
information is available in the days following the absence.

##### Timeliness for vertical reporting

The Australian government census of attendance data is annual,
aggregated over Semester 1.

School systems that undertake censuses of attendance gather data at
least annually.

##### Quality for local use

Attendance data is important for tracking both student welfare and student achievement,
so schools require it to be of high quality, even if that is at the expense
of timeliness.

##### Quality for vertical reporting

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

##### At local level

##### For vertical reporting


### How are data sources accessed?

&lt;list how data sources area accessed&gt;

#### At local level

#### For vertical reporting


### What are the privacy implications of this data exchange?

Consider the questions on [this
page](file:///C:\display\SIFOG\Privacy+framework+questions) in
establishing privacy measures. Many are specific to your local
configuration, but some questions and answers will be common to all
instances of this use case.

#### At local level

#### For vertical reporting


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

##### At local level

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

##### For vertical reporting

The data passed on for attendance reporting is aggregated and
deidentified, and does not include any breakdown of reasons for absence.
This data does not present serious privacy implications.

Any unit data passed to education researchers must be deidentified, and
the demographic cohorts of students passed on must be large enough that
individual student identity may be recovered.
