package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ProductsApiRunner {

    @Test
    void runProducts() {
        Results results = Runner.path("classpath:features/products")
                .outputCucumberJson(true)
                .parallel(2);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
