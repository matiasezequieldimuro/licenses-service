const cds = require('@sap/cds');
const { SELECT, UPDATE, INSERT } = cds.ql;

class LicensesService extends cds.ApplicationService {

    init() {
        const { Licenses, Employees } = this.entities;

        this.on('approve', this.onApprove);
        this.on('observe', this.onObserve);
        this.on('reject', this.onReject);

        this.before(['CREATE'], Licenses, this.validateDates);
        this.after(['CREATE'], Employees, this.generateEmployeeLicTypeRecords);

        return super.init();
    }

    async onApprove(req) {
        const { licenseID } = req.data;
        try {
            const hasFinalStatus = await this.checkIfHasFinalStatus(licenseID);
        
            if (hasFinalStatus) {
                return req.error("ERROR_FINAL_STATUS");
            }
    
            const newID = 3;
            await this.updateLicenseState(licenseID, newID);
    
            const { employee_ID, licenseType_ID, beginDate, endDate } = await this.getLicenseData(licenseID);
            
            const daysToTake = this.calculateDifferenceDaysBetweenDates(beginDate, endDate);
            const daysTaked = await this.getDaysTakedFromLicType(employee_ID, licenseType_ID);
            await this.updateEmployeeLicenseDays(employee_ID, licenseType_ID, daysTaked + daysToTake);
    
            return {
                license: licenseID,
                state: newID
            }
        }
        catch(err) {
            console.error("Error en validateDates:", err)
            return req.error(err);
        }
    }

    async onObserve(req) {
        const { licenseID } = req.data;
        try {
            const hasFinalStatus = await this.checkIfHasFinalStatus(licenseID);

            if (hasFinalStatus) {
                return req.error("ERROR_FINAL_STATUS");
            }

            const newID = 2;
            await this.updateLicenseState(licenseID, newID);

            return {
                license: licenseID,
                state: newID
            }
        } 
        catch(err) {
            console.error("Error en validateDates:", err)
            return req.error(err);
        }
    }

    async onReject(req) {
        const { licenseID } = req.data;
        try {
            const hasFinalStatus = await this.checkIfHasFinalStatus(licenseID);

            if (hasFinalStatus) {
                return req.error("ERROR_FINAL_STATUS");
            }

            const newID = 4;
            await this.updateLicenseState(licenseID, newID);

            return {
                license: licenseID,
                state: newID
            }
        } 
        catch(err) {
            console.error("Error en validateDates:", err)
            return req.error(err);
        }
    }

    async checkIfHasFinalStatus(licenseID) {
        const { Licenses } = this.entities;
        return new Promise((resolve, reject) => {
            SELECT.from(Licenses, licenseID, l => l.state_ID )
                .then(res => {
                    const { state_ID } = res;
                    console.log(`>>> License ${licenseID} - Current state: ${state_ID}`);
                    // Approved or Rejected
                    return (state_ID === 3 || state_ID === 4) ? resolve(true) : resolve(false)
                })
                .catch(err => reject(err));
        })
    }

    updateLicenseState(licenseID, newStateID) {
        const { Licenses } = this.entities;
        return new Promise((resolve, reject) => {
            UPDATE(Licenses, licenseID).with({ state_ID: newStateID })
                .then(res => resolve(res))
                .catch(err => reject(err));
        })
    }

    getLicenseData(licenseID) {
        const { Licenses } = this.entities;
        return new Promise((resolve, reject) => {
            SELECT.from(Licenses, licenseID).columns(['employee_ID', 'licenseType_ID', 'beginDate', 'endDate'])
                .then(res => resolve(res))
                .catch(err => reject(err));
        })
    }

    getDaysTakedFromLicType(employee_ID, licenseType_ID) {
        const { Employees_LicenseTypes } = this.entities;
        return new Promise((resolve, reject) => {
            SELECT.one
                .from(Employees_LicenseTypes)
                .where({ employee_ID, licenseType_ID })
                .columns(['daysTaked'])
                    .then(res => resolve(res.daysTaked))
                    .catch(err => reject(err));
        })
    }

    updateEmployeeLicenseDays(employee_ID, licenseType_ID, daysTaked) {
        const { Employees_LicenseTypes } = this.entities;
        return new Promise((resolve, reject) => {
            UPDATE(Employees_LicenseTypes).where({ employee_ID, licenseType_ID }).with({ daysTaked })
                .then(res => resolve(res))
                .catch(err => reject(err));
        })
        
    }

    calculateDifferenceDaysBetweenDates(beginDate, endDate) {
        const dBeginDate = new Date(beginDate);
        const dEndDate = new Date(endDate);

        const differenceMs = dEndDate - dBeginDate;

        const differenceDate = new Date(differenceMs);
        const MS_PER_DAY = 1000 * 60 * 60 * 24;

        const differenceDays = parseInt(differenceDate / MS_PER_DAY, 10); 
        console.log("Days difference: " + differenceDays);
        return differenceDays;
    }

    async validateDates(req) {
        const { LicenseTypes } = this.entities;
        const { beginDate, endDate, employee_ID, licenseType_ID } = req.data;

        if (new Date(beginDate) > new Date(endDate)) {
            req.error("ERROR_VALIDATION_DATES", [beginDate, endDate]);
        }

        try {
            const daysToTake = this.calculateDifferenceDaysBetweenDates(beginDate, endDate);
            const { days } = await SELECT.from(LicenseTypes, licenseType_ID).columns(['days']);
            const daysTaked = await this.getDaysTakedFromLicType(employee_ID, licenseType_ID);

            console.log(`${days} - ${daysTaked}`);
            const daysAvailable = days - daysTaked;
            
            if (daysAvailable < daysToTake) {
                return req.error("ERROR_VALIDATION_DATES_AVAILABLE");
            }
        } 
        catch (err) {
            console.error("Error en validateDates:", err)
            req.error(err);
        }
        
        return;
    }

    async generateEmployeeLicTypeRecords(req) {
        const { ID } = req;
        const { LicenseTypes, Employees_LicenseTypes } = this.entities;

        try {
            const typeIDs = await SELECT.from(LicenseTypes).columns(['ID']);
            console.log(typeIDs);

            typeIDs.forEach(async (type) => {
                const res = await Promise.resolve(
                    INSERT({ employee_ID: ID, licenseType_ID: type.ID }).into(Employees_LicenseTypes)
                )
                console.log(res);
            });

            return;
        } 
        catch (err) {
            console.error("Error en generateEmployeeLicTypeRecords:", err)
        }
    }
}

module.exports = LicensesService;