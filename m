Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D120347375B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhLMWUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:20:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:16506 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235993AbhLMWUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639434000; x=1670970000;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=giitmPLHY1uPSBPFc8J8RDh4a1c75MNyGcBQOV07+RM=;
  b=QkcS3oP/rVueOE4RvGEn5fMLBU+aBkykCrTmpOT1mucB/YW3VRdh/6lN
   hCHGGHa/BmZNLqCIiaY0QgpNlLPJ7Gs2pJ2lKajnxoGOK7z6hZS6xB4FI
   whEFVXjoJMIEAkyZChouT0Oby0uYiv55LA1zl1kfF2QLE9psDTkmy38Q4
   hykG4/BrXQr0INdSYLazBI1IbryOS/UYrxVxHShmXIDlg5KMakCBgDrSY
   84ofKfJDP7myFBQquxYROHmXjkGpnUHoLpkCiDsqwyIRHalqAIm/U0bv7
   ba/6dNhXHXbNfys25CqGhL6zGftXq7KGdOB9LS6CXLZdyY0jAXQQCgNvl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238789857"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="238789857"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:20:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="517953255"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2021 14:19:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwtfp-00077f-JM; Mon, 13 Dec 2021 22:19:57 +0000
Date:   Tue, 14 Dec 2021 06:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, wangkefeng.wang@huawei.com,
        weiyongjun1@huawei.com, linux-kernel@vger.kernel.org
Subject: [kevin78:percpu-cleanup 3/4] include/linux/kern_levels.h:5:25:
 warning: format '%lx' expects argument of type 'long unsigned int', but
 argument 4 has type 'long long unsigned int'
Message-ID: <202112140613.AxIBwwbd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kevin78/linux.git percpu-cleanup
head:   ec8bef0e65982bb71c931efddde0fca6418e02ba
commit: c3ebf9a83e686d6d3dc8b571493219a64558d536 [3/4] mm: percpu: Add generic pcpu_fc_alloc/free funciton
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20211214/202112140613.AxIBwwbd-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kevin78/linux/commit/c3ebf9a83e686d6d3dc8b571493219a64558d536
        git remote add kevin78 https://github.com/kevin78/linux.git
        git fetch --no-tags kevin78 percpu-cleanup
        git checkout c3ebf9a83e686d6d3dc8b571493219a64558d536
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:20,
                    from include/linux/cpumask.h:10,
                    from mm/percpu.c:72:
   mm/percpu.c: In function 'pcpu_fc_alloc':
>> include/linux/kern_levels.h:5:25: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:580:9: note: in expansion of macro 'no_printk'
     580 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:580:19: note: in expansion of macro 'KERN_DEBUG'
     580 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   mm/percpu.c:3011:17: note: in expansion of macro 'pr_debug'
    3011 |                 pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
         |                 ^~~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'long long unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:580:9: note: in expansion of macro 'no_printk'
     580 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:580:19: note: in expansion of macro 'KERN_DEBUG'
     580 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   mm/percpu.c:3018:17: note: in expansion of macro 'pr_debug'
    3018 |                 pr_debug("per cpu data for cpu%d %lu bytes on node%d at %016lx\n",
         |                 ^~~~~~~~


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
