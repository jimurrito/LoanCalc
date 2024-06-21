namespace LoanCalc;

static class Program
{
    /// <summary>
    ///  The main entry point for the application.
    /// </summary>
    [STAThread]
    static void Main()
    {
        // Create window
        ApplicationConfiguration.Initialize();
        Application.Run(new Calc());
    }    
}