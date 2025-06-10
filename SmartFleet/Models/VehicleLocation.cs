using System.ComponentModel.DataAnnotations.Schema;

namespace SmartFleet.Models
{
       public class VehicleLocation
    {
        public int Id { get; set; }
        public int VehicleId { get; set; }

        [ForeignKey("VehicleId")]
        public Vehicle Vehicle { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public decimal Speed { get; set; }
        public DateTime Timestamp { get; set; }
    }
}
