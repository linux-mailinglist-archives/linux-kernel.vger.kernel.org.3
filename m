Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E298F53D909
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 03:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbiFEBR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiFEBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 21:17:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979EDF4E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 18:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654391845; x=1685927845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+9SmauaC50SGMWqDNTH6YEIYCMPjxm85swtliW3l4iY=;
  b=dYy4lAz9KUFALd8E2MiILBb//NKuUu9Y3tUKraUAxe0r2tGsqiT+/NH6
   xryyIsI1y9aJOKPBIOmRXEkfQutdWI+hSJC0JysQ1txQxs4ytzUMDLgHL
   2kFGl29d+rKrXc0Jft/yOi3ABPRqn8XhXJRlsM+9XAkQpiNIJeb5F8TYX
   YEGf94LyMdR6+y42v9eJ5aUx0H2eX+pMHP/LEbwEe4S5kJs+d+vinwTYs
   lCJrdX7Q8ohkn59nBNC2OVxQ6ltjdoEZM2sd5xBjDSU/jKQgk1Dg12U8R
   987ewxYkvGjmANmXEcybr4QOkXcURZLCV4eAXggefHH7yJqI+upI+r0OT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="274061219"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="274061219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 18:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="564331304"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2022 18:17:22 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxetO-000BLB-7Y;
        Sun, 05 Jun 2022 01:17:22 +0000
Date:   Sun, 5 Jun 2022 09:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [asahilinux:bits/050-nvme 4/9] drivers/soc/apple/sart.c:248:4:
 warning: format specifies type 'unsigned long long' but the argument has
 type 'phys_addr_t' (aka 'unsigned int')
Message-ID: <202206050943.yFqgZDBn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/050-nvme
head:   54dfe8ce63a23f4a11e9aa0481a09a6ec2267b2f
commit: 96470149f537ee4410acef69bb8a38d806fc98c1 [4/9] soc: apple: Add SART driver
config: hexagon-randconfig-r041-20220605 (https://download.01.org/0day-ci/archive/20220605/202206050943.yFqgZDBn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/96470149f537ee4410acef69bb8a38d806fc98c1
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/050-nvme
        git checkout 96470149f537ee4410acef69bb8a38d806fc98c1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/soc/apple/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/apple/sart.c:248:4: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                    paddr, size);
                    ^~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   drivers/soc/apple/sart.c:284:4: warning: format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Wformat]
                    paddr, size);
                    ^~~~~
   include/linux/dev_printk.h:146:70: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +248 drivers/soc/apple/sart.c

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
   247			 "no free entries left to add [paddr: 0x%llx, size: 0x%zx]\n",
 > 248			 paddr, size);
   249	
   250		return -EBUSY;
   251	}
   252	EXPORT_SYMBOL(apple_sart_add_allowed_region);
   253	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
