package com.healthcare.model;

import java.util.Date;

public class Prescription {
    private int id;
    private int visitId;
    private int doctorId;
    private int userId;
    private String medicines;
    private String instructions;
    private Date generatedAt;
    private String pdfPath;
    private String qrCodeText;

    public Prescription(){}

    // getters & setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getVisitId() { return visitId; }
    public void setVisitId(int visitId) { this.visitId = visitId; }
    public int getDoctorId() { return doctorId; }
    public void setDoctorId(int doctorId) { this.doctorId = doctorId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getMedicines() { return medicines; }
    public void setMedicines(String medicines) { this.medicines = medicines; }
    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }
    public Date getGeneratedAt() { return generatedAt; }
    public void setGeneratedAt(Date generatedAt) { this.generatedAt = generatedAt; }
    public String getPdfPath() { return pdfPath; }
    public void setPdfPath(String pdfPath) { this.pdfPath = pdfPath; }
    public String getQrCodeText() { return qrCodeText; }
    public void setQrCodeText(String qrCodeText) { this.qrCodeText = qrCodeText; }
}
