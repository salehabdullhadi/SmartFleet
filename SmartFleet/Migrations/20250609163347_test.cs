using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SmartFleet.Migrations
{
    /// <inheritdoc />
    public partial class test : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Events_Users_UserId",
                table: "Events");

            migrationBuilder.AddColumn<decimal>(
                name: "Speed",
                table: "VehicleLocations",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AlterColumn<string>(
                name: "UserId",
                table: "Events",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.UpdateData(
                table: "Drivers",
                keyColumn: "Id",
                keyValue: "2",
                column: "LicenseExpiryDate",
                value: new DateTime(2027, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4206));

            migrationBuilder.UpdateData(
                table: "Maintenances",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4269));

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "TripEndDate", "TripStartDate" },
                values: new object[] { new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4302), new DateTime(2025, 6, 9, 22, 33, 47, 670, DateTimeKind.Local).AddTicks(4301), new DateTime(2025, 6, 9, 20, 33, 47, 670, DateTimeKind.Local).AddTicks(4297) });

            migrationBuilder.UpdateData(
                table: "SimCards",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "ActivatedAt", "CreatedAt" },
                values: new object[] { new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4328), new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4331) });

            migrationBuilder.UpdateData(
                table: "Trips",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "StartTime" },
                values: new object[] { new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4360), new DateTime(2025, 6, 9, 20, 33, 47, 670, DateTimeKind.Local).AddTicks(4358) });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: "1",
                columns: new[] { "ConcurrencyStamp", "CreatedAt", "SecurityStamp" },
                values: new object[] { "c315ee1c-6ba4-4714-8c55-768c605cea75", new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4051), "8ad9a0ab-4795-4a68-bba6-e87302cbb2d6" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: "2",
                columns: new[] { "ConcurrencyStamp", "CreatedAt", "SecurityStamp" },
                values: new object[] { "c06ced4a-6838-4a0f-aa33-b7147fc8d475", new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4212), "ed768a76-e52c-4c17-94ba-2484f6c948bd" });

            migrationBuilder.UpdateData(
                table: "Vehicles",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4237));

            migrationBuilder.UpdateData(
                table: "Vehicles",
                keyColumn: "Id",
                keyValue: 2,
                column: "CreatedAt",
                value: new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4243));

            migrationBuilder.AddForeignKey(
                name: "FK_Events_Users_UserId",
                table: "Events",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Events_Users_UserId",
                table: "Events");

            migrationBuilder.DropColumn(
                name: "Speed",
                table: "VehicleLocations");

            migrationBuilder.AlterColumn<string>(
                name: "UserId",
                table: "Events",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.UpdateData(
                table: "Drivers",
                keyColumn: "Id",
                keyValue: "2",
                column: "LicenseExpiryDate",
                value: new DateTime(2027, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7319));

            migrationBuilder.UpdateData(
                table: "Maintenances",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7410));

            migrationBuilder.UpdateData(
                table: "Orders",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "TripEndDate", "TripStartDate" },
                values: new object[] { new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7452), new DateTime(2025, 2, 28, 8, 38, 54, 235, DateTimeKind.Local).AddTicks(7449), new DateTime(2025, 2, 28, 6, 38, 54, 235, DateTimeKind.Local).AddTicks(7444) });

            migrationBuilder.UpdateData(
                table: "SimCards",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "ActivatedAt", "CreatedAt" },
                values: new object[] { new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7484), new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7488) });

            migrationBuilder.UpdateData(
                table: "Trips",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "CreatedAt", "StartTime" },
                values: new object[] { new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7528), new DateTime(2025, 2, 28, 6, 38, 54, 235, DateTimeKind.Local).AddTicks(7523) });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: "1",
                columns: new[] { "ConcurrencyStamp", "CreatedAt", "SecurityStamp" },
                values: new object[] { "2a1d1cb9-0b78-4bc9-b095-01bb3fc9c43f", new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7080), "1c09bd9c-2d60-47bd-b146-7ce08086e954" });

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: "2",
                columns: new[] { "ConcurrencyStamp", "CreatedAt", "SecurityStamp" },
                values: new object[] { "78035726-b052-4e83-b87f-aaa63ea7e3d4", new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7325), "ed68c8a0-b1d6-4649-a9dd-ce02f715d2a4" });

            migrationBuilder.UpdateData(
                table: "Vehicles",
                keyColumn: "Id",
                keyValue: 1,
                column: "CreatedAt",
                value: new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7365));

            migrationBuilder.UpdateData(
                table: "Vehicles",
                keyColumn: "Id",
                keyValue: 2,
                column: "CreatedAt",
                value: new DateTime(2025, 2, 28, 5, 38, 54, 235, DateTimeKind.Local).AddTicks(7373));

            migrationBuilder.AddForeignKey(
                name: "FK_Events_Users_UserId",
                table: "Events",
                column: "UserId",
                principalTable: "Users",
                principalColumn: "Id");
        }
    }
}
