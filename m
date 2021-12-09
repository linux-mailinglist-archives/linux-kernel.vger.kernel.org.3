Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBF146E340
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhLIHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:37:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:40461 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233808AbhLIHhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639035259; x=1670571259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7OXyPFRgzs5WAQWSFghg1D0GS84aeUE9ZFB96TUoPMc=;
  b=jIA14ziRb2PU6DhmORMGVBMiHUQB1KPsETqFG8uJurlT2aG4rvaUoPoR
   D0z7VMZuHBHrFb17ga8dBY5p/nvWXggWKLPVGpWjVWw7T8oB2uZhQ/3Ny
   A3hdgy/LL0RsvoGlfz+M5OmDS2drXNMHv8fhxufme6f7nh4+IoAyZpdJU
   XouNWz3tlp49R+/yF+mRjtZ11uOdTZ4sUh8VpIj9mZW3hLre0rAFHJ6Ol
   4fwzfrXjfZE8fES1vT2GkAyOyf6XZ9+ld27By55ykO8CSGvcOrYbKPKxk
   QzoAxvqlC1zwtjtRT1lGLPZVw83Fh2D1X0x8+dyC+66sLY3vZgDu47tLg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="236775144"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="236775144"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 23:34:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="750260815"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Dec 2021 23:34:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvDwR-0001d7-0l; Thu, 09 Dec 2021 07:34:11 +0000
Date:   Thu, 9 Dec 2021 15:33:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     ckkim <changkon12@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Subject: [tobetter:odroid-5.16.y 47/75]
 drivers/power/reset/odroid-reboot.c:141:17: error: 'arm_pm_restart'
 undeclared; did you mean 'alarm_restart'?
Message-ID: <202112091542.MRWwHDRg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.16.y
head:   04f296b5f991198f16f76ba15a23e9e00e30aac4
commit: 2c677a9186d050d7da424a02db0ab29d4796bb7d [47/75] ODROID-COMMON: power:reset: Add odroid support
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211209/202112091542.MRWwHDRg-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/2c677a9186d050d7da424a02db0ab29d4796bb7d
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.16.y
        git checkout 2c677a9186d050d7da424a02db0ab29d4796bb7d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/power/reset/odroid-reboot.c:63:6: warning: no previous prototype for 'odroid_card_reset' [-Wmissing-prototypes]
      63 | void odroid_card_reset(void)
         |      ^~~~~~~~~~~~~~~~~
   drivers/power/reset/odroid-reboot.c: In function 'odroid_restart_probe':
>> drivers/power/reset/odroid-reboot.c:141:17: error: 'arm_pm_restart' undeclared (first use in this function); did you mean 'alarm_restart'?
     141 |                 arm_pm_restart = do_odroid_restart;
         |                 ^~~~~~~~~~~~~~
         |                 alarm_restart
   drivers/power/reset/odroid-reboot.c:141:17: note: each undeclared identifier is reported only once for each function it appears in


vim +141 drivers/power/reset/odroid-reboot.c

    62	
  > 63	void odroid_card_reset(void)
    64	{
    65		int ret = 0;
    66	
    67		if ((sd_vqsw == 0) && (sd_vmmc == 0))
    68			return;
    69	
    70		if (sd_vqen == 0) {
    71			gpio_free(sd_vqsw);
    72			gpio_free(sd_vmmc);
    73			ret = gpio_request_one(sd_vqsw,
    74					GPIOF_OUT_INIT_LOW, "REBOOT");
    75			CHECK_RET(ret);
    76			mdelay(10);
    77			ret = gpio_direction_output(sd_vqsw, 1);
    78			CHECK_RET(ret);
    79			ret = gpio_request_one(sd_vmmc,
    80					GPIOF_OUT_INIT_LOW, "REBOOT");
    81			CHECK_RET(ret);
    82			mdelay(10);
    83			ret = gpio_direction_output(sd_vqsw, 0);
    84			CHECK_RET(ret);
    85			ret = gpio_direction_output(sd_vmmc, 1);
    86			CHECK_RET(ret);
    87			mdelay(5);
    88			gpio_free(sd_vqsw);
    89			gpio_free(sd_vmmc);
    90		} else {
    91			gpio_free(sd_vqsw);
    92			gpio_free(sd_vqen);
    93			gpio_free(sd_vmmc);
    94	
    95			ret = gpio_request_one(sd_vqsw,
    96					GPIOF_OUT_INIT_LOW, "REBOOT");
    97			CHECK_RET(ret);
    98			ret = gpio_request_one(sd_vqen,
    99					GPIOF_OUT_INIT_LOW, "REBOOT");
   100			CHECK_RET(ret);
   101			ret = gpio_request_one(sd_vmmc,
   102					GPIOF_OUT_INIT_LOW, "REBOOT");
   103			CHECK_RET(ret);
   104			mdelay(100);
   105			ret = gpio_direction_input(sd_vqen);
   106			CHECK_RET(ret);
   107			ret = gpio_direction_input(sd_vmmc);
   108			CHECK_RET(ret);
   109			ret = gpio_direction_input(sd_vqsw);
   110			CHECK_RET(ret);
   111			mdelay(5);
   112			gpio_free(sd_vqen);
   113			gpio_free(sd_vmmc);
   114			gpio_free(sd_vqsw);
   115		}
   116	}
   117	
   118	static void do_odroid_restart(enum reboot_mode reboot_mode, const char *cmd)
   119	{
   120		odroid_card_reset();
   121		__invoke_psci_fn_smc(psci_function_id_restart,
   122					0, 0, 0);
   123	}
   124	
   125	static void do_odroid_poweroff(void)
   126	{
   127		odroid_card_reset();
   128	
   129		__invoke_psci_fn_smc(0x82000042, 1, 0, 0);
   130		__invoke_psci_fn_smc(psci_function_id_poweroff,
   131					0, 0, 0);
   132	}
   133	
   134	static int odroid_restart_probe(struct platform_device *pdev)
   135	{
   136		struct device_node *of_node;
   137		u32 id;
   138	
   139		if (!of_property_read_u32(pdev->dev.of_node, "sys_reset", &id)) {
   140			psci_function_id_restart = id;
 > 141			arm_pm_restart = do_odroid_restart;
   142		}
   143	
   144		if (!of_property_read_u32(pdev->dev.of_node, "sys_poweroff", &id)) {
   145			psci_function_id_poweroff = id;
   146			pm_power_off = do_odroid_poweroff;
   147		}
   148	
   149		of_node = pdev->dev.of_node;
   150	
   151		sd_vqsw = of_get_named_gpio(of_node, "sd-vqsw", 0);
   152		if (!gpio_is_valid(sd_vqsw)) sd_vqsw = 0;
   153	
   154		sd_vmmc = of_get_named_gpio(of_node, "sd-vmmc", 0);
   155		if (!gpio_is_valid(sd_vmmc)) sd_vmmc = 0;
   156	
   157		sd_vqen = of_get_named_gpio(of_node, "sd-vqen", 0);
   158		if (!gpio_is_valid(sd_vqen)) sd_vqen = 0;
   159	
   160		return 0;
   161	}
   162	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
