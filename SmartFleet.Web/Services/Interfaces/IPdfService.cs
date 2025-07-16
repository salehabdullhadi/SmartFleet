using SmartFleet.Models;

namespace SmartFleet.Services.Interfaces
{
    public interface IPdfService
    {
        byte[] GenerateOrderPdf(Order order);
    }
} 