using hexagon.licenseapplications.masters as masters from '../db/masters';
using hexagon.licenseapplications.schema as schemas from '../db/schema';

service ApplicantService @(path: '/service/applicant') {

    entity LicenseTypes as projection on masters.LicenseTypes {
        ID,
        name,
        descr,
        days
    };

    entity States as projection on masters.States {
        ID,
        name,
        descr
    }; 

    entity Genres as projection on masters.Genres {
        ID,
        name,
        descr
    }; 

    entity Licenses as projection on schemas.Licenses;
    entity Documents as projection on schemas.Documents;
    entity Employees_LicenseTypes as projection on schemas.Employees_LicenseTypes;

    function getLicensesData() returns {};
    function getUserData() returns {};

}