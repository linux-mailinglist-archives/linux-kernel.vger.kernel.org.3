Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F24DEA45
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 20:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbiCSTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbiCSTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 15:04:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F5713D68
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647716612; x=1679252612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MVOwVbmbHPN6GDl799mE/hFNyK635h6rErdS/6yWJgk=;
  b=g+hkOIJ83aJ6Tw9GjvUMWHZDeQB05fE80hf5vRGAOeE1yye4D0/HPdUl
   +HpbXJvBoDYYnq3pKnBmOc8j8J8BPWDBSNkHu2l3sLCsLIHipID3oSjZA
   zTjAm2POi/6G7ju2jaOUvmMvGQcB0dpHbYfL4i8SJjtWBnz2bOgrLrT8W
   E5YBNwqukpbaoN7Gkz2g23YO8PqNA29G8zK+zEbWSQu1cBr6X0ci8Vgo/
   XleCVceioNEcBwNtPoNgQ2W3Ks+ipgPrAMti9CqjN204vD/UwkzuiYOLU
   vkad98t4uIT7KQIVzRCbRGbI3y5nUhJDgQakpy6BwDrfeAFMYfVvsDPI7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237265205"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="237265205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 12:03:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="715958318"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2022 12:03:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVeMK-000GDr-68; Sat, 19 Mar 2022 19:03:28 +0000
Date:   Sun, 20 Mar 2022 03:03:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:nvme-rfc 4/12] drivers/soc/apple/sart.c:70:18: error:
 implicit declaration of function 'FIELD_GET'
Message-ID: <202203200221.1Ai955oJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-rfc
head:   668a74289aa4cdde7d55e4f602043ece670ea71c
commit: 75717c92a144d9fd0f94ddeed76f158ef14b83d7 [4/12] soc: apple: Add SART driver
config: parisc-randconfig-r011-20220320 (https://download.01.org/0day-ci/archive/20220320/202203200221.1Ai955oJ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/75717c92a144d9fd0f94ddeed76f158ef14b83d7
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-rfc
        git checkout 75717c92a144d9fd0f94ddeed76f158ef14b83d7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/soc/apple/sart.c: In function 'sart2_get_entry':
>> drivers/soc/apple/sart.c:70:18: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
      70 |         *flags = FIELD_GET(APPLE_SART2_CONFIG_FLAGS, cfg);
         |                  ^~~~~~~~~
   drivers/soc/apple/sart.c: In function 'sart2_set_entry':
>> drivers/soc/apple/sart.c:94:15: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
      94 |         cfg = FIELD_PREP(APPLE_SART2_CONFIG_FLAGS, flags);
         |               ^~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/soc/apple/sart.h:15,
                    from drivers/soc/apple/sart.c:14:
   drivers/soc/apple/sart.c: In function 'apple_sart_probe':
   drivers/soc/apple/sart.c:173:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     173 |                         "SART bootloader entry: index %02d; flags: 0x%02x; paddr: 0x%llx; size: 0x%zx\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                             ^~~~~~~
   drivers/soc/apple/sart.c:172:17: note: in expansion of macro 'dev_dbg'
     172 |                 dev_dbg(sart->dev,
         |                 ^~~~~~~
   drivers/soc/apple/sart.c:173:88: note: format string is defined here
     173 |                         "SART bootloader entry: index %02d; flags: 0x%02x; paddr: 0x%llx; size: 0x%zx\n",
         |                                                                                     ~~~^
         |                                                                                        |
         |                                                                                        long long unsigned int
         |                                                                                     %x
   In file included from include/linux/device.h:15,
                    from include/linux/soc/apple/sart.h:15,
                    from drivers/soc/apple/sart.c:14:
   drivers/soc/apple/sart.c: In function 'apple_sart_add_allowed_region':
   drivers/soc/apple/sart.c:224:33: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     224 |                                 "unable to set entry %d to [0x%llx, 0x%zx]\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                             ^~~~~~~
   drivers/soc/apple/sart.c:223:25: note: in expansion of macro 'dev_dbg'
     223 |                         dev_dbg(sart->dev,
         |                         ^~~~~~~
   drivers/soc/apple/sart.c:224:66: note: format string is defined here
     224 |                                 "unable to set entry %d to [0x%llx, 0x%zx]\n",
         |                                                               ~~~^
         |                                                                  |
         |                                                                  long long unsigned int
         |                                                               %x
   In file included from include/linux/device.h:15,
                    from include/linux/soc/apple/sart.h:15,
                    from drivers/soc/apple/sart.c:14:
   drivers/soc/apple/sart.c:230:36: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     230 |                 dev_dbg(sart->dev, "wrote [0x%llx, 0x%zx] to %d\n", paddr, size,
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
         |                                             ^~~~~~~
   drivers/soc/apple/sart.c:230:17: note: in expansion of macro 'dev_dbg'
     230 |                 dev_dbg(sart->dev, "wrote [0x%llx, 0x%zx] to %d\n", paddr, size,
         |                 ^~~~~~~
   drivers/soc/apple/sart.c:230:49: note: format string is defined here
     230 |                 dev_dbg(sart->dev, "wrote [0x%llx, 0x%zx] to %d\n", paddr, size,
         |                                              ~~~^
         |                                                 |
         |                                                 long long unsigned int
         |                                              %x
   In file included from include/linux/device.h:15,
                    from include/linux/soc/apple/sart.h:15,
                    from drivers/soc/apple/sart.c:14:
   drivers/soc/apple/sart.c:236:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     236 |                  "no free entries left to add [paddr: 0x%llx, size: 0x%zx]\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/soc/apple/sart.c:235:9: note: in expansion of macro 'dev_warn'
     235 |         dev_warn(sart->dev,
         |         ^~~~~~~~
   drivers/soc/apple/sart.c:236:60: note: format string is defined here
     236 |                  "no free entries left to add [paddr: 0x%llx, size: 0x%zx]\n",
         |                                                         ~~~^
         |                                                            |
         |                                                            long long unsigned int
         |                                                         %x
   In file included from include/linux/device.h:15,
                    from include/linux/soc/apple/sart.h:15,
                    from drivers/soc/apple/sart.c:14:
   drivers/soc/apple/sart.c: In function 'apple_sart_remove_allowed_region':
   drivers/soc/apple/sart.c:249:17: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     249 |                 "will remove [paddr: 0x%llx, size: 0x%zx] from allowed regions\n",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
     129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
         |                                         ^~~
   include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
     163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \


vim +/FIELD_GET +70 drivers/soc/apple/sart.c

    65	
    66	static void sart2_get_entry(struct apple_sart *sart, int index, u8 *flags,
    67				    phys_addr_t *paddr, size_t *size)
    68	{
    69		u32 cfg = readl_relaxed(sart->regs + APPLE_SART2_CONFIG(index));
  > 70		*flags = FIELD_GET(APPLE_SART2_CONFIG_FLAGS, cfg);
    71		*size = (size_t)FIELD_GET(APPLE_SART2_CONFIG_SIZE, cfg)
    72			<< APPLE_SART2_CONFIG_SIZE_SHIFT;
    73		*paddr = (phys_addr_t)readl_relaxed(sart->regs +
    74						    APPLE_SART2_PADDR(index))
    75			 << APPLE_SART2_PADDR_SHIFT;
    76	}
    77	
    78	static int sart2_set_entry(struct apple_sart *sart, int index, u8 flags,
    79				   phys_addr_t paddr, size_t size)
    80	{
    81		u32 cfg;
    82	
    83		if (size & ((1 << APPLE_SART2_CONFIG_SIZE_SHIFT) - 1))
    84			return -EINVAL;
    85		if (paddr & ((1 << APPLE_SART2_PADDR_SHIFT) - 1))
    86			return -EINVAL;
    87	
    88		size >>= APPLE_SART2_CONFIG_SIZE_SHIFT;
    89		paddr >>= APPLE_SART2_PADDR_SHIFT;
    90	
    91		if (size > APPLE_SART2_CONFIG_SIZE_MAX)
    92			return -EINVAL;
    93	
  > 94		cfg = FIELD_PREP(APPLE_SART2_CONFIG_FLAGS, flags);
    95		cfg |= FIELD_PREP(APPLE_SART2_CONFIG_SIZE, size);
    96	
    97		writel_relaxed(paddr, sart->regs + APPLE_SART2_PADDR(index));
    98		writel_relaxed(cfg, sart->regs + APPLE_SART2_CONFIG(index));
    99	
   100		return 0;
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
