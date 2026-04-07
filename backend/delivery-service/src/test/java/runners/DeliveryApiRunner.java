package runners;

import com.intuit.karate.junit5.Karate;

class DeliveryApiRunner {

    @Karate.Test
    Karate runAssignment() {
        return Karate.run("classpath:features/orders/assignment.feature");
    }

    @Karate.Test
    Karate runDelivers() {
        return Karate.run("classpath:features/users/delivers.feature");
    }
}
