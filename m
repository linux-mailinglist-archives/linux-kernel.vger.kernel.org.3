Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B49463C28
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244306AbhK3QtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:49:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:33874 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233320AbhK3QtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:49:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223485227"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="223485227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:46:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="458902134"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Nov 2021 08:46:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms6GW-000DXz-MB; Tue, 30 Nov 2021 16:46:00 +0000
Date:   Wed, 1 Dec 2021 00:45:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:randconfig-5.16-min 165/191]
 drivers/usb/host/fhci.h:245:26: error: array type has incomplete element
 type 'struct gpio_desc'
Message-ID: <202112010005.F7PgW900-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git randconfig-5.16-min
head:   7a16665b8fd19f170c0c15f1432c90e4750183f2
commit: d072f346046db778b5a416898383e8a1bb860aa6 [165/191] replace most of_gpio_get
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20211201/202112010005.F7PgW900-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=d072f346046db778b5a416898383e8a1bb860aa6
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground randconfig-5.16-min
        git checkout d072f346046db778b5a416898383e8a1bb860aa6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/usb/host/fhci-hcd.c:32:
>> drivers/usb/host/fhci.h:245:26: error: array type has incomplete element type 'struct gpio_desc'
     245 |         struct gpio_desc gpios[NUM_GPIOS];
         |                          ^~~~~
   In file included from include/linux/device.h:15,
                    from arch/powerpc/include/asm/io.h:27,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/usb/host/fhci-hcd.c:21:
   drivers/usb/host/fhci-hcd.c: In function 'of_fhci_probe':
>> drivers/usb/host/fhci-hcd.c:636:67: error: 'gpio' undeclared (first use in this function)
     636 |                         dev_err(dev, "incorrect GPIO%d: %d\n", i, gpio);
         |                                                                   ^~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/usb/host/fhci-hcd.c:636:25: note: in expansion of macro 'dev_err'
     636 |                         dev_err(dev, "incorrect GPIO%d: %d\n", i, gpio);
         |                         ^~~~~~~
   drivers/usb/host/fhci-hcd.c:636:67: note: each undeclared identifier is reported only once for each function it appears in
     636 |                         dev_err(dev, "incorrect GPIO%d: %d\n", i, gpio);
         |                                                                   ^~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/usb/host/fhci-hcd.c:636:25: note: in expansion of macro 'dev_err'
     636 |                         dev_err(dev, "incorrect GPIO%d: %d\n", i, gpio);
         |                         ^~~~~~~
--
   In file included from drivers/usb/host/fhci-hub.c:24:
>> drivers/usb/host/fhci.h:245:26: error: array type has incomplete element type 'struct gpio_desc'
     245 |         struct gpio_desc gpios[NUM_GPIOS];
         |                          ^~~~~


vim +245 drivers/usb/host/fhci.h

   240	
   241	struct fhci_hcd {
   242		enum qe_clock fullspeed_clk;
   243		enum qe_clock lowspeed_clk;
   244		struct qe_pin *pins[NUM_PINS];
 > 245		struct gpio_desc gpios[NUM_GPIOS];
   246	
   247		struct qe_usb_ctlr __iomem *regs; /* I/O memory used to communicate */
   248		struct fhci_pram __iomem *pram;	/* Parameter RAM */
   249		struct gtm_timer *timer;
   250	
   251		spinlock_t lock;
   252		struct fhci_usb *usb_lld; /* Low-level driver */
   253		struct virtual_root_hub *vroot_hub; /* the virtual root hub */
   254		int active_urbs;
   255		struct fhci_controller_list *hc_list;
   256		struct tasklet_struct *process_done_task; /* tasklet for done list */
   257	
   258		struct list_head empty_eds;
   259		struct list_head empty_tds;
   260	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
