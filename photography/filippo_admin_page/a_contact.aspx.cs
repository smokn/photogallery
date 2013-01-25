﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace photography.filippo_admin_page
{
    public partial class a_contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["username"] == null)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("login.aspx");
                }
            }

            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                try
                {
                    SqlCommand check_cmd = new SqlCommand("SELECT COUNT(*) FROM info", con);
                    con.Open();
                    int count = (int)check_cmd.ExecuteScalar();
                    if (count == 0)
                    {
                        SqlCommand create_cmd = new SqlCommand("INSERT INTO info VALUES(NULL, NULL, NULL, NULL, NULL)", con);
                        create_cmd.ExecuteNonQuery();
                    }
                    else if (count == 1 && !IsPostBack)
                    {
                        SqlCommand read_cmd = new SqlCommand("SELECT telephone, facebook, twitter, email FROM info", con);
                        SqlDataReader rdr = read_cmd.ExecuteReader();
                        rdr.Read();
                        tel_txt.Text = rdr["telephone"].ToString();
                        facebook_txt.Text = rdr["facebook"].ToString();
                        twitter_txt.Text = rdr["twitter"].ToString();
                        mail_txt.Text = rdr["email"].ToString();
                    }

                }
                catch (SqlException ex)
                {
                    msg_lbl.Visible = true;
                    msg_lbl.Text = ex.Message;
                }
                catch (Exception ex)
                {
                    msg_lbl.Visible = true;
                    msg_lbl.Text = ex.Message;
                }
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                try
                {
                    SqlCommand update_cmd = new SqlCommand("UPDATE info SET telephone=@telephone, facebook=@facebook, twitter=@twitter, email=@email", con);
                    update_cmd.Parameters.AddWithValue("@telephone", tel_txt.Text);
                    update_cmd.Parameters.AddWithValue("@facebook", facebook_txt.Text);
                    update_cmd.Parameters.AddWithValue("@twitter", twitter_txt.Text);
                    update_cmd.Parameters.AddWithValue("@email", mail_txt.Text);
                    con.Open();
                    int result = update_cmd.ExecuteNonQuery();
                    if (result != 1)
                    {
                        msg_lbl.Visible = true;
                        msg_lbl.Text = "Error occured.";
                    }
                    else
                    {
                        msg_lbl.Visible = true;
                        msg_lbl.Text = "Contact Us is updated.";
                    }

                }
                catch (SqlException ex)
                {
                    msg_lbl.Visible = true;
                    msg_lbl.Text = ex.Message;
                }
                catch (Exception ex)
                {
                    msg_lbl.Visible = true;
                    msg_lbl.Text = ex.Message;
                }
            }

        }
    }
}