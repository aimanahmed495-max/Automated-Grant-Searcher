-- 1. USERS
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. ORGANIZATIONS
CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    owner_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. GRANT SOURCES
CREATE TABLE grant_sources (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    url VARCHAR(500),
    source_type VARCHAR(100)
);

-- 4. GRANTS
CREATE TABLE grants (
    id SERIAL PRIMARY KEY,
    source_id INTEGER REFERENCES grant_sources(id) ON DELETE CASCADE,
    title VARCHAR(500) NOT NULL,
    description TEXT,
    amount_min NUMERIC(12, 2),
    amount_max NUMERIC(12, 2),
    deadline_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. USER GRANT MATCHES (The Junction Table)
CREATE TABLE user_grant_matches (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    grant_id INTEGER REFERENCES grants(id) ON DELETE CASCADE,
    status VARCHAR(50),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);