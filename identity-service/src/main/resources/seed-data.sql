-- =================================================================
-- IDENTITY SERVICE - DATA SEED SCRIPT
-- Database: identity_service
-- Description: File SQL seed dữ liệu mẫu cho identity_service
-- (Bao gồm Permission, Role, User và các bảng liên kết)
-- =================================================================

USE identity_service;

-- Tắt kiểm tra khóa ngoại để thực hiện dọn dẹp và chèn dữ liệu an toàn
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------------------
-- 0. CLEANUP (Xóa dữ liệu cũ nếu trùng username để tránh lỗi duplicate)
-- -----------------------------------------------------------------
DELETE FROM user_roles WHERE user_id IN ('11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333');
DELETE FROM user WHERE username IN ('admin', 'john_doe', 'jane_smith');

-- -----------------------------------------------------------------
-- 1. SEED PERMISSIONS
-- -----------------------------------------------------------------
INSERT IGNORE INTO permission (name, description) VALUES
('CREATE_POST', 'Permission to create posts'),
('READ_POST', 'Permission to read posts'),
('UPDATE_POST', 'Permission to update posts'),
('DELETE_POST', 'Permission to delete posts'),
('USER_MANAGE', 'Permission to manage users'),
('ROLE_MANAGE', 'Permission to manage roles'),
('PERMISSION_MANAGE', 'Permission to manage permissions'),
('APPROVE_POST', 'Permission to approve posts'),
('REJECT_POST', 'Permission to reject posts');

-- -----------------------------------------------------------------
-- 2. SEED ROLES
-- -----------------------------------------------------------------
INSERT IGNORE INTO role (name, description) VALUES
('ADMIN', 'Administrator role with full system control'),
('USER', 'Regular user role with standard permissions'),
('MANAGER', 'Manager role with post & content management permissions');

-- -----------------------------------------------------------------
-- 3. SEED ROLE_PERMISSIONS (Mối quan hệ giữa Role và Permission)
-- -----------------------------------------------------------------
INSERT IGNORE INTO role_permissions (role_name, permissions_name) VALUES
-- ADMIN role permissions (Toàn quyền)
('ADMIN', 'CREATE_POST'),
('ADMIN', 'READ_POST'),
('ADMIN', 'UPDATE_POST'),
('ADMIN', 'DELETE_POST'),
('ADMIN', 'USER_MANAGE'),
('ADMIN', 'ROLE_MANAGE'),
('ADMIN', 'PERMISSION_MANAGE'),
('ADMIN', 'APPROVE_POST'),
('ADMIN', 'REJECT_POST'),

-- MANAGER role permissions (Quản lý nội dung)
('MANAGER', 'CREATE_POST'),
('MANAGER', 'READ_POST'),
('MANAGER', 'UPDATE_POST'),
('MANAGER', 'DELETE_POST'),
('MANAGER', 'APPROVE_POST'),
('MANAGER', 'REJECT_POST'),

-- USER role permissions (Người dùng thông thường)
('USER', 'READ_POST'),
('USER', 'CREATE_POST');

-- -----------------------------------------------------------------
-- 4. SEED USERS
-- Password hashes (BCrypt 10 rounds):
-- - 'admin'  => $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
-- - '123456' => $2a$10$8.UnVuG9HHgffUDAlk8qfOUVGkq8yVzpE651h4nO90jG2pM5.9Q1.
-- -----------------------------------------------------------------
INSERT IGNORE INTO user (id, username, password, first_name, last_name, dob) VALUES
('11111111-1111-1111-1111-111111111111', 'admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'System', 'Admin', '1990-01-01'),
('22222222-2222-2222-2222-222222222222', 'john_doe', '$2a$10$8.UnVuG9HHgffUDAlk8qfOUVGkq8yVzpE651h4nO90jG2pM5.9Q1.', 'John', 'Doe', '1995-05-15'),
('33333333-3333-3333-3333-333333333333', 'jane_smith', '$2a$10$8.UnVuG9HHgffUDAlk8qfOUVGkq8yVzpE651h4nO90jG2pM5.9Q1.', 'Jane', 'Smith', '1998-08-20');

-- -----------------------------------------------------------------
-- 5. SEED USER_ROLES (Mối quan hệ giữa User và Role)
-- -----------------------------------------------------------------
INSERT IGNORE INTO user_roles (user_id, roles_name) VALUES
('11111111-1111-1111-1111-111111111111', 'ADMIN'),
('22222222-2222-2222-2222-222222222222', 'USER'),
('33333333-3333-3333-3333-333333333333', 'MANAGER');

-- Bật lại kiểm tra khóa ngoại
SET FOREIGN_KEY_CHECKS = 1;

-- =================================================================
-- SEED COMPLETED SUCCESSFULLY!
-- =================================================================
