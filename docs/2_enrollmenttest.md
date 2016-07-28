### What you need before you start:

-   Apply for a HITS testing account at <info@nsip.edu.au>
-   This will give you access to your own testing environment 
-   Your testing environment will provide you with all necessary authentication and access tokens to work with the HITS API.

A basic knowledge of SIF REST.

-   Here is [some information from the SIF Association].
-   Here is <a href="http://kb.nsip.edu.au/display/SATWI/SIF+3+Bootcamp+online" class="confluence-link">a short (1-day) course in developing with SIF 3 REST</a>.

You need to know<span class="confluence-link"> [how to work with a usecase in HITS]</span>

You need to know<span class="confluence-link"> [how to access the HITS API][how to work with a usecase in HITS]</span>

If you get stuck: drop us a line at <info@nsip.edu.au>

 

### Enrollment

<table class="confluenceTable">
<tbody>
<tr>
<td class="confluenceTd" style="vertical-align:top;&quot;">
**1. What’s the business problem?**

</td>
<td class="confluenceTd">
Allow schools in a school system to enrol students, saving the required information about the students to a jurisdictional data hub. **[More…]**

</td>
</tr>
<tr>
<td class="confluenceTd" style="vertical-align:top;&quot;">
**2. Use Case Description & Pre-Conditions**

</td>
<td class="confluenceTd">
A 3rd Party SIS application connects to HITS as a jurisdiction hub, collecting the relevant information and publishing back student records to the centralised system.

#### Assumptions:

3<sup>rd</sup> Party Vendor is a current supplier of a SIS product in schools or has knowledge of student administration processes in K-12 Schools.   

#### <span data-mce-style="color: #333333;" style="color: rgb(51,51,51);">Pre-Conditions:</span>

-   Vendor has access to HITs
-   HITs has been provisioned with School Data
-   Vendor has mapped the relevant SIF Objects to their systems:
    <span>StudentPersonal</span>
    SchoolInfo
    StudentSchoolEnrolment
    StudentContactPersonal
    StudentContactRelationship 

  [some information from the SIF Association]: https://www.sifassociation.org/Resources/Developer-Resources/SIF-3-0/Pages/SIF-3.0-Infrastructure.aspx
  [how to work with a usecase in HITS]: http://hits.dev.nsip.edu.au/site/working-use-case-hits
  [More…]: #businessdriver
