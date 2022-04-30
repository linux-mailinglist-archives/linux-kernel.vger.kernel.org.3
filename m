Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0C515A3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 06:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbiD3EED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 00:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbiD3ED5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:03:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3869618B1F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651291235; x=1682827235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PYRMwKZ7bWbe9G5Ghmd798FLgNzoEFpMpjbnkuG1rcA=;
  b=T1u767vSs2GbAkexFmtcPpskrs0jaCcbqaN7mfGmBW0ALQtrbvkkBon+
   rsEDGiO0Rtn+4vL7bCthDu+qHHiN07e9A+3PcoSYdKcEqvTyPutd1iDq2
   0McoT+CcU6vf7m1zWwO1ymUKfy6lNo8UCj+gwKOVz18D5zQsfA8KZMYG7
   Khb/gQ/NrPNnGy++fL46hGs2iAnbDuzrwu6Hgw5/bLejDMHomj1uR/To7
   OtGe376c5b7FgfiV6uEgSmgibi0XTZyjtYQwsiLKCeW0C48iPnJMgXImJ
   JsnADYiLbmWAJ+2wg1PxdY+NNsaHoi2Ssh6TmnFcL26KwoWoHC7ynXaeg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264415321"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="264415321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 21:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="686039233"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2022 21:00:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkeHY-0006r1-Iu;
        Sat, 30 Apr 2022 04:00:32 +0000
Date:   Sat, 30 Apr 2022 12:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:nvme-v3 4/6] drivers/soc/apple/sart.c:247:18: warning:
 format '%llx' expects argument of type 'long long unsigned int', but
 argument 3 has type 'phys_addr_t' {aka 'unsigned int'}
Message-ID: <202204301124.xCHwrb3R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-v3
head:   ab2e9498dde5a82fa515c5278335de404de4df63
commit: 18cb959d4f944bb410711eda2ff3b5d4eb872b7c [4/6] soc: apple: Add SART driver
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20220430/202204301124.xCHwrb3R-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/18cb959d4f944bb410711eda2ff3b5d4eb872b7c
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-v3
        git checkout 18cb959d4f944bb410711eda2ff3b5d4eb872b7c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/netdevsim/ drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/soc/apple/sart.h:15,
                    from drivers/soc/apple/sart.c:14:
   drivers/soc/apple/sart.c: In function 'apple_sart_add_allowed_region':
>> drivers/soc/apple/sart.c:247:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     247 |                  "no free entries left to add [paddr: 0x%llx, size: 0x%zx]\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/soc/apple/sart.c:246:9: note: in expansion of macro 'dev_warn'
     246 |         dev_warn(sart->dev,
         |         ^~~~~~~~
   drivers/soc/apple/sart.c:247:60: note: format string is defined here
     247 |                  "no free entries left to add [paddr: 0x%llx, size: 0x%zx]\n",
         |                                                         ~~~^
         |                                                            |
         |                                                            long long unsigned int
         |                                                         %x
   In file included from include/linux/device.h:15,
                    from include/linux/soc/apple/sart.h:15,
                    from drivers/soc/apple/sart.c:14:
   drivers/soc/apple/sart.c: In function 'apple_sart_remove_allowed_region':
   drivers/soc/apple/sart.c:283:29: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     283 |         dev_warn(sart->dev, "entry [paddr: 0x%llx, size: 0x%zx] not found\n",
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:146:61: note: in expansion of macro 'dev_fmt'
     146 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/soc/apple/sart.c:283:9: note: in expansion of macro 'dev_warn'
     283 |         dev_warn(sart->dev, "entry [paddr: 0x%llx, size: 0x%zx] not found\n",
         |         ^~~~~~~~
   drivers/soc/apple/sart.c:283:49: note: format string is defined here
     283 |         dev_warn(sart->dev, "entry [paddr: 0x%llx, size: 0x%zx] not found\n",
         |                                              ~~~^
         |                                                 |
         |                                                 long long unsigned int
         |                                              %x


vim +247 drivers/soc/apple/sart.c

   219	
   220	int apple_sart_add_allowed_region(struct apple_sart *sart, phys_addr_t paddr,
   221					  size_t size)
   222	{
   223		int i, ret;
   224	
   225		for (i = 0; i < APPLE_SART_MAX_ENTRIES; ++i) {
   226			if (test_bit(i, &sart->protected_entries))
   227				continue;
   228			if (test_and_set_bit(i, &sart->used_entries))
   229				continue;
   230	
   231			ret = sart_set_entry(sart, i, APPLE_SART_FLAGS_ALLOW, paddr,
   232					     size);
   233			if (ret) {
   234				dev_dbg(sart->dev,
   235					"unable to set entry %d to [%pa, 0x%zx]\n",
   236					i, &paddr, size);
   237				clear_bit(i, &sart->used_entries);
   238				return ret;
   239			}
   240	
   241			dev_dbg(sart->dev, "wrote [%pa, 0x%zx] to %d\n", &paddr, size,
   242				i);
   243			return 0;
   244		}
   245	
   246		dev_warn(sart->dev,
 > 247			 "no free entries left to add [paddr: 0x%llx, size: 0x%zx]\n",
   248			 paddr, size);
   249	
   250		return -EBUSY;
   251	}
   252	EXPORT_SYMBOL(apple_sart_add_allowed_region);
   253	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
