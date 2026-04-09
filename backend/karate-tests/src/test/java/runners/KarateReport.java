package runners;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public final class KarateReport {

    private KarateReport() {
    }

    public static void generate(String reportDir) {
        File reportOutput = new File(reportDir);
        Configuration config = new Configuration(reportOutput, "FoodTech API Karate Tests");
        config.setBuildNumber(System.getProperty("build.number", "local"));
        config.addClassifications("Environment", System.getProperty("karate.env", "dev"));
        config.addClassifications("Test Type", "API");

        File[] files = reportOutput.listFiles((dir, name) -> name.endsWith(".json") && !name.equals("karate-summary-json.txt"));
        if (files == null || files.length == 0) {
            return;
        }

        List<String> jsonPaths = Arrays.stream(files)
                .map(File::getAbsolutePath)
                .collect(Collectors.toList());

        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}