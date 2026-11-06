using System.Net;
using Microsoft.AspNetCore.Mvc.Testing;

namespace RenoHome.Web.Tests;

public class HomePageTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;

    public HomePageTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Home_ReturnsSuccessAndContainsBrand()
    {
        var response = await _client.GetAsync("/");

        Assert.Equal(HttpStatusCode.OK, response.StatusCode);

        var html = await response.Content.ReadAsStringAsync();
        Assert.Contains("RenoHome", html, StringComparison.OrdinalIgnoreCase);
    }
}
