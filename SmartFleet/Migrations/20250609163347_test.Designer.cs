﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using SmartFleet.Data;

#nullable disable

namespace SmartFleet.Migrations
{
    [DbContext(typeof(SmartFleetContext))]
    [Migration("20250609163347_test")]
    partial class test
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.15")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasDatabaseName("RoleNameIndex")
                        .HasFilter("[NormalizedName] IS NOT NULL");

                    b.ToTable("AspNetRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("RoleId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("ClaimType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.Property<string>("LoginProvider")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("ProviderKey")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("ProviderDisplayName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("RoleId")
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.Property<string>("UserId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("LoginProvider")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Value")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens", (string)null);
                });

            modelBuilder.Entity("SmartFleet.Models.ApplicationUser", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("nvarchar(450)");

                    b.Property<int>("AccessFailedCount")
                        .HasColumnType("int");

                    b.Property<bool>("AccountStatus")
                        .HasColumnType("bit");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<bool>("EmailConfirmed")
                        .HasColumnType("bit");

                    b.Property<bool>("LockoutEnabled")
                        .HasColumnType("bit");

                    b.Property<DateTimeOffset?>("LockoutEnd")
                        .HasColumnType("datetimeoffset");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("PhoneNumberConfirmed")
                        .HasColumnType("bit");

                    b.Property<string>("ProfileImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("SecurityStamp")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("TwoFactorEnabled")
                        .HasColumnType("bit");

                    b.Property<string>("UserName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasDatabaseName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasDatabaseName("UserNameIndex")
                        .HasFilter("[NormalizedUserName] IS NOT NULL");

                    b.ToTable("Users", (string)null);

                    b.UseTptMappingStrategy();

                    b.HasData(
                        new
                        {
                            Id = "1",
                            AccessFailedCount = 0,
                            AccountStatus = true,
                            ConcurrencyStamp = "c315ee1c-6ba4-4714-8c55-768c605cea75",
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4051),
                            Email = "admin@smartfleet.com",
                            EmailConfirmed = false,
                            LockoutEnabled = false,
                            PhoneNumberConfirmed = false,
                            ProfileImageUrl = "https://example.com/admin.jpg",
                            SecurityStamp = "8ad9a0ab-4795-4a68-bba6-e87302cbb2d6",
                            TwoFactorEnabled = false,
                            UserName = "admin@smartfleet.com"
                        });
                });

            modelBuilder.Entity("SmartFleet.Models.Event", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Message")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("RelatedId")
                        .HasColumnType("int");

                    b.Property<string>("RelatedTable")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Severity")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Type")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Events");
                });

            modelBuilder.Entity("SmartFleet.Models.Maintenance", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("IssueDescription")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Priority")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("RepairStatus")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("RepairedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("ReportedBy")
                        .HasColumnType("nvarchar(450)");

                    b.Property<int?>("VehicleId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("ReportedBy");

                    b.HasIndex("VehicleId");

                    b.ToTable("Maintenances");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4269),
                            IssueDescription = "Flat tire",
                            Priority = "high",
                            RepairStatus = "pending",
                            ReportedBy = "1",
                            VehicleId = 1
                        });
                });

            modelBuilder.Entity("SmartFleet.Models.Notification", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<bool>("IsRead")
                        .HasColumnType("bit");

                    b.Property<string>("Message")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("RelatedId")
                        .HasColumnType("int");

                    b.Property<int>("RelatedTable")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Notifications");
                });

            modelBuilder.Entity("SmartFleet.Models.Order", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<int>("PassengerCount")
                        .HasColumnType("int");

                    b.Property<string>("Reason")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("TripEndDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("TripEndLocation")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("TripStartDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("TripStartLocation")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("UserId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<int>("VehicleType")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("Orders");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4302),
                            PassengerCount = 3,
                            Reason = "Business Trip",
                            Status = "pending",
                            TripEndDate = new DateTime(2025, 6, 9, 22, 33, 47, 670, DateTimeKind.Local).AddTicks(4301),
                            TripEndLocation = "Airport",
                            TripStartDate = new DateTime(2025, 6, 9, 20, 33, 47, 670, DateTimeKind.Local).AddTicks(4297),
                            TripStartLocation = "University",
                            UserId = "1",
                            VehicleType = 0
                        });
                });

            modelBuilder.Entity("SmartFleet.Models.SimCard", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("ActivatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("Carrier")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("SimNumber")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Status")
                        .HasColumnType("bit");

                    b.Property<int?>("VehicleId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("VehicleId")
                        .IsUnique()
                        .HasFilter("[VehicleId] IS NOT NULL");

                    b.ToTable("SimCards");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            ActivatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4328),
                            Carrier = "CarrierX",
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4331),
                            SimNumber = "1234567890",
                            Status = true,
                            VehicleId = 1
                        });
                });

            modelBuilder.Entity("SmartFleet.Models.Trip", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<string>("CreatedBy")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<decimal>("Distance")
                        .HasColumnType("decimal(9, 6)");

                    b.Property<string>("DriverId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("EndLocation")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime?>("EndTime")
                        .HasColumnType("datetime2");

                    b.Property<int?>("OrderId")
                        .HasColumnType("int");

                    b.Property<string>("StartLocation")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("StartTime")
                        .HasColumnType("datetime2");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("VehicleId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("CreatedBy");

                    b.HasIndex("DriverId");

                    b.HasIndex("OrderId")
                        .IsUnique()
                        .HasFilter("[OrderId] IS NOT NULL");

                    b.HasIndex("VehicleId");

                    b.ToTable("Trips");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4360),
                            CreatedBy = "1",
                            Distance = 50m,
                            DriverId = "2",
                            EndLocation = "Airport",
                            OrderId = 1,
                            StartLocation = "University",
                            StartTime = new DateTime(2025, 6, 9, 20, 33, 47, 670, DateTimeKind.Local).AddTicks(4358),
                            Status = "scheduled",
                            VehicleId = 1
                        });
                });

            modelBuilder.Entity("SmartFleet.Models.Vehicle", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("Capacity")
                        .HasColumnType("int");

                    b.Property<DateTime>("CreatedAt")
                        .HasColumnType("datetime2");

                    b.Property<decimal>("Distance")
                        .HasColumnType("decimal(9, 6)");

                    b.Property<string>("LicensePlate")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Model")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Status")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Type")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("VehicleImageUrl")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Vehicles");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Capacity = 5,
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4237),
                            Distance = 0m,
                            LicensePlate = "XYZ 1234",
                            Model = "Toyota Corolla",
                            Status = "available",
                            Type = "Car",
                            VehicleImageUrl = "https://example.com/toyota.jpg"
                        },
                        new
                        {
                            Id = 2,
                            Capacity = 12,
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4243),
                            Distance = 500m,
                            LicensePlate = "XYZ 5678",
                            Model = "Ford Transit",
                            Status = "available",
                            Type = "Van",
                            VehicleImageUrl = "https://example.com/ford.jpg"
                        });
                });

            modelBuilder.Entity("SmartFleet.Models.VehicleLocation", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<decimal>("Latitude")
                        .HasColumnType("decimal(9, 6)");

                    b.Property<decimal>("Longitude")
                        .HasColumnType("decimal(9, 6)");

                    b.Property<decimal>("Speed")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("Timestamp")
                        .HasColumnType("datetime2");

                    b.Property<int>("VehicleId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("VehicleId");

                    b.ToTable("VehicleLocations");
                });

            modelBuilder.Entity("SmartFleet.Models.Driver", b =>
                {
                    b.HasBaseType("SmartFleet.Models.ApplicationUser");

                    b.Property<string>("DriverStatus")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("LicenseExpiryDate")
                        .HasColumnType("datetime2");

                    b.Property<string>("LicenseNumber")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.ToTable("Drivers", (string)null);

                    b.HasData(
                        new
                        {
                            Id = "2",
                            AccessFailedCount = 0,
                            AccountStatus = true,
                            ConcurrencyStamp = "c06ced4a-6838-4a0f-aa33-b7147fc8d475",
                            CreatedAt = new DateTime(2025, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4212),
                            Email = "driver@smartfleet.com",
                            EmailConfirmed = false,
                            LockoutEnabled = false,
                            PhoneNumberConfirmed = false,
                            ProfileImageUrl = "https://example.com/driver.jpg",
                            SecurityStamp = "ed768a76-e52c-4c17-94ba-2484f6c948bd",
                            TwoFactorEnabled = false,
                            UserName = "driver@smartfleet.com",
                            DriverStatus = "active",
                            LicenseExpiryDate = new DateTime(2027, 6, 9, 19, 33, 47, 670, DateTimeKind.Local).AddTicks(4206),
                            LicenseNumber = "AB12345"
                        });
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<string>", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<string>", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<string>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SmartFleet.Models.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<string>", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("SmartFleet.Models.Event", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", "User")
                        .WithMany("Events")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("SmartFleet.Models.Maintenance", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", "ReportedUser")
                        .WithMany("Maintenances")
                        .HasForeignKey("ReportedBy");

                    b.HasOne("SmartFleet.Models.Vehicle", "Vehicle")
                        .WithMany("Maintenances")
                        .HasForeignKey("VehicleId");

                    b.Navigation("ReportedUser");

                    b.Navigation("Vehicle");
                });

            modelBuilder.Entity("SmartFleet.Models.Notification", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", "User")
                        .WithMany("Notifications")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("SmartFleet.Models.Order", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", "User")
                        .WithMany("Orders")
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("User");
                });

            modelBuilder.Entity("SmartFleet.Models.SimCard", b =>
                {
                    b.HasOne("SmartFleet.Models.Vehicle", "Vehicle")
                        .WithOne("SimCard")
                        .HasForeignKey("SmartFleet.Models.SimCard", "VehicleId");

                    b.Navigation("Vehicle");
                });

            modelBuilder.Entity("SmartFleet.Models.Trip", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", "admin")
                        .WithMany("Trips")
                        .HasForeignKey("CreatedBy")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("SmartFleet.Models.Driver", "Driver")
                        .WithMany()
                        .HasForeignKey("DriverId");

                    b.HasOne("SmartFleet.Models.Order", "Order")
                        .WithOne("Trip")
                        .HasForeignKey("SmartFleet.Models.Trip", "OrderId");

                    b.HasOne("SmartFleet.Models.Vehicle", "Vehicle")
                        .WithMany("Trips")
                        .HasForeignKey("VehicleId");

                    b.Navigation("Driver");

                    b.Navigation("Order");

                    b.Navigation("Vehicle");

                    b.Navigation("admin");
                });

            modelBuilder.Entity("SmartFleet.Models.VehicleLocation", b =>
                {
                    b.HasOne("SmartFleet.Models.Vehicle", "Vehicle")
                        .WithMany("VehicleLocations")
                        .HasForeignKey("VehicleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Vehicle");
                });

            modelBuilder.Entity("SmartFleet.Models.Driver", b =>
                {
                    b.HasOne("SmartFleet.Models.ApplicationUser", null)
                        .WithOne()
                        .HasForeignKey("SmartFleet.Models.Driver", "Id")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("SmartFleet.Models.ApplicationUser", b =>
                {
                    b.Navigation("Events");

                    b.Navigation("Maintenances");

                    b.Navigation("Notifications");

                    b.Navigation("Orders");

                    b.Navigation("Trips");
                });

            modelBuilder.Entity("SmartFleet.Models.Order", b =>
                {
                    b.Navigation("Trip")
                        .IsRequired();
                });

            modelBuilder.Entity("SmartFleet.Models.Vehicle", b =>
                {
                    b.Navigation("Maintenances");

                    b.Navigation("SimCard");

                    b.Navigation("Trips");

                    b.Navigation("VehicleLocations");
                });
#pragma warning restore 612, 618
        }
    }
}
