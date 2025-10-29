// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract AttendanceValidator {
    address public owner;

    // mapping of student address to their attendance status
    mapping(address => bool) private attendance;

    // keep list of all marked students for easy viewing
    address[] public markedStudents;

    event AttendanceMarked(address indexed student, bool status);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: only owner");
        _;
    }

    // mark a student as present
    function markPresent(address _student) public onlyOwner {
        require(!attendance[_student], "Already marked present");
        attendance[_student] = true;
        markedStudents.push(_student);
        emit AttendanceMarked(_student, true);
    }

    // check if a student is marked present
    function isPresent(address _student) public view returns (bool) {
        return attendance[_student];
    }

    // get list of all students marked present
    function getAllPresentStudents() public view returns (address[] memory) {
        return markedStudents;
    }

    // reset attendance for all students (new session/day)
    function resetAllAttendance() public onlyOwner {
        for (uint i = 0; i < markedStudents.length; i++) {
            attendance[markedStudents[i]] = false;
        }
        delete markedStudents;
    }
}