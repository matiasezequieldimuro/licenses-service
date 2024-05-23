using { 
    ApplicantService.Licenses, 
    ApplicantService.Documents, 
    ApplicantService.Employees_LicenseTypes ,
    ApplicantService.Genres,
    ApplicantService.LicenseTypes,
    ApplicantService.States,
    ApplicantService.getLicensesData,
    ApplicantService.getUserData
} from './applicant-service';

annotate Licenses with @(restrict: [
    {
        grant: ['CREATE'],
        to: 'applicant'
    }
]);

annotate Documents with @(restrict: [
    {
        grant: ['CREATE'],
        to: 'applicant'
    }
]);

annotate Employees_LicenseTypes with @(restrict: [
    {
        grant: ['UPDATE'],
        to: 'applicant'
    }
]);

annotate Genres with @readonly @(requires: 'applicant');
annotate LicenseTypes with @readonly @(requires: 'applicant');
annotate States with @readonly @(requires: 'applicant');

annotate getLicensesData with @(requires: 'applicant');
annotate getUserData with @(requires: 'applicant');
