using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SmartFleet.Controllers;
using SmartFleet.Data;
using Xunit;
using FluentAssertions;

namespace SmartFleet.Tests
{
    public class ReportsControllerTests
    {
        private SmartFleetContext GetInMemoryDbContext(string dbName = null)
        {
            dbName ??= System.Guid.NewGuid().ToString();
            var options = new DbContextOptionsBuilder<SmartFleetContext>()
                .UseInMemoryDatabase(databaseName: dbName)
                .Options;
            return new SmartFleetContext(options);
        }

        [Fact]
        public async Task Index_ReturnsViewResult()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = new ReportsController(dbContext);
            var result = await controller.Index();
            result.Should().BeOfType<ViewResult>();
        }
    }
} 