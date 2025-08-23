<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.Items" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Create Bill</title>
  <style>
    body { font-family: Arial, sans-serif; background:#f5f5f5; margin:0; padding:0; }
    h2, h3 { text-align:center; color:#333; }
    table { border-collapse: collapse; width: 80%; margin: 20px auto; background:#fff; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
    th { background:#007bff; color:white; }
    button { margin: 5px; padding: 6px 12px; border:none; border-radius:4px; cursor:pointer; }
    button:hover { opacity:0.9; }
    .primary { background:#007bff; color:#fff; }
    .danger { background:#dc3545; color:#fff; }
    .success { background:#28a745; color:#fff; }
    .modal { display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%;
      background:rgba(0,0,0,0.4); }
    .modal-content { background:#fff; margin:10% auto; padding:20px; border-radius:8px; width:320px; }
    .form-control { width:95%; padding:6px; margin-bottom:8px; border:1px solid #ccc; border-radius:4px; }
  </style>
  <script>
    // Toast messages
    function toast(msg, type="info") {
      let t=document.createElement('div');
      t.textContent=msg;
      t.style.position='fixed';
      t.style.bottom='20px';t.style.left='50%';
      t.style.transform='translateX(-50%)';
      t.style.background=type==='error'?'#dc3545':'#28a745';
      t.style.color='#fff';t.style.padding='10px 20px';
      t.style.borderRadius='5px';t.style.zIndex=2000;
      document.body.appendChild(t);
      setTimeout(()=>t.remove(),2500);
    }

    function addRow() {
      let tbody=document.getElementById("itemsTable").getElementsByTagName('tbody')[0];
      let row=tbody.insertRow();

      row.innerHTML=`
        <td>${document.getElementById("itemTemplate").innerHTML}</td>
        <td><input type='number' name='quantity[]' value='1' min='1' oninput='updateRowTotal(this)' class='form-control'/></td>
        <td><input type='number' name='unitPrice[]' value='0' step='0.01' readonly class='form-control'/></td>
        <td><input type='text' name='rowTotal[]' value='0' readonly class='form-control'/></td>
        <td><button type='button' class='danger' onclick='removeRow(this)'>Remove</button></td>
      `;

      let itemSelect=row.querySelector("select[name='itemId[]']");
      itemSelect.addEventListener('change',()=>{ enforceStock(itemSelect); fetchUnitPrice(itemSelect); });
      enforceStock(itemSelect);
      fetchUnitPrice(itemSelect);
    }

    function fetchUnitPrice(select){
      let row=select.closest("tr");
      let itemId=select.value;
      let priceInput=row.querySelector("input[name='unitPrice[]']");
      if(!itemId){ priceInput.value=0; updateRowTotal(priceInput); return; }
      let xhr=new XMLHttpRequest();
      xhr.onreadystatechange=function(){
        if(xhr.readyState===4 && xhr.status===200){
          try{
            let resp=JSON.parse(xhr.responseText);
            priceInput.value=resp.price;
            updateRowTotal(priceInput);
          }catch(e){ priceInput.value=0; updateRowTotal(priceInput); }
        }
      };
      xhr.open('GET','getItemPrice?itemId='+encodeURIComponent(itemId),true);
      xhr.send();
    }

    function updateRowTotal(input){
      let row=input.closest("tr");
      let qty=parseFloat(row.querySelector("input[name='quantity[]']").value||0);
      let price=parseFloat(row.querySelector("input[name='unitPrice[]']").value||0);
      row.querySelector("input[name='rowTotal[]']").value=(qty*price).toFixed(2);
      updateTotal();
    }

    function updateTotal(){
      let sum=0;
      document.querySelectorAll("input[name='rowTotal[]']").forEach(el=>{
        sum+=parseFloat(el.value||0);
      });
      document.getElementById("totalAmount").value=sum.toFixed(2);
    }

    function removeRow(btn){
      let row=btn.closest("tr");
      row.parentNode.removeChild(row);
      updateTotal();
    }

    function resetForm(){
      document.querySelector("form").reset();
      let tbody=document.getElementById("itemsTable").getElementsByTagName('tbody')[0];
      tbody.innerHTML="";
      addRow(); updateTotal();
    }

    function showCustomerModal(){ document.getElementById('customerModal').style.display='block'; }
    function closeCustomerModal(){ document.getElementById('customerModal').style.display='none'; }

    function addCustomerAJAX(){
      let name=document.getElementById('newCustomerName').value;
      let account=document.getElementById('newCustomerAccount').value;
      if(!name||!account){ toast("Name & Account required","error"); return; }
      let xhr=new XMLHttpRequest();
      xhr.onreadystatechange=function(){
        if(xhr.readyState===4 && xhr.status===200){
          try{
            let resp=JSON.parse(xhr.responseText);
            if(resp.success){
              let select=document.querySelector("select[name='customerId']");
              let opt=document.createElement("option");
              opt.value=resp.id; opt.text=resp.name;
              select.appendChild(opt); select.value=resp.id;
              closeCustomerModal();
              toast("Customer added successfully","success");
            }else toast("Failed to add","error");
          }catch(e){ toast("Error adding customer","error"); }
        }
      };
      xhr.open('POST','AddCustomerServlet',true);
      xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
      xhr.send('name='+encodeURIComponent(name)+'&account='+encodeURIComponent(account));
    }

    function enforceStock(select){
      let opt=select.selectedOptions[0]; if(!opt) return;
      let stock=parseInt(opt.dataset.stock||'0');
      if(stock===0){ toast("Item out of stock","error"); select.value=""; }
    }

    window.addEventListener('DOMContentLoaded',()=>{ addRow(); });
  </script>
</head>
<body>
<div style="text-align:center;margin:20px;">
  <button class="primary" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
</div>

<h2>Create New Bill</h2>
<form action="addBill" method="post">
  <table>
    <tr>
      <td>Customer:</td>
      <td>
        <select name="customerId" required>
          <%
            CustomerDAO cdao=new CustomerDAO();
            for(Customer c: cdao.getAllCustomers()){ %>
          <option value="<%=c.getCustomerId()%>"><%=c.getFullName()%></option>
          <% } %>
        </select>
        <button type="button" class="success" onclick="showCustomerModal()">+ Add New Customer</button>
      </td>
    </tr>
    <tr>
      <td>User ID:</td>
      <td><input type="number" name="userId" required class="form-control"/></td>
    </tr>
    <tr>
      <td>Payment Method:</td>
      <td>
        <select name="paymentMethod" required class="form-control">
          <option value="Cash">Cash</option>
          <option value="Card">Card</option>
          <option value="Online">Online</option>
        </select>
      </td>
    </tr>
  </table>

  <h3>Bill Items</h3>
  <table id="itemsTable">
    <thead>
    <tr><th>Item</th><th>Quantity</th><th>Unit Price</th><th>Total</th><th>Action</th></tr>
    </thead>
    <tbody></tbody>
  </table>
  <div style="text-align:center;">
    <button type="button" class="primary" onclick="addRow()">+ Add Item</button>
  </div>

  <table align="center">
    <tr>
      <td><b>Total Amount:</b></td>
      <td><input type="text" id="totalAmount" name="totalAmount" readonly class="form-control"/></td>
    </tr>
  </table>
  <div style="text-align:center;margin:15px;">
    <button type="submit" class="success">Save Bill</button>
    <button type="button" class="danger" onclick="resetForm()">Reset</button>
  </div>
</form>

<!-- Hidden item dropdown template -->
<div id="itemTemplate" style="display:none;">
  <select name="itemId[]" class="form-control">
    <%
      ItemDAO itemDAO=new ItemDAO();
      for(Items i: itemDAO.getAllItems()){
        int stk=i.getStock_quantity();
        String label=i.getItem_name()+(stk==0?" (Out of Stock)":"");
    %>
    <option value="<%=i.getItem_id()%>" data-stock="<%=stk%>" <%= (stk==0)?"disabled style='color:gray;'":"" %>>
      <%=label%>
    </option>
    <% } %>
  </select>
</div>

<!-- Customer Modal -->
<div id="customerModal" class="modal">
  <div class="modal-content">
    <span style="float:right;cursor:pointer;" onclick="closeCustomerModal()">&times;</span>
    <h3>Add Customer</h3>
    <input type="text" id="newCustomerAccount" placeholder="Account Number" class="form-control" required/>
    <input type="text" id="newCustomerName" placeholder="Full Name" class="form-control" required/>
    <input type="text" id="newCustomerAddress" placeholder="Address" class="form-control"/>
    <input type="text" id="newCustomerContact" placeholder="Contact" class="form-control"/>
    <input type="number" id="newCustomerUnit" placeholder="Unit Consumed" value="0" class="form-control"/>
    <button type="button" class="success" onclick="addCustomerAJAX()">Save Customer</button>
  </div>
</div>
</body>
</html>
