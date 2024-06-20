namespace LoanCalc;




// Creates a `Form` class obj called Form1
public partial class Form1 : Form
{   
    public const string Icon = "../.assets/icon/favicon.ico";

    // Public fn called self.Form1()
    public Form1()
    {
        InitializeComponent();
        this.Text = "LoanCalc" ;
        //this.Size = new System.Drawing.Size(270, 500) ;
        //this.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle;
        this.StartPosition = FormStartPosition.CenterScreen;
        this.AutoSize = true;
        this.MaximizeBox = false;
        this.TopMost = true;
        this.Icon = new Icon(Icon);
        // (left, top, right, bottom)
        this.Padding = new System.Windows.Forms.Padding(0, 0, 0, 15);
        // Enable high DPI
        //this.AutoScaleDimensions = '96, 96';
        //this.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi;

    }
}
