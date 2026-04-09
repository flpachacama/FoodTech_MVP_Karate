package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class OrdersApiRunner {

    @Test
    void runOrders() {
        Results results = Runner.path("classpath:features/orders")
                .tags("~@e2e", "~@ignore")
                .outputCucumberJson(true)
                .parallel(4);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
