using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using MySql.Data;

namespace DataImporter
{
    class Program
    {
        public static int batchSize = 0;
        public static string fileSystemPath = @"C:\Users\kagajjar\Desktop\WIP\Travellanda\";
        static void Main(string[] args)
        {
            // SQL Bulk Copy
            ReadCountries();
            ReadCities();
            ReadHotels();
            ReadFacilities();
            ReadDescriptions();
            ReadImages();

        }

        private static void ReadCountries()
        {
            string header = "Yes";
            string path = fileSystemPath + "Countries.csv";
            string pathOnly = Path.GetDirectoryName(path);
            string fileName = Path.GetFileName(path);

            string sql = @"SELECT * FROM [" + fileName + "]";

            using (OleDbConnection connection = new OleDbConnection(
                      @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathOnly +
                      ";Extended Properties=\"Text;HDR=" + header + "\""))
            using (OleDbCommand command = new OleDbCommand(sql, connection))
            using (OleDbDataAdapter adapter = new OleDbDataAdapter(command))
            {
                try
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Locale = CultureInfo.CurrentCulture;
                    adapter.Fill(dataTable);
                    dataTable.Columns[1].ColumnName = "CountryName";
                    dataTable.Columns[0].ColumnName = "CountryCode";

                    using (SqlConnection destinationConnection = new SqlConnection(GetConnectionString()))
                    {
                        destinationConnection.Open();
                        using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection))
                        {
                            bulkCopy.DestinationTableName = "CountriesTemp";
                            TruncateTable(bulkCopy.DestinationTableName, destinationConnection);
                            bulkCopy.ColumnMappings.Add("CountryCode", "CountryCode");
                            bulkCopy.ColumnMappings.Add("CountryName", "CountryName");
                            bulkCopy.NotifyAfter = batchSize;
                            bulkCopy.BatchSize = batchSize;

                            try
                            {
                                bulkCopy.WriteToServer(dataTable);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
        private static void ReadCities()
        {
            string header = "Yes";
            string path = fileSystemPath + "Cities.csv";
            string pathOnly = Path.GetDirectoryName(path);
            string fileName = Path.GetFileName(path);

            string sql = @"SELECT * FROM [" + fileName + "]";

            using (OleDbConnection connection = new OleDbConnection(
                      @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathOnly +
                      ";Extended Properties=\"Text;HDR=" + header + "\""))
            using (OleDbCommand command = new OleDbCommand(sql, connection))
            using (OleDbDataAdapter adapter = new OleDbDataAdapter(command))
            {
                try
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Locale = CultureInfo.CurrentCulture;
                    adapter.Fill(dataTable);
                    dataTable.Columns[3].ColumnName = "CountryCode";
                    dataTable.Columns[2].ColumnName = "StateCode";
                    dataTable.Columns[1].ColumnName = "CityName";
                    dataTable.Columns[0].ColumnName = "CityId";

                    using (SqlConnection destinationConnection = new SqlConnection(GetConnectionString()))
                    {
                        destinationConnection.Open();
                        using (SqlBulkCopy bulkCopy =new SqlBulkCopy(destinationConnection))
                        {
                            bulkCopy.DestinationTableName = "CitiesTemp";
                            TruncateTable(bulkCopy.DestinationTableName, destinationConnection);
                            bulkCopy.ColumnMappings.Add("CityId", "CityId");
                            bulkCopy.ColumnMappings.Add("CityName", "CityName");
                            bulkCopy.ColumnMappings.Add("StateCode", "StateCode");
                            bulkCopy.ColumnMappings.Add("CountryCode", "CountryCode");
                            bulkCopy.NotifyAfter = batchSize;
                            bulkCopy.BatchSize = batchSize;

                            try
                            {
                                bulkCopy.WriteToServer(dataTable);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
        private static void ReadHotels()
        {
            string header = "Yes";
            string path = fileSystemPath + "Hotels.csv";
            string pathOnly = Path.GetDirectoryName(path);
            string fileName = Path.GetFileName(path);

            string sql = @"SELECT * FROM [" + fileName + "]";

            using (OleDbConnection connection = new OleDbConnection(
                      @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathOnly +
                      ";Extended Properties=\"Text;HDR=" + header + "\""))
            using (OleDbCommand command = new OleDbCommand(sql, connection))
            using (OleDbDataAdapter adapter = new OleDbDataAdapter(command))
            {
                try
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Locale = CultureInfo.CurrentCulture;
                    adapter.Fill(dataTable);
                    dataTable.Columns[8].ColumnName = "PhoneNumber";
                    dataTable.Columns[7].ColumnName = "Location";
                    dataTable.Columns[6].ColumnName = "Address";
                    dataTable.Columns[5].ColumnName = "Longitude";
                    dataTable.Columns[4].ColumnName = "Latitude";
                    dataTable.Columns[3].ColumnName = "StarRating";
                    dataTable.Columns[2].ColumnName = "HotelName";
                    dataTable.Columns[1].ColumnName = "CityId";
                    dataTable.Columns[0].ColumnName = "HotelId";

                    using (SqlConnection destinationConnection = new SqlConnection(GetConnectionString()))
                    {
                        destinationConnection.Open();
                        using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection))
                        {
                            bulkCopy.DestinationTableName = "HotelsTemp";
                            TruncateTable(bulkCopy.DestinationTableName, destinationConnection);
                            bulkCopy.ColumnMappings.Add("HotelId", "HotelId");
                            bulkCopy.ColumnMappings.Add("CityId", "CityId");
                            bulkCopy.ColumnMappings.Add("HotelName", "HotelName");
                            bulkCopy.ColumnMappings.Add("StarRating", "StarRating");
                            bulkCopy.ColumnMappings.Add("Latitude", "Latitude");
                            bulkCopy.ColumnMappings.Add("Longitude", "Longitude");
                            bulkCopy.ColumnMappings.Add("Address", "Address");
                            bulkCopy.ColumnMappings.Add("Location", "Location");
                            bulkCopy.ColumnMappings.Add("PhoneNumber", "PhoneNumber");
                            bulkCopy.NotifyAfter = batchSize;
                            bulkCopy.BatchSize = batchSize;
                            try
                            {
                                bulkCopy.WriteToServer(dataTable);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
        private static void ReadFacilities()
        {
            string header = "Yes";
            string path = fileSystemPath + "Facilities.csv";
            string pathOnly = Path.GetDirectoryName(path);
            string fileName = Path.GetFileName(path);

            string sql = @"SELECT * FROM [" + fileName + "]";

            using (OleDbConnection connection = new OleDbConnection(
                      @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathOnly +
                      ";Extended Properties=\"Text;HDR=" + header + "\""))
            using (OleDbCommand command = new OleDbCommand(sql, connection))
            using (OleDbDataAdapter adapter = new OleDbDataAdapter(command))
            {
                try
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Locale = CultureInfo.CurrentCulture;
                    adapter.Fill(dataTable);
                    dataTable.Columns[2].ColumnName = "FacilityName";
                    dataTable.Columns[1].ColumnName = "FacilityType";
                    dataTable.Columns[0].ColumnName = "HotelId";

                    using (SqlConnection destinationConnection = new SqlConnection(GetConnectionString()))
                    {
                        destinationConnection.Open();
                        using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection))
                        {
                            bulkCopy.DestinationTableName = "FacilitiesTemp";
                            TruncateTable(bulkCopy.DestinationTableName, destinationConnection);
                            bulkCopy.ColumnMappings.Add("HotelId", "HotelId");
                            bulkCopy.ColumnMappings.Add("FacilityType", "FacilityType");
                            bulkCopy.ColumnMappings.Add("FacilityName", "FacilityName");
                            bulkCopy.NotifyAfter = batchSize;
                            bulkCopy.BatchSize = batchSize;
                            try
                            {
                                bulkCopy.WriteToServer(dataTable);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
        private static void ReadDescriptions()
        {
            string header = "Yes";
            string path = fileSystemPath + "Descriptions.csv";
            string pathOnly = Path.GetDirectoryName(path);
            string fileName = Path.GetFileName(path);

            string sql = @"SELECT * FROM [" + fileName + "]";

            using (OleDbConnection connection = new OleDbConnection(
                      @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathOnly +
                      ";Extended Properties=\"Text;HDR=" + header + "\""))
            using (OleDbCommand command = new OleDbCommand(sql, connection))
            using (OleDbDataAdapter adapter = new OleDbDataAdapter(command))
            {
                try
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Locale = CultureInfo.CurrentCulture;
                    adapter.Fill(dataTable);
                    dataTable.Columns[1].ColumnName = "Description";
                    dataTable.Columns[0].ColumnName = "HotelId";

                    using (SqlConnection destinationConnection = new SqlConnection(GetConnectionString()))
                    {
                        destinationConnection.Open();
                        using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection))
                        {
                            bulkCopy.DestinationTableName = "DescriptionsTemp";
                            TruncateTable(bulkCopy.DestinationTableName, destinationConnection);
                            bulkCopy.ColumnMappings.Add("HotelId", "HotelId");
                            bulkCopy.ColumnMappings.Add("Description", "Description");
                            bulkCopy.NotifyAfter = batchSize;
                            bulkCopy.BatchSize = batchSize;
                            try
                            {
                                bulkCopy.WriteToServer(dataTable);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
        private static void ReadImages()
        {
            string header = "Yes";
            string path = fileSystemPath + "Images.csv";
            string pathOnly = Path.GetDirectoryName(path);
            string fileName = Path.GetFileName(path);

            string sql = @"SELECT * FROM [" + fileName + "]";

            using (OleDbConnection connection = new OleDbConnection(
                      @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + pathOnly +
                      ";Extended Properties=\"Text;HDR=" + header + "\""))
            using (OleDbCommand command = new OleDbCommand(sql, connection))
            using (OleDbDataAdapter adapter = new OleDbDataAdapter(command))
            {
                try
                {
                    DataTable dataTable = new DataTable();
                    dataTable.Locale = CultureInfo.CurrentCulture;
                    adapter.Fill(dataTable);
                    dataTable.Columns[1].ColumnName = "Image";
                    dataTable.Columns[0].ColumnName = "HotelId";

                    using (SqlConnection destinationConnection = new SqlConnection(GetConnectionString()))
                    {
                        destinationConnection.Open();
                        using (SqlBulkCopy bulkCopy = new SqlBulkCopy(destinationConnection))
                        {
                            bulkCopy.DestinationTableName = "ImagesTemp";
                            TruncateTable(bulkCopy.DestinationTableName, destinationConnection);
                            bulkCopy.ColumnMappings.Add("HotelId", "HotelId");
                            bulkCopy.ColumnMappings.Add("Image", "Image");
                            bulkCopy.NotifyAfter = batchSize;
                            bulkCopy.BatchSize = batchSize;
                            try
                            {
                                bulkCopy.WriteToServer(dataTable);
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine(ex.Message);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
 
        private static void TruncateTable(string destinationTableName, SqlConnection conn)
        {
            SqlCommand deleteCommand = new SqlCommand("TRUNCATE TABLE " + destinationTableName, conn);
            var count = deleteCommand.ExecuteNonQuery();
            Console.WriteLine(string.Format("TRUNCATED {0} (NoCount) records from {1}", count, destinationTableName));
        }
       private static string GetConnectionString()
        // To avoid storing the sourceConnection string in your code, 
        // you can retrieve it from a configuration file. 
        {
            return @"Data Source=(localdb)\MSSQLLocalDB;" +
                "Integrated Security=SSPI;" +
                "Initial Catalog=HJ;";
        }

    }
}
