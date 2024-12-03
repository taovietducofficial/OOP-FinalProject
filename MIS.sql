CREATE DATABASE ShoeStoreManagement;
USE ShoeStoreManagement;

-- Bảng Khách hàng
CREATE TABLE CUSTOMER (
    MaKH INT AUTO_INCREMENT PRIMARY KEY,
    TenKH VARCHAR(100) NOT NULL,
    DiaChi VARCHAR(255),
    SDT VARCHAR(15),
    Email VARCHAR(100),
    LichSuMuaHang TEXT
);

-- Bảng Nhân viên
CREATE TABLE EMPLOYEE (
    MaNV INT AUTO_INCREMENT PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL,
    ChucVu VARCHAR(50),
    SDT VARCHAR(15),
    Email VARCHAR(100)
);

-- Bảng Đơn hàng Offline
CREATE TABLE OFFLINE_ORDER (
    MaDonHang INT AUTO_INCREMENT PRIMARY KEY,
    NgayDatHang DATE NOT NULL,
    TongTien DECIMAL(10, 2) NOT NULL,
    HinhThucThanhToan VARCHAR(50),
    MaKH INT NOT NULL,
    MaNV INT NOT NULL,
    FOREIGN KEY (MaKH) REFERENCES CUSTOMER(MaKH),
    FOREIGN KEY (MaNV) REFERENCES EMPLOYEE(MaNV)
);

-- Bảng Đơn hàng Online
CREATE TABLE ONLINE_ORDER (
    MaDonHang INT AUTO_INCREMENT PRIMARY KEY,
    NgayDatHang DATE NOT NULL,
    TongTien DECIMAL(10, 2) NOT NULL,
    HinhThucThanhToan VARCHAR(50),
    TrangThaiDonHang ENUM('Dang xu ly', 'Da giao', 'Da huy') NOT NULL,
    MaKH INT NOT NULL,
    FOREIGN KEY (MaKH) REFERENCES CUSTOMER(MaKH)
);

-- Bảng Sản phẩm
CREATE TABLE PRODUCT (
    MaSP INT AUTO_INCREMENT PRIMARY KEY,
    TenSP VARCHAR(100) NOT NULL,
    MoTa TEXT,
    HinhAnh VARCHAR(255),
    DanhMuc VARCHAR(50)
);

-- Bảng Chi tiết đơn hàng
CREATE TABLE ORDER_DETAIL (
    MaDonHang INT NOT NULL,
    MaSP INT NOT NULL,
    SoLuong INT NOT NULL,
    GiaSanPham DECIMAL(10, 2) NOT NULL,
    TongTienSanPham DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (MaDonHang, MaSP),
    FOREIGN KEY (MaDonHang) REFERENCES OFFLINE_ORDER(MaDonHang),
    FOREIGN KEY (MaSP) REFERENCES PRODUCT(MaSP)
);

-- Bảng Tồn kho sản phẩm
CREATE TABLE STOCK (
    MaSP INT NOT NULL,
    SoLuongTon INT NOT NULL,
    KhoLuuTru VARCHAR(100),
    PRIMARY KEY (MaSP, KhoLuuTru),
    FOREIGN KEY (MaSP) REFERENCES PRODUCT(MaSP)
);

-- Bảng Nhà cung cấp
CREATE TABLE SUPPLIER (
    MaNCC INT AUTO_INCREMENT PRIMARY KEY,
    TenCongTy VARCHAR(100) NOT NULL,
    ThongTinLienHe VARCHAR(255)
);

-- Bảng Khuyến mãi
CREATE TABLE PROMOTION (
    MaKM INT AUTO_INCREMENT PRIMARY KEY,
    TenChuongTrinh VARCHAR(100) NOT NULL,
    MoTa TEXT,
    ThoiGianBatDau DATE,
    ThoiGianKetThuc DATE,
    DieuKienThamGia TEXT
);

-- Bảng Sản phẩm trên nền tảng thương mại điện tử
CREATE TABLE ECOMMERCE_PRODUCT (
    MaSP INT PRIMARY KEY,
    TenSP VARCHAR(100) NOT NULL,
    MoTa TEXT,
    Gia DECIMAL(10, 2) NOT NULL,
    DanhMuc VARCHAR(50),
    FOREIGN KEY (MaSP) REFERENCES PRODUCT(MaSP)
);

-- Bảng Thanh toán
CREATE TABLE PAYMENT (
    MaGiaoDich INT AUTO_INCREMENT PRIMARY KEY,
    NgayGiaoDich DATETIME NOT NULL,
    MaDonHang INT NOT NULL,
    HinhThucThanhToan VARCHAR(50),
    SoTienThanhToan DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MaDonHang) REFERENCES OFFLINE_ORDER(MaDonHang)
);

-- Bảng Tài chính
CREATE TABLE FINANCE (
    MaBaoCao INT AUTO_INCREMENT PRIMARY KEY,
    DoanhThu DECIMAL(15, 2),
    ChiPhi DECIMAL(15, 2),
    LoiNhuan DECIMAL(15, 2),
    ThoiGianBaoCao DATE
);

-- Dữ liệu mẫu cho Khách hàng
INSERT INTO CUSTOMER (TenKH, DiaChi, SDT, Email, LichSuMuaHang)
VALUES 
    ('Nguyen Van A', '123 Le Loi, TP.HCM', '0912345678', 'a.nguyen@example.com', 'Mua giay the thao, Mua giay cong so'),
    ('Tran Thi B', '456 Tran Hung Dao, TP.HCM', '0987654321', 'b.tran@example.com', 'Mua giay cao got');

-- Dữ liệu mẫu cho Nhân viên
INSERT INTO EMPLOYEE (HoTen, ChucVu, SDT, Email)
VALUES 
    ('Le Van C', 'Nhan vien ban hang', '0934567890', 'c.le@example.com'),
    ('Pham Thi D', 'Quan ly', '0976543210', 'd.pham@example.com');

-- Dữ liệu mẫu cho Sản phẩm
INSERT INTO PRODUCT (TenSP, MoTa, HinhAnh, DanhMuc)
VALUES 
    ('Giay The Thao Nike', 'Giay the thao chinh hang Nike', 'nike.jpg', 'Giay the thao'),
    ('Giay Cao Got Gucci', 'Giay cao got sang trong Gucci', 'gucci.jpg', 'Giay cao got');

-- Dữ liệu mẫu cho Nhà cung cấp
INSERT INTO SUPPLIER (TenCongTy, ThongTinLienHe)
VALUES 
    ('Cong ty ABC', '123 Nguyen Trai, TP.HCM, 0911222333, abc@example.com'),
    ('Cong ty XYZ', '789 Le Van Sy, TP.HCM, 0944556677, xyz@example.com');

-- Dữ liệu mẫu cho Đơn hàng Offline
INSERT INTO OFFLINE_ORDER (NgayDatHang, TongTien, HinhThucThanhToan, MaKH, MaNV)
VALUES 
    ('2024-11-20', 1500000, 'Tien mat', 1, 1),
    ('2024-11-21', 2000000, 'Chuyen khoan', 2, 2);

-- Dữ liệu mẫu cho Chi tiết đơn hàng
INSERT INTO ORDER_DETAIL (MaDonHang, MaSP, SoLuong, GiaSanPham, TongTienSanPham)
VALUES 
    (1, 1, 2, 750000, 1500000),
    (2, 2, 1, 2000000, 2000000);

-- Dữ liệu mẫu cho Tồn kho sản phẩm
INSERT INTO STOCK (MaSP, SoLuongTon, KhoLuuTru)
VALUES 
    (1, 50, 'Kho A'),
    (2, 30, 'Kho B');

-- Dữ liệu mẫu cho Khuyến mãi
INSERT INTO PROMOTION (TenChuongTrinh, MoTa, ThoiGianBatDau, ThoiGianKetThuc, DieuKienThamGia)
VALUES 
    ('Giam gia Black Friday', 'Giam gia 20% tat ca san pham', '2024-11-25', '2024-11-30', 'Ap dung cho tat ca khach hang');

-- Dữ liệu mẫu cho Thanh toán
INSERT INTO PAYMENT (NgayGiaoDich, MaDonHang, HinhThucThanhToan, SoTienThanhToan)
VALUES 
    ('2024-11-20 10:00:00', 1, 'Tien mat', 1500000),
    ('2024-11-21 15:00:00', 2, 'Chuyen khoan', 2000000);
