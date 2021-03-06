
## How to implement enrollment


### 1. What's the business problem?


Allow schools in a school system to enrol students, saving the required
information about the students to a jurisdictional data hub.

**[More...](#what-business-problem-does-this-use-case-address)**

### 2. Use Case Description & Pre-Conditions

A third party SIS application connects to HITS as a jurisdiction hub,
collecting the relevant information and publishing back student records
to the centralised system.

#### Assumptions:

The third party vendor is a current supplier of a SIS product in schools or
has knowledge of student administration processes in K-12 Schools.

#### Pre-conditions:

-   The vendor has access to HITS
-   HITS has been provisioned with School Data
-   The vendor has mapped the relevant SIF Objects to their systems:
 
     - StudentPersonal

     - SchoolInfo
    
     - StudentSchoolEnrolment
    
     - StudentContactPersonal
    
     - StudentContactRelationship

(Here is a
**[summary](/docs/common/resources/SIS Baseline Profile 1_3 Draft Summary.pdf)** and
a **[full
draft](/docs/common/resources/SIS Baseline Profile SBP Jurisdiction Full Draft v0_3.pdf)** of
the SIS Basline Profile which governs the interactions for an
enrollment.)

#### Usecase workflow summary:

1.  Join

2.  Consume

3.  Process

4.  Provide

5.  Assurance

#### Assurance:

The SIF/XML data sent by the third party app to the Jurisdiction Zone
for the app must satisfy the following conditions:

-   Must be able to respond to requests for all StudentPersonal records
    within a School.

-   Must be able to respond to requests for all StudentContactPersonal
    records within a School.

-   Must be able to respond to requests for all
    StudentContactRelationship records within a School.

-   Must be able to respond to requests for all StudentSchoolEnrollment
    records within a School.

    **[More...](#usecase-preconditions-for-assurance)**
    

### 3. Join required to School Zone

Join:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1").
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz").
-   Jurisdiction Zone authorises read access to objects in the
    Jurisdiction Zone for the School ("HITS Zone 1 Authn").

### 4. Consume base data from HITS.

Vendor-facing (pull); HITS represents the Jurisdiction and is the data
source for seed information.

Consume:
 -   on the Jurisdiction-established Zone for the app, third party app accesses the SchoolInfo object corresponding to their school.
 -   Third party app ingests the relevant SIF Objects.

Get SchoolInfos: http://.../SchoolInfos
 -  This step may be skipped if the Third party app if the SchoolInfo RefId is already known.
 - The query mechanism is specific to the hub, but retrieval is unlikely to be automatic; it is likeliest for the school to do a manual query on the school name, using one of the established SIF query mechanisms, or else retrieve all SchoolInfo records from the hub and choose the the right record.

### 5. Process - processes in third party application.

Third party app creates student enrollments for students enrolling in the
given school.

Steps:

  1. Third party app creates StudentPersonal records.
  2. Third party app creates StudentSchoolEnrollment records, one for each StudentPersonal record. StudentSchoolEnrollment/SchoolInfoRefId is populated with the SchoolInfo RefId for the current school that has been retrieved
from HITS.
  3. Third party app creates StudentContactPersonal records.
  4. Third party app creates at least one StudentContactRelationship record for each StudentContactPersonal record, and at least one for
    each StudentPersonal record.

### 6. Provide authoritative data

Prior to providing: 

-   Third party expresses return information in SIF/XML:

-   Third party app connects to Jurisdiction-established Zone for the
    School ("HITS Zone 1").
-   Third party app authenticates to Jurisdiction-established Zone for
    the School ("HITS Zone 1 Authz").
-   Jurisdiction-established Zone authorises write access to objects in
    the Jurisdiction Zone for the School ("HITS Zone 1 Authn").
-   Following is provided by the third party app back to HITS;
    1.  Post StudentPersonal to URL [http://.../StudentPersonals]()
    2.  Post StudentSchoolEnrollment to URL
        [http://../StudentSchoolEnrollments]()
    3.  Post StudentContactPersonal to URL
        [http://../StudentContactPersonals]()
    4.  Post StudentContactRelationship to URL
        [http://../StudentContactRelationships]()\
         

### 7. Assurance: Self–confirmation of use case support

  1.  Validate StudentPersonal records
  2.  Validate StudentSchoolEnrollment records
  3.  Validate StudentContactPersonal records
  4.  Validate StudentContactRelationship records

### More information


#### What business problem does this Use Case address?

In brief, this process:

-   Allows schools secure access to SIS information.
-   Allows schools to use the SIS product of their choice.
-   Allows third party SIS
    apps to publish a school's student enrollments to a
    jurisdictional hub.

The use case described here satisfies the following scenarios in the SIS
Baseline Profile (SBP): 

-   **3.1.2 Future Enrollment:** StudentSchoolEnrollment/TimeFrame is set to
    F (future)
-   **3.1.4 New Current Enrollment:** StudentSchoolEnrollment/TimeFrame
    is set to C (current)
-   **3.3.4.1 New Student Contact and Relationship**
-   **3.3.4.2 New Relationship added to a Current Contact**

The use case described above can be straightforwardly extended with update operations to satisfy the following scenarios in the SBP:

-   **3.1.3 Future to Current Enrollment:** StudentSchoolEnrollment/TimeFrame is updated
    from F (future) to C (current)
-   **3.1.5 Year End Rollover:** StudentSchoolEnrollment/TimeFrame is updated from C
    (current) to H (historical); new StudentSchoolEnrollment is created
    with StudentSchoolEnrollment/TimeFrame set to C (current)
-   **3.1.6 Exit School:** StudentSchoolEnrollment/TimeFrame is updated from C
    (current) to H (historical)
-   **3.1.7 Change Campus:** StudentSchoolEnrollment/TimeFrame is updated from C
    (current) to H (historical), with RecordClosureReason set to
    CampusExit and ExitType set to "Transfer campus of the same school";
    new StudentSchoolEnrollment is created
    with StudentSchoolEnrollment/TimeFrame set to C (current) and
    EntryType set to "Transfer from a different campus of the same
    school"
-   **3.1.8 Mid-year Promotion/Demotion:** StudentSchoolEnrollment/YearLevel
    and StudentSchoolEnrollment/PromotionInfo/PromotionStatus is
    updated; StudentPersonal/YearLevel is updated
-   **3.1.9 Change in Personal Details:** update
    StudentPersonal
-   **3.3.4.3 Change to a StudentContact Personal information:**
    update StudentContactPersonal
-   **3.3.4.4 Change to StudentContact Relationship info:** update
    StudentContactRelationship
-   **3.3.4.5 Remove a StudentContact from a student:** delete
    StudentContactRelationship record

#### Usecase preconditions for assurance 

As this use case applies to school
systems, the enrollment records needs to identify the school being
enrolled into. This is done with the established SIF mechanism of
referencing a SchoolInfo RefId. The master for the SchoolInfo object is
the jurisdiction hub, and the third party SIS is meant to retrieve the
relevant SchoolInfo object from the hub, in order to reference it
correctly.

The following conditions also
must be met:

-   Any SIF object published by the App must
    be valid against the SIF AU 1.3 schema
-   Any SIF object published by the App
    should confirm to the SBP profile of the SIF-AU schema specific to
    the given scenarios (including both the black elements, and the blue
    elements intended for national reporting). In particular:
    -   The use of several elements is
        upgraded from optional to strongly recommended
    -   FamilyName, GivenName, MiddleName are
        used instead of FullName for students, and are strongly
        recommended for student contacts
    -   StudentPersonal/PersonInfo/Demographics/Sex
        is mandatory
    -   StudentPersonal/PersonInfo/Demographics/BirthDate
        is mandatory
    -   StudentSchoolEnrollment/YearLevel is
        mandatory
-   All SIF objects posted by the App must
    have referential integrity. Any RefId contained in the SIF object
    must refer either to a SIF object provisioned to the App — for example
    SchoolInfo, or to a SIF object that has also been posted by the App
    to the Zone (e.g. StudentSchoolEnrollment referring to
    StudentPersonal, StudentContactRelationship referring to
    StudentContactPersonal).This condition applies recursively to all
    additional SIF objects posted by the App. The test of this condition
    is done only when the App indicates that it has finished publishing
    to the Zone the objects required for the test.
