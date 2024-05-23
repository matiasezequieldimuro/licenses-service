using { cuid } from '@sap/cds/common';
using { 
    hexagon.licenseapplications.masters.Genre, 
    hexagon.licenseapplications.masters.LicenseTypes, 
    hexagon.licenseapplications.masters.Roles,
    hexagon.licenseapplications.masters.States
} from './masters';


namespace hexagon.licenseapplications.schema;

entity Employees : cuid {
    firstName   : String(20) @mandatory;
    lastName    : String(20) @mandatory;
    email       : String(20) @mandatory;
    bornDate    : Date;
    genre       : Genre;
    isApprover  : Boolean default false;
    role        : Association to Roles @assert.target @mandatory;
    licenses    : Association to many Licenses on licenses.employee = $self;
    licenseType : Composition of many Employees_LicenseTypes on licenseType.employee = $self;
}

entity Licenses : cuid {
    // TODO: Chequear qué pasa si no pongo 'many'.
    licenseType     : Association to many LicenseTypes @assert.target @mandatory;
    state           : Association to many States @assert.target @mandatory;
    employee        : Association to one Employees @assert.target @mandatory;
    date            : Date @cds.on.insert : $now;
    beginDate       : Date @mandatory;
    endDate         : Date @mandatory;
    observations    : String(200);
    documents       : Composition of many Documents on documents.license = $self;
}

entity Documents : cuid {
    uri         : String(100);
    format      : String(4) @mandatory;
    fileName    : String(30) @mandatory;
    license     : Association to many Licenses @assert.target @mandatory;
}

entity Employees_LicenseTypes : cuid {
    employee    : Association to one Employees @assert.target @mandatory;
    licenseType : Association to one LicenseTypes;
    daysTaked   : Integer default 0;
}