Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4559549330B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351097AbiASCkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:40:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:50511 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351032AbiASCkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642560017; x=1674096017;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VCH8WO0XLfxSlyzeMSeacf0IRboGEyy2xqx1o0Uvz6E=;
  b=ENQIPTFWkjtJyKbwWBuFCHx7LRP9EQ9TKW+IlmnqN2a4Nq9JN4QzZWis
   f2NVtQQU7dAnucOUYex2C5YY0xmGXtk42hu+AkUquFFOlvkI+dDyjyoKR
   3bCtMi4PWGD77qHDIK0QS9XbumWqE8XA0l14+IqHGyZKw7k5yDv9LcWgL
   CP6VNO7z3AOKsxVyhzwNolQ3WYNdEem45kNkl89uIqnHQpVZOwe7VPWun
   IBXxHUfXNQvwioF4NNw7mm7/247EwF1nV26QkuxT1OtSOHw19iJ/zKxpU
   fF5SqI4cyJZlClM9cjcEI+ob4TUfDyEg3WQtHXtlKgul0ahsjyf+E1ebA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269354459"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="269354459"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 18:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="518002399"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2022 18:40:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA0tR-000D9f-U3; Wed, 19 Jan 2022 02:40:13 +0000
Date:   Wed, 19 Jan 2022 10:40:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "sw.multimedia" <sw.multimedia@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        "jack.zhu" <jack.zhu@starfivetech.com>,
        "keith.zhao" <keith.zhao@starfivetech.com>
Subject: [esmil:visionfive 64/80] include/linux/kern_levels.h:5:25: warning:
 format '%llx' expects argument of type 'long long unsigned int', but
 argument 2 has type 'dma_addr_t' {aka 'unsigned int'}
Message-ID: <202201191032.ozy73s1C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 1eb3575230496368002bc06d59b7d219c09af47b [64/80] drm/starfive: Add StarFive drm driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201191032.ozy73s1C-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/1eb3575230496368002bc06d59b7d219c09af47b
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 1eb3575230496368002bc06d59b7d219c09af47b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/starfive/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:11,
                    from include/linux/dma-buf-map.h:9,
                    from include/linux/dma-buf.h:16,
                    from drivers/gpu/drm/starfive/starfive_drm_gem.c:5:
   drivers/gpu/drm/starfive/starfive_drm_gem.c: In function 'starfive_drm_gem_alloc_dma':
>> include/linux/kern_levels.h:5:25: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/drm/drm_print.h:494:9: note: in expansion of macro 'printk'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/drm/drm_print.h:494:22: note: in expansion of macro 'KERN_INFO'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |                      ^~~~~
   include/drm/drm_print.h:498:9: note: in expansion of macro '_DRM_PRINTK'
     498 |         _DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   drivers/gpu/drm/starfive/starfive_drm_gem.c:132:9: note: in expansion of macro 'DRM_INFO'
     132 |         DRM_INFO("dma_addr = 0x%llx, size = %lu\n", starfive_obj->dma_addr, obj->size);
         |         ^~~~~~~~
   include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/drm/drm_print.h:494:9: note: in expansion of macro 'printk'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/drm/drm_print.h:494:22: note: in expansion of macro 'KERN_INFO'
     494 |         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
         |                      ^~~~~
   include/drm/drm_print.h:498:9: note: in expansion of macro '_DRM_PRINTK'
     498 |         _DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   drivers/gpu/drm/starfive/starfive_drm_gem.c:132:9: note: in expansion of macro 'DRM_INFO'
     132 |         DRM_INFO("dma_addr = 0x%llx, size = %lu\n", starfive_obj->dma_addr, obj->size);
         |         ^~~~~~~~
   At top level:
   drivers/gpu/drm/starfive/starfive_drm_gem.c:17:42: warning: 'mmap_mem_ops' defined but not used [-Wunused-const-variable=]
      17 | static const struct vm_operations_struct mmap_mem_ops = {
         |                                          ^~~~~~~~~~~~


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
