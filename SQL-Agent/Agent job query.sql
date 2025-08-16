USE msdb;
GO

EXEC sp_add_job @job_name = N'Daily_ETL_LoadCSVs';

EXEC sp_add_jobstep
  @job_name  = N'Daily_ETL_LoadCSVs',
  @step_name = N'Load CSVs',
  @subsystem = N'PowerShell',
  @command   = N'powershell.exe -NoProfile -ExecutionPolicy Bypass -File ""C:\Users\Admin\Desktop\Project\LoadCSVs.ps1""',
  @on_success_action = 1;

EXEC sp_add_jobstep
    @job_name  = N'Daily_ETL_LoadCSVs',
    @step_name = N'Run KPIs and Restock',
    @subsystem = N'TSQL',
    @command   = N'
        -- Write KPI row (company-wide)
        INSERT INTO dbo.KPI_AuditLog (StoreID, TotalRevenue, AOV, InventoryTurnover)
        EXEC dbo.sp_CalculateStoreKPI @StoreID = NULL;

        -- Write restock rows (company-wide)
        INSERT INTO dbo.Restock_AuditLog (StoreID, ProductID, ProductName, AvailableQty)
        EXEC dbo.sp_GGenerateRestockList @StoreID = NULL, @MinQty = 5;
    ',
    @on_success_action = 1;  -- quit with success

EXEC sp_add_schedule
  @schedule_name = N'Daily_2AM',
  @freq_type = 4,             -- Daily
  @freq_interval = 1,
  @active_start_time = 020000; -- 02:00

EXEC sp_attach_schedule
  @job_name = N'Daily_ETL_LoadCSVs',
  @schedule_name = N'Daily_2AM';

EXEC sp_add_jobserver @job_name = N'Daily_ETL_LoadCSVs';
GO
