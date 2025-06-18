#! /usr/bin/env python

#  runPharmacyApplication Solution

import psycopg2
import sys
import datetime

# The three Python functions for Lab4 should appear below.
# Write those functions, as described in Lab4 Section 4 (and Section 5,
# which describes the Stored Function used by the third Python function).
#
# Write the tests of those function in main, as described in Section 6
# of Lab4.


# countNumberOfCustomers (myConn, thePharmacyID):
# The Purchase table tells us about purchases made by a customer (customerID) in a pharmacy (pharmacyID).
#
# Besides the database connection, the countNumberOfCustomers function has one parameter, an
# integer, thePharmacyID.
#
# countNumberOfCustomers counts the number of different customers that the pharmacy with thePharmacyID has,
# based on the number of different customerID values that appears in the Purchase table.
#
# countNumberOfCustomers returns that value.
#
# For more details, including error handling and return codes, see the Lab4 pdf.

def countNumberOfCustomers(conn, thePharmacyID):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT COUNT(*) FROM Pharmacy WHERE pharmacyID = %s", (thePharmacyID,))
        if cur.fetchone()[0] == 0:
            return -1
        cur.execute(
            "SELECT COUNT(DISTINCT customerID) FROM Purchase WHERE pharmacyID = %s", (thePharmacyID,))
        return cur.fetchone()[0]
# end countNumberOfCustomers


# updateOrderStatus (myConn, currentYear):
# In the OrderSupply table, the value of status is either 'dlvd' (delivered), 'pndg' (pending), or 'cnld' (cancelled).
#
# Besides the database connection, updateOrderStatus has another parameter, currentYear, which is an integer.
# If currentYear is between 2000 and 2030 (inclusive), then updateOrderStatus should append ' AS OF <currentYear>' at the end of the status value
# if status is not 'cnld'.
# Other values of currentYear are errors.
#
# updateOrderStatus should return the number of orders whose status values were updated.
#
# For more details, including error handling, see the Lab4 pdf.

def updateOrderStatus(conn, currentYear):
    if currentYear < 2000 or currentYear > 2030:
        return -1
    with conn.cursor() as cur:
        cur.execute("""
            UPDATE OrderSupply
            SET status = TRIM(status)::text || ' AS OF ' || %s
            WHERE TRIM(status)::text IN ('dlvd', 'pndg')
        """, (str(currentYear),))
        conn.commit()
        return cur.rowcount
# end updateOrderStatus


# deleteSomeOrders (myConn, maxOrderDeletions):
# Besides the database connection, this Python function has one other parameter,
# maxOrderDeletions, which is an integer.
#
# deleteSomeOrders invokes a Stored Function, deleteSomeOrdersFunction, that you will need to
# implement and store in the database according to the description in Section 5.  The Stored
# Function deleteSomeOrdersFunction has all the same parameters as deleteSomeOrders (except
# for the database connection, which is not a parameter for the Stored Function), and it returns
# an integer.
#
# Section 5 of the Lab4 tells you which orders to delete and explains the integer value
# that deleteSomeOrdersFunction returns.  The deleteSomeOrders Python function returns the
# the same integer value that the deleteSomeOrdersFunction Stored Function returns.
#
# deleteSomeOrdersFunction doesn’t print anything.  The deleteSomeOrders function must only
# invoke the Stored Function deleteSomeOrdersFunction, which does all of the work for this part
# of the assignment; deleteSomeOrders should not do any of the work itself.
#
# For more details, see the Lab4 pdf.

def deleteSomeOrders(conn, maxOrderDeletions):
    with conn.cursor() as cur:
        cur.execute("SELECT deleteSomeOrdersFunction(%s)",
                    (maxOrderDeletions,))
        result = cur.fetchone()[0]
        conn.commit()
        return result
# end deleteSomeOrders


def main():
    user = sys.argv[1] if len(sys.argv) > 2 else 'cse182'
    password = sys.argv[2] if len(sys.argv) > 2 else 'database4me'

    # Try to make a connection to the database
    conn = psycopg2.connect(
        dbname='cse182',
        user=user,
        password=password,
        host='localhost'
    )
    with conn.cursor() as cur:
        cur.execute("SET search_path TO Lab4;")

    # We're making every SQL statement a transaction that commits.
    # Don't need to explicitly begin a transaction.
    # Could have multiple statement in a transaction, using conn.commit when we want to commit.

    # There are other correct ways of writing all of these calls correctly in Python.

    # Perform tests of countNumberOfCustomers, as described in Section 6 of Lab4.
    # Print their outputs (including error outputs) here, not in countNumberOfCustomers.
    # You may use a Python method to help you do the printing.
    for pid in [11, 17, 44, 66]:
        result = countNumberOfCustomers(conn, pid)
        if result >= 0:
            print(f"Number of customers for pharmacy {pid} is {result}\n")
        else:
            print(f"Error: Pharmacy ID {pid} not found.\n")

    # Perform tests of updateOrderStatus, as described in Section 6 of Lab4.
    # Print their outputs (including error outputs) here, not in updateOrderStatus.
    # You may use a Python method to help you do the printing.
    for year in [1999, 2025, 2031]:
        result = updateOrderStatus(conn, year)
        if result >= 0:
            print(
                f"Number of orders whose status values were updated by updateOrderStatus is {result}\n")
        else:
            print(
                f"Error: Invalid year {year} provided to updateOrderStatus.\n")

    # Perform tests of deleteSomeOrders, as described in Section 6 of Lab4,
    # Print their outputs (including error outputs) here, not in deleteSomeOrders.
    # You may use a Python method to help you do the printing.
    for maxDel in [2, 4, 3, 1]:
        result = deleteSomeOrders(conn, maxDel)
        if result >= 0:
            print(
                f"Number of orders which were deleted for maxOrderDeletions value {maxDel} is {result}\n")
        else:
            print(f"Error: Invalid maxOrderDeletions value {maxDel}.\n")

    conn.close()
    sys.exit(0)
# end


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    main()
# end
