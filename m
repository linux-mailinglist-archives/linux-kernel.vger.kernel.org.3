Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD548D022
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiAMB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:29:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:33454 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbiAMB32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642037368; x=1673573368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l2M044q/bbtvrFp79xYX0GZb+kgV5O5IYjhh74Dnvnc=;
  b=LOIozGpFI0TqUc9lBNfy7T3hRx9+OLWmVmlhJYtOVRwZeNsF0ro87jsa
   Fiu6awXCvCK4Bg9K9v21OHvDbrCLZG7QFG/AsRcZsxktNkfURdRCO/gNO
   suYus2uUqCzQqL/Ewy2WVnv69K1KSxeibPgmojkUyZrkAZzkQoRyhDBCu
   yyTaS+AyxW/p4zlcD8uBBDfxUGEFgSyz/0wmiBS4OMyWhvrHG18qJABoA
   ohqruzD2J3i0i+U/m0p5Y1wLV10fViG789gvbfUryLE1vM5SXwCQ8+dOD
   ihGF52ateaEpBKqECgZ4Qe3JY7WtOiR2R9/2NOHOtDqSPD+zLSOr4DjLq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="268251655"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="268251655"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:29:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="765397632"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2022 17:29:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7ovd-0006fl-Jv; Thu, 13 Jan 2022 01:29:25 +0000
Date:   Thu, 13 Jan 2022 09:28:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: drivers/leds/simple/simatic-ipc-leds.c:42:17: sparse: sparse: symbol
 'simatic_ipc_led_mem_res' was not declared. Should it be static?
Message-ID: <202201130807.DvdFeysr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f079ab01b5609fb0c9acc52c88168bf1eed82373
commit: 8c78e0614edc628b13313afd28856720b85d86a3 leds: simatic-ipc-leds: add new driver for Siemens Industial PCs
date:   3 weeks ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220113/202201130807.DvdFeysr-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c78e0614edc628b13313afd28856720b85d86a3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8c78e0614edc628b13313afd28856720b85d86a3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/simple/ drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/leds/simple/simatic-ipc-leds.c:42:17: sparse: sparse: symbol 'simatic_ipc_led_mem_res' was not declared. Should it be static?
>> drivers/leds/simple/simatic-ipc-leds.c:155:40: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *static [toplevel] simatic_ipc_led_memory @@     got void [noderef] __iomem * @@
   drivers/leds/simple/simatic-ipc-leds.c:155:40: sparse:     expected void *static [toplevel] simatic_ipc_led_memory
   drivers/leds/simple/simatic-ipc-leds.c:155:40: sparse:     got void [noderef] __iomem *

vim +/simatic_ipc_led_mem_res +42 drivers/leds/simple/simatic-ipc-leds.c

    40	
    41	/* the actual start will be discovered with PCI, 0 is a placeholder */
  > 42	struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, SZ_4K, KBUILD_MODNAME);
    43	
    44	static void *simatic_ipc_led_memory;
    45	
    46	static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
    47		{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
    48		{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
    49		{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
    50		{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
    51		{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
    52		{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
    53		{ }
    54	};
    55	
    56	static struct resource simatic_ipc_led_io_res =
    57		DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2, KBUILD_MODNAME);
    58	
    59	static DEFINE_SPINLOCK(reg_lock);
    60	
    61	static inline struct simatic_ipc_led *cdev_to_led(struct led_classdev *led_cd)
    62	{
    63		return container_of(led_cd, struct simatic_ipc_led, cdev);
    64	}
    65	
    66	static void simatic_ipc_led_set_io(struct led_classdev *led_cd,
    67					   enum led_brightness brightness)
    68	{
    69		struct simatic_ipc_led *led = cdev_to_led(led_cd);
    70		unsigned long flags;
    71		unsigned int val;
    72	
    73		spin_lock_irqsave(&reg_lock, flags);
    74	
    75		val = inw(SIMATIC_IPC_LED_PORT_BASE);
    76		if (brightness == LED_OFF)
    77			outw(val | led->value, SIMATIC_IPC_LED_PORT_BASE);
    78		else
    79			outw(val & ~led->value, SIMATIC_IPC_LED_PORT_BASE);
    80	
    81		spin_unlock_irqrestore(&reg_lock, flags);
    82	}
    83	
    84	static enum led_brightness simatic_ipc_led_get_io(struct led_classdev *led_cd)
    85	{
    86		struct simatic_ipc_led *led = cdev_to_led(led_cd);
    87	
    88		return inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF : led_cd->max_brightness;
    89	}
    90	
    91	static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
    92					    enum led_brightness brightness)
    93	{
    94		struct simatic_ipc_led *led = cdev_to_led(led_cd);
    95	
    96		u32 *p;
    97	
    98		p = simatic_ipc_led_memory + led->value;
    99		*p = (*p & ~1) | (brightness == LED_OFF);
   100	}
   101	
   102	static enum led_brightness simatic_ipc_led_get_mem(struct led_classdev *led_cd)
   103	{
   104		struct simatic_ipc_led *led = cdev_to_led(led_cd);
   105	
   106		u32 *p;
   107	
   108		p = simatic_ipc_led_memory + led->value;
   109		return (*p & 1) ? LED_OFF : led_cd->max_brightness;
   110	}
   111	
   112	static int simatic_ipc_leds_probe(struct platform_device *pdev)
   113	{
   114		const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
   115		struct device *dev = &pdev->dev;
   116		struct simatic_ipc_led *ipcled;
   117		struct led_classdev *cdev;
   118		struct resource *res;
   119		int err, type;
   120		u32 *p;
   121	
   122		switch (plat->devmode) {
   123		case SIMATIC_IPC_DEVICE_227D:
   124		case SIMATIC_IPC_DEVICE_427E:
   125			res = &simatic_ipc_led_io_res;
   126			ipcled = simatic_ipc_leds_io;
   127			/* on 227D the two bytes work the other way araound */
   128			if (plat->devmode == SIMATIC_IPC_DEVICE_227D) {
   129				while (ipcled->value) {
   130					ipcled->value = swab16(ipcled->value);
   131					ipcled++;
   132				}
   133				ipcled = simatic_ipc_leds_io;
   134			}
   135			type = IORESOURCE_IO;
   136			if (!devm_request_region(dev, res->start, resource_size(res), KBUILD_MODNAME)) {
   137				dev_err(dev, "Unable to register IO resource at %pR\n", res);
   138				return -EBUSY;
   139			}
   140			break;
   141		case SIMATIC_IPC_DEVICE_127E:
   142			res = &simatic_ipc_led_mem_res;
   143			ipcled = simatic_ipc_leds_mem;
   144			type = IORESOURCE_MEM;
   145	
   146			/* get GPIO base from PCI */
   147			res->start = simatic_ipc_get_membase0(PCI_DEVFN(13, 0));
   148			if (res->start == 0)
   149				return -ENODEV;
   150	
   151			/* do the final address calculation */
   152			res->start = res->start + (0xC5 << 16);
   153			res->end += res->start;
   154	
 > 155			simatic_ipc_led_memory = devm_ioremap_resource(dev, res);
   156			if (IS_ERR(simatic_ipc_led_memory))
   157				return PTR_ERR(simatic_ipc_led_memory);
   158	
   159			/* initialize power/watchdog LED */
   160			p = simatic_ipc_led_memory + 0x500 + 0x1D8; /* PM_WDT_OUT */
   161			*p = (*p & ~1);
   162			p = simatic_ipc_led_memory + 0x500 + 0x1C0; /* PM_BIOS_BOOT_N */
   163			*p = (*p | 1);
   164	
   165			break;
   166		default:
   167			return -ENODEV;
   168		}
   169	
   170		while (ipcled->value) {
   171			cdev = &ipcled->cdev;
   172			if (type == IORESOURCE_MEM) {
   173				cdev->brightness_set = simatic_ipc_led_set_mem;
   174				cdev->brightness_get = simatic_ipc_led_get_mem;
   175			} else {
   176				cdev->brightness_set = simatic_ipc_led_set_io;
   177				cdev->brightness_get = simatic_ipc_led_get_io;
   178			}
   179			cdev->max_brightness = LED_ON;
   180			cdev->name = ipcled->name;
   181	
   182			err = devm_led_classdev_register(dev, cdev);
   183			if (err < 0)
   184				return err;
   185			ipcled++;
   186		}
   187	
   188		return 0;
   189	}
   190	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
