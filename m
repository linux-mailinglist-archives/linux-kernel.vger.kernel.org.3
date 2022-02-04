Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAB4A9F83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377757AbiBDSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:50:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:53933 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347727AbiBDSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:50:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644000642; x=1675536642;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o1K1uV/hMeSpUytiWvlE9GEbQToDadKm/dWWrO3/09Q=;
  b=hWGeMFMp8UIGZbx8X+5X71atB1NtPoJHaHicQGPxUZEnHMVaf0wZGaT1
   OYOg/A0lLla+iiX1keWr2Bwes3I//lD2AsRg6KMXwNNTmtCzSawjSMMZi
   nyMARyEtNMkYp0h7qFO9f0NHC3JS3TW9kSVU6LJ6EtEMiEILdsXqICSfq
   IfXwlrdg3BGNiLDv+pm+7qgZ8BMEy+tLJ3qI+QhpHLI7uiJb02MxY+pzb
   h+uSdbFZVM3zJ3vnzH9dLRwxAYvPOwOj6h3+ITc+rb8sMjyfYX1L09Ywg
   mB5WCC5koKRCvksL4xEtFLCK5/RAubZzGsiK0MdaEF4K/rrrxlZGZ9M7q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272925739"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="272925739"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 10:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="772170961"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2022 10:50:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG3fM-000Y1R-4Q; Fri, 04 Feb 2022 18:50:40 +0000
Date:   Sat, 5 Feb 2022 02:49:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:smc/work 9/11] include/linux/export.h:67:43: error:
 redefinition of '__ksymtab_apple_smc_write'
Message-ID: <202202050259.BKTS2NwP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux smc/work
head:   fc848a39b71518ca1661de7057b87cb0e8cac9f9
commit: a429c9bbeba2b08856339793bd4a0d1a65a730a1 [9/11] platform/apple: Add new Apple Mac SMC driver
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220205/202202050259.BKTS2NwP-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/a429c9bbeba2b08856339793bd4a0d1a65a730a1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux smc/work
        git checkout a429c9bbeba2b08856339793bd4a0d1a65a730a1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/platform/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_core.c:7:
>> include/linux/export.h:67:43: error: redefinition of '__ksymtab_apple_smc_write'
      67 |         static const struct kernel_symbol __ksymtab_##sym               \
         |                                           ^~~~~~~~~~
   include/linux/export.h:108:9: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |         __KSYMTAB_ENTRY(sym, sec)
         |         ^~~~~~~~~~~~~~~
   include/linux/export.h:152:41: note: in expansion of macro '___EXPORT_SYMBOL'
     152 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/export.h:160:41: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:163:41: note: in expansion of macro '_EXPORT_SYMBOL'
     163 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   drivers/platform/apple/smc_core.c:69:1: note: in expansion of macro 'EXPORT_SYMBOL'
      69 | EXPORT_SYMBOL(apple_smc_write);
         | ^~~~~~~~~~~~~
   include/linux/export.h:67:43: note: previous definition of '__ksymtab_apple_smc_write' with type 'const struct kernel_symbol'
      67 |         static const struct kernel_symbol __ksymtab_##sym               \
         |                                           ^~~~~~~~~~
   include/linux/export.h:108:9: note: in expansion of macro '__KSYMTAB_ENTRY'
     108 |         __KSYMTAB_ENTRY(sym, sec)
         |         ^~~~~~~~~~~~~~~
   include/linux/export.h:152:41: note: in expansion of macro '___EXPORT_SYMBOL'
     152 | #define __EXPORT_SYMBOL(sym, sec, ns)   ___EXPORT_SYMBOL(sym, sec, ns)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/export.h:160:41: note: in expansion of macro '__EXPORT_SYMBOL'
     160 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "")
         |                                         ^~~~~~~~~~~~~~~
   include/linux/export.h:163:41: note: in expansion of macro '_EXPORT_SYMBOL'
     163 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   drivers/platform/apple/smc_core.c:56:1: note: in expansion of macro 'EXPORT_SYMBOL'
      56 | EXPORT_SYMBOL(apple_smc_write);
         | ^~~~~~~~~~~~~
>> drivers/platform/apple/smc_core.c:135:1: error: expected ',' or ';' before 'struct'
     135 | struct apple_smc *apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops, void *cookie)
         | ^~~~~~
   drivers/platform/apple/smc_core.c:25:30: warning: 'apple_smc_devs' defined but not used [-Wunused-const-variable=]
      25 | static const struct mfd_cell apple_smc_devs[] = {
         |                              ^~~~~~~~~~~~~~
--
   drivers/platform/apple/smc_rtkit.c: In function 'apple_smc_cmd':
>> drivers/platform/apple/smc_rtkit.c:69:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      69 |         msg = (FIELD_PREP(SMC_MSG, cmd) |
         |                ^~~~~~~~~~
>> drivers/platform/apple/smc_rtkit.c:85:13: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      85 |         if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
         |             ^~~~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/platform/apple/smc_rtkit.c:8:
   drivers/platform/apple/smc_rtkit.c: At top level:
>> drivers/platform/apple/smc_rtkit.c:332:25: error: 'apple_smc_of_match' undeclared here (not in a function); did you mean 'apple_smc_rtkit_of_match'?
     332 | MODULE_DEVICE_TABLE(of, apple_smc_of_match);
         |                         ^~~~~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__apple_smc_of_match_device_table' aliased to undefined symbol 'apple_smc_of_match'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/platform/apple/smc_rtkit.c:332:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     332 | MODULE_DEVICE_TABLE(of, apple_smc_of_match);
         | ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__ksymtab_apple_smc_write +67 include/linux/export.h

f50169324df4ad9 Paul Gortmaker    2011-05-23  41  
7290d58095712a8 Ard Biesheuvel    2018-08-21  42  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
7290d58095712a8 Ard Biesheuvel    2018-08-21  43  #include <linux/compiler.h>
7290d58095712a8 Ard Biesheuvel    2018-08-21  44  /*
7290d58095712a8 Ard Biesheuvel    2018-08-21  45   * Emit the ksymtab entry as a pair of relative references: this reduces
7290d58095712a8 Ard Biesheuvel    2018-08-21  46   * the size by half on 64-bit architectures, and eliminates the need for
7290d58095712a8 Ard Biesheuvel    2018-08-21  47   * absolute relocations that require runtime processing on relocatable
7290d58095712a8 Ard Biesheuvel    2018-08-21  48   * kernels.
7290d58095712a8 Ard Biesheuvel    2018-08-21  49   */
7290d58095712a8 Ard Biesheuvel    2018-08-21  50  #define __KSYMTAB_ENTRY(sym, sec)					\
7290d58095712a8 Ard Biesheuvel    2018-08-21  51  	__ADDRESSABLE(sym)						\
7290d58095712a8 Ard Biesheuvel    2018-08-21  52  	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
ed13fc33f763035 Matthias Maennich 2019-09-06  53  	    "	.balign	4					\n"	\
7290d58095712a8 Ard Biesheuvel    2018-08-21  54  	    "__ksymtab_" #sym ":				\n"	\
7290d58095712a8 Ard Biesheuvel    2018-08-21  55  	    "	.long	" #sym "- .				\n"	\
7290d58095712a8 Ard Biesheuvel    2018-08-21  56  	    "	.long	__kstrtab_" #sym "- .			\n"	\
c3a6cf19e695c8b Masahiro Yamada   2019-10-18  57  	    "	.long	__kstrtabns_" #sym "- .			\n"	\
7290d58095712a8 Ard Biesheuvel    2018-08-21  58  	    "	.previous					\n")
7290d58095712a8 Ard Biesheuvel    2018-08-21  59  
7290d58095712a8 Ard Biesheuvel    2018-08-21  60  struct kernel_symbol {
7290d58095712a8 Ard Biesheuvel    2018-08-21  61  	int value_offset;
7290d58095712a8 Ard Biesheuvel    2018-08-21  62  	int name_offset;
8651ec01daedad2 Matthias Maennich 2019-09-06  63  	int namespace_offset;
7290d58095712a8 Ard Biesheuvel    2018-08-21  64  };
7290d58095712a8 Ard Biesheuvel    2018-08-21  65  #else
7290d58095712a8 Ard Biesheuvel    2018-08-21  66  #define __KSYMTAB_ENTRY(sym, sec)					\
7290d58095712a8 Ard Biesheuvel    2018-08-21 @67  	static const struct kernel_symbol __ksymtab_##sym		\
7290d58095712a8 Ard Biesheuvel    2018-08-21  68  	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
ed13fc33f763035 Matthias Maennich 2019-09-06  69  	__aligned(sizeof(void *))					\
c3a6cf19e695c8b Masahiro Yamada   2019-10-18  70  	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
7290d58095712a8 Ard Biesheuvel    2018-08-21  71  

:::::: The code at line 67 was first introduced by commit
:::::: 7290d58095712a89f845e1bca05334796dd49ed2 module: use relative references for __ksymtab entries

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
