Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15D47CE83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbhLVIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:55:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:25705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236120AbhLVIzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640163352; x=1671699352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sN9CQ6H0z2ggrNBRyE2c71qxS6Hewy6xxcUI7wjpYMs=;
  b=heY5kiJB8svr2Gkr/Yq0KPuokocQ8WQdMpbUYECVXiRLZV4uyKU8GkVY
   uTEQcMBbj+wlDxhZ/hbX8tTcJEcKNq29XIpTpPyrferOh/o/9dSs8aE5v
   hqLt1Tos+OgwcQk9dsEPVZAUUaB9XOPxhv3jFgix+/w8vBj1zxbcLO2LK
   MidYGiSOqxxvlK75Fxe9hYnvjX/MGkyO8XBV1QRYCJaT1CqzazLjg7vED
   mdCx2L+NG/VfqYb0QjzCd1xq+VBTMtwyxDUEdvlXsQ1+BKd50d/dJHQiA
   to+joh4M5yyqMaKUICmVqPit6l9MQ01ph+6RK1wDbj9a5+e78AIQkITuO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227876987"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="227876987"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 00:55:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="684958718"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2021 00:55:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzxPO-0000IX-4c; Wed, 22 Dec 2021 08:55:38 +0000
Date:   Wed, 22 Dec 2021 16:55:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/pinctrl/bcm/pinctrl-ns.c:286:53: warning: passing argument 3
 of 'pinmux_generic_add_function' discards 'const' qualifier from pointer
 target type
Message-ID: <202112221651.gLNfcGwH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211222-144502/Rafa-Mi-ecki/pinctrl-bcm-ns-use-generic-groups-functions-helpers/20211117-064419
head:   da7c70cdea1466b4234a30658ee2b5383545a629
commit: da7c70cdea1466b4234a30658ee2b5383545a629 pinctrl: bcm: ns: use generic groups & functions helpers
date:   2 hours ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112221651.gLNfcGwH-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/da7c70cdea1466b4234a30658ee2b5383545a629
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211222-144502/Rafa-Mi-ecki/pinctrl-bcm-ns-use-generic-groups-functions-helpers/20211117-064419
        git checkout da7c70cdea1466b4234a30658ee2b5383545a629
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/pinctrl/bcm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/pinctrl/bcm/pinctrl-ns.c: In function 'ns_pinctrl_probe':
>> drivers/pinctrl/bcm/pinctrl-ns.c:286:53: warning: passing argument 3 of 'pinmux_generic_add_function' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     286 |                                             function->groups,
         |                                             ~~~~~~~~^~~~~~~~
   In file included from drivers/pinctrl/bcm/pinctrl-ns.c:18:
   drivers/pinctrl/bcm/../pinmux.h:153:46: note: expected 'const char **' but argument is of type 'const char * const*'
     153 |                                 const char **groups,
         |                                 ~~~~~~~~~~~~~^~~~~~


vim +286 drivers/pinctrl/bcm/pinctrl-ns.c

   207	
   208	static int ns_pinctrl_probe(struct platform_device *pdev)
   209	{
   210		struct device *dev = &pdev->dev;
   211		const struct of_device_id *of_id;
   212		struct ns_pinctrl *ns_pinctrl;
   213		struct pinctrl_desc *pctldesc;
   214		struct pinctrl_pin_desc *pin;
   215		struct resource *res;
   216		int i;
   217	
   218		ns_pinctrl = devm_kzalloc(dev, sizeof(*ns_pinctrl), GFP_KERNEL);
   219		if (!ns_pinctrl)
   220			return -ENOMEM;
   221		pctldesc = &ns_pinctrl->pctldesc;
   222		platform_set_drvdata(pdev, ns_pinctrl);
   223	
   224		/* Set basic properties */
   225	
   226		ns_pinctrl->dev = dev;
   227	
   228		of_id = of_match_device(ns_pinctrl_of_match_table, dev);
   229		if (!of_id)
   230			return -EINVAL;
   231		ns_pinctrl->chipset_flag = (uintptr_t)of_id->data;
   232	
   233		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
   234						   "cru_gpio_control");
   235		ns_pinctrl->base = devm_ioremap_resource(dev, res);
   236		if (IS_ERR(ns_pinctrl->base)) {
   237			dev_err(dev, "Failed to map pinctrl regs\n");
   238			return PTR_ERR(ns_pinctrl->base);
   239		}
   240	
   241		memcpy(pctldesc, &ns_pinctrl_desc, sizeof(*pctldesc));
   242	
   243		/* Set pinctrl properties */
   244	
   245		pctldesc->pins = devm_kcalloc(dev, ARRAY_SIZE(ns_pinctrl_pins),
   246					      sizeof(struct pinctrl_pin_desc),
   247					      GFP_KERNEL);
   248		if (!pctldesc->pins)
   249			return -ENOMEM;
   250		for (i = 0, pin = (struct pinctrl_pin_desc *)&pctldesc->pins[0];
   251		     i < ARRAY_SIZE(ns_pinctrl_pins); i++) {
   252			const struct pinctrl_pin_desc *src = &ns_pinctrl_pins[i];
   253			unsigned int chipsets = (uintptr_t)src->drv_data;
   254	
   255			if (chipsets & ns_pinctrl->chipset_flag) {
   256				memcpy(pin++, src, sizeof(*src));
   257				pctldesc->npins++;
   258			}
   259		}
   260	
   261		/* Register */
   262	
   263		ns_pinctrl->pctldev = devm_pinctrl_register(dev, pctldesc, ns_pinctrl);
   264		if (IS_ERR(ns_pinctrl->pctldev)) {
   265			dev_err(dev, "Failed to register pinctrl\n");
   266			return PTR_ERR(ns_pinctrl->pctldev);
   267		}
   268	
   269		for (i = 0; i < ARRAY_SIZE(ns_pinctrl_groups); i++) {
   270			const struct ns_pinctrl_group *group = &ns_pinctrl_groups[i];
   271	
   272			if (!(group->chipsets & ns_pinctrl->chipset_flag))
   273				continue;
   274	
   275			pinctrl_generic_add_group(ns_pinctrl->pctldev, group->name,
   276						  group->pins, group->num_pins, NULL);
   277		}
   278	
   279		for (i = 0; i < ARRAY_SIZE(ns_pinctrl_functions); i++) {
   280			const struct ns_pinctrl_function *function = &ns_pinctrl_functions[i];
   281	
   282			if (!(function->chipsets & ns_pinctrl->chipset_flag))
   283				continue;
   284	
   285			pinmux_generic_add_function(ns_pinctrl->pctldev, function->name,
 > 286						    function->groups,
   287						    function->num_groups, NULL);
   288		}
   289	
   290		return 0;
   291	}
   292	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
