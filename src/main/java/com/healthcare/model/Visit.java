package com.healthcare.model;

import java.sql.Timestamp;

public class Visit {
    private int id;
    private int bookingId;
    private String symptoms;
    private String diagnosis;
    private String doctorNotes;
    private Timestamp visitDate;

    // 🔹 Constructors
    public Visit() {}

    public Visit(int id, int bookingId, String symptoms, String diagnosis, String doctorNotes, Timestamp visitDate) {
        this.id = id;
        this.bookingId = bookingId;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.doctorNotes = doctorNotes;
        this.visitDate = visitDate;
    }

    // 🔹 Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getDoctorNotes() {
        return doctorNotes;
    }

    public void setDoctorNotes(String doctorNotes) {
        this.doctorNotes = doctorNotes;
    }

    public Timestamp getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(Timestamp visitDate) {
        this.visitDate = visitDate;
    }

    @Override
    public String toString() {
        return "Visit{" +
                "id=" + id +
                ", bookingId=" + bookingId +
                ", symptoms='" + symptoms + '\'' +
                ", diagnosis='" + diagnosis + '\'' +
                ", doctorNotes='" + doctorNotes + '\'' +
                ", visitDate=" + visitDate +
                '}';
    }
}
