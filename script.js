let claims = [];
let payments = [];

function addClaim() {
  let claim = {
    vehicle: vehicleNo.value,
    customer: customerName.value,
    company: company.value,
    estimate: Number(estimate.value),
    approved: Number(approved.value),
    received: 0
  };
  claims.push(claim);
  renderTable();
}

function addPayment() {
  let payment = {
    company: payCompany.value,
    vehicle: payVehicle.value,
    amount: Number(payAmount.value)
  };
  payments.push(payment);

  // map payment to claim
  let claim = claims.find(c => c.vehicle === payment.vehicle);
  if(claim){
    claim.received += payment.amount;
  }
  renderTable();
}

function renderTable() {
  claimTable.innerHTML = "";
  claims.forEach(c => {
    let pending = c.approved - c.received;
    let status = pending <= 0 ? "Closed" : (c.received > 0 ? "Partial" : "Pending");

    claimTable.innerHTML += `
      <tr>
        <td>${c.vehicle}</td>
        <td>${c.company}</td>
        <td>₹${c.estimate}</td>
        <td>₹${c.approved}</td>
        <td>₹${c.received}</td>
        <td>₹${pending}</td>
        <td>${status}</td>
      </tr>
    `;
  });
}
