## Business implementation 

This section deals with implementation questions at the business rules
level.

###  What data is exchanged? 

#### Description of the data (entity types)

#### Data relationships

<!--- DIAGRAM HERE --->

#### Authoritative source


#### Stakeholders

#### Downstream destinations

##### National 

##### School system

##### School

#### Data recipients at unit level


#### Data recipients at aggregate level


#### Data quality and timeliness

##### Timeliness



##### Quality



#### Are there national and local definitions? 

##### National



##### School system

##### School

### What are the business rules for this data exchange?

##### National 



##### School system




##### School



#### Localisation

<!--- local rules for data exchange, self inserted by school systems 
authorities and others who have localised versions of this use case --->

### How are data sources accessed?

<!--- list how data sources area accessed --->

### What are the privacy implications of this data exchange?

Consider the questions on [this
page](/docs/common/privacy_framework_questions.md) in
establishing privacy measures. Many are specific to your local
configuration, but some questions and answers will be common to all
instances of this use case.

#### Privacy framework questions

##### Data collection

<!--- provide suggested answers below where possible, according to the privacy framework questions document referenced above --->

1.  Data use primary or secondary? Explicit consent?

2.  What SIF data required by vendor?

3.  Third party collection (eg cookies)?

##### Data storage and access

1.  Data stored where? (in locale, Australia?)

2.  How is stored data protected (Encryption? Method?)

3.  How stored? If cloud, how segregated?

4.  Physical server security?

5.  Protection of data in transit (eg SSL)?

6.  Who can access?

   * Logged?

   * Employee only?

   * When/how?

   * Background checks?

   * Subcontract? (eg analytics)

   * Authenticating callers, reset access, account create/delete?

##### Data and Metadata Retention

1.  Data management and disposal?

2.  Is data deletion scheduled, end of contract, on school request?

3.  Copy of all information on request?

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

