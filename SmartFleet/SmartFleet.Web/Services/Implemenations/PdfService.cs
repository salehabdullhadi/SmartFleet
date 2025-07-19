using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using iText.Layout.Properties;
using iText.Kernel.Colors;
using iText.Layout.Borders;
using SmartFleet.Models;
using SmartFleet.Services.Interfaces;

namespace SmartFleet.Services.Implemenations
{
    public class PdfService : IPdfService
    {
        public byte[] GenerateOrderPdf(Order order)
        {
            try
            {
                using var memoryStream = new MemoryStream();
                using var writer = new PdfWriter(memoryStream);
                using var pdf = new PdfDocument(writer);
                var document = new Document(pdf);

                // Header with company logo and title
                var header = new Paragraph("SMART FLEET TRANSPORT ORDER")
                    .SetTextAlignment(TextAlignment.CENTER)
                    .SetFontSize(20)
                    .SetBold()
                    .SetMarginBottom(20);
                document.Add(header);

                // Order information table
                var orderTable = new Table(new float[] { 1, 2 })
                    .SetWidth(UnitValue.CreatePercentValue(100))
                    .SetMarginBottom(20);

                // Table header
                orderTable.AddHeaderCell(new Cell()
                    .Add(new Paragraph("Field").SetBold())
                    .SetBackgroundColor(ColorConstants.LIGHT_GRAY));
                orderTable.AddHeaderCell(new Cell()
                    .Add(new Paragraph("Details").SetBold())
                    .SetBackgroundColor(ColorConstants.LIGHT_GRAY));

                // Order details - with null checks
                orderTable.AddCell("Order ID");
                orderTable.AddCell($"#{order.Id}");

                orderTable.AddCell("Passenger Count");
                orderTable.AddCell(order.PassengerCount.ToString());

                orderTable.AddCell("Start Location");
                orderTable.AddCell(order.StartLocation ?? "N/A");

                orderTable.AddCell("Destination");
                orderTable.AddCell(order.Destination ?? "N/A");

                orderTable.AddCell("Trip Start Date");
                orderTable.AddCell(order.TripStartDate.ToString("dd/MM/yyyy HH:mm"));

                orderTable.AddCell("Trip End Date");
                orderTable.AddCell(order.TripEndDate.ToString("dd/MM/yyyy HH:mm"));

                orderTable.AddCell("Vehicle Type");
                orderTable.AddCell(order.VehicleType.ToString());

                orderTable.AddCell("Reason");
                orderTable.AddCell(order.Reason ?? "N/A");

                orderTable.AddCell("Status");
                orderTable.AddCell(order.Status.ToString());

                orderTable.AddCell("Created At");
                orderTable.AddCell(order.CreatedAt.ToString("dd/MM/yyyy HH:mm"));

                if (order.User != null)
                {
                    orderTable.AddCell("Requested By");
                    orderTable.AddCell(order.User.UserName ?? "N/A");
                }

                document.Add(orderTable);

            // Terms and conditions
            var termsTitle = new Paragraph("Terms and Conditions:")
                .SetBold()
                .SetFontSize(14)
                .SetMarginTop(20)
                .SetMarginBottom(10);
            document.Add(termsTitle);

            var terms = new List()
                .SetMarginLeft(20);
            terms.Add(new ListItem("Passenger must arrive at the pickup location 15 minutes before the scheduled time."));
            terms.Add(new ListItem("Any changes to the trip must be communicated at least 2 hours in advance."));
            terms.Add(new ListItem("The company reserves the right to cancel trips due to weather or safety concerns."));
            terms.Add(new ListItem("Passengers are responsible for their personal belongings during the trip."));
            terms.Add(new ListItem("No smoking or consumption of alcohol is allowed in the vehicle."));
            document.Add(terms);

            // Signature section
            var signatureSection = new Table(new float[] { 1, 1 })
                .SetWidth(UnitValue.CreatePercentValue(100))
                .SetMarginTop(40);

            // Customer signature
            var customerSigCell = new Cell()
                .SetBorder(Border.NO_BORDER)
                .SetHeight(80);
            customerSigCell.Add(new Paragraph("Customer Signature:")
                .SetBold()
                .SetMarginBottom(5));
            customerSigCell.Add(new Paragraph("_________________________")
                .SetMarginTop(20));
            customerSigCell.Add(new Paragraph("Date: _______________")
                .SetMarginTop(10));

            // Company signature
            var companySigCell = new Cell()
                .SetBorder(Border.NO_BORDER)
                .SetHeight(80);
            companySigCell.Add(new Paragraph("Company Representative:")
                .SetBold()
                .SetMarginBottom(5));
            companySigCell.Add(new Paragraph("_________________________")
                .SetMarginTop(20));
            companySigCell.Add(new Paragraph("Date: _______________")
                .SetMarginTop(10));

            signatureSection.AddCell(customerSigCell);
            signatureSection.AddCell(companySigCell);

            document.Add(signatureSection);

            // Footer
            var footer = new Paragraph("This document is generated automatically by Smart Fleet System")
                .SetTextAlignment(TextAlignment.CENTER)
                .SetFontSize(10)
                .SetItalic()
                .SetMarginTop(30);
                document.Add(footer);

                document.Close();
                return memoryStream.ToArray();
            }
            catch (Exception ex)
            {
                // Log the error and return empty array or throw
                throw new ApplicationException($"Error generating PDF: {ex.Message}", ex);
            }
        }
    }
} 