using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Moq;
using SmartFleet.Controllers;
using SmartFleet.Data;
using SmartFleet.Models;
using SmartFleet.Services.Interfaces;
using Xunit;
using FluentAssertions;
namespace SmartFleet.Tests
{
    public class SimCardsControllerTests
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
        public async Task Index_ReturnsViewResult_WithSimCards()
        {
            var context = GetInMemoryDbContext();
            context.SimCards.AddRange(
                new SimCard { Id = 2, Carrier = "Carrier2", SimNumber = "0987654321", Status = SimCardStatus.Inactive },
                                new SimCard { Id = 1, Carrier = "Carrier1", SimNumber = "1234567890", Status = SimCardStatus.Active }

                );
            context.SaveChanges();
            // mocking the SearchService (with no filters)
            var SearchMock = new Mock<ISearchService>();
            SearchMock.Setup(s => s.ApplyFilters(It.IsAny<IQueryable<SimCard>>(), It.IsAny<List<System.Linq.Expressions.Expression<Func<SimCard, bool>>>>()))
       .Returns((IQueryable<SimCard> q, List<System.Linq.Expressions.Expression<Func<SimCard, bool>>> f) => q);
            

            //mocking the pagincatinoSErvice (with no filters)
            var PaginationService = new Mock<IPaginationService>();
            PaginationService.Setup(p => p.GetPaginatedAsync(It.IsAny<IQueryable<SimCard>>(), It.IsAny<int>(), It.IsAny<int>()))
             .ReturnsAsync((IQueryable<SimCard> q, int page, int size) => q.ToList());

            var controller = new SimCardsController(context, null, null, PaginationService.Object, SearchMock.Object);
            var result = await controller.Index(null, null, null, 1);
            var viewResult = result.Should().BeOfType<ViewResult>().Subject;
            var model = viewResult.Model as List<SimCard>;
            model.Should().HaveCount(2);
            model[1].Carrier.Should().Be("Carrier1");
            model[0].Carrier.Should().Be("Carrier2");
            model[1].Status.Should().Be(SimCardStatus.Active);
            model[0].Status.Should().Be(SimCardStatus.Inactive);
            model[1].SimNumber.Should().Be("1234567890");
            model[0].SimNumber.Should().Be("0987654321");
        }
    }

            
}
