package com.dao;

import com.model.Reservation;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/hoteldb";
    private static final String USER = "root";
    private static final String PASSWORD = "root"; 

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // ADD
    public boolean addReservation(Reservation r) throws Exception {
        String sql = "INSERT INTO Reservations (ReservationID, CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, r.getReservationID());
            ps.setString(2, r.getCustomerName());
            ps.setString(3, r.getRoomNumber());
            ps.setDate(4, r.getCheckIn());
            ps.setDate(5, r.getCheckOut());
            ps.setBigDecimal(6, r.getTotalAmount());
            return ps.executeUpdate() > 0;
        }
    }

    // UPDATE
    public boolean updateReservation(Reservation r) throws Exception {
        String sql = "UPDATE Reservations SET CustomerName=?, RoomNumber=?, CheckIn=?, CheckOut=?, TotalAmount=? WHERE ReservationID=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getCustomerName());
            ps.setString(2, r.getRoomNumber());
            ps.setDate(3, r.getCheckIn());
            ps.setDate(4, r.getCheckOut());
            ps.setBigDecimal(5, r.getTotalAmount());
            ps.setInt(6, r.getReservationID());
            return ps.executeUpdate() > 0;
        }
    }

    // DELETE
    public boolean deleteReservation(int id) throws Exception {
        String sql = "DELETE FROM Reservations WHERE ReservationID=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // GET ALL
    public List<Reservation> getAllReservations() throws Exception {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // GET BY ID
    public Reservation getReservationById(int id) throws Exception {
        String sql = "SELECT * FROM Reservations WHERE ReservationID=?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    // REPORT: Date Range
    public List<Reservation> getReservationsByDateRange(Date from, Date to) throws Exception {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM Reservations WHERE CheckIn >= ? AND CheckOut <= ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, from);
            ps.setDate(2, to);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    // REPORT: Most Booked Rooms
    public List<String[]> getMostBookedRooms() throws Exception {
        List<String[]> list = new ArrayList<>();
        String sql = "SELECT RoomNumber, COUNT(*) AS BookingCount FROM Reservations GROUP BY RoomNumber ORDER BY BookingCount DESC";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new String[]{rs.getString("RoomNumber"), rs.getString("BookingCount")});
            }
        }
        return list;
    }

    // REPORT: Total Revenue
    public BigDecimal getTotalRevenue(Date from, Date to) throws Exception {
        String sql = "SELECT SUM(TotalAmount) FROM Reservations WHERE CheckIn >= ? AND CheckOut <= ?";
        try (Connection con = getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, from);
            ps.setDate(2, to);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal val = rs.getBigDecimal(1);
                    return val != null ? val : BigDecimal.ZERO;
                }
            }
        }
        return BigDecimal.ZERO;
    }

    private Reservation mapRow(ResultSet rs) throws SQLException {
        return new Reservation(
            rs.getInt("ReservationID"),
            rs.getString("CustomerName"),
            rs.getString("RoomNumber"),
            rs.getDate("CheckIn"),
            rs.getDate("CheckOut"),
            rs.getBigDecimal("TotalAmount")
        );
    }
}