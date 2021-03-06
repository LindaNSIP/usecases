What you need before you start:
===============================

-   Apply for a HITS testing account at <info@nsip.edu.au>
-   This will give you access to your own testing environment 
-   Your testing environment will provide you with all necessary
    authentication and access tokens to work with the HITS API.

A basic knowledge of SIF REST.

-   Here is [some information from the SIF
    Association](https://www.sifassociation.org/Resources/Developer-Resources/SIF-3-0/Pages/SIF-3.0-Infrastructure.aspx).
-   Here is [a short (1-day) course in developing with SIF 3
    REST](http://kb.nsip.edu.au/display/SATWI/SIF+3+Bootcamp+online){.confluence-link}.

You need to know<span class="confluence-link"> [how to work with a
usecase in
HITS](http://hits.dev.nsip.edu.au/site/working-use-case-hits)</span>

You need to know<span class="confluence-link"> [how to access the HITS
API](http://hits.dev.nsip.edu.au/site/working-use-case-hits)</span>

If you get stuck: drop us a line at <info@nsip.edu.au>

#### NAPLAN registration standalone

1. What's the business problem?
-------------------------------

Allow schools with a SIS to provide information about NAPLAN candidates
and platform users (staff), and read back the Platform Student
Identifier (PSI) assigned by the Assessment Platform.
**[More...](#businessdriver)**

 

2. Usecase description & Pre-conditions
---------------------------------------

<span>NAPLAN testing is to occur this year, through a national delivery
system. Around NAPLAN census time, the SIS lodges bulk information about
its NAPLAN candidates to the Assessment Platform (AP), on behalf of one
or more schools.  Any other information, including registration of
students to particular NAPLAN testing events, personal needs and
preferences, and assigning staff members and invigilators, is done out
of band on the AP web site.</span>

#### Assumptions:

-   SIS can both read and write SIF records.
-   SIS manages information for an individual school, a systemic
    authority data hub, or a third party data hub.
-   <span>Quality assurance may be deferred to after records are
    uploaded, through record editing permitted by the
    AP.  </span><span> </span>
-   <span>Contact details of the school or school system administrator
    for NAPLAN Online are known to the AP.</span>
-   <span>S<span>chool (or school system) administrator</span> has
    access to the AP as a registered and authorised user, so that they
    can authorise SIS access, confirm the upload data, and authorise
    other staff on the AP.</span>
-   Allocation of staff accounts for teachers in schools is done outside
    of this process. It can be based on the staff records uploaded to
    the AP, but it can also be set up before any staff records
    are uploaded.
-   The school(s)' ACARA ID is known to the SIS. The mechanism for this
    is out of scope for this use case: school systems are expected to
    arrange a computer feed to the Australian School List, while
    non-systemic schools will likely query a web interface.
-   <span data-mce-style="font-size: 10.0pt; line-height: 13.0pt;"
    style="font-size: 10.0pt;line-height: 13.0pt;">Personal Needs and
    Preferences are manually entered into the AP, and are not
    contributed using this method.</span>
-   Allocation of students to a particular session of NAP is done
    through the AP.
-   <span>Allocation of students to a particular NAP activity is
    done through the AP.</span>
-   AP is tenanted: the SIS client does not have access to data outside
    its school/school system.

-   AP is purged of data at the end of each assessment cycle: only
    current student records are available from it. 

-   <span style="font-size: 0.923em;">StudentPersonal/MostRecent
    includes all information necessary for student registration in
    NAPLAN, without needing to resort to StudentSchoolEnrollment.</span>

-   <span style="font-size: 0.923em;">StudentPersonal
    records</span><span style="font-size: 0.923em;"> are only assigned
    to one school for the purposes of NAPLAN. If they need to be
    assigned to more than one school within a system, multiple
    StudentPersonal records need to be created for the same student.
    Note that the Assessment Platform will create a separate record for
    each student enrolment, which corresponds to the
    first alternative.</span>

#### <span data-mce-style="color: #333333;" style="color: rgb(51,51,51);">Pre-conditions:</span>

-   Vendor has access to HITs
-   <span>Vendor has mapped the relevant SIF Objects to their
    systems:</span>
    -   StudentPersonal

#### <span data-mce-style="color: #333333;" style="color: rgb(51,51,51);">Usecase workflow summary:</span>

1.  Join

2.  <span>Provide</span>

3.  Consume (Students)

4.  Process (Students)

5.  Assurance

<span data-mce-style="color: #ff6600;"
style="color: rgb(255,102,0);">NOTE: Consume and Process occur after
Provide in this use case!</span>

#### <span data-mce-style="color: #333333;" style="color: rgb(51,51,51);">Assurance:</span>

The SIF/XML data sent by the 3^rd^ Party app to the Jurisdiction Zone
for the app must satisfy the following conditions:

-   <span>All StudentPersonal records are well-formed
    SIF records.</span>

-   <span style="font-size: 0.923em;">None of the SIF records submitted
    have dependencies on any other SIF records (no
    RefID references)</span>

<span>[More...](#usecasepreconditions)</span>
---------------------------------------------

3. Join school zone
-------------------

Join:

-   SIS client registers with AP
-   <span data-mce-style="font-size: 10.0pt; line-height: 13.0pt;"
    style="font-size: 10.0pt;line-height: 13.0pt;">AP communicates to
    SIS client out of band credentials for connecting to the AP
    zone </span>

**4. Provide authoritative data**

Vendor-facing (push); HITS represents AP and is the data sink .

<span> </span><span>SIS client expresses information in SIF/XML:</span>

-   SIS client obtains ACARA ID(s) for its school(s)
-   SIS client connects to AP zone (“HITS Zone 1”) 
-   SIS client authenticates to AP zone (“HITS Zone 1 Authz”)
-   AP zone authorises write access to objects in the AP zone (“HITS
    Zone 1 Authn”, StudentPersonal)
-   AP zone authorises read access to objects in the AP zone (“HITS Zone
    1 Authn”, StudentPersonal) 
-   <span>Following is provided by the SIS client</span><span> to HITs;
    </span>
    1.  Post StudentPersonal to URL [http://.../S]()tudentPersonals :
        all StudentPersonal records of students eligible for NAP
        1.  The unique ACARAId of the school that each student is
            enrolled in is included in
            StudentPersonal/MostRecent/ACARAId
-   <span style="font-size: 0.923em;">AP associates the StudentPersonal
    records with the school nominated in </span><span
    style="font-size: 0.923em;">StudentPersonal/MostRecent/ACARAId</span>
-   AP assigns a different PSI to each enrolment

5. Consume base data from HITS (Students)
-----------------------------------------

-   SIS client gets from AP:
    -   One or more StudentPersonal records corresponding to
        every StudentPersonal posted by the SIS client, and containing
        the PSI identifier. 
    -   The PSI is added to the StudentPersonal record as
        StudentPersonal/OtherIdList/OtherId\[type="NAPPlatformStudentIdentifier"\]

**6. Process in 3rd party apps**

-    SIS client ingests the PSI identifier, by matching the student
    records received against the student records it has sent
    -   Matching is assumed to be done on StudentPersonal/LocalId. (TBC)
    -   SIS clients must not assume that the StudentPersonal@RefId sent
        will be the same as the StudentPersonal@RefId received.

7. Self – confirm usecase support
---------------------------------

1.  1.  Validate StudentPersonal records

More information
================

#### Business driver - what is the problem is this usecase is trying to solve? {#businessdriver}

###### In brief:

-   Allow schools to provision StudentPersonal records to the Assessment
    Platform (as potential candidates for NAP)
-   Enable those schools to retrieve the Platform Student Identifier
    that the Assessment Platform associates with StudentPersonal
    records\
     

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

#### Usecase preconditions (assurance) {#usecasepreconditions}

<span data-mce-style="color: #000000;" style="color: rgb(0,0,0);">No
further conditions are set on assurance</span>
