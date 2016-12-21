ansible-role-squid
===

An ansible role for setting up SQUID

## How to use

1. prepare configration file

You need to prepare configration file in your playbook. Put it into right directory which is defined in variables  
If you would like to change the path, overwrite specific variable

## Variables

| parameter | defaults | choices | comments |
|:---|:---|:---|:---|
| squid_conf_src_path | files/squid/squid.conf |  | The path of the configuration file |
