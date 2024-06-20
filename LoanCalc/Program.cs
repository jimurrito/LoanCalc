namespace LoanCalc;

// Entry point for C# app
static class Program
{
    // Single-Thread Apartment
    [STAThread]
    static void Main()
    {
        // To customize application configuration such as set high DPI settings or default font,
        // see https://aka.ms/applicationconfiguration.
        // Initializes the form config
        ApplicationConfiguration.Initialize();
        // Run application
        Application.Run(new Form1());
    }    
}