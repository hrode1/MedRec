pragma solidity ^0.5.12;
pragma experimental ABIEncoderV2;

contract MedRec {
	/* create data structure for adding a record */
	struct Record {
		uint mrn;
		string diagnosis;
		string medication;
		string visitDate;
	}
	mapping(uint => Record) public patientRecords;
	uint public recIndex;
	
	/* Constructor: This is called only once during blockchain deployment
	to create a new medical record 
	*/
	constructor() public {
		recIndex = 0;
	}
	
	/* adding a new record */
	function addRecord(
		uint inputMRN, 
		string memory inputDiagnosis,
		string memory inputMedication,
		string memory inputVisitDate
	)
	public 
	{
		patientRecords[recIndex].mrn = inputMRN;
		patientRecords[recIndex].diagnosis = inputDiagnosis;
		patientRecords[recIndex].medication = inputMedication;
		patientRecords[recIndex].visitDate = inputVisitDate;
		recIndex = recIndex+1;
	}
	
	/* Number of records */
	function getNumRecords() public view returns(uint) {
		return recIndex;
	}
	
	/* get patient records using patient MRN */
	function getPatientRecord(uint inputMRN) 
	public
	view
	returns 
	(
		uint mrn,
		string memory diag, 
		string memory medi, 
		string memory visit
	)
	{
	for(uint i=0; i<recIndex; i++) {
			if(inputMRN==patientRecords[i].mrn) {
				return 
				(
					patientRecords[i].mrn,
					patientRecords[i].diagnosis, 
					patientRecords[i].medication,
					patientRecords[i].visitDate
				);
			}
		}
	}

	/* get patient records using patient MRN */
	function getPatientRecords(uint inputMRN) public view
	returns 
	(
			uint[] memory,
			string[] memory, 
			string[] memory, 
			string[] memory
	)
	{
	/* Find no. of records for the input MRN */
	uint numRec=0;
	for(uint i=0; i<recIndex; i++) {
		if(inputMRN==patientRecords[i].mrn)
			numRec++;
	}
	
	/* Temp */
	uint[] memory mrns = new uint[](numRec);
	string[] memory diag = new string[](numRec);
	string[] memory medi = new string[](numRec);
	string[] memory visits = new string[](numRec);
	
	uint counter=0;
	for(uint i=0; i<recIndex; i++) {
		Record storage rec = patientRecords[i];
		if(inputMRN==rec.mrn) {
			mrns[counter]=rec.mrn;
			diag[counter]=rec.diagnosis;
			medi[counter]=rec.medication;
			visits[counter]=rec.visitDate;
			counter++;
		}
	}
	return (mrns, diag, medi, visits);
	}

	/* get all patient records using patient */
	function getAllPatientRecords() public view
	returns 
	(
		uint[] memory,
		string[] memory, 
		string[] memory, 
		string[] memory
	)
	{
		/* Temp */
		uint[] memory mrns = new uint[](recIndex);
		string[] memory diag = new string[](recIndex);
		string[] memory medi = new string[](recIndex);
		string[] memory visits = new string[](recIndex);
	
		for(uint i=0; i<recIndex; i++) {
			Record storage rec = patientRecords[i];
			mrns[i]=rec.mrn;
			diag[i]=rec.diagnosis;
			medi[i]=rec.medication;
			visits[i]=rec.visitDate;
		}
		return (mrns, diag, medi, visits);
	}
}
