

## How to implement NAPLAN standalone registration

### 1. What's the business problem?


Allow schools with a SIS to provide information about NAPLAN candidates
and platform users (staff), and read back the Platform Student
Identifier (PSI) assigned by the Assessment Platform.

**[More...](#what-business-problem-does-this-usecase-address)**

 

### 2. Usecase description & Pre-conditions


NAPLAN testing is to occur this year, through a national delivery
system. Around NAPLAN census time, the SIS lodges bulk information about
its NAPLAN candidates to the Assessment Platform (AP), on behalf of one
or more schools.  Any other information, including registration of
students to particular NAPLAN testing events, personal needs and
preferences, and assigning staff members and invigilators, is done out
of band on the AP web site.

#### Assumptions:

-   SIS can both read and write SIF records.
-   SIS manages information for an individual school, a systemic
    authority data hub, or a third party data hub.
-   Quality assurance may be deferred to after records are
    uploaded, through record editing permitted by the
    AP.  
-   Contact details of the school or school system administrator
    for NAPLAN Online are known to the AP.
-   School (or school system) administrator has
    access to the AP as a registered and authorised user, so that they
    can authorise SIS access, confirm the upload data, and authorise
    other staff on the AP.
-   Allocation of staff accounts for teachers in schools is done outside
    of this process. It can be based on the staff records uploaded to
    the AP, but it can also be set up before any staff records
    are uploaded.
-   The school(s)' ACARA ID is known to the SIS. The mechanism for this
    is out of scope for this use case: school systems are expected to
    arrange a computer feed to the Australian School List, while
    non-systemic schools will likely query a web interface.
-   Personal Needs and
    Preferences are manually entered into the AP, and are not
    contributed using this method.
-   Allocation of students to a particular session of NAP is done
    through the AP.
-   Allocation of students to a particular NAP activity is
    done through the AP.
-   AP is tenanted: the SIS client does not have access to data outside
    its school/school system.

-   AP is purged of data at the end of each assessment cycle: only
    current student records are available from it. 

-   StudentPersonal/MostRecent
    includes all information necessary for student registration in
    NAPLAN, without needing to resort to StudentSchoolEnrollment.

-   StudentPersonal
    records are only assigned
    to one school for the purposes of NAPLAN. If they need to be
    assigned to more than one school within a system, multiple
    StudentPersonal records need to be created for the same student.
    Note that the Assessment Platform will create a separate record for
    each student enrolment, which corresponds to the
    first alternative.

#### Pre-conditions:

-   Vendor has access to HITs
-   Vendor has mapped the relevant SIF Objects to their
    systems:
    -   StudentPersonal

#### Usecase workflow summary:

1.  Join

2.  Provide

3.  Consume (Students)

4.  Process (Students)

5.  Assurance

NOTE: Consume and Process occur after
Provide in this use case!

#### Assurance:

The SIF/XML data sent by the 3^rd^ Party app to the Jurisdiction Zone
for the app must satisfy the following conditions:

-  All StudentPersonal records are well-formed
    SIF records.

-   None of the SIF records submitted
    have dependencies on any other SIF records (no
    RefID references)

**[More...](#usecase-preconditions-for-assurance)**


### 3. Join school zone


Join:

-   SIS client registers with AP
-   AP communicates to
    SIS client out of band credentials for connecting to the AP
    zone.

**4. Provide authoritative data**

Vendor-facing (push); HITS represents AP and is the data sink .

SIS client expresses information in SIF/XML:

-   SIS client obtains ACARA ID(s) for its school(s).
-   SIS client connects to AP zone (“HITS Zone 1”) .
-   SIS client authenticates to AP zone (“HITS Zone 1 Authz”).
-   AP zone authorises write access to objects in the AP zone (“HITS
    Zone 1 Authn”, StudentPersonal).
-   AP zone authorises read access to objects in the AP zone (“HITS Zone
    1 Authn”, StudentPersonal) .
-   The SIS client provides to HITS the following:    
    - Post StudentPersonal to URL `http://.../StudentPersonals`
        all StudentPersonal records of students eligible for NAP
    - The unique ACARAId of the school that each student is enrolled in, included in StudentPersonal/MostRecent/ACARAId            
-   AP associates the StudentPersonal
    records with the school nominated in `StudentPersonal/MostRecent/ACARAId`
-   AP assigns a different PSI to each enrolment

5. Consume base data from HITS (Students)
-----------------------------------------

-   SIS client gets from AP:
    -   One or more StudentPersonal records corresponding to
        every StudentPersonal posted by the SIS client, and containing
        the PSI identifier. 
    -   The PSI is added to the StudentPersonal record as
        StudentPersonal/OtherIdList/OtherId\[type="NAPPlatformStudentIdentifier"\]

### 6. Process in 3rd party apps

- SIS client ingests the PSI identifier, by matching the student records received against the student records it has sent
- Matching is assumed to be done on StudentPersonal/LocalId. (TBC)
- SIS clients must not assume that the StudentPersonal@RefId sent will be the same as the StudentPersonal@RefId received.


### 7. Self – confirm usecase support


1.  Validate StudentPersonal records

### More information


#### What business problem does this usecase address?

In brief:

-   Allows schools to provision StudentPersonal records to the Assessment
    Platform (as potential candidates for NAP).
-   Enables those schools to retrieve the Platform Student Identifier
    that the Assessment Platform associates with StudentPersonal
    records.
     

The SIS is presumed to have limited technical capabilities. In
particular, there is no requirement for it to read SIF objects from
external sources (such as the Australian School List), although schools
are presumed to be able to supply their own ACARA Id. The SIS is not
required to be able to relate objects to each other (e.g. through
StudentSchoolEnrollment). The use case is applicable to both individual
school and to school systems; in the case of school systems, the SIS is
expected to have system-wide scope. 

This use case is quite restricted, and does not support extending SIS
capability to other areas (such as online assessment or census). It
requires the AP to do school-specific processing for each SIS client. It
is not currently clear whether this use case provides enough information
to support NAPLAN reporting back to the school. 

This usecase deviates from the usual workflow of HITS: the SIS being
tested provides data before it consumes it and processes it.

#### Usecase preconditions for assurance 

No further conditions are set on assurance.
