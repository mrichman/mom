# -*- coding: utf-8 -*-

"""
Dydacomp MOM SQL Server Client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:copyright: (c) 2013 by Mark A. Richman.
:license: GPL v2, see LICENSE for more details.
:author: Mark Richman
"""

import datetime
import logging
from csv import Error, writer
from io import BytesIO
from pymssql import connect, InterfaceError

DELIMITER = 'tab'  # , ; | tab


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
            cur.execute(
                "exec ListPull_GetCatXSell @item_list='{}'".format(product_ids))
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

    def create_customer(self, customer_obj):
        """Creates a new MOM customer in the CUST table.
        :param customer_obj: The customer object.
        :returns: Customer object, containing new custnum
        """
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("Amazon_CUST_Insert")
            #TODO: Implement me
            cur.execute("exec Amazon_CUST_Insert")
            cur.fetchall()
            return customer_obj
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise

    def get_customer(self, custnum):
        """Gets a MOM customer from the CUST table.
        :param custnum: The customer number.
        :returns: Customer object
        """
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("Amazon_CUST_Insert")
            #TODO: Implement me
            cur.execute("exec Amazon_CUST_Insert")
            cur.fetchall()
            return None
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise

    def create_order(self, order_obj):
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("Amazon_CUST_Insert")
            #TODO: Implement me
            cur.execute("exec Amazon_CUST_Insert")
            cur.fetchall()
            return order_obj
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise

    def get_order(self, ordernum):
        try:
            conn = self.get_mom_connection()
            cur = conn.cursor()
            logging.info("Amazon_CUST_Insert")
            #TODO: Implement me
            cur.execute("exec Amazon_CUST_Insert")
            cur.fetchall()
            return None
        except Error as e:
            logging.error(e)
            raise
        except Exception as ex:
            logging.error(ex.message)
            raise