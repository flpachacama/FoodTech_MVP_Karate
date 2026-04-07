package runners;

import com.intuit.karate.junit5.Karate;

class KarateSmokeTest {

    @Karate.Test
    Karate runSmoke() {
        return Karate.run("classpath:features/common/smoke.feature");
    }
}
