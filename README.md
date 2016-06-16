# Tsung Pack
Everything you need to get up and running with Tsung for load testing.


## Requirements
+ [ansible](http://docs.ansible.com/ansible/intro_installation.html) 2.1.0.0 (older versions should work, but aren't guaranteed)
+ [Terraform](https://www.terraform.io/docs/index.html) v0.6.16


## Compatibility
This code has only been tested with Amazon Linux (a RHEL 6 variant) in AWS. Although, it shouldn't be difficult to modify for other providers and operating systems. Pull requests welcome!


## Setup

### 1. Create your infrastructure
Use the Terraform configuration included in this repo. Read the [README](terraform/README.md) for details on how to set that up.


### 2. Configure Ansible for your Tsung nodes
Once your infrastructure is created, you'll need to reference information about your instances to configure ansible (such as private and public IPs and hostnames).

There are two files you need to update, `ansible/vars/tsung_config.yml` and your ansible inventory file in `ansible/hosts/`.


#### `ansible/vars/tsung_config.yml`
Add each of your Tsung nodes that will be actually making requests to the `clients:` section of the file. You will need to choose a single node to act as your controller. The details of that instance need to be added to the `controller:` section.


#### Ansible inventory file
Use `ansible/hosts/example.ini` as an example. The file name doesn't matter, but for the rest of these steps, we use `myhosts.ini` as the file name. This file contains info about all of your Tsung nodes so that ansible can connect to them, install tsung, and run the tests.


### 3. Install Tsung
Ansible playbooks are included to handle this for you. Erlang and Tsung are built from source on each of your Tsung nodes.

```
> cd ansible;
> ansible-playbook install.yml -i hosts/myhosts.ini
```


### 4. Record your sessions
No need to go into detail here. To create sessions for Tsung to run, refer to the [Tsung proxy recorder docs](http://tsung.erlang-projects.org/user_manual/proxy.html). You will use these sessions in the following step to configure Tsung.


### 5. Configure Tsung
In `ansible/vars/run/sessions/`, add your recorded sessions. [Read the docs](http://tsung.erlang-projects.org/user_manual/conf-sessions.html) for details. It should look something like this:

```
<sessions>
  <session name='best-buy' probability='20'  type='ts_http'>
    <request><http url='http://example.com' version='1.1' method='GET'></http></request>
  </session>
</sessions>
```

Note: Be sure to convert all ampersands (&) to `&amp;` in HTTP URLs, or you may get a `expected_entity_reference_semicolon` error.

Next, define your load phases in `ansible/vars/run/loads/`. Refer to [the manual](http://tsung.erlang-projects.org/user_manual/conf-load.html) for more details. Here's an example:

```
<load>
  <arrivalphase phase="1" duration="5" unit="minute">
    <users interarrival="1" unit="second" maxnumber="1000"></users>
  </arrivalphase>
</load>
```

When you've got your session and load files prepped, update `ansible/vars/tsung_config.yml` with the proper paths for `load_file` and `sessions_file`. Then upload the configuration to your Tsung controller:

```
> cd ansible
> ansible-playbook config.yml -i hosts/myhosts.ini
```

### 6. Run Tsung
This will start your test:

```
> date; ansible controller -i hosts/myhosts.ini -a "tsung start"
```

Tsung makes a web interface available to view the status of your test. To view the status of Tsung *while it's running*, go to http://controller-ip-or-hostname:8091/. The status page will not be available when Tsung is not running.

## Caveat! (PLEASE READ)

If you decide to use the Tsung, please keep in mind the following important caveat: Tsung is, more-or-less a distributed denial-of-service attack and, therefore, if you point them at any server you don’t own you will behaving unethically, have your provider account locked-out, and be liable in a court of law for any downtime you cause.

Keep in mind that you may need to notify your hosting provider of any load or performance testing you are doing. Check with your provider for more info.

You have been warned!

Some of this verbiage was taken from another awesome load testing tool to have in your toolbox called [beeswithmachineguns](https://github.com/newsapps/beeswithmachineguns).

## License
MIT License
