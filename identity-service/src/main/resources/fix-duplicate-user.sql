-- =================================================================
-- FIX: NonUniqueResultException - trùng username trong bảng `user`
-- Chạy script này TRƯỚC khi start lại app (vì ddl-auto=update sẽ
-- tạo UNIQUE index trên cột username, sẽ fail nếu còn dữ liệu trùng).
-- =================================================================

USE identity_service;

-- 1. Xem trước các username bị trùng
SELECT username, COUNT(*) AS so_luong
FROM user
GROUP BY username
HAVING COUNT(*) > 1;

-- 2. Xóa các bản ghi trùng, giữ lại 1 bản ghi (id nhỏ nhất) cho mỗi username
SET FOREIGN_KEY_CHECKS = 0;

DELETE ur FROM user_roles ur
JOIN user u ON ur.user_id = u.id
JOIN (
    SELECT username, MIN(id) AS keep_id
    FROM user
    GROUP BY username
    HAVING COUNT(*) > 1
) d ON u.username = d.username AND u.id <> d.keep_id;

DELETE u FROM user u
JOIN (
    SELECT username, MIN(id) AS keep_id
    FROM user
    GROUP BY username
    HAVING COUNT(*) > 1
) d ON u.username = d.username AND u.id <> d.keep_id;

SET FOREIGN_KEY_CHECKS = 1;

-- 3. Kiểm tra lại: query dưới đây phải trả về 0 dòng
SELECT username, COUNT(*) AS so_luong
FROM user
GROUP BY username
HAVING COUNT(*) > 1;
