package runners;

import com.intuit.karate.junit5.Karate;

class OrderApiRunner {

    @Karate.Test
    Karate runOrders() {
        return Karate.run("classpath:features/orders/orders.feature");
    }

    @Karate.Test
    Karate runRestaurants() {
        return Karate.run("classpath:features/users/restaurants.feature");
    }
}
