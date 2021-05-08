public class BonusBatchableScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {
        BonusBatchable batchBonus = new BonusBatchable();
        Database.executeBatch(batchBonus,10);
    }
}