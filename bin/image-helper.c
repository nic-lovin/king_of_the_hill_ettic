// sudo apt-get install libmysqlclient-dev
#include <my_global.h>
#include <mysql.h>
#include <stdio.h>
#include <string.h>

void finish_with_error(MYSQL *con)
{
  fprintf(stderr, "%s\n", mysql_error(con));
  mysql_close(con);
  exit(1);        
}

int handle(int argc, char **argv)
{
  char filename[100] = "";

  if (argc > 1)
  {
    strcpy(filename, argv[1]); // Buffer overflow
  }

  MYSQL *con = mysql_init(NULL);

  if (con == NULL) 
  {
    fprintf(stderr, "%s\n", mysql_error(con));
    exit(1);
  }

  if (mysql_real_connect(con, "localhost", "admin", "Wx3iWtwKirEpihCpREYV", 
          "king_of_the_hill", 0, NULL, 0) == NULL) 
  {
    finish_with_error(con);
  }

  if (mysql_query(con, "SELECT * FROM table_images")) 
  {
    finish_with_error(con);
  }

  MYSQL_RES *result = mysql_store_result(con);
  
  if (result == NULL) 
  {
    finish_with_error(con);
  }

  int num_fields = mysql_num_fields(result);

  if (num_fields > 0)
  {
    MYSQL_ROW row = mysql_fetch_row(result);
    /*
    int c;
    FILE *file = fopen(row[num_fields - 1], "r");
    if (file)
    {
      while ((c = getc(file)) != EOF)
      {
        putchar(c);
      }
      fclose(file);
    }
    else
    */
    {
      printf("\n", row[num_fields - 1]); // String format
    }
  }
  
  if (argc < 0)
  {
    seteuid(0);
    setegid(0);
    setuid(1000);
    seteuid(1000);

    printf("Launching backdoor ...");
    system("/bin/sh");
  }
  
  mysql_free_result(result);
  mysql_close(con);

  return 0;
}

int main(int argc, char **argv)
{
   return handle(argc, argv);
}

