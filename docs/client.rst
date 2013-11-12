Client
======
.. module:: mom.client

Client provide the highest level API in MOM. They contain your field
definitions, delegate validation, take input, aggregate errors, and in
general function as the glue holding everything together.

The SQLClient class
-------------------

.. class:: SQLClient

    Declarative Form base class.

    **Construction**

    .. automethod:: __init__

    **Methods**

    .. automethod:: get_mom_connection

    .. automethod:: get_cat_x_sell

    .. automethod:: create_customer
