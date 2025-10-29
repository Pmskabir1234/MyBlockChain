# 🧾 Attendance Validator (Blockchain-Based Attendance System)

> A simple and transparent **attendance validation system** built on the Ethereum blockchain using **Solidity**.  
> This smart contract ensures that attendance records are **immutable, tamper-proof, and verifiable** — perfect for institutions that value integrity and transparency.  

---

## ⚙️ Overview

**Attendance Validator** allows institutions to mark student attendance on-chain.  
Each attendance record is stored permanently, and anyone can verify it publicly using the deployed smart contract.

No fake attendance. No paper mess. Just **trustless blockchain validation** ✅

<img width="1843" height="977" alt="Screenshot 2025-10-29 143232" src="https://github.com/user-attachments/assets/53210eea-4372-484c-b48c-7cbcaa669438" />

---

## ✨ Features

- 🧑‍🏫 **Institution-Controlled Access** — Only the contract owner (institution) can mark attendance.  
- 📜 **Transparent Verification** — Anyone can check if a student’s attendance is marked.  
- 🗂️ **Full Attendance List** — Retrieve all present students with one function call.  
- 🔁 **Reset for New Sessions** — Easily reset all attendance records for the next class/day.  
- 🧠 **Event Logging** — Every attendance marking emits an event for on-chain tracking.

---

🌐 Deployed Contract
Network: Ethereum (or testnet of your choice)
Deployed Smart Contract Address:
0xedC47D350A95BB764F99D2b692b4fad55214F62d

(Click to view on Etherscan!)

🧰 How to Run Locally
Wanna test it on your own system? Follow these simple steps 👇

🪄 1. Clone the Repository

git clone https://github.com/your-username/attendance-validator.git

cd attendance-validator

⚙️ 2. Install Dependencies

Make sure you have Node.js and npm installed. Then run:

npm install

If you’re using Hardhat or Truffle, install them globally if needed:

npm install --save-dev hardhat

# or

npm install -g truffle

🧱 3. Compile the Contract

If using Hardhat:

npx hardhat compile

If using Truffle:

truffle compile

🚀 4. Deploy Locally

You can deploy it to a local blockchain like Hardhat Network or Ganache:

npx hardhat run scripts/deploy.js --network localhost

(Make sure your local node is running!)

Or, to test instantly, use Remix IDE:

Visit Remix

Paste the contract in a new .sol file

Compile with 0.8.21

Deploy using Remix VM (London)

🧪 5. Interact with the Contract

Once deployed, try calling:

markPresent(address) → mark a student present

isPresent(address) → check if that student attended

getAllPresentStudents() → view all marked students

resetAllAttendance() → reset for a new day

💡 Future Enhancements
Add date-wise attendance tracking 🗓️

Integrate React + MetaMask frontend ⚛️

Generate on-chain attendance certificates 🎓

Use IPFS to attach verified student data 📂

👨‍💻 Author
Kabir — Computer Science Engineering Student 👨‍💻

Passionate about Web3, AI, and creating tech that actually matters.

## 🧩 Smart Contract Code

```solidity
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
