// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DonorContract {

    struct pledged {
        string fullname;
        uint age;
        string gender;
        string medical_id;
        string blood_type;
        string[] organ;
        uint weight;
        uint height;
    }

    struct donor {
        string fullname;
        uint age;
        string gender;
        string medical_id;
        string blood_type;
        string[] organ;
        uint weight;
        uint height;
    }

    struct patient {
        string fullname;
        uint age;
        string gender;
        string medical_id;
        string blood_type;
        string[] organ;
        uint weight;
        uint height;
    }

    struct tmatch {
        string D_name;
        string P_name;
        string D_medical_id;
        string P_medical_id;
        string D_blood_type;
        string P_blood_type;
        string[] organ;
        string Transplant_id;
    }

    mapping(string => pledged) pledgedMap;
    mapping(string => donor) donorMap;
    mapping(string => patient) patientMap;
    mapping(string => tmatch) public transplantMap;

    string[] PledgedArray;
    string[] DonorsArray;
    string[] PatientsArray;
    string[] TransplantArray;

    function setPledge(string memory _fullname, uint _age, string memory _gender, string memory _medical_id,
                       string memory _blood_type, string[] memory _organ, uint _weight, uint _height)
    public {
        require(keccak256(abi.encodePacked((pledgedMap[_medical_id].medical_id))) != keccak256(abi.encodePacked(_medical_id)));
        pledgedMap[_medical_id] = pledged({
            fullname: _fullname,
            age: _age,
            gender: _gender,
            medical_id: _medical_id,
            blood_type: _blood_type,
            organ: _organ,
            weight: _weight,
            height: _height
        });

        PledgedArray.push(_medical_id);
    }

    function setDonors(string memory _fullname, uint _age, string memory _gender, string memory _medical_id,
                       string memory _blood_type, string[] memory _organ, uint _weight, uint _height)
    public {
        require(keccak256(abi.encodePacked((donorMap[_medical_id].medical_id))) != keccak256(abi.encodePacked(_medical_id)));
        donorMap[_medical_id] = donor({
            fullname: _fullname,
            age: _age,
            gender: _gender,
            medical_id: _medical_id,
            blood_type: _blood_type,
            organ: _organ,
            weight: _weight,
            height: _height
        });

        DonorsArray.push(_medical_id);
    }

    function setPatients(string memory _fullname, uint _age, string memory _gender, string memory _medical_id,
                       string memory _blood_type, string[] memory _organ, uint _weight, uint _height)
    public {
        require(keccak256(abi.encodePacked((patientMap[_medical_id].medical_id))) != keccak256(abi.encodePacked(_medical_id)));
        patientMap[_medical_id] = patient({
            fullname: _fullname,
            age: _age,
            gender: _gender,
            medical_id: _medical_id,
            blood_type: _blood_type,
            organ: _organ,
            weight: _weight,
            height: _height
        });

        PatientsArray.push(_medical_id);
    }

    function setTransplant(
        string memory _D_name, string memory _P_name, string memory _D_medical_id, string memory _P_medical_id, string memory _D_blood_type, string memory _P_blood_type, string[] memory _organ, string memory _Transplant_id )
         public {
        require(keccak256(abi.encodePacked((transplantMap[_Transplant_id].Transplant_id))) != keccak256(abi.encodePacked(_Transplant_id)));

        transplantMap[_Transplant_id] = tmatch({
            D_name: _D_name,
            P_name: _P_name,
            D_medical_id: _D_medical_id,
            P_medical_id: _P_medical_id,
            D_blood_type: _D_blood_type,
            P_blood_type: _P_blood_type,
            organ: _organ,
            Transplant_id: _Transplant_id
        });

        TransplantArray.push(_Transplant_id);
    }

    function getPledge(string memory _medical_id) view public returns(string memory, uint, string memory, string memory, string[] memory, uint, uint) {
        pledged storage p = pledgedMap[_medical_id];
        return (p.fullname, p.age, p.gender, p.blood_type, p.organ, p.weight, p.height);
    }

    function getDonor(string memory _medical_id) view public returns(string memory, uint, string memory, string memory, string[] memory, uint, uint) {
        donor storage d = donorMap[_medical_id];
        return (d.fullname, d.age, d.gender, d.blood_type, d.organ, d.weight, d.height);
    }

    function getPatient(string memory _medical_id) view public returns(string memory, uint, string memory, string memory, string[] memory, uint, uint) {
        patient storage p = patientMap[_medical_id];
        return (p.fullname, p.age, p.gender, p.blood_type, p.organ, p.weight, p.height);
    }

    function getTransplant(string memory _Transplant_id) view public returns(string memory, string memory, string memory, string memory, string memory, string memory, string[] memory) {
        tmatch storage t = transplantMap[_Transplant_id];
        return (t.D_name, t.P_name, t.D_medical_id, t.P_medical_id, t.D_blood_type, t.P_blood_type, t.organ);
    }

    function validateTransplant(string memory _Transplant_id) view public returns(bool) {
        return keccak256(abi.encodePacked((transplantMap[_Transplant_id].Transplant_id))) == keccak256(abi.encodePacked(_Transplant_id));
    }

    function validatePledge(string memory _medical_id) view public returns(bool) {
        return keccak256(abi.encodePacked((pledgedMap[_medical_id].medical_id))) == keccak256(abi.encodePacked(_medical_id));
    }

    function validateDonor(string memory _medical_id) view public returns(bool) {
        return keccak256(abi.encodePacked((donorMap[_medical_id].medical_id))) == keccak256(abi.encodePacked(_medical_id));
    }

    function validatePatient(string memory _medical_id) view public returns(bool) {
        return keccak256(abi.encodePacked((patientMap[_medical_id].medical_id))) == keccak256(abi.encodePacked(_medical_id));
    }

    function getAllPledgeIDs() view public returns(string[] memory) {
        return PledgedArray;
    }

    function getAllDonorIDs() view public returns(string[] memory) {
        return DonorsArray;
    }

    function getAllPatientIDs() view public returns(string[] memory) {
        return PatientsArray;
    }

    function getAllTransplantIDs() view public returns(string[] memory) {
        return TransplantArray;
    }

    function getCountOfPledges() view public returns (uint) {
        return PledgedArray.length;
    }

    function getCountOfDonors() view public returns (uint) {
        return DonorsArray.length;
    }

    function getCountOfPatients() view public returns (uint) {
        return PatientsArray.length;
    }

    function getCountOfTransplants() view public returns (uint) {
        return TransplantArray.length;
    }
}
