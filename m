Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F044E1E93
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbiCUBLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiCUBLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:11:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1217A2E8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647825024; x=1679361024;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fsjJq34rAU+mDpeCy34fQFnLsRo2UrwFwjjI8k4EnZk=;
  b=cov5TauZqURc2HWKRmaLTApZgDgvNKn9P2hl35bNUmXZQtvWitDlmWUJ
   jvKFyf2Xk2PHkDpKnk/UJDo0WbytxBVqWNDthfp6mAckbgHXpOQ8O51QK
   1SeyAVtwWAQjKEmY2lYqVxd4u+bp5lhS9zDexwBJ4xUUdGu5ycgVdQGTO
   J8nXkBQU/ef8jVQWPEgVWr80PoHfXJROI2QGS2bAuPbBtANi30xsUn11r
   /XAIOUrAP6I/W4BySbwahScQs82yWmpFEVEnHzbOXlkCjPK7cMCsy/TsI
   hX2WwzSkHR1tFFG0h+RYWXhdSwJnC/YLAFfSLBtSzlsmKBYfDhSEgXEYX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="237387886"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="237387886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 18:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="543010454"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2022 18:10:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW6Yv-000HLJ-E6; Mon, 21 Mar 2022 01:10:21 +0000
Date:   Mon, 21 Mar 2022 09:10:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [asahilinux:nvme-rfc 4/10] drivers/soc/apple/sart.c:175:14: warning:
 format specifies type 'unsigned long long' but the argument has type
 'phys_addr_t' (aka 'unsigned int')
Message-ID: <202203210914.Sqyrtli2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme-rfc
head:   822f7747e396aa35f280972b5f018c19b8dbc11c
commit: ca0f2729fc45ec18e49de08ffcadbb22f3ecc028 [4/10] soc: apple: Add SART driver
config: hexagon-buildonly-randconfig-r004-20220320 (https://download.01.org/0day-ci/archive/20220321/202203210914.Sqyrtli2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/ca0f2729fc45ec18e49de08ffcadbb22f3ecc028
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme-rfc
        git checkout ca0f2729fc45ec18e49de08ffcadbb22f3ecc028
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/apple/sart.c:175:14: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                           i, flags, paddr, size);
                                     ^~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/soc/apple/sart.c:226:8: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                                   i, paddr, size);
                                      ^~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/soc/apple/sart.c:231:55: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                   dev_dbg(sart->dev, "wrote [0x%llx, 0x%zx] to %d\n", paddr, size,
                                                ~~~~                   ^~~~~
                                                %x
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/soc/apple/sart.c:238:4: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                    paddr, size);
                    ^~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   drivers/soc/apple/sart.c:251:3: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                   paddr, size);
                   ^~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/soc/apple/sart.c:274:4: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                    paddr, size);
                    ^~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   6 warnings generated.


vim +175 drivers/soc/apple/sart.c

   145	
   146	static int apple_sart_probe(struct platform_device *pdev)
   147	{
   148		int i;
   149		struct apple_sart *sart;
   150		struct device *dev = &pdev->dev;
   151	
   152		sart = devm_kzalloc(dev, sizeof(*sart), GFP_KERNEL);
   153		if (!sart)
   154			return -ENOMEM;
   155	
   156		sart->dev = dev;
   157		sart->ops = of_device_get_match_data(dev);
   158	
   159		sart->regs = devm_platform_ioremap_resource(pdev, 0);
   160		if (IS_ERR(sart->regs))
   161			return PTR_ERR(sart->regs);
   162	
   163		for (i = 0; i < APPLE_SART_MAX_ENTRIES; ++i) {
   164			u8 flags;
   165			size_t size;
   166			phys_addr_t paddr;
   167	
   168			sart->ops->get_entry(sart, i, &flags, &paddr, &size);
   169	
   170			if (!flags)
   171				continue;
   172	
   173			dev_dbg(sart->dev,
   174				"SART bootloader entry: index %02d; flags: 0x%02x; paddr: 0x%llx; size: 0x%zx\n",
 > 175				i, flags, paddr, size);
   176			set_bit(i, &sart->protected_entries);
   177		}
   178	
   179		platform_set_drvdata(pdev, sart);
   180		return 0;
   181	}
   182	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
