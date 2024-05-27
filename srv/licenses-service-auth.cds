using {
    LicensesService.Areas,
    LicensesService.Genres,
    LicensesService.Roles,
    LicensesService.States,
    LicensesService.LicenseTypes,
    LicensesService.Employees,
    LicensesService.Licenses,
    LicensesService.Documents,
    LicensesService.Employees_LicenseTypes,
    LicensesService.approve,
    LicensesService.observe,
    LicensesService.reject,

} from './licenses-service';

annotate Areas with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: 'READ',
        to: 'applicant',
    },
    {
        grant: 'READ',
        to: 'approver',
    }
]);

annotate Roles with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: 'READ',
        to: 'applicant',
    },
    {
        grant: 'READ',
        to: 'approver',
    }
]);

annotate Genres with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: 'READ',
        to: 'applicant',
    },
    {
        grant: 'READ',
        to: 'approver',
    }
]);

annotate States with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: 'READ',
        to: 'applicant',
    },
    {
        grant: 'READ',
        to: 'approver',
    }
]);

annotate LicenseTypes with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: 'READ',
        to: 'applicant',
    },
    {
        grant: 'READ',
        to: 'approver',
    }
]);

annotate Employees with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: 'READ',
        to: 'applicant',
    },
    {
        grant: 'READ',
        to: 'approver',
    }
]);

annotate Licenses with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: ['READ', 'CREATE'],
        to: 'applicant',
        where: 'employee.email = $user'
    },
    {
        grant: ['READ'],
        to: 'approver',
        where: 'employee.email <> $user and (state_ID = 1 or state_ID = 2)' // pendientes - observadas
    }
]);

annotate Documents with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: ['READ', 'CREATE'],
        to: 'applicant',
        where: 'license.employee.email = $user'
    },
    {
        grant: 'READ',
        to: 'approver',
        where: 'license.employee.email <> $user and (license.state_ID = 1 or license.state_ID = 2)' // pendientes - observadas
    }
]);

annotate Employees_LicenseTypes with @(restrict: [
    {
        grant: '*',
        to: 'administrator',
    },
    {
        grant: 'READ',
        to: 'applicant',
        where: 'employee.email = $user'
    },
    {
        grant: ['READ'],
        to: 'approver'
    }
]);

annotate approve with @(requires: ['administrator', 'approver']);
annotate observe with @(requires: ['administrator', 'approver']);
annotate reject with @(requires: ['administrator', 'approver']);
