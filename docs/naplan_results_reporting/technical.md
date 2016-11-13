### 1. Business problem

Allow jurisdictions to retrieve information about the NAPLAN test constructs for the current cycle, and about the performance of their students in the current cycle, in order to determine the level of education attainment of their students and to generate expected reporting to schools.


### 2. Usecase description and pre-conditions


A Jurisdiction client connects to HITS as a National Assessment hub, collecting the relevant information about student assessments and performance under NAPLAN, and gathering it back to jurisdiction applications for further processing.


####  Assumptions

* Information about the students taking part in the NAPLAN assessment has already been provided to the National Assessment hub. The workflow for this is captured in the NAPLAN Registration use case. The workflow for this use case assumes that the information is already available, either because a client has carried out the NAPLAN Registration workflow, or that the client will accept StudentPersonal records prepopulated on the HITs  server.

* The students have already undertaken all the NAPLAN assessment for this year's, and the responses they have provided have been captured in the National Assessment hub. 

* The assessment results have already been processed post-assessment, and all required information is available for jurisdictions from the National Assessment hub. This includes scaling of scored results, and deriving the national and jurisdiction averages for each test.

* The source of truth about the jurisdiction schools involved in NAPLAN assessment is not the National Assessment hub, but the Australian Schools List. The assessment results data includes ACARA Ids for schools, which reference the records held in the Australian Schools List.

* Jurisdictions need to access information about the NAPLAN test structure as well as the test results: the former helps contextualise and interpret the latter. Information about the NAPLAN test structure is available under SIF modelling in two separate models: a single codeframe object per test, which contains all testlets, test items, rubrics and stimuli accessible through the test; and separate test, testlet and test item objects, which are referenced individually from the student test results object. The use case assumes that the code frame object will be consumed prior to testing, and the individual testlet and test item objects will be consumed alongside the test results.

####  Pre-conditions 

-   Jurisdiction has access to HITs

-   HITs has been provisioned with School Data. Note that HITs can act as a proxy for the Australian Schools List; but jurisdictions should be planning on integrating with the Australian Schools List directly

- HITS has been provisioned with Student Data, whether by the Jurisdiction client (through the NAP Registration Use case), or as pregenerated data within HITS

-   Vendor has mapped the relevant SIF Objects to their systems:

 * StudentPersonal
 * SchoolInfo
 * NAPCodeFrame
 * NAPStudentScoreSummary
 * NAPTest
 * NAPTestlet
 * NAPTestItem
 * NAPStudentEventLink
 * NAPStudentResponseSet

####  Usecase workflow summary

1.  Join

2.  Consume (Codeframe)

3. Consume (Results)

Note that this is not the usual workflow under HITs of Produce–Consume or Consume–Produce. This is a Consume-only workflow: the Produce component of the workflow is already captured under the NAP Registration use case. 


Any processing of the NAPLAN results is out of scope of this use case, since it depends on jurisdiction-speific setup. Note that NSIP will offer some support to jurisdictions for processing NAP results, throughh its NIAS toolkit.


####  Assurance

As there is no Produce component to the workflow, there is also no Assurance component. Any processing of NAPLAN results will be specific to the jurisdiction’s database setup, and will need to be undertaken within the jurisdiction: it is out of scope of this use case.

 

### 3. Join required School Zone


* Jurisdiction client connects to Nationally established Zone for the Jurisdiction, which emulates the data tenancy for the Jurisdiction on the National Assessment Platform ("HITS Zone 1")
* Jurisdiction client authenticates to Nationally established Zone for the Jurisdiction ("HITS Zone 1 Authz")
* Nationally established Zone authorises read access to objects in the Nationally established Zone for the Jurisdiction ("HITS Zone 1 Authn")


### 4. Consume base data

Client-facing (pull); HITS represents the National Assessment hub and is the data
source for seed information.


Consume:

* The Jurisdiction client accesses all SchoolInfo records corresponding to schools within the jurisdiction. These records will be referenced by assessment records within the National Assessment hub; but their source of truth is the Australian Schools List, and jurisdictions are expected to source them there.
* The Jurisdiction client accesses all StudentPersonal records corresponding to students within the jurisdiction. If the Jurisdiction has performed the NAP Registration use case, it has already provided this information in the same format; but the client still needs to retrieve these records, in order to access accurate RefIds for the StudentPersonal records, as well as the Student Platform Identifier values assigned by the Assessment Platform.
* The Jurisdiction client accesses all NAPCodeFrame records corresponding to NAPLAN assessment undertaken by students for this NAP cycle.
* The Jurisdiction client accesses all NAP results records corresponding to NAPLAN assessment undertaken by students for this NAP cycle. That includes: all NAPTest records; all NAPStudentEventLink and NAPStudentResponseSet records corresponding to a StudentPersonal record from the jurisdiction; all NAPStudentScoreSummary records corresponding to a SchoolInfo record from the jurisdiction; and all NAPTestlet and NAPTestItem records corresponding to a NAPTest record.


The following is a list of calls that need to be made to consume the
required information:

1. Get SchoolInfos - http://.../SchoolInfos (from the Australian Schools List)
2. Get StudentPersonals - http://.../StudentPersonals (HITS should determine the URLs eg http://hits.nsip.edu.au/StudentPersonals - access this information from your Dashboard.)
3. Get NAPCodeFrames - http://.../NAPCodeFrames
4. Get NAPTests - http://.../NAPTests
5. Get NAPTestlets - http://.../NAPTestlets
6. Get NAPTestItems - http://.../NAPTestIitems
7. Get NAPStudentEventLinks - http://.../NAPStudentEventLinks
8. Get NAPStudentResponseSets - http://.../NAPStudentResponseSets

### More information

 
#### What is the business problem this usecase addresses?

 
**Assurance pre-conditions**

The following conditions also must be met:

N/A
