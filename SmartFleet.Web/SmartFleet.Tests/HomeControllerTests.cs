using System;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using SmartFleet.Controllers;
using SmartFleet.Data;
using SmartFleet.Models;
using Xunit;
using FluentAssertions;

namespace SmartFleet.Tests
{
    public class HomeControllerTests
    {
        private SmartFleetContext GetInMemoryDbContext(string dbName = null)
        {
            dbName ??= Guid.NewGuid().ToString();
            var options = new DbContextOptionsBuilder<SmartFleetContext>()
                .UseInMemoryDatabase(databaseName: dbName)
                .Options;
            return new SmartFleetContext(options);
        }

        private HomeController GetController(SmartFleetContext context)
        {
            var userManager = new Mock<Microsoft.AspNetCore.Identity.UserManager<ApplicationUser>>(
                new Mock<Microsoft.AspNetCore.Identity.IUserStore<ApplicationUser>>().Object,
                null, null, null, null, null, null, null, null);
            var signInManager = new Mock<Microsoft.AspNetCore.Identity.SignInManager<ApplicationUser>>(
                userManager.Object,
                new Mock<Microsoft.AspNetCore.Http.IHttpContextAccessor>().Object,
                new Mock<Microsoft.AspNetCore.Identity.IUserClaimsPrincipalFactory<ApplicationUser>>().Object,
                null, null, null, null);
            return new HomeController(context, userManager.Object, signInManager.Object);
        }

        [Fact]
        public void Privacy_ReturnsViewResult()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = GetController(dbContext);
            var result = controller.Privacy();
            result.Should().BeOfType<ViewResult>();
        }

        [Fact]
        public void Dashboard_ReturnsViewResult()
        {
            var dbContext = GetInMemoryDbContext();
            var controller = GetController(dbContext);
            var result = controller.Dashboard();
            result.Should().BeOfType<ViewResult>();
        }

       
    }
} 