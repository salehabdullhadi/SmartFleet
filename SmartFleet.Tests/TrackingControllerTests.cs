using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartFleet.Controllers;
using SmartFleet.Data;
using SmartFleet.Models;
using Xunit;
using FluentAssertions;

namespace SmartFleet.Tests
{
    public class TrackingControllerTests
    {
        private SmartFleetContext GetInMemoryDbContext(string dbName = null)
        {
            dbName ??= Guid.NewGuid().ToString();
            var options = new DbContextOptionsBuilder<SmartFleetContext>()
                .UseInMemoryDatabase(databaseName: dbName)
                .Options;
            return new SmartFleetContext(options);
        }

        [Fact]
        public void Index_ReturnsViewResult()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = new Tracking(dbContext);
            var result = controller.Index();
            result.Should().BeOfType<ViewResult>();
        }

        [Fact]
        public void GetVehiclesWithLocations_ReturnsJsonResult()
        {
            var dbContext = GetInMemoryDbContext();
            dbContext.Vehicles.Add(new Vehicle { Id = 1, Model = "Test", Type = VehicleType.Car, Capacity = 4, LicensePlate = "ABC", Status = VehicleState.available });
            dbContext.SaveChanges();
            var controller = new Tracking(dbContext);
            var result = controller.GetVehiclesWithLocations();
            result.Should().BeOfType<JsonResult>();
        }

        [Fact]
        public async Task GetVehicleDetails_ReturnsNotFound_WhenVehicleMissing()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = new Tracking(dbContext);
            var result = await controller.GetVehicleDetails(999);
            result.Should().BeOfType<NotFoundResult>();
        }

        [Fact]
        public async Task GetVehiclePath_ReturnsJsonResult()
        {
            var dbContext = GetInMemoryDbContext();
            dbContext.VehicleLocations.Add(new VehicleLocation { Id = 1, VehicleId = 1, Latitude = 10, Longitude = 20, Speed = 0, Timestamp = DateTime.Now });
            dbContext.SaveChanges();
            var controller = new Tracking(dbContext);
            var result = await controller.GetVehiclePath(1);
            result.Should().BeOfType<JsonResult>();
        }
    }
} 