Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F34D3F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiCJCBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbiCJCBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:01:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2728447062
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646877613; x=1678413613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gcuiOh3w0jgfxzs61NDSlw6c5iU4egtYNjZYoDO0J+4=;
  b=XO26FxZWYpvcPZN7+odaCmHPTVr7fi8fXmP336IjtUBL2P9N6/V3L71c
   xroKmDYJi2tiydc9RNFFgPssltOKfi6NU7t5fzsYPLpt2kW5gOnZ2fpt9
   5AZ7aJ59faDfKkZko6G/Hkd0fs6MIXmTWap51cZb7bDb1+DcxmjCTpWsU
   CZt50Qvz+ut8ongjY+vMUj9cfqSMX2EeR4x6bpjaD4Kd95F3kbQ0/Wpne
   Wfk7g/t7sCAUxFJmdagIvHJZn0q8zGYBe9dU2+N65LRPEMwXTFgC4rmxj
   JA5XfgTFQZUgvTv7MWCE1FxdoROlPZKHImqOJhGxvCS3PpSF1mhGvEnqb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341567073"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="341567073"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 18:00:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="632828349"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2022 18:00:11 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS867-0004Ao-7v; Thu, 10 Mar 2022 02:00:11 +0000
Date:   Thu, 10 Mar 2022 09:59:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: include/linux/kern_levels.h:5:25: warning: format '%u' expects a
 matching 'unsigned int' argument
Message-ID: <202203100927.zuVzlGY0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 9dd78194a3722fa6712192cdd4f7032d45112a9a ARM: report Spectre v2 status through sysfs
date:   5 days ago
config: arm-randconfig-r023-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100927.zuVzlGY0-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9dd78194a3722fa6712192cdd4f7032d45112a9a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9dd78194a3722fa6712192cdd4f7032d45112a9a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:20,
                    from arch/arm/mm/proc-v7-bugs.c:3:
   arch/arm/mm/proc-v7-bugs.c: In function 'spectre_v2_install_workaround':
>> include/linux/kern_levels.h:5:25: warning: format '%u' expects a matching 'unsigned int' argument [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:523:9: note: in expansion of macro 'printk'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:523:16: note: in expansion of macro 'KERN_INFO'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   arch/arm/mm/proc-v7-bugs.c:111:9: note: in expansion of macro 'pr_info'
     111 |         pr_info("CPU%u: Spectre V2: workarounds disabled by configuration\n");
         |         ^~~~~~~
   arch/arm/mm/proc-v7-bugs.c: At top level:
   arch/arm/mm/proc-v7-bugs.c:205:6: warning: no previous prototype for 'cpu_v7_ca8_ibe' [-Wmissing-prototypes]
     205 | void cpu_v7_ca8_ibe(void)
         |      ^~~~~~~~~~~~~~
   arch/arm/mm/proc-v7-bugs.c:211:6: warning: no previous prototype for 'cpu_v7_ca15_ibe' [-Wmissing-prototypes]
     211 | void cpu_v7_ca15_ibe(void)
         |      ^~~~~~~~~~~~~~~
   arch/arm/mm/proc-v7-bugs.c:217:6: warning: no previous prototype for 'cpu_v7_bugs_init' [-Wmissing-prototypes]
     217 | void cpu_v7_bugs_init(void)
         |      ^~~~~~~~~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
