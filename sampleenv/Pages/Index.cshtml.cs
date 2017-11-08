using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

using sampleenv.Models;

namespace sampleenv.Pages
{
    public class IndexModel : PageModel
    {
        public List<EnvModel> MyVariables { get; private set; }

        public void OnGet()
        {
            var envs = new List<EnvModel>();
            var envVariables = System.Environment.GetEnvironmentVariables();
            foreach(var variable in envVariables.Keys) {
                envs.Add(new EnvModel {
                    Variable = variable.ToString(),
                    Value = envVariables[variable].ToString()
                });
            }       
            MyVariables = envs;
        }
    }
}
