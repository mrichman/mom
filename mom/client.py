#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Dydacomp MOM SQL Server Client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:copyright: (c) 2013 by Mark A. Richman.
:license: GPL v2, see LICENSE for more details.
:author: Mark Richman

Example Usage:

from mom.client import SQLClient

config = os.path.join(os.path.dirname(__file__), 'config.ini')
mom = SQLClient(config)
csv = mom.get_customers()
"""

import datetime
import logging
from csv import Error, writer
from io import BytesIO
from pymssql import connect, InterfaceError

DELIMITER = 'tab'


class SQLClient(object):
    """ MOM SQL Client """

    def __init__(self, host, user, password, database):
        self.conn = None
        self.host = host
        self.user = user
        self.password = password
        self.database = database

    def get_mom_connection(self):
        """ Gets SQL Server connection to MOM """
        try:
            logging.info('Connecting to MOM...')
            if self.conn is None:
                self.conn = connect(host=self.host,
                                    user=self.user,
                                    password=self.password,
                                    database=self.database,
                                    as_dict=False)
            return self.conn
        except InterfaceError as error:
            msg = "Error connecting to SQL Server: %s" % error.message
            logging.error(msg)
            raise
        except Exception as e:
            logging.error(e.message)
            raise

    def get_customers(self):
        """
        Get all customers from MOM, including Autoship customers, but excluding
        opt-outs and Amazon emails. Returns CSV and record count
        """
        bio = BytesIO()
        count = 0
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("ListPull_GetAllCustomers")
            start = datetime.datetime.now()
            cur.execute("exec ListPull_GetAllCustomers")
            end = datetime.datetime.now()
            logging.info("Took {} seconds".format(end - start))
            data = cur.fetchall()
            end2 = datetime.datetime.now()
            logging.info("Got {} rows in {} seconds.".format(len(data),
                                                             (end2 - end)))
            wr = writer(bio, delimiter=DELIMITER)
            for row in data:
                wr.writerow([unicode(s).encode("utf-8") for s in row])
                count += 1
            end3 = datetime.datetime.now()
            logging.info("Wrote CSV in {} seconds.".format(end3 - end2))
        except UnicodeEncodeError as uee:
            logging.error(uee)
            raise
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise
        return bio.getvalue(), count

    def get_customers_excl_autoship(self):
        """
        Get all customers from MOM, excluding Autoship customers, opt-outs and
        Amazon emails. Returns CSV and record count
        """
        bio = BytesIO()
        count = 0
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("ListPull_GetAllCustomers_ExclAS")
            start = datetime.datetime.now()
            cur.execute("exec ListPull_GetAllCustomers_ExclAS")
            end = datetime.datetime.now()
            logging.info("Took {} seconds".format(end - start))
            data = cur.fetchall()
            end2 = datetime.datetime.now()
            logging.info("Got {} rows in {} seconds.".format(len(data),
                                                             (end2 - end)))
            wr = writer(bio, delimiter=DELIMITER)
            for row in data:
                wr.writerow(row)
                count += 1
            end3 = datetime.datetime.now()
            logging.info("Wrote CSV in {} seconds.".format(end3 - end2))
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise
        return bio.getvalue(), count

    def get_customers_reengagement(self):
        """
        Re-engagement File (Non-Autoship Customers idle > 120 days)
        """
        bio = BytesIO()
        count = 0
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("ListPull_Reengagement")
            start = datetime.datetime.now()
            cur.execute("exec ListPull_Reengagement")
            end = datetime.datetime.now()
            logging.info("Took {} seconds".format(end - start))
            data = cur.fetchall()
            end2 = datetime.datetime.now()
            logging.info("Got {} rows in {} seconds.".format(len(data),
                                                             (end2 - end)))
            wr = writer(bio, delimiter=DELIMITER)
            for row in data:
                wr.writerow(row)
                count += 1
            end3 = datetime.datetime.now()
            logging.info("Wrote CSV in {} seconds.".format(end3 - end2))
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise
        return bio.getvalue(), count

    def get_autoships(self):
        """
        Get all Autoships from MOM shipping in 7 days.
        Returns CSV and record count.
        """
        bio = BytesIO()
        count = 0
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("ListPull_GetAutoships")
            start = datetime.datetime.now()
            cur.execute("exec ListPull_GetAutoships")
            end = datetime.datetime.now()
            logging.info("Took {} seconds".format(end - start))
            data = cur.fetchall()
            end2 = datetime.datetime.now()
            logging.info("Got {} rows in {} seconds.".format(len(data),
                                                             (end2 - end)))
            wr = writer(bio, delimiter=DELIMITER)
            for row in data:
                wr.writerow(row)
                count += 1
            end3 = datetime.datetime.now()
            logging.info("Wrote CSV in {} seconds.".format(end3 - end2))
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise
        return bio.getvalue(), count

    def get_cat_x_sell(self, products):
        """
        Get Category Cross-Sells.
        Returns CSV and record count.
        """
        bio = BytesIO()
        count = 0
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("ListPull_GetCatXSell")
            start = datetime.datetime.now()
            product_ids = ",".join(str(p) for p in products)
            cur.execute("exec ListPull_GetCatXSell @item_list='{}'".
            format(product_ids))
            end = datetime.datetime.now()
            logging.info("Took {} seconds".format(end - start))
            data = cur.fetchall()
            end2 = datetime.datetime.now()
            logging.info("Got {} rows in {} seconds.".format(len(data),
                                                             (end2 - end)))
            wr = writer(bio, delimiter=DELIMITER)
            for row in data:
                wr.writerow(row)
                count += 1
            end3 = datetime.datetime.now()
            logging.info("Wrote CSV in {} seconds.".format(end3 - end2))
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise
        return bio.getvalue(), count

    def create_customer(self, altnum, custtype, lastname, firstname, company,
                        addr, addr2, city, county, state, zipcode, country,
                        phone, phone2, orig_ad, ctype, last_ad, catcount,
                        odr_date, expired, badcheck, orderrec, net, gross,
                        ord_freq, comment, custbal, discount, exempt,
                        ar_balance, credit_lim, due_days, promo_bal, comment2,
                        sales_id, nomail, belongnum, ctype2, ctype3, salu,
                        title, delpoint, carroute, ncoachange, entrydate,
                        searchcomp, email, n_exempt, tax_id, hono, noemail,
                        rfm, points, norent, addr_type, web, extension,
                        extension2, date_limit, start_date, end_date,
                        from_month, from_day, to_month, to_day, addrissame):

        """Creates a new MOM customer in the CUST table.
        :param altnum: The customer's alternate number. It is an alphanumeric field, and may be assigned either externally, from another package before importing, or it may be generated automatically based on specific parameters (in MOM's Global Parameter function).
        :param custtype: O=Ordering Customer, P=Prospect (no orders), S=Ship-to Address only. These three are the only options for this field. If a ship-to address becomes an ordering customer, the CUSTTYPE on the record changes to O (although it may still have a "belongnum" below). The CUSTTYPE is P only if no orders have been generated through MOM for the customer. However, if you're importing a customer list through DBUWIN and you default this field to O, it will stay O even if no orders are subsequently entered in MOM for this customer.
        :param lastname: 
        :param firstname: 
        :param company: 
        :param addr: 
        :param addr2: 
        :param city: 
        :param county: 
        :param state: 
        :param zipcode: 
        :param country: 
        :param phone: 
        :param phone2: 
        :param orig_ad: The customer's original source key, meaning the first source key ever associated with that order. If it is imported blank, it remains blank, even after activity in MOM that is affiliated with a source key.
        :param ctype: This corresponds to the first customer type, a single character, located on the "General" tab in the customer's main information screen in MOM.
        :param last_ad: The last recorded source key for this customer, whether as an order or as a contact.
        :param catcount: Total count of catalogs mailed. This only populates if you use the "Mailing Counter" feature in List Management.
        :param odr_date: Last date of activity for the customer, whether an order or a contact.
        :param expired: If customer is marked "address Expired" in general tab of customer's main info screen, this will be True. Customer's address will not be included in a List Management generation. Mark this true when an address is no longer valid.
        :param badcheck: If you have marked the customer "Bad Credit" on the financial tab of customer's main info screen, this will be true.
        :param orderrec: The order number of the most recent order placed by this customer.
        :param net: The net amount that the customer has sent (for MOM, this is in invoiced orders). If this is imported originally, MOM will add to this amount.
        :param gross: The gross amount that the customer has spent (for MOM, this is in invoiced orders). If this is imported originally, MOM will add to this amount.
        :param ord_freq: The total number of orders placed by the customer.
        :param comment: Corresponds to the first line of the comment field in the general tab of the customer's main info screen.
        :param custbal: Balances that have been deferred to the next order rather than left open.
        :param discount: Discount for the customer, which is used globally as a discount unless there is a price discount on the individual product. 60 correspond to 60%. There is no way to have a 100% discount.
        :param exempt: If true, the customer is tax exempt for all purchases. Only necessary to mark this as true for customers that live in states in which your business has a physical presence, where you are collecting tax.
        :param ar_balance: Current open A/R balance. This corresponds to MOM orders only. You will not be able to populate this field upon importing from an external package; MOM would not recognize it as valid, because you can only bring in payments from invoices that have been generated through the system.
        :param credit_lim: Credit limit for the customer, as entered on the financial tab of the customer's main information screen.
        :param due_days: Customer terms (e.g., 30 for Net 30), which corresponds to the entry on the financial tab of the customer's main info screen.
        :param promo_bal: The current open promotional balance that has been assigned to the customer in "New Contact."
        :param comment2: Corresponds to the second line of the comment field in the general tab of the customer's main info screen.
        :param sales_id: 
        :param nomail: 
        :param belongnum: If this is 0, this customer does not "belong" to another customer record as a ship-to address. If there is a number here, it corresponds to the LATEST customer number that has used this address as a ship-to address. This will remain filled in even if this customer becomes an ordering customer at a future time.
        :param ctype2: This corresponds to the second customer type, two characters, located on the "General" tab in the customer's main information screen in MOM.
        :param ctype3: This corresponds to the third customer type, three characters, located on the "General" tab in the customer's main information screen in MOM.
        :param salu: 
        :param title: 
        :param delpoint: Postal delivery point.
        :param carroute:￼Postal carrier route.
        :param ncoachange: True/False indication for NCOA change made as a result of NCOA processing in List Management.
        :param entrydate: The date the customer was first entered in the system. Can be one of the fields you import. If you are importing a list and do not assign specific entry dates to each customer, MOM assigns the date that the customer was imported.
        :param searchcomp: An abbreviated form of the company's name, which MOM generates upon entry of the company name. This helps avoid duplicates when looking up the company in customer lookup.
        :param email: 
        :param n_exempt: This is marked true if the customer is exempt from National tax. It is most often used in countries other than the US (because the US, at least for the foreseeable future, does not impose a national tax).
        :param tax_id: Tax exemption certified number. This is handy, but is not required in MOM for tax exempt status to be true.
        :param hono: Suffix (honorific) of customer. (Jr., III, PhD)
        :param noemail: 
        :param rfm: RFM value as assigned in the procedure in List Management Module.
        :param points: Points accumulated through purchases/
        :param norent: Set to true if “do not rent” is checked on the general tab of the customer information screen
        :param addr_type: S=Ship-to address, B=Bill-to address, G=Gift-to address, L=Sold-to address A=Alternate address, C=Contact name, P=Primary address, M=Mail-to address
        :param web: Web site address.
        :param extension: 
        :param extension2: 
        :param date_limit: A 1-digit code indicating the type of date limit
        :param start_date: The starting date on which this address is valid.
        :param end_date: The final date on which this address is valid.
        :param from_month: The numeric value representing the month of the year on which this address starts to be valid each year. (Used for seasonal addresses.)
        :param from_day: The numeric value representing the day of the month on the month on which this address starts to be valid each year. (Used for seasonal addresses.)
        :param to_month: 
        :param to_day: 
        :param addrissame: Set to true if the address for this contact is the same as the main address for the contact.
        :returns: Customer number
        """
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("Amazon_CUST_Insert")
            #TODO: Implement me
            cur.execute("exec Amazon_CUST_Insert")
            cur.fetchall()
            return 0
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise
        return 0
