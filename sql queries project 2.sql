-- Insert into Candidate
INSERT INTO Candidate (Name, DateOfBirth, Gender, Address, Phone, Email, Nationality)
VALUES
    ('John Doe', '1990-01-15', 'M', '123 Elm Street, Springfield', '555-1234', 'john.doe@example.com', 'American'),
    ('Jane Smith', '1985-05-22', 'F', '456 Oak Avenue, Rivertown', '555-5678', 'jane.smith@example.com', 'Canadian');

-- Insert into Examination
INSERT INTO Examination (ExamName, ExamDate, ExamLocation)
VALUES
    ('Civil Services Preliminary Exam', '2024-09-10', 'New York City'),
    ('Civil Services Main Exam', '2024-12-05', 'San Francisco');

-- Insert into Application
INSERT INTO Application (CandidateID, ExamID, ApplicationDate, Status)
VALUES
    (1, 1, '2024-08-01', 'Submitted'),
    (2, 2, '2024-08-15', 'Under Review');

-- Insert into Payment
INSERT INTO Payment (ApplicationID, PaymentDate, Amount, PaymentMethod)
VALUES
    (1, '2024-08-02', 1000.00, 'Credit Card'),
    (2, '2024-08-16', 1200.00, 'PayPal');
-- Create Candidate Table
CREATE TABLE Candidate (
    CandidateID INTEGER PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F', 'O')), -- M: Male, F: Female, O: Other
    Address TEXT,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE NOT NULL,
    Nationality VARCHAR(50)
);

-- Create Examination Table
CREATE TABLE Examination (
    ExamID INTEGER PRIMARY KEY,
    ExamName VARCHAR(100) NOT NULL,
    ExamDate DATE NOT NULL,
    ExamLocation VARCHAR(100) NOT NULL
);

-- Create Application Table
CREATE TABLE Application (
    ApplicationID INTEGER PRIMARY KEY,
    CandidateID INTEGER NOT NULL,
    ExamID INTEGER NOT NULL,
    ApplicationDate DATE NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Submitted', 'Under Review', 'Accepted', 'Rejected')),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    FOREIGN KEY (ExamID) REFERENCES Examination(ExamID)
);

-- Create Payment Table
CREATE TABLE Payment (
    PaymentID INTEGER PRIMARY KEY,
    ApplicationID INTEGER NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL CHECK (PaymentMethod IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer')),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

-- Create Document Table
CREATE TABLE Document (
    DocumentID INTEGER PRIMARY KEY,
    ApplicationID INTEGER NOT NULL,
    DocumentType VARCHAR(50) NOT NULL,
    DocumentFile BLOB NOT NULL, -- Assuming the file is stored as binary data
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);

-- Create Result Table
CREATE TABLE Result (
    ResultID INTEGER PRIMARY KEY,
    ApplicationID INTEGER NOT NULL,
    Marks DECIMAL(5, 2),
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pass', 'Fail', 'Pending')),
    FOREIGN KEY (ApplicationID) REFERENCES Application(ApplicationID)
);


-- Insert into Document
INSERT INTO Document (ApplicationID, DocumentType, DocumentFile)
VALUES
    (1, 'Passport', x'62696e6172795f646174615f68657265'), -- Replace with actual binary data
    (2, 'Birth Certificate', x'62696e6172795f646174615f68657265'); -- Replace with actual binary data

-- Insert into Result
INSERT INTO Result (ApplicationID, Marks, Status)
VALUES
    (1, 85.50, 'Pass'),
    (2, NULL, 'Pending'); -- Assuming result is not yet available
