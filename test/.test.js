const cds = require('@sap/cds')

describe("Licenses Service REST API Test with Jest", ()=>{
    
	const test = cds.test(__dirname+'/..');

	const users = {
		admin: {
			auth: {
				username: "admin@email.com",
				password: "123"
			}
		}
	}
    
	it ("'Hello World' message is expected", () => {
		let message = "Hello World";
		expect(message).toBe("Hello World");
    });

	it ("Check LicenseType entity with ID 1 is 'Holidays'", async () => {
		// Arrange: set initial data or input.
		let ID = 1;
		// Act: do what we want to test.
		let res = await test.get(`/service/licenses/LicenseTypes/${ID}`, users.admin);
		// Verify: check output is correct given input.
		console.log(res.data)
		expect(res.data.name).toBe("Holidays");
		expect(res.data.ID).toBe(ID);
		expect(res.status).toBe(200);
    });
})
