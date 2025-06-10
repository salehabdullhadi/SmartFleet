// Initialize map correctly after page load
document.addEventListener("DOMContentLoaded", function () {
    const map = L.map('map', { zoomControl: false }).setView([30.0444, 31.2357], 8); // Centered on Egypt

    // Ensure the map container has a fixed height
    document.getElementById('map').style.height = '500px';

    // Add OpenStreetMap tiles
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    // Vehicle data
    const vehicles = [
        { name: 'Bus', lat: 30.0444, lon: 31.2357, driver: 'Ahmed Hassan', engine_hours: '12345 h 30 min', engine_id: 'EG654789321', engine_type: 'Diesel', model: 'Mercedes Sprinter', odometer: '450000 km', plate: 'EGY 1234', status: 'Moving', speed: '80 kph', address: 'Tahrir Square, Cairo', altitude: '23 m' },
        { name: 'Car', lat: 31.2156, lon: 29.9553, driver: 'Mohamed Ali', engine_hours: '9876 h 15 min', engine_id: 'EG987654321', engine_type: 'Petrol', model: 'Toyota Corolla', odometer: '220000 km', plate: 'EGY 5678', status: 'In Use', speed: '60 kph', address: 'Stanley Bridge, Alexandria', altitude: '5 m' },
        { name: 'Truck', lat: 25.6872, lon: 32.6396, driver: 'Youssef Mahmoud', engine_hours: '15000 h 50 min', engine_id: 'EG321654987', engine_type: 'Diesel', model: 'Mercedes Actros', odometer: '700000 km', plate: 'EGY 9101', status: 'Available', speed: '0 kph', address: 'Luxor Corniche, Luxor', altitude: '76 m' }
    ];

    // Add markers for vehicles
    const markers = {};
    vehicles.forEach(vehicle => {
        markers[vehicle.name] = L.marker([vehicle.lat, vehicle.lon]).addTo(map)
            .bindPopup(`${vehicle.name}`);
    });

    // Hide info-panel initially
    const infoPanel = document.getElementById('info-panel');
    infoPanel.style.display = 'none';
    infoPanel.style.transition = 'opacity 0.3s ease-in-out';
    infoPanel.style.opacity = '0';

    // Select vehicle and zoom in
    window.selectVehicle = function (vehicleName) {
        const vehicle = vehicles.find(v => v.name === vehicleName);
        if (vehicle) {
            map.setView([vehicle.lat, vehicle.lon], 12); // Zoom to vehicle
            markers[vehicle.name].openPopup(); // Open marker popup
            
            // Show info-panel with smooth transition
            infoPanel.style.display = 'block';
            setTimeout(() => infoPanel.style.opacity = '1', 50);
            
            // Update info-panel with vehicle data
            infoPanel.innerHTML = `
                <div class="info-section">
                    <h3>Data</h3>
                    <div class="info-row"><span>Driver:</span><span>${vehicle.driver}</span></div>
                    <div class="info-row"><span>Engine hours:</span><span>${vehicle.engine_hours}</span></div>
                    <div class="info-row"><span>Engine ID:</span><span>${vehicle.engine_id}</span></div>
                    <div class="info-row"><span>Engine type:</span><span>${vehicle.engine_type}</span></div>
                </div>
                <div class="info-section">
                    <h3>Details</h3>
                    <div class="info-row"><span>Model:</span><span>${vehicle.model}</span></div>
                    <div class="info-row"><span>Odometer:</span><span>${vehicle.odometer}</span></div>
                    <div class="info-row"><span>Plate:</span><span>${vehicle.plate}</span></div>
                    <div class="info-row"><span>Status:</span><span>${vehicle.status}</span></div>
                </div>
                <div class="info-section position">
                    <h3>Position</h3>
                    <div class="info-row"><span>Position:</span><span>${vehicle.lat}°, ${vehicle.lon}°</span></div>
                    <div class="info-row"><span>Speed:</span><span>${vehicle.speed}</span></div>
                    <div class="info-row"><span>Address:</span><span>${vehicle.address}</span></div>
                    <div class="info-row"><span>Altitude:</span><span>${vehicle.altitude}</span></div>
                </div>
            `;
        }
    }
});
