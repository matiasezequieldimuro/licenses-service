using hexagon.licenseapplications.masters as masters from '../db/masters';
using hexagon.licenseapplications.schema as schema from '../db/schema';

service LicensesService @(path: '/service/licenses') {

    entity LicenseTypes as projection on masters.LicenseTypes;
    entity Areas as projection on masters.Areas;
    entity Roles as projection on masters.Roles;
    entity Genres as projection on masters.Genres;
    entity States as projection on masters.States;

    entity Employees as projection on schema.Employees;
    entity Employees_LicenseTypes as projection on schema.Employees_LicenseTypes;
    entity Licenses as projection on schema.Licenses;
    entity Documents as projection on schema.Documents;

    action approve(licenseID: schema.Licenses: ID) returns {
        license : Licenses:ID;
        state   : States:ID;
    };
    action observe(licenseID: schema.Licenses: ID) returns {
        license : Licenses:ID;
        state   : States:ID;
    };
    action reject(licenseID: schema.Licenses: ID) returns {
        license : Licenses:ID;
        state   : States:ID;
    };
}