# -*- coding: utf-8 -*-

"""
Dydacomp MOM Models
~~~~~~~~~~~~~~~~~~~

:copyright: (c) 2013 by Mark A. Richman.
:license: GPL v2, see LICENSE for more details.
:author: Mark Richman
"""

import logging
from datetime import datetime


class Customer:
    """Represents the CUST table in MOM.

    altnum: The customer's alternate number. It is an alphanumeric field, and
    may be assigned either externally, from another package before importing,
    or it may be generated automatically based on specific parameters (in
    MOM's Global Parameter function).

    custtype: O=Ordering Customer, P=Prospect (no orders), S=Ship-to Address
    only. These three are the only options for this field. If a ship-to address
    becomes an ordering customer, the CUSTTYPE on the record changes to O
    (although it may still have a "belongnum" below). The CUSTTYPE is P only
    if no orders have been generated through MOM for the customer. However,
    if you're importing a customer list through DBUWIN and you default this
    field to O, it will stay O even if no orders are subsequently entered in
    MOM for this customer.

    lastname:

    firstname:

    company:

    addr:

    addr2:

    city:

    county:

    state:

    zipcode:

    country:

    phone:

    phone2:

    orig_ad: The customer's original source key, meaning the first source key
    ever associated with that order. If it is imported blank, it remains blank,
     even after activity in MOM that is affiliated with a source key.

    ctype: This corresponds to the first customer type, a single character,
    located on the "General" tab in the customer's main information screen in
    MOM.

    last_ad: The last recorded source key for this customer, whether as an
    order or as a contact.

    catcount: Total count of catalogs mailed. This only populates if you use
    the "Mailing Counter" feature in List Management.

    odr_date: Last date of activity for the customer, whether an order or a
    contact.

    expired: If customer is marked "address Expired" in general tab of
    customer's main info screen, this will be True. Customer's address will
    not be included in a List Management generation. Mark this true when an
    address is no longer valid.

    badcheck: If you have marked the customer "Bad Credit" on the financial
    tab of customer's main info screen, this will be true.

    orderrec: The order number of the most recent order placed by this customer.

    net: The net amount that the customer has sent (for MOM, this is in
    invoiced orders). If this is imported originally, MOM will add to this
    amount.

    gross: The gross amount that the customer has spent (for MOM, this is in
    invoiced orders). If this is imported originally, MOM will add to this
    amount.

    ord_freq: The total number of orders placed by the customer.

    comment: Corresponds to the first line of the comment field in the general
    tab of the customer's main info screen.

    custbal: Balances that have been deferred to the next order rather than
    left open.

    discount: Discount for the customer, which is used globally as a discount
    unless there is a price discount on the individual product. 60 correspond
    to 60%. There is no way to have a 100% discount.

    exempt: If true, the customer is tax exempt for all purchases. Only
    necessary to mark this as true for customers that live in states in which
    your business has a physical presence, where you are collecting tax.

    ar_balance: Current open A/R balance. This corresponds to MOM orders only.
    You will not be able to populate this field upon importing from an
    external package; MOM would not recognize it as valid, because you can
    only bring in payments from invoices that have been generated through the
    system.

    credit_lim: Credit limit for the customer, as entered on the financial tab
    of the customer's main information screen.

    due_days: Customer terms (e.g., 30 for Net 30), which corresponds to the
    entry on the financial tab of the customer's main info screen.

    promo_bal: The current open promotional balance that has been assigned to
    the customer in "New Contact."

    comment2: Corresponds to the second line of the comment field in the
    general tab of the customer's main info screen.

    sales_id:

    nomail:

    belongnum: If this is 0, this customer does not "belong" to another
    customer record as a ship-to address. If there is a number here, it
    corresponds to the LATEST customer number that has used this address as a
    ship-to address. This will remain filled in even if this customer becomes
    an ordering customer at a future time.

    ctype2: This corresponds to the second customer type, two characters,
    located on the "General" tab in the customer's main information screen in
    MOM.

    ctype3: This corresponds to the third customer type, three characters,
    located on the "General" tab in the customer's main information screen in
    MOM.

    salu:

    title:

    delpoint: Postal delivery point.

    carroute:￼Postal carrier route.

    ncoachange: True/False indication for NCOA change made as a result of NCOA
    processing in List Management.

    entrydate: The date the customer was first entered in the system. Can be
    one of the fields you import. If you are importing a list and do not assign
    specific entry dates to each customer, MOM assigns the date that the
    customer was imported.

    searchcomp: An abbreviated form of the company's name, which MOM generates
    upon entry of the company name. This helps avoid duplicates when looking up
    the company in customer lookup.

    email:

    n_exempt: This is marked true if the customer is exempt from National tax.
    It is most often used in countries other than the US (because the US, at
    least for the foreseeable future, does not impose a national tax).

    tax_id: Tax exemption certified number. This is handy, but is not required
    in MOM for tax exempt status to be true.

    hono: Suffix (honorific) of customer. (Jr., III, PhD)

    noemail:

    rfm: RFM value as assigned in the procedure in List Management Module.

    points: Points accumulated through purchases/

    norent: Set to true if “do not rent” is checked on the general tab of the
    customer information screen

    addr_type: S=Ship-to address, B=Bill-to address, G=Gift-to address,
    L=Sold-to address A=Alternate address, C=Contact name, P=Primary address,
    M=Mail-to address

    web: Web site address.

    extension:

    extension2:

    date_limit: A 1-digit code indicating the type of date limit

    start_date: The starting date on which this address is valid.

    end_date: The final date on which this address is valid.

    from_month: The numeric value representing the month of the year on which
    this address starts to be valid each year. (Used for seasonal addresses.)

    from_day: The numeric value representing the day of the month on the month
    on which this address starts to be valid each year. (Used for seasonal
    addresses.)

    to_month:

    to_day:

    addrissame: Set to true if the address for this contact is the same as the
    main address for the contact.
    """
    def __init__(self):
        self.custnum = 0
        self.altnum = 0
        self.custtype = 'O'
        self.lastname = ''
        self.firstname = ''
        self.company = ''
        self.addr = ''
        self.addr2 = ''
        self.city = ''
        self.county = ''
        self.state = ''
        self.zipcode = ''
        self.country = ''
        self.phone = ''
        self.phone2 = ''
        self.orig_ad = ''
        self.ctype = ''
        self.last_ads = ''
        self.catcount = 0
        self.odr_date = datetime.now()
        self.expired = False
        self.badcheck = False
        self.orderrec = 0
        self.net = 0
        self.gross = 0
        self.ord_freq = 0
        self.comment = ''
        self.custbal = 0
        self.discount = 0
        self.exempt = 0
        self.ar_balance = 0
        self.credit_lim = 0
        self.due_days = 0
        self.promo_bal = 0
        self.comment2 = ''
        self.sales_id = ''
        self.nomail = False
        self.belongnum = 0
        self.ctype2 = ''
        self.ctype3 = ''
        self.salu = ''
        self.title = ''
        self.delpoint = ''
        self.carroute = ''
        self.ncoachange = ''
        self.entrydate = datetime.now()
        self.searchcomp = ''
        self.email = ''
        self.n_exempt = False
        self.tax_id = ''
        self.hono = ''
        self.noemail = False
        self.rfm = 0
        self.points = 0
        self.norent = False
        self.addr_type = ''
        self.web = ''
        self.extension = ''
        self.extension2 = ''
        self.date_limit = ''
        self.start_date = datetime.min
        self.end_date = datetime.max
        self.from_month = 0
        self.from_day = 0
        self.to_month = 0
        self.to_day = 0
        self.addrissame = False

    def __repr__(self):
        return "Customer {}".format(self.custnum)

    def __hash__(self):
        return hash(self.custnum)

    def __eq__(self, other):
        return self.custnum == other.custnum


class Order:
    """Represents the CMS table in MOM."""
    def __init__(self):
        self.order_num = ''
        self.cust_num = ''
        self.first_name = ''
        self.last_name = ''
        self.email = ''
        self.expect_ship = datetime.max
        self.billing_address1 = ''
        self.billing_address2 = ''
        self.billing_city = ''
        self.billing_state = ''
        self.billing_zip = ''
        self.discount = 0.00
        self.payment_type = ''
        self.sku = ''
        self.description = ''
        self.list_price = ''
        self.unit_price = ''
        self.ext_price = ''
        self.order_date = datetime.min
        self.qty = 0
        self.payment_last4 = ''
        self.tax = 0.00
        self.shipping_fee = 0.00
        self.subtotal = 0.00
        self.total = 0.00
        self.promocode = ''
        self.promocode_discount = 0.00
        self.shipping_address1 = ''
        self.shipping_address2 = ''
        self.shipping_city = ''
        self.shipping_state = ''
        self.shipping_zip = ''
        self.ship_type = ''
        self.tracking_num = ''
        self.tracking_url = ''
        self.source_key = ''
        self.order_items = []

    def __repr__(self):
        return "Order {}".format(self.order_num)

    def __hash__(self):
        return hash(self.order_num)

    def __eq__(self, other):
        return self.order_num == other.order_num

    def html_table(self):
        """ Returns order as a collection of HTML rows """
        table = ""
        for order_item in self.order_items:
            table += (
                "  <tr>"
                "    <td>" + order_item.sku + "</td>"
                "    <td>" + order_item.description + "</td>"
                "    <td>" + str(order_item.qty) + "</td>"
                "    <td>" + "${0:0.2f}".format(order_item.list_price) + "</td>"
                "    <td>" + "${0:0.2f}".format(order_item.total) + "</td>"
                "  </tr>")
        logging.debug(table)
        return table


class OrderItem:
    """Represents the ITEM table in MOM."""
    def __init__(self):
        self.order_num = ''
        self.expect_ship = datetime.today()
        self.sku = ''
        self.description = ''
        self.list_price = ''
        self.unit_price = ''
        self.ext_price = ''
        self.discount = 0.00
        self.qty = 0
        self.tax = 0.00
        self.shipping = 0.00
        self.ship_type = ''
        self.tracking_num = ''
        self.tracking_url = ''
        self.source_key = ''
        self.total = 0.00

    def html_row(self):
        """ Returns order item as an HTML row """
        row = ("  <tr>"
               "    <td>" + self.sku + "</td>"
               "    <td>" + self.description + "</td>"
               "    <td>" + str(self.qty) + "</td>"
               "    <td>" + "${0:0.2f}".format(self.list_price) + "</td>"
               "    <td>" + "${0:0.2f}".format(self.total) + "</td>"
               "  </tr>")
        logging.debug(row)
        return row