-- 1. Insert 10 Users
INSERT INTO users (name, email, password_hash, role) VALUES
('Alice Smith', 'alice@example.com', 'hash123', 'user'),
('Bob Jones', 'bob@example.com', 'hash123', 'user'),
('Charlie Day', 'charlie@example.com', 'hash123', 'user'),
('Diana Prince', 'diana@example.com', 'hash123', 'admin'),
('Evan Peters', 'evan@example.com', 'hash123', 'user'),
('Fiona Gallagher', 'fiona@example.com', 'hash123', 'user'),
('George Costanza', 'george@example.com', 'hash123', 'user'),
('Hannah Montana', 'hannah@example.com', 'hash123', 'user'),
('Ian Malcolm', 'ian@example.com', 'hash123', 'user'),
('Jack Ryan', 'jack@example.com', 'hash123', 'user');

-- 2. Insert 10 Organizations
INSERT INTO organizations (name, type, owner_id) VALUES
('TechStart Inc', 'Startup', 1),
('Green Earth', 'Nonprofit', 2),
('EduFuture', 'Education', 3),
('MediCare Plus', 'Healthcare', 4),
('Solar Solutions', 'Startup', 5),
('Local Food Bank', 'Nonprofit', 6),
('City Dev Corp', 'Government', 7),
('Artist Collective', 'Arts', 8),
('BioGen Labs', 'Research', 9),
('Community First', 'Nonprofit', 10);

-- 3. Insert 10 Grant Sources
INSERT INTO grant_sources (name, url, source_type) VALUES
('National Science Foundation', 'nsf.gov', 'Federal'),
('Grants.gov', 'grants.gov', 'Federal'),
('Y Combinator', 'ycombinator.com', 'Private'),
('Gates Foundation', 'gatesfoundation.org', 'Private'),
('SBIR', 'sbir.gov', 'Federal'),
('Ford Foundation', 'fordfoundation.org', 'Private'),
('Department of Energy', 'energy.gov', 'Federal'),
('NIH', 'nih.gov', 'Federal'),
('Techstars', 'techstars.com', 'Private'),
('Global Fund', 'theglobalfund.org', 'International');

-- 4. Insert 10 Grants
INSERT INTO grants (source_id, title, description, amount_min, amount_max, deadline_at) VALUES
(1, 'AI Research Grant', 'Funding for AI safety research', 50000, 250000, '2025-12-31'),
(2, 'Small Business Boost', 'For main street businesses', 5000, 10000, '2025-06-30'),
(3, 'Seed Funding Batch', 'Standard deal for startups', 125000, 500000, '2025-04-15'),
(4, 'Global Health Initiative', 'Vaccine distribution logs', 100000, 1000000, '2025-09-01'),
(5, 'Phase 1 Tech Innovation', 'Prototype development', 75000, 150000, '2025-08-15'),
(6, 'Community Arts Fund', 'Local art installations', 1000, 5000, '2025-03-01'),
(7, 'Clean Energy Grant', 'Solar panel installation', 20000, 50000, '2025-07-20'),
(8, 'Cancer Research Pilot', 'Early stage trials', 200000, 500000, '2025-11-30'),
(9, 'Accelerator Program', 'Mentorship and funding', 20000, 120000, '2025-05-10'),
(10, 'Education for All', 'Building schools', 50000, 100000, '2025-10-01');

-- 5. Insert 10 Matches (Saved Grants)
INSERT INTO user_grant_matches (user_id, grant_id, status) VALUES
(1, 1, 'saved'),
(1, 3, 'applied'),
(2, 2, 'saved'),
(2, 6, 'rejected'),
(3, 10, 'saved'),
(4, 4, 'applied'),
(5, 5, 'saved'),
(6, 2, 'saved'),
(7, 7, 'applied'),
(8, 6, 'saved');