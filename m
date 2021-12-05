Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CEC468B0C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhLEN17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 08:27:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:54033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234108AbhLEN16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 08:27:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="323439563"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="323439563"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 05:24:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="678680398"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2021 05:24:29 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtrVF-000KAU-1A; Sun, 05 Dec 2021 13:24:29 +0000
Date:   Sun, 5 Dec 2021 21:23:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:asahi 55/56] drivers/pci/controller/pcie-apple.c:537:18:
 error: implicit declaration of function 'FIELD_PREP'
Message-ID: <202112052106.IiknpGPg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   69711d887d3f10a4f7dd6fd648bfff63ff66ba18
commit: 1dcce995852337e04880b91baef1994681d62f9c [55/56] PCI: apple: Configure link speeds properly
config: ia64-randconfig-r015-20211203 (https://download.01.org/0day-ci/archive/20211205/202112052106.IiknpGPg-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/1dcce995852337e04880b91baef1994681d62f9c
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 1dcce995852337e04880b91baef1994681d62f9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/gpu/drm/tiny/ drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/pcie-apple.c: In function 'apple_pcie_link_configure_max_speed':
>> drivers/pci/controller/pcie-apple.c:537:18: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     537 |         ctrl2 |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, max_gen);
         |                  ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/kallsyms.h:14,
                    from include/linux/ftrace.h:12,
                    from include/linux/kprobes.h:28,
                    from include/linux/kgdb.h:19,
                    from include/linux/fb.h:6,
                    from include/linux/platform_data/simplefb.h:12,
                    from drivers/gpu/drm/tiny/simpledrm.c:6:
>> include/linux/module.h:131:49: error: redefinition of '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/module.h:119:41: note: in expansion of macro 'module_init'
     119 | #define fs_initcall(fn)                 module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/gpu/drm/tiny/simpledrm.c:915:1: note: in expansion of macro 'fs_initcall'
     915 | fs_initcall(simplefb_init);
         | ^~~~~~~~~~~
   include/linux/module.h:131:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:263:1: note: in expansion of macro 'module_init'
     263 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/gpu/drm/tiny/simpledrm.c:899:1: note: in expansion of macro 'module_platform_driver'
     899 | module_platform_driver(simpledrm_platform_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:133:13: error: redefinition of 'init_module'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/module.h:119:41: note: in expansion of macro 'module_init'
     119 | #define fs_initcall(fn)                 module_init(fn)
         |                                         ^~~~~~~~~~~
   drivers/gpu/drm/tiny/simpledrm.c:915:1: note: in expansion of macro 'fs_initcall'
     915 | fs_initcall(simplefb_init);
         | ^~~~~~~~~~~
   include/linux/module.h:133:13: note: previous definition of 'init_module' with type 'int(void)'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:263:1: note: in expansion of macro 'module_init'
     263 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:252:9: note: in expansion of macro 'module_driver'
     252 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/gpu/drm/tiny/simpledrm.c:899:1: note: in expansion of macro 'module_platform_driver'
     899 | module_platform_driver(simpledrm_platform_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~


vim +/FIELD_PREP +537 drivers/pci/controller/pcie-apple.c

   523	
   524	static int apple_pcie_link_configure_max_speed(struct apple_pcie_port *port)
   525	{
   526		int max_gen;
   527		u32 ctrl2;
   528	
   529		max_gen = of_pci_get_max_link_speed(port->np);
   530		if (max_gen < 0) {
   531			dev_err(port->pcie->dev, "max link speed not specified\n");
   532			return max_gen;
   533		}
   534	
   535		ctrl2 = readw_relaxed(bridge_reg(port, PCIE_CAP_BASE + PCI_EXP_LNKCTL2));
   536		ctrl2 &= ~PCI_EXP_LNKCTL2_TLS;
 > 537		ctrl2 |= FIELD_PREP(PCI_EXP_LNKCTL2_TLS, max_gen);
   538		writew_relaxed(ctrl2, bridge_reg(port, PCIE_CAP_BASE + PCI_EXP_LNKCTL2));
   539	
   540		return 0;
   541	}
   542	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
