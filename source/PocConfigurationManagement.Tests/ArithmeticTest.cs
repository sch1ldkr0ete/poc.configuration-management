using Xunit;

namespace PocConfigurationManagement.UnitTests
{
    public class ArithmeticTest
    {
        [Fact]
        public void IntegerAddTest()
        {
            var result = 1 + 1;
            Assert.Equal(2, result);
        }
    }
}
