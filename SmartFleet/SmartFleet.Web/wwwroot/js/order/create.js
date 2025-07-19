// Dynamic resource availability check for order creation

document.addEventListener('DOMContentLoaded', function () {
    const vehicleTypeSelect = document.getElementById('vehicleTypeSelect');
    const passengerCountInput = document.getElementById('PassengerCount');
    const tripStartInput = document.getElementById('TripStartDate');
    const tripEndInput = document.getElementById('TripEndDate');
    const noteDiv = document.getElementById('resourceAvailabilityNote');

    // You may want to fetch this from the server via AJAX for real data
    // For now, use a simple heuristic: if vehicle type and passenger count are filled, show a note
    function checkAvailability() {
        const vehicleType = vehicleTypeSelect.value;
        const passengerCount = parseInt(passengerCountInput.value, 10);
        const tripStart = tripStartInput.value;
        const tripEnd = tripEndInput.value;

        if (!vehicleType || !passengerCount || !tripStart || !tripEnd) {
            noteDiv.style.display = 'none';
            return;
        }

        // Simulate a check: if passengerCount > 20 or vehicleType is Bus, assume less likely available
        let likelyAvailable = true;
        if (vehicleType === 'Bus' && passengerCount > 30) {
            likelyAvailable = false;
        } else if (passengerCount > 20) {
            likelyAvailable = false;
        }

        noteDiv.style.display = 'block';
        if (likelyAvailable) {
            noteDiv.innerHTML = '<i class="fas fa-info-circle"></i> <span style="color: #28a745;">Resources may be available for this order.</span>';
        } else {
            noteDiv.innerHTML = '<i class="fas fa-exclamation-triangle"></i> <span style="color: #dc3545;">There may be a lack of resources for your order.</span>';
        }
        noteDiv.style.opacity = 0.7;
    }

    vehicleTypeSelect.addEventListener('change', checkAvailability);
    passengerCountInput.addEventListener('input', checkAvailability);
    tripStartInput.addEventListener('change', checkAvailability);
    tripEndInput.addEventListener('change', checkAvailability);
});

// Function to download PDF only - Same as Index.cshtml
function downloadPdfOnly() {
    // Get form data
    const form = document.querySelector('form');
    const formData = new FormData(form);
    
    // Simple validation
    const passengerCount = formData.get('PassengerCount');
    const startLocation = formData.get('StartLocation');
    const destination = formData.get('Destination');
    const tripStartDate = formData.get('TripStartDate');
    const tripEndDate = formData.get('TripEndDate');
    const reason = formData.get('Reason') || 'General Transport';
    const vehicleType = formData.get('VehicleType');
    
    if (!passengerCount || !startLocation || !destination || !tripStartDate || !tripEndDate || !vehicleType) {
        alert('Please fill all required fields to generate PDF');
        return;
    }
    
    // Show loading indicator
    const btn = document.getElementById('downloadPdfBtn');
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Generating...';
    btn.disabled = true;
    
    // Add timeout to reset button if PDF generation takes too long
    const timeoutId = setTimeout(() => {
        btn.innerHTML = originalText;
        btn.disabled = false;
        alert('PDF generation timed out. Please try again.');
    }, 10000); // 10 seconds timeout

    try {
        // Check if jsPDF is loaded
        if (typeof window.jspdf === 'undefined') {
            throw new Error('PDF library not loaded');
        }

        // Use the same simple approach as Index.cshtml
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        
        // Set font
        doc.setFont("times", "normal");
        
        let yPosition = 30;
        
        // Header
        doc.setFontSize(18);
        doc.setFont("times", "bold");
        doc.text("SMART FLEET", 105, yPosition, { align: 'center' });
        
        yPosition += 8;
        doc.setFontSize(14);
        doc.setFont("times", "normal");
        doc.text("Transport Order", 105, yPosition, { align: 'center' });
        
        yPosition += 10;
        doc.setFontSize(10);
        doc.text(`Date: ${new Date().toLocaleDateString('en-US')}`, 105, yPosition, { align: 'center' });
        
        yPosition += 20;
        
        // Order Details
        doc.setFontSize(12);
        doc.setFont("times", "bold");
        doc.text("Order Details", 20, yPosition);
        doc.line(20, yPosition + 2, 80, yPosition + 2);
        
        yPosition += 10;
        doc.setFontSize(10);
        doc.setFont("times", "normal");
        
        const details = [
            ['Passenger Count:', `${passengerCount} passengers`],
            ['Start Location:', startLocation],
            ['Destination:', destination],
            ['Trip Start:', new Date(tripStartDate).toLocaleString('en-US')],
            ['Trip End:', new Date(tripEndDate).toLocaleString('en-US')],
            ['Vehicle Type:', vehicleType],
            ['Reason:', reason]
        ];
        
        details.forEach(([label, value]) => {
            doc.setFont("times", "bold");
            doc.text(label, 25, yPosition);
            doc.setFont("times", "normal");
            doc.text(value, 70, yPosition);
            yPosition += 8;
        });
        
        yPosition += 10;
        
        // Terms & Conditions
        doc.setFontSize(12);
        doc.setFont("times", "bold");
        doc.text("Terms & Conditions", 20, yPosition);
        doc.line(20, yPosition + 2, 90, yPosition + 2);
        
        yPosition += 10;
        doc.setFontSize(10);
        doc.setFont("times", "normal");
        
        const terms = [
            "1. Must comply with scheduled trip times",
            "2. Smoking is prohibited inside the vehicle",
            "3. Must respect traffic laws and regulations",
            "4. Passenger is responsible for personal belongings",
            "5. Company reserves the right to cancel trips in emergencies"
        ];
        
        terms.forEach(term => {
            doc.text(term, 25, yPosition);
            yPosition += 8;
        });
        
        yPosition += 15;
        
        // Signatures
        doc.setFontSize(12);
        doc.setFont("times", "bold");
        doc.text("Signatures", 105, yPosition, { align: 'center' });
        doc.line(70, yPosition + 2, 140, yPosition + 2);
        
        yPosition += 20;
        
        // Signature boxes
        doc.rect(30, yPosition, 60, 25);
        doc.rect(120, yPosition, 60, 25);
        
        doc.setFontSize(10);
        doc.setFont("times", "bold");
        doc.text("Customer Signature", 60, yPosition + 30, { align: 'center' });
        doc.text("Company Representative", 150, yPosition + 30, { align: 'center' });
        
        doc.setFont("times", "normal");
        doc.text("Date: _______________", 60, yPosition + 35, { align: 'center' });
        doc.text("Date: _______________", 150, yPosition + 35, { align: 'center' });
        
        // Footer
        yPosition += 50;
        doc.setFontSize(9);
        doc.line(20, yPosition, 190, yPosition);
        yPosition += 8;
        doc.text("This document was automatically generated by Smart Fleet System", 105, yPosition, { align: 'center' });
        yPosition += 5;
        doc.text("Contact: info@smartfleet.com | Phone: +1-234-567-8900", 105, yPosition, { align: 'center' });
        
        // Clear timeout and download
        clearTimeout(timeoutId);
        
        // Download the PDF
        const fileName = `Transport_Order_${new Date().toISOString().split('T')[0]}.pdf`;
        doc.save(fileName);
        
        // Reset button state
        btn.innerHTML = originalText;
        btn.disabled = false;

    } catch (error) {
        clearTimeout(timeoutId);
        console.error('Error generating PDF:', error);
        alert('Error generating PDF. Please try again.');
        
        // Reset button state
        btn.innerHTML = originalText;
        btn.disabled = false;
    }
}