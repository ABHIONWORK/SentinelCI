public class Main {
    public static void main(String[] args) {
        System.out.println("Starting application checks...." ); // <- Notice I removed the semicolon here on purpose! and i myself changed it to correct ones 
        
        // Processing arguments
        for (int i = 0; i < args.length; i++) {
            System.out.println("Argument " + i + ": " + args[i]);
        }
        
        System.out.println("Application executed successfully!");
    }
}
