CREATE OR REPLACE FUNCTION deleteSomeOrdersFunction(maxOrderDeletions INTEGER)
RETURNS INTEGER AS $$
DECLARE
    numDeleted INTEGER := 0;
    remainingDeletions INTEGER := maxOrderDeletions;
    sID INTEGER;
    futureCount INTEGER;
    rec RECORD;
BEGIN
    IF maxOrderDeletions <= 0 THEN
        RETURN -1;
    END IF;

    FOR rec IN
        SELECT os.supplierID, COUNT(*) AS cancelCount
        FROM OrderSupply os
        WHERE os.status = 'cnld' AND os.orderDate <= DATE '2024-01-05'
        GROUP BY os.supplierID
        ORDER BY cancelCount DESC,
                 (SELECT supplierName FROM Supplier s WHERE s.supplierID = os.supplierID)
    LOOP
        sID := rec.supplierID;

        SELECT COUNT(*) INTO futureCount
        FROM OrderSupply
        WHERE supplierID = sID AND orderDate > DATE '2024-01-05';

        IF futureCount <= remainingDeletions THEN
            DELETE FROM OrderSupply
            WHERE supplierID = sID AND orderDate > DATE '2024-01-05';

            numDeleted := numDeleted + futureCount;
            remainingDeletions := remainingDeletions - futureCount;
        ELSE
            EXIT;
        END IF;
    END LOOP;

    RETURN numDeleted;
END;
$$ LANGUAGE plpgsql;

