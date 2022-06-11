Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D96547481
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiFKMaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiFKMaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 08:30:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166E60FB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654950615; x=1686486615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WKfZXA41JkopJ5QmGfbUlBJ/6S1pBCi6dvv7jlnMQwE=;
  b=gEgx0iirhuSFKBsaoOR30p9j67eRoDVSMkZutCycx68DkofXJn3m+6ln
   RITxoB8ANS4zRc2HmTHQxxSRLvGklQeEFA+RI5GV0rIrTZWnadEMO1dru
   GWur3ozypzzlTwKc/AgKhgmGcP0M+Wt7EgGt7hBoA5bQJUS0ct12tSioO
   suWRJxtP3CPHf1QHc0bV+XHCanNARAiD8hgSX3U/cF3P6+JTpJna1OuVO
   valBsIB544tf35VgRzXTMwsBhC3qdZxHVa69SfFjwr8ADUg2i7dtu5rBp
   onFNs8xDGx9oGG4CankpdI6ES/4FZR1mx3w6OkS+x69r625v/1BQS7qE0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266627127"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="266627127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 05:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="534470043"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2022 05:30:13 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o00Fo-000IsX-Uj;
        Sat, 11 Jun 2022 12:30:12 +0000
Date:   Sat, 11 Jun 2022 20:29:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: drivers/watchdog/indydog.c:116:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202206112049.H5ffJfda-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0885eacdc81f920c3e0554d5615e69a66504a28d
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   1 year, 2 months ago
config: mips-randconfig-s032-20220611 (https://download.01.org/0day-ci/archive/20220611/202206112049.H5ffJfda-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
