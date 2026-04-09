package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class AllApiRunner {

    @Test
    void runAllApis() {
        Results results = Runner.path(
                        "classpath:features/users",
                        "classpath:features/products",
                        "classpath:features/orders")
                .tags("~@e2e", "~@ignore")
                .outputCucumberJson(true)
                .parallel(5);

        KarateReport.generate(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}