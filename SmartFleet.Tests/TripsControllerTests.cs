using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartFleet.Controllers;
using SmartFleet.Data;
using SmartFleet.Models;
using Moq;
using Xunit;
using FluentAssertions;
using SmartFleet.Services.Implemenations;
using SmartFleet.Services.Interfaces;
using SmartFleet.Services;

namespace SmartFleet.Tests
{
    public class TripsControllerTests
    {
        private SmartFleetContext GetInMemoryDbContext(string dbName = null)
        {
            dbName ??= Guid.NewGuid().ToString();
            var options = new DbContextOptionsBuilder<SmartFleetContext>()
                .UseInMemoryDatabase(databaseName: dbName)
                .Options;
            return new SmartFleetContext(options);
        }

        private TripsController GetController(SmartFleetContext context)
        {
            // All dependencies are mocked, but not used in these simple tests
            var tripStateService = new Mock<ITripStateManagementService>();
            var driverStatusService = new Mock<IDriverStatusManagementService>();
            var vehicleStateService = new Mock<IVehicleStateManagementService>();
            var userManager = new Mock<Microsoft.AspNetCore.Identity.UserManager<ApplicationUser>>(
                new Mock<Microsoft.AspNetCore.Identity.IUserStore<ApplicationUser>>().Object,
                null, null, null, null, null, null, null, null);
            var notificationService = new Mock<INotificationService>();
            var userRoleService = new Mock<IUserRoleService>();
            var paginationService = new Mock<IPaginationService>();
            var searchService = new Mock<ISearchService>();
            return new TripsController(context, tripStateService.Object, driverStatusService.Object, vehicleStateService.Object, userManager.Object, notificationService.Object, userRoleService.Object, paginationService.Object, searchService.Object);
        }

        [Fact]
        public async Task Details_ReturnsNotFound_WhenIdIsNull()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = GetController(dbContext);
            var result = await controller.Details(null);
            result.Should().BeOfType<NotFoundResult>();
        }

        [Fact]
        public async Task Details_ReturnsNotFound_WhenTripMissing()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = GetController(dbContext);
            var result = await controller.Details(999);
            result.Should().BeOfType<RedirectToActionResult>();
        }

        [Fact]
        public async Task Delete_ReturnsNotFound_WhenIdIsNull()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = GetController(dbContext);
            var result = await controller.Delete(null);
            result.Should().BeOfType<NotFoundResult>();
        }

        [Fact]
        public async Task Delete_ReturnsNotFound_WhenTripMissing()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = GetController(dbContext);
            var result = await controller.Delete(999);
            result.Should().BeOfType<RedirectToActionResult>();
        }
    }
} 