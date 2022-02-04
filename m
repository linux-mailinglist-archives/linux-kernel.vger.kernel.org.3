Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC074AA01C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiBDTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:31:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:62070 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233868AbiBDTbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644003105; x=1675539105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEUCBTML5VbcmuMzVJyi8tE4jl/Fqu9D9myYJv94nJo=;
  b=D84xJE6hbqb3Ffx2IpteircOx4ffxmhtaAjPH7oP8Mjc2xoe7iHSp/wb
   xfxmf6/BwW3KgPdM2hKjsW520ADiy2YA8GGE6YEQXdMdShQr+2nXbJrYM
   ZMZ6bj9cS3n/GgARde/gTWhN6wT+2RLLhRKKvU6MF9+/zqbtB3QXFbC0g
   PTpmrjsI9uoHud5fZ4+pcsCCeMnigD+tOjRV2pYjZAiGj1xWP5JrmmX8G
   SROtxrypaCV7PvNFpWmFuR2RAvbQ4ZmBJOM6XOKpQ4MaTvs6riG+/6/6A
   1APIoc04qU/VpdtLmpf65t211yPJu/7TS8CA/tPAvDnd6S/0D9je9f/+0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246018741"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246018741"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="620916838"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2022 11:31:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG4J4-000Y4Q-9u; Fri, 04 Feb 2022 19:31:42 +0000
Date:   Sat, 5 Feb 2022 03:30:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        geert+renesas@glider.be, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     kbuild-all@lists.01.org, Phil Edworthy <phil.edworthy@renesas.com>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 6/6] watchdog: Add Renesas RZ/N1 Watchdog driver
Message-ID: <202202050309.wemilTv5-lkp@intel.com>
References: <20220204161806.3126321-7-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204161806.3126321-7-jjhiblot@traphandler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on geert-renesas-devel/next geert-renesas-drivers/renesas-clk linus/master v5.17-rc2 next-20220204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jean-Jacques-Hiblot/ARM-r9a06g032-add-support-for-the-watchdogs/20220205-001909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220205/202202050309.wemilTv5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/12248ab8278751ebab4bf211becde9db4956ca5a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jean-Jacques-Hiblot/ARM-r9a06g032-add-support-for-the-watchdogs/20220205-001909
        git checkout 12248ab8278751ebab4bf211becde9db4956ca5a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/watchdog/rzn1_wdt.c: In function 'rzn1_wdt_probe':
>> drivers/watchdog/rzn1_wdt.c:134:25: error: 'NO_IRQ' undeclared (first use in this function); did you mean 'NR_IRQS'?
     134 |         if (wdt->irq == NO_IRQ) {
         |                         ^~~~~~
         |                         NR_IRQS
   drivers/watchdog/rzn1_wdt.c:134:25: note: each undeclared identifier is reported only once for each function it appears in


vim +134 drivers/watchdog/rzn1_wdt.c

   112	
   113	static int rzn1_wdt_probe(struct platform_device *pdev)
   114	{
   115		struct rzn1_watchdog *wdt;
   116		int ret;
   117		struct device_node *np = pdev->dev.of_node;
   118		int err;
   119		struct clk *clk;
   120	
   121		wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
   122		if (!wdt)
   123			return -ENOMEM;
   124		wdt->dev = &pdev->dev;
   125		wdt->wdt = rzn1_wdt_dev;
   126		platform_set_drvdata(pdev, wdt);
   127	
   128		wdt->base = devm_platform_ioremap_resource(pdev, 0);
   129		if (IS_ERR(wdt->base)) {
   130			dev_err(wdt->dev, "unable to get register bank\n");
   131			return PTR_ERR(wdt->base);
   132		}
   133		wdt->irq = irq_of_parse_and_map(np, 0);
 > 134		if (wdt->irq == NO_IRQ) {
   135			dev_err(wdt->dev, "failed to get IRQ from DT\n");
   136			return -EINVAL;
   137		}
   138	
   139		err = devm_request_irq(wdt->dev, wdt->irq, rzn1_wdt_irq, 0,
   140				       np->name, wdt);
   141		if (err) {
   142			dev_err(wdt->dev, "failed to request irq %d\n", wdt->irq);
   143			return err;
   144		}
   145		clk = devm_clk_get(wdt->dev, NULL);
   146		if (!IS_ERR(clk) && clk_prepare_enable(clk))
   147			return PTR_ERR(clk);
   148	
   149		wdt->clk_rate = clk_get_rate(clk);
   150		if (!wdt->clk_rate) {
   151			err = -EINVAL;
   152			goto err_clk_disable;
   153		}
   154	
   155		wdt->reload_val = RZN1_WDT_MAX;
   156		wdt->wdt.max_hw_heartbeat_ms = (RZN1_WDT_MAX * 1000) /
   157						(wdt->clk_rate / RZN1_WDT_PRESCALER);
   158	
   159		ret = watchdog_init_timeout(&wdt->wdt, 0, &pdev->dev);
   160		if (ret)
   161			dev_warn(&pdev->dev, "Specified timeout invalid, using default");
   162	
   163		ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdt);
   164		if (ret)
   165			goto error;
   166	
   167		dev_info(wdt->dev, "Initialized\n");
   168	
   169		return 0;
   170	
   171	error:
   172	err_clk_disable:
   173		clk_disable_unprepare(clk);
   174		dev_warn(wdt->dev, "Initialization failed\n");
   175		return err;
   176	}
   177	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
