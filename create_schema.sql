CREATE TABLE Users (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each user
    name VARCHAR(100) NOT NULL,          -- Full name of the user
    email VARCHAR(255) UNIQUE NOT NULL,  -- Email address for login
    role VARCHAR(50) NOT NULL,           -- ENUM: 'student' or 'teacher'
    password_hash TEXT NOT NULL,         -- Hashed password for authentication
    created_at TIMESTAMP DEFAULT NOW()   -- Timestamp of user creation
);

CREATE TABLE Courses (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each course
    teacher_id INT NOT NULL,             -- Foreign key: Users.id
    name VARCHAR(200) NOT NULL,          -- Name of the course
    description TEXT,                    -- Description of the course
    created_at TIMESTAMP DEFAULT NOW(),  -- Timestamp of course creation
    FOREIGN KEY (teacher_id) REFERENCES Users(id)
);

CREATE TABLE Modules (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each module
    course_id INT NOT NULL,              -- Foreign key: Courses.id
    title VARCHAR(200) NOT NULL,         -- Title of the module
    description TEXT,                    -- Description of the module
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

CREATE TABLE Materials (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each material
    course_id INT NOT NULL,              -- Foreign key: Courses.id
    module_id INT NOT NULL,              -- Foreign key: Modules.id
    file_type VARCHAR(50) NOT NULL,      -- Type of file (e.g., 'PDF', 'Video')
    file_url TEXT NOT NULL,              -- URL to the file (e.g., S3 link)
    created_at TIMESTAMP DEFAULT NOW(),  -- Timestamp of material creation
    FOREIGN KEY (module_id) REFERENCES Modules(id)
);

CREATE TABLE Enrollments (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each enrollment
    student_id INT NOT NULL,             -- Foreign key: Users.id
    course_id INT NOT NULL,              -- Foreign key: Courses.id
    joined_at TIMESTAMP DEFAULT NOW(),   -- Timestamp of enrollment
    FOREIGN KEY (student_id) REFERENCES Users(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

CREATE TABLE Threads (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each thread
    student_id INT NOT NULL,             -- Foreign key referencing Users(id)
    course_id INT NOT NULL,              -- Foreign key referencing Courses(id)
    created_at TIMESTAMP DEFAULT NOW(),  -- Timestamp of thread creation
    last_updated TIMESTAMP,               -- Timestamp of last thread update
    FOREIGN KEY (student_id) REFERENCES Users(id),
    FOREIGN KEY (course_id) REFERENCES Courses(id)
);

CREATE TABLE ProficiencyScores (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each proficiency score
    student_id INT NOT NULL,             -- Foreign key: Users.id
    course_id INT NOT NULL,              -- Foreign key: Courses.id
    module_id INT NOT NULL,              -- Foreign key: Modules.id
    score DECIMAL(5, 2),                 -- Proficiency Score
    last_updated TIMESTAMP DEFAULT NOW(),-- Timestamp of last score update
    FOREIGN KEY (student_id) REFERENCES Users(id),
    FOREIGN KEY (module_id) REFERENCES Modules(id)
);
