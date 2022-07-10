Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E234056CC89
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 05:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGJDz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 23:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJDzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 23:55:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3681B7BF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 20:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657425353; x=1688961353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tw394z/xIBEzoScDq5DC/Tbbvl8zGSXtqytQmkdAJ1Y=;
  b=PCQ8aS2ILMH07PM2NS8f1P2qCuwEyDAUNlSC/I87s79+FVROiSdsOmr2
   GTpqsW+26C7gfigTdWGDm4xrw4/TWvdRfhK7+hyYBiY0Sj3WHeAYKyV1X
   5guhXE8Scnmuk/sFiJA5en4qXuA7wcLhaE9hWOMGNH9MRZs9nIcCgY+st
   iWRkB+z8Ba5BuDx/OFmkMw8mAa9QHR9MWZfpRW6s7v6ekVBCGYGxy8FWK
   OpTs+pflDoTD8MrOBp3MGG7lKzKqWqqfjmtnOoKALiyfTfI6irNB6J4+Z
   nu9CdUDU/iIH8hmYhQ1t5YVE1d+bNLR11cpyJxGIAQGIy9LRj4ODA3OYs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="282029699"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="282029699"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 20:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="544631883"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2022 20:55:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAO2w-000PRa-I1;
        Sun, 10 Jul 2022 03:55:50 +0000
Date:   Sun, 10 Jul 2022 11:55:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/watchdog/ar7_wdt.c:193:29: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202207101149.aY0HuHPC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b1c428b6c3684ee8ddf4137d68b3e8d51d2a700f
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   1 year, 3 months ago
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220710/202207101149.aY0HuHPC-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash block// drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/watchdog/ar7_wdt.c:193:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__p @@     got char const * @@
   drivers/watchdog/ar7_wdt.c:193:29: sparse:     expected char const [noderef] __user *__p
   drivers/watchdog/ar7_wdt.c:193:29: sparse:     got char const *
   drivers/watchdog/ar7_wdt.c:216:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct watchdog_info * @@
   drivers/watchdog/ar7_wdt.c:216:35: sparse:     expected void [noderef] __user *to
   drivers/watchdog/ar7_wdt.c:216:35: sparse:     got struct watchdog_info *
>> drivers/watchdog/ar7_wdt.c:222:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   drivers/watchdog/ar7_wdt.c:222:21: sparse:     expected int [noderef] __user *__p
   drivers/watchdog/ar7_wdt.c:222:21: sparse:     got int *
>> drivers/watchdog/ar7_wdt.c:229:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__p @@     got int * @@
   drivers/watchdog/ar7_wdt.c:229:21: sparse:     expected int const [noderef] __user *__p
   drivers/watchdog/ar7_wdt.c:229:21: sparse:     got int *
   drivers/watchdog/ar7_wdt.c:240:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   drivers/watchdog/ar7_wdt.c:240:21: sparse:     expected int [noderef] __user *__p
   drivers/watchdog/ar7_wdt.c:240:21: sparse:     got int *
   drivers/watchdog/ar7_wdt.c:250:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/ar7_wdt.c:250:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/ar7_wdt.c:250:27: sparse:     got int ( * )( ... )
   drivers/watchdog/ar7_wdt.c:270:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ar7_wdt *static [toplevel] ar7_wdt @@     got void [noderef] __iomem * @@
   drivers/watchdog/ar7_wdt.c:270:17: sparse:     expected struct ar7_wdt *static [toplevel] ar7_wdt
   drivers/watchdog/ar7_wdt.c:270:17: sparse:     got void [noderef] __iomem *

vim +193 drivers/watchdog/ar7_wdt.c

c283cf2c09ca1b Matteo Croce        2007-09-20  178  
c283cf2c09ca1b Matteo Croce        2007-09-20  179  static ssize_t ar7_wdt_write(struct file *file, const char *data,
c283cf2c09ca1b Matteo Croce        2007-09-20  180  			     size_t len, loff_t *ppos)
c283cf2c09ca1b Matteo Croce        2007-09-20  181  {
c283cf2c09ca1b Matteo Croce        2007-09-20  182  	/* check for a magic close character */
c283cf2c09ca1b Matteo Croce        2007-09-20  183  	if (len) {
c283cf2c09ca1b Matteo Croce        2007-09-20  184  		size_t i;
c283cf2c09ca1b Matteo Croce        2007-09-20  185  
670d59c0ae31a8 Alan Cox            2008-08-04  186  		spin_lock(&wdt_lock);
c283cf2c09ca1b Matteo Croce        2007-09-20  187  		ar7_wdt_kick(1);
670d59c0ae31a8 Alan Cox            2008-08-04  188  		spin_unlock(&wdt_lock);
c283cf2c09ca1b Matteo Croce        2007-09-20  189  
c283cf2c09ca1b Matteo Croce        2007-09-20  190  		expect_close = 0;
c283cf2c09ca1b Matteo Croce        2007-09-20  191  		for (i = 0; i < len; ++i) {
c283cf2c09ca1b Matteo Croce        2007-09-20  192  			char c;
c283cf2c09ca1b Matteo Croce        2007-09-20 @193  			if (get_user(c, data + i))
c283cf2c09ca1b Matteo Croce        2007-09-20  194  				return -EFAULT;
c283cf2c09ca1b Matteo Croce        2007-09-20  195  			if (c == 'V')
c283cf2c09ca1b Matteo Croce        2007-09-20  196  				expect_close = 1;
c283cf2c09ca1b Matteo Croce        2007-09-20  197  		}
c283cf2c09ca1b Matteo Croce        2007-09-20  198  
c283cf2c09ca1b Matteo Croce        2007-09-20  199  	}
c283cf2c09ca1b Matteo Croce        2007-09-20  200  	return len;
c283cf2c09ca1b Matteo Croce        2007-09-20  201  }
c283cf2c09ca1b Matteo Croce        2007-09-20  202  
670d59c0ae31a8 Alan Cox            2008-08-04  203  static long ar7_wdt_ioctl(struct file *file,
c283cf2c09ca1b Matteo Croce        2007-09-20  204  					unsigned int cmd, unsigned long arg)
c283cf2c09ca1b Matteo Croce        2007-09-20  205  {
42747d712de56c Wim Van Sebroeck    2009-12-26  206  	static const struct watchdog_info ident = {
c283cf2c09ca1b Matteo Croce        2007-09-20  207  		.identity = LONGNAME,
c283cf2c09ca1b Matteo Croce        2007-09-20  208  		.firmware_version = 1,
e73a780272a46e Wim Van Sebroeck    2009-05-11  209  		.options = (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
e73a780272a46e Wim Van Sebroeck    2009-05-11  210  						WDIOF_MAGICCLOSE),
c283cf2c09ca1b Matteo Croce        2007-09-20  211  	};
c283cf2c09ca1b Matteo Croce        2007-09-20  212  	int new_margin;
c283cf2c09ca1b Matteo Croce        2007-09-20  213  
c283cf2c09ca1b Matteo Croce        2007-09-20  214  	switch (cmd) {
c283cf2c09ca1b Matteo Croce        2007-09-20  215  	case WDIOC_GETSUPPORT:
c283cf2c09ca1b Matteo Croce        2007-09-20  216  		if (copy_to_user((struct watchdog_info *)arg, &ident,
c283cf2c09ca1b Matteo Croce        2007-09-20  217  				sizeof(ident)))
c283cf2c09ca1b Matteo Croce        2007-09-20  218  			return -EFAULT;
c283cf2c09ca1b Matteo Croce        2007-09-20  219  		return 0;
c283cf2c09ca1b Matteo Croce        2007-09-20  220  	case WDIOC_GETSTATUS:
c283cf2c09ca1b Matteo Croce        2007-09-20  221  	case WDIOC_GETBOOTSTATUS:
c283cf2c09ca1b Matteo Croce        2007-09-20 @222  		if (put_user(0, (int *)arg))
c283cf2c09ca1b Matteo Croce        2007-09-20  223  			return -EFAULT;
c283cf2c09ca1b Matteo Croce        2007-09-20  224  		return 0;
c283cf2c09ca1b Matteo Croce        2007-09-20  225  	case WDIOC_KEEPALIVE:
c283cf2c09ca1b Matteo Croce        2007-09-20  226  		ar7_wdt_kick(1);
c283cf2c09ca1b Matteo Croce        2007-09-20  227  		return 0;
c283cf2c09ca1b Matteo Croce        2007-09-20  228  	case WDIOC_SETTIMEOUT:
c283cf2c09ca1b Matteo Croce        2007-09-20 @229  		if (get_user(new_margin, (int *)arg))
c283cf2c09ca1b Matteo Croce        2007-09-20  230  			return -EFAULT;
c283cf2c09ca1b Matteo Croce        2007-09-20  231  		if (new_margin < 1)
c283cf2c09ca1b Matteo Croce        2007-09-20  232  			return -EINVAL;
c283cf2c09ca1b Matteo Croce        2007-09-20  233  
670d59c0ae31a8 Alan Cox            2008-08-04  234  		spin_lock(&wdt_lock);
c283cf2c09ca1b Matteo Croce        2007-09-20  235  		ar7_wdt_update_margin(new_margin);
c283cf2c09ca1b Matteo Croce        2007-09-20  236  		ar7_wdt_kick(1);
670d59c0ae31a8 Alan Cox            2008-08-04  237  		spin_unlock(&wdt_lock);
bd490f8222510d Gustavo A. R. Silva 2020-07-07  238  		fallthrough;
c283cf2c09ca1b Matteo Croce        2007-09-20  239  	case WDIOC_GETTIMEOUT:
c283cf2c09ca1b Matteo Croce        2007-09-20  240  		if (put_user(margin, (int *)arg))
c283cf2c09ca1b Matteo Croce        2007-09-20  241  			return -EFAULT;
c283cf2c09ca1b Matteo Croce        2007-09-20  242  		return 0;
0c06090c9472db Wim Van Sebroeck    2008-07-18  243  	default:
0c06090c9472db Wim Van Sebroeck    2008-07-18  244  		return -ENOTTY;
c283cf2c09ca1b Matteo Croce        2007-09-20  245  	}
c283cf2c09ca1b Matteo Croce        2007-09-20  246  }
c283cf2c09ca1b Matteo Croce        2007-09-20  247  

:::::: The code at line 193 was first introduced by commit
:::::: c283cf2c09ca1b7f1e7677bde384a8f92b1b7584 [WATCHDOG] AR7: watchdog timer

:::::: TO: Matteo Croce <technoboy85@gmail.com>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
