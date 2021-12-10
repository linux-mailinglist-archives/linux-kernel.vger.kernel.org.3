Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCA46FC6A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhLJIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:15:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:24704 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhLJIPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639123921; x=1670659921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EpMTnbkN9th3B/olMnD/CSz85HJXNfLduHFz0RFcpaE=;
  b=KkWaZJvqqF0WOg0dXqz0xxO5hMBXTaTKrGolDIWdBWc0rl2vhDrow5td
   WUDohISqw2mI2q/iebs84cz4STezDxNObiBgnIpi3ktbjx6qGifVpjxsj
   oGPI7PwiLQEiW8CUdR7UM01oxiDf+dU0Qb4HXe3uq09O+CfRQNTbvCv5u
   PXc4GaQ3I35BCm2rldE1Zl0yZ4jn7A07g4xY0WGtwsjfThnpIvjzQi1NT
   NeYWSkgATC68MQKgaViwr11wetZfJutgD6mlv49pqU+HaVZFAuWVUoa5H
   qm5zGTc52OUwd++TPdMW1VrJ5S+ByDJlCl8J2ontEGboS3fuzKC2c5yTC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301685685"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="301685685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 00:12:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="503841404"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2021 00:11:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvb0Y-0002x9-8J; Fri, 10 Dec 2021 08:11:58 +0000
Date:   Fri, 10 Dec 2021 16:11:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_soft_counters 9/10]
 include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of
 type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202112101613.n18YqogN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw petrm_soft_counters
head:   38ca0aa04554a994a5ab769f0c07b37484b5f4c9
commit: 0839ffb5b56fb6f5e67545c77bf6151fe606835d [9/10] wip
config: arc-randconfig-r043-20211210 (https://download.01.org/0day-ci/archive/20211210/202112101613.n18YqogN-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/0839ffb5b56fb6f5e67545c77bf6151fe606835d
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw petrm_soft_counters
        git checkout 0839ffb5b56fb6f5e67545c77bf6151fe606835d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:19,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12,
                    from net/core/rtnetlink.c:17:
   net/core/rtnetlink.c: In function 'if_nlmsg_stats_size':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   net/core/rtnetlink.c:5509:9: note: in expansion of macro 'printk'
    5509 |         printk(KERN_WARNING "if_nlmsg_stats_size %ld\n", size);
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   net/core/rtnetlink.c:5509:16: note: in expansion of macro 'KERN_WARNING'
    5509 |         printk(KERN_WARNING "if_nlmsg_stats_size %ld\n", size);
         |                ^~~~~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a7 Joe Perches 2012-07-30  4  
04d2c8c83d0e3ac Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3ac Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3ac Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
