package com.healthcare.utils;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfWriter;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;

public class PDFGenerator {

    /**
     * Creates a prescription PDF; returns path (relative) or byte[] as needed.
     */
    public static byte[] createPrescriptionPdf(String patientName, String doctorName, String meds,
                                               String instructions, BufferedImage qrImage) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, baos);
        document.open();

        Font title = new Font(Font.HELVETICA, 18, Font.BOLD);
        Font normal = new Font(Font.HELVETICA, 12, Font.NORMAL);

        document.add(new Paragraph("E-Prescription", title));
        document.add(new Paragraph(" "));
        document.add(new Paragraph("Patient: " + patientName, normal));
        document.add(new Paragraph("Doctor: " + doctorName, normal));
        document.add(new Paragraph("Date: " + new java.util.Date(), normal));
        document.add(new Paragraph(" "));
        document.add(new Paragraph("Medicines: ", normal));
        document.add(new Paragraph(meds, normal));
        document.add(new Paragraph(" "));
        document.add(new Paragraph("Instructions: ", normal));
        document.add(new Paragraph(instructions, normal));

        // Add QR code image
        if (qrImage != null) {
            ByteArrayOutputStream qrOut = new ByteArrayOutputStream();
            ImageIO.write(qrImage, "png", qrOut);
            Image qr = Image.getInstance(qrOut.toByteArray());
            qr.scaleToFit(120, 120);
            qr.setAlignment(Image.ALIGN_RIGHT);
            document.add(qr);
        }

        document.close();
        return baos.toByteArray();
    }
}
