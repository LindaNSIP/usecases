
## How to implement gradebook

### 1. What's the business problem?


Allow schools to securely provide account information to the classroom
assessment product of their choice, and also to allow assessment results
records to be published to a jurisdictional data hub.

**[More...](#what-business-problem-does-this-usecase-address)**


### 2. Usecase description & pre-conditions

A third party classroom assessment application connects to HITS as a
jurisdiction hub, collecting the relevant information and publishing
back assessment results records to the centralised system.

#### Assumptions:

The third party vendor is a current supplier of a classroom
assessment product in schools or has knowledge of classroom
assessment processes in K-12 Schools.

#### Pre-Conditions:

-   Vendor has access to HITS.
-   HITS has been provisioned with School Data.
-   Vendor has mapped the relevant SIF Objects to their systems:
    - SchoolInfo
    - StudentPersonal
    - StudentSchoolEnrolment
    - StaffPersonal
    - StaffAssignment
    - TeachingGroup
    - GradingAssignment
    - GradingAssignmentScore

**Note:** Some of these objects are proposed for SIF 1.4 and are
therefore not in the SIF 1.3 schema.
Here is [**a draft XSD schema for SIF
1.4**](/docs/common/resources/SIF_Message1.4_3.x_current.zip),
and here are **[draft specifications for the proposed grading
objects](resources/DSWG_V1.4_ChangeProposal_GradingAssignment_0.4.pdf)**
listed above.)

#### Usecase workflow summary:

1.  Join

2.  Consume

3.  Process

4.  Provide

5.  Assurance

#### Assurance:

The SIF/XML data sent by the third party app to the Jurisdiction Zone
for the app must satisfy the following conditions:

-   Must be able to provide all GradingAssignment records
    within a School;

-   Must be able provide all GradingAssignmentScore records
    within a School.

**[More...](#usecase-preconditions-for-assurance)**


### 3. Join school zone.


Join:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1").
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz").
-   Jurisdiction Zone authorises read access to objects in the
    Jurisdiction Zone for the School ("HITS Zone 1 Authn").


### 4. Consume base data from HITS

Vendor-facing (pull); HITS represents the Jurisdiction and is the data
source for seed information.

-   Consume:
-   on the Jurisdiction-established zone for the app, third party app
    accesses all StudentPersonal records which are in a
    StudentSchoolEnrollment relationship with the given school RefId.
-   on the jurisdiction-established zone for the app, third party app
    accesses all StaffPersonal records which are in a StaffAssignment
    relationship with the given school RefId.
-   on the jurisdiction-established zone for the app, third party app
    accesses all TeachingGroup objects linked to the given school RefId.
-   Third party app ingests the relevant SIF objects.

There are two possible ways to obtain the base information through REST
service path calls:

#### Via single data dump

The first assumes that all available students, staff, and classes, in
all known schools, will be exposed to the third party application, as a
single dump of data. This is the path recommended for HITS assurance, as
it is simpler to fetch the data and start generating objects for
validation.  (This is useful to prove that the objects can be consumed
and processed, as HITS end points contain customised test data.)

1.  Get SchoolInfos: `http://.../SchoolInfos`
2.  Get StudentSchoolEnrollments: `http://.../StudentSchoolEnrollments`
3.  Get StudentPersonals: `http://.../StudentPersonals` (linked to
    school via StudentSchoolEnrollment; equivalent to
    `http://..../SchoolInfo/{REFID}/StudentSchoolEnrollments/{REFID}/StudentPersonals`)
4.  Get StaffAssignments: `http://.../StaffAssignments`
5.  Get StaffPersonals: `http://.../StaffPersonals`
    (linked to school via StaffAssignment; equivalent to
    `http://.../SchoolInfo/{REFID}/StaffAssignments/{REFID}/StaffPersonals`)
6.  Get TeachingGroups: `http://.../TeachingGroups` (linked to a
    school via SchoolInfoRefId)

#### Via teaching groups

The second assumes, more realistically, that only certain
teaching groups will be exposed to the application, and that any staff
and student records exposed should be accessed via their teaching group.
You do not need to obtain data this way for HITS assurance: you will end
up getting the same data, since at this stage endpoints are customised
for the user. But you should be prepared to consume data from SIF APIs
in the following way for production environment where the end point
contains more than one school's data:

1.  Get SchoolInfos: `http://.../SchoolInfos`
2.  Get TeachingGroups: `http://.../TeachingGroups`
3.  Get StudentPersonals:
    `http://.../TeachingGroups/{REFID}/StudentPersonals` (Calls to
    StudentSchoolEnrollment are unnecessary; note that the same student
    record may appear under two different teaching groups)
4.  Get StaffPersonals:
    `http://.../TeachingGroups/{REFID}/StaffPersonals`
    (Calls to StaffAssignment are unnecessary; note that the same
    staff record may appear under two different teaching groups. )

Endpoints may support additional queries for retreiving data - refer to
**[Query-by-example or service paths?](.docs/common/qbe_or_service_paths.md)** for HITS
guidance on queries.


### 5. Processes in third party application

The third party app uses the consumed data to produce descriptions of
classroom assignments, and records of assignment results. The definition
and automation of this process is out of scope of HITs.

Steps:

a.  Third party app processes information and generates accounts for
    staff and students, organised by teaching group.
b.  Staff uses third party app to create classroom assessment tasks.
c.  Staff uses third party app to assign classroom assessment
    tasks to students in a teaching group.
d.  Students use third party app to perform classroom
    assessment tasks.
e.  Third party app creates descriptions of the classroom
    assessment tasks created.
f.  Third party app creates descriptions of the results that
    students achieved when performing the classroom assessment
    tasks.


### 6. Provide authoritative data

Prior to providing, the third party expresses return information in SIF/XML:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1").
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz").
-   Jurisdiction-established Zone authorises write access to objects in
    the Jurisdiction Zone for the School ("HITS Zone 1 Authn").
-   Following is provided by thethird party app back to HITs;
    1.  Post GradingAssignment to URL `http://.../GradingAssignments`
    2.  Post GradingAssignmentScore to URL `http://../GradingAssignmentScores`

**Note:** The Activity object could be used instead of, or alongside,
the GradingAssignment object to describe a classroom task, and
gives much more information about the pedagogical context of the task.
However although Activity/Points provides the possible score of the
task, SIF does not contain an object giving individual students'
performance against the activity.)
 

### 7. Self-confirm usecase support

1.  Validate GradingAssignment records
2.  Validate GradingAssignmentScore records

### More information

#### What business problem does this usecase address?

In brief:

-   Allows schools secure access to SIS information.
-   Allows schools to use the classroom assessment product of their
    choice.
-   Allows third party classroom assessment apps automated
    access to base information, including class membership.
-   Allows third party classroom assessment apps to publish
    assessment results records to a jurisdictional hub.

Schools currently use third-party classroom
assessment locally for formative assessment. The seed information
for generating accounts on third party apps is held
in the School's  Student Information System (SIS), and is
usually exported locally to the third party apps with little
security. There is an added complication: both student and class membership data are required
as seed information, since
classroom assessment is typically assigned to a class cohort by the
class teacher. Class memberships can change frequently, imposing an
additional burden on teachers who must manually update the third-party tools.

As jurisdictions centralise systems, third party vendors have the
opportunity to seed their product/s from a quality-assured data hub
using automated feeds, rather than manual updates from the school. This
allows changes such as new enrolments and changes in class membership to
be reflected promptly and accurately in the third party applications.
Third party vendors are also expected to provide information directly back
to the centralised system through an automated feed, rather than having
the information mediated through the school. This enables not only more
secure and efficient transfer of information, but also the possibility
of extracting business intelligence across the assessment results of
multiple schools stored in the same hub. 

This use case shows how third party classroom assessment vendors can
connect to a centralised data hub to securely access to the required
information and publish back the assessment result records to the
centralised data hub.

#### Usecase preconditions for assurance 

The following conditions also must be met:

-   Any SIF object published by the app must
    be valid against the SIF AU 1.4 schema. Note that the
    GradingAssignment and GradingAssignmentScore objects are proposed
    for inclusion in SIF  AU1.4.
-   All SIF objects posted by the classroom
    assessment app must have referential integrity. Any RefId contained
    in the SIF object must refer either to a SIF object provisioned to
    the app (e.g. SchoolInfo, StudentPersonal, StaffPersonal,
    TeachingGroup), or to a SIF object that has also been posted by the
    app to the zone (e.g. GradingAssignmentScore referring to GradingAssignment).This condition
    applies recursively to all additional SIF objects posted by the app.
    The test of this condition is done only when the app indicates that
    it has finished publishing to the zone the objects required for
    the test.

For the purposes of validation, a new GradingAssignment object is
well-formed if:

-   1.  All mandatory elements of the GradingAssignment object are
        provided
    2.  The TeachingGroupRefId element is provided
    3.  The SchoolInfoRefId element is provided

For the purposes of validation, a new GradingAssignmentScore object is
well-formed if it satisfies the following requirements:

1.  All mandatory elements of the GradingAssignmentScore object are
    provided.
2.  The StudentPersonalRefId element is provided.
3.  The TeachingGroupRefId element is provided.
4.  The SchoolInfoRefId element is provided.
