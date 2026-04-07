package runners;

import com.intuit.karate.junit5.Karate;

class OrderApiRunner {

    @Karate.Test
    Karate runOrderApiSuite() {
        return Karate.run(
                "classpath:features/orders/orders.feature",
                "classpath:features/users/restaurants.feature"
        );
    }
}
