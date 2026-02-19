<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add-insurance.aspx.cs" Inherits="add_insurance" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
<meta charset="UTF-8" />
<title>Insurance Claim Management | Add Insurance</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet" />
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#f4f6f9;color:#333}
header{height:60px;background:#1e293b;color:#fff;display:flex;align-items:center;justify-content:space-between;padding:0 20px;position:fixed;width:100%;top:0;z-index:1000;}
header .left{display:flex;align-items:center;gap:15px;} .menu-btn{font-size:20px;cursor:pointer;} header .title{font-weight:600;font-size:18px;} header .right{font-size:14px;}
.container{display:flex;margin-top:60px;} .sidebar{width:240px;background:#0f172a;min-height:100vh;transition:.3s;}
.sidebar ul{list-style:none;padding:15px;} .sidebar li{padding:12px 15px;color:#cbd5e1;cursor:pointer;border-radius:6px;margin-bottom:6px;font-size:14px;}
.sidebar li i{width:20px;} .sidebar li:hover,.sidebar li.active{background:#2563eb;color:#fff;} .sidebar a{text-decoration:none;color:inherit;display:block;}
.menu-title{color:#64748b;font-size:12px;margin:15px 10px 5px;text-transform:uppercase;}
main{flex:1;padding:20px;} .toast{position:fixed;top:80px;right:20px;background:#16a34a;color:#fff;padding:12px 20px;border-radius:6px;display:none;z-index:9999;}
label{font-size:13px;color:#374151}.input{width:100%;padding:10px;margin-top:5px;border:1px solid #d1d5db;border-radius:6px;outline:none;}
.input:focus{border-color:#2563eb}.btn-save{background:#2563eb;color:#fff;padding:12px 25px;border:none;border-radius:6px;cursor:pointer;}.btn-save:hover{background:#1d4ed8}
@media(max-width:768px){.sidebar{position:fixed;left:-240px;top:60px;height:100%;z-index:1001;}.sidebar.show{left:0;}}
</style>
</head>
<body>
<header>
    <div class="left">
        <i class="fa fa-bars menu-btn" onclick="toggleMenu()"></i>
        <div class="title">Insurance Claim System</div>
    </div>
    <div class="right" id="dateTime"></div>
</header>

<div class="toast" id="toast"><%= ToastMessage %></div>

<div class="container">
    <aside class="sidebar" id="sidebar">
        <ul>
            <li><a href="dashboard.html"><i class="fa fa-gauge"></i> Dashboard</a></li>
            <li class="menu-title">MASTERS</li>
            <li class="active"><a href="add-insurance.aspx"><i class="fa fa-building"></i> Add Insurance</a></li>
            <li><a href="insurance-list.html"><i class="fa fa-list"></i> Insurance List</a></li>
            <li class="menu-title">CLAIMS</li>
            <li><a href="claim-entry.html"><i class="fa fa-car-burst"></i> Claim Entry</a></li>
            <li><a href="pending-payment.html"><i class="fa fa-clock"></i> Pending Payments</a></li>
            <li><a href="payment-entry.html"><i class="fa fa-money-check"></i> Payment Entry</a></li>
            <li><a href="completed-claims.html"><i class="fa fa-check-circle"></i> Completed Claims</a></li>
        </ul>
    </aside>

    <main>
        <h2>Insurance Company Master</h2>
        <br />
        <div style="background:#fff;padding:25px;border-radius:12px;box-shadow:0 5px 15px rgba(0,0,0,0.08);">
            <form method="post" action="add-insurance.aspx">
                <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:20px;">
                    <div><label>Insurance Company Name</label><input type="text" name="Insurance_Name" required class="input" /></div>
                    <div><label>Branch Name</label><input type="text" name="Branch_Name" class="input" /></div>
                    <div><label>Contact Person Name</label><input type="text" name="Contact_Person" class="input" /></div>
                    <div><label>Contact Number</label><input type="tel" maxlength="20" name="Contact_Number" class="input" /></div>
                    <div><label>Email</label><input type="email" name="Email" class="input" /></div>
                    <div><label>GST Number</label><input type="text" maxlength="20" name="GST_Number" class="input" /></div>
                    <div>
                        <label>Status</label>
                        <select class="input" name="Status">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                    <div style="grid-column:1/-1"><label>Address</label><textarea rows="3" name="Address" class="input"></textarea></div>
                </div>
                <br />
                <button type="submit" class="btn-save">Save Insurance Company</button>
            </form>
        </div>
    </main>
</div>

<script>
function toggleMenu(){document.getElementById('sidebar').classList.toggle('show');}
(function(){
    const el=document.getElementById('dateTime');
    if(el){el.textContent=new Date().toLocaleString();}
    const shouldShow=<%= ShowToast ? "true" : "false" %>;
    if(shouldShow){
        const toast=document.getElementById('toast');
        toast.style.display='block';
        setTimeout(()=>toast.style.display='none',2500);
    }
})();
</script>
</body>
</html>
