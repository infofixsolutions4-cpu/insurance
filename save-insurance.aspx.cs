using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class save_insurance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Response.Redirect("add-insurance.html", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        string insuranceName = (Request.Form["Insurance_Name"] ?? string.Empty).Trim();
        string branchName = (Request.Form["Branch_Name"] ?? string.Empty).Trim();
        string contactPerson = (Request.Form["Contact_Person"] ?? string.Empty).Trim();
        string contactNumber = (Request.Form["Contact_Number"] ?? string.Empty).Trim();
        string email = (Request.Form["Email"] ?? string.Empty).Trim();
        string gstNumber = (Request.Form["GST_Number"] ?? string.Empty).Trim();
        string address = (Request.Form["Address"] ?? string.Empty).Trim();
        bool status = Request.Form["Status"] == "1";

        if (string.IsNullOrWhiteSpace(insuranceName))
        {
            Response.Redirect("add-insurance.html?error=missing-name", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        string connString = ConfigurationManager.ConnectionStrings["InsuranceDb"]?.ConnectionString;
        if (string.IsNullOrWhiteSpace(connString))
        {
            Response.Redirect("add-insurance.html?error=missing-connection", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        const string insertSql = @"
INSERT INTO Insurance_Master
(
    Insurance_Name,
    Branch_Name,
    Contact_Person,
    Contact_Number,
    Email,
    GST_Number,
    Status,
    Address,
    Created_Date
)
VALUES
(
    @Insurance_Name,
    @Branch_Name,
    @Contact_Person,
    @Contact_Number,
    @Email,
    @GST_Number,
    @Status,
    @Address,
    GETDATE()
);";

        try
        {
            using (SqlConnection connection = new SqlConnection(connString))
            using (SqlCommand command = new SqlCommand(insertSql, connection))
            {
                command.Parameters.AddWithValue("@Insurance_Name", insuranceName);
                command.Parameters.AddWithValue("@Branch_Name", string.IsNullOrEmpty(branchName) ? (object)DBNull.Value : branchName);
                command.Parameters.AddWithValue("@Contact_Person", string.IsNullOrEmpty(contactPerson) ? (object)DBNull.Value : contactPerson);
                command.Parameters.AddWithValue("@Contact_Number", string.IsNullOrEmpty(contactNumber) ? (object)DBNull.Value : contactNumber);
                command.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                command.Parameters.AddWithValue("@GST_Number", string.IsNullOrEmpty(gstNumber) ? (object)DBNull.Value : gstNumber);
                command.Parameters.AddWithValue("@Status", status);
                command.Parameters.AddWithValue("@Address", string.IsNullOrEmpty(address) ? (object)DBNull.Value : address);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
        catch
        {
            Response.Redirect("add-insurance.html?error=save-failed", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        Response.Redirect("add-insurance.html?saved=1", false);
        Context.ApplicationInstance.CompleteRequest();
    }
}
