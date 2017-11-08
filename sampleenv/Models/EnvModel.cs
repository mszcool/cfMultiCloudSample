using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace sampleenv.Models
{
    public class EnvModel {
        public string Variable { get; set; }
        public string Value { get; set; }
    }
}