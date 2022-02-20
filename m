Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D534BCFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbiBTQYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:24:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiBTQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:24:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADB34663
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645374224; x=1676910224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TjOE0wtS4BescYQXAThfxC/sfHq0Ovi4k5YvJwbBtwE=;
  b=cwUP/DnM/V3H/8dDqYU539cowflz68I0InNKNm0QhMjt0HQjSOEiFQyC
   N47bNU3JamfNp9Ps1/6zMtX1uyi4qWAG1pO1uBE1TZIObMTViw+1Kj4V0
   VJsLEfaomZEALwndE+6wPUNf7DoBEIPLWWnkG6UOQLEkgfKjS0lwWNNr6
   EWDMZIHBluuUCuJrKKqNlJfcIoztAKmVFCPwyWDKDa9qZ6S79/ZgT3/cS
   IGFD14n8jkEuBqu/5IKtuwXJl2eaSm46dFXphYkHRV6fyrsUM04/iSSPr
   JSIWBTNx8b4oZsO9VhjpkfXc00ymkMzB8YdFwc2NYWuMPB1d5HZlgBejw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314649963"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="314649963"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 08:23:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="507351136"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2022 08:23:42 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLozt-0000SL-QI; Sun, 20 Feb 2022 16:23:41 +0000
Date:   Mon, 21 Feb 2022 00:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/watchdog/indydog.c:116:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202202210058.Ytrak73L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f12b742eb2b3a850ac8be7dc4ed52976fc6cb0b
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   10 months ago
config: mips-randconfig-s032-20220220 (https://download.01.org/0day-ci/archive/20220221/202202210058.Ytrak73L-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/watchdog/indydog.c:110:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct watchdog_info * @@
   drivers/watchdog/indydog.c:110:35: sparse:     expected void [noderef] __user *to
   drivers/watchdog/indydog.c:110:35: sparse:     got struct watchdog_info *
>> drivers/watchdog/indydog.c:116:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   drivers/watchdog/indydog.c:116:24: sparse:     expected int [noderef] __user *__p
   drivers/watchdog/indydog.c:116:24: sparse:     got int *
>> drivers/watchdog/indydog.c:119:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__p @@     got int * @@
   drivers/watchdog/indydog.c:119:21: sparse:     expected int const [noderef] __user *__p
   drivers/watchdog/indydog.c:119:21: sparse:     got int *
   drivers/watchdog/indydog.c:135:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   drivers/watchdog/indydog.c:135:24: sparse:     expected int [noderef] __user *__p
   drivers/watchdog/indydog.c:135:24: sparse:     got int *
   drivers/watchdog/indydog.c:153:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *write )( ... ) @@     got long ( * )( ... ) @@
   drivers/watchdog/indydog.c:153:27: sparse:     expected long ( *write )( ... )
   drivers/watchdog/indydog.c:153:27: sparse:     got long ( * )( ... )

vim +116 drivers/watchdog/indydog.c

^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16   97  
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19   98  static long indydog_ioctl(struct file *file, unsigned int cmd,
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19   99  							unsigned long arg)
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  100  {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  101  	int options, retval = -EINVAL;
42747d712de56c drivers/watchdog/indydog.c      Wim Van Sebroeck 2009-12-26  102  	static const struct watchdog_info ident = {
e73a780272a46e drivers/watchdog/indydog.c      Wim Van Sebroeck 2009-05-11  103  		.options		= WDIOF_KEEPALIVEPING,
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  104  		.firmware_version	= 0,
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  105  		.identity		= "Hardware Watchdog for SGI IP22",
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  106  	};
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  107  
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  108  	switch (cmd) {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  109  	case WDIOC_GETSUPPORT:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  110  		if (copy_to_user((struct watchdog_info *)arg,
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  111  				 &ident, sizeof(ident)))
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  112  			return -EFAULT;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  113  		return 0;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  114  	case WDIOC_GETSTATUS:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  115  	case WDIOC_GETBOOTSTATUS:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16 @116  		return put_user(0, (int *)arg);
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  117  	case WDIOC_SETOPTIONS:
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  118  	{
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16 @119  		if (get_user(options, (int *)arg))
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  120  			return -EFAULT;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  121  		if (options & WDIOS_DISABLECARD) {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  122  			indydog_stop();
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  123  			retval = 0;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  124  		}
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  125  		if (options & WDIOS_ENABLECARD) {
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  126  			indydog_start();
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  127  			retval = 0;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  128  		}
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  129  		return retval;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  130  	}
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  131  	case WDIOC_KEEPALIVE:
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  132  		indydog_ping();
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  133  		return 0;
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  134  	case WDIOC_GETTIMEOUT:
0c06090c9472db drivers/watchdog/indydog.c      Wim Van Sebroeck 2008-07-18  135  		return put_user(WATCHDOG_TIMEOUT, (int *)arg);
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19  136  	default:
9b9dbcca3fa13a drivers/watchdog/indydog.c      Alan Cox         2008-05-19  137  		return -ENOTTY;
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  138  	}
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  139  }
^1da177e4c3f41 drivers/char/watchdog/indydog.c Linus Torvalds   2005-04-16  140  

:::::: The code at line 116 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
