package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class UsersApiRunner {

    @Test
    void runUsers() {
        Results results = Runner.path("classpath:features/users")
                .outputCucumberJson(true)
                .parallel(3);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
