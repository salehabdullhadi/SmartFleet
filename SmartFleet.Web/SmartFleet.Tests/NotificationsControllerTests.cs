using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Moq;
using SmartFleet.Controllers;
using SmartFleet.Data;
using SmartFleet.Models;
using SmartFleet.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.SignalR;
using Xunit;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;

namespace SmartFleet.Tests
{
    public class NotificationsControllerTests
    {
        private NotificationsController GetController()
        {
            var notificationService = new Mock<INotificationService>();
            var userManager = new Mock<UserManager<ApplicationUser>>(
                new Mock<IUserStore<ApplicationUser>>().Object,
                null, null, null, null, null, null, null, null);
            var dbContext = new Mock<SmartFleetContext>(new DbContextOptionsBuilder<SmartFleetContext>().Options);
            var hubContext = new Mock<IHubContext<SmartFleet.Hubs.NotificationHub>>();
            return new NotificationsController(notificationService.Object, userManager.Object, dbContext.Object, hubContext.Object);
        }

        [Fact]
        public async Task MarkAsRead_ReturnsBadRequest_WhenRequestIsNull()
        {
            var controller = GetController();
            var result = await controller.MarkAsRead(null);
            result.Should().BeOfType<BadRequestObjectResult>();
        }
    }
} 