Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48F048AB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbiAKKYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:24:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:59881 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237737AbiAKKYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641896657; x=1673432657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8cjrlj0GTpz7COrtvh5wm1lvAirPfnGISqNG7uHUwbQ=;
  b=mFO1gfw12trO5j8g5vMciKt5Em9kOhk7L7Af/WNib2ggHvJFqau45FNm
   hXyePDaModcjVcElXqyIDYcuPfXoVLODh+TpUa6Q96RfoLUB/SEd0Nupl
   tM3K1SE2LTMAA6eBysXHDCLG/iYrcqK5MhBiFdcby1bCDGBmGanRVg412
   JYH9N1rKkDErBQ247IVzAR18nlHKlth0vXOGuh9jULjEq0WUU4TE9vtRU
   a6ykUIjzsLG/IcFjVT41QdWb80Y8c8911GpaoeN/DpPPgxa7V/JYYPZtM
   AzKnVkOfIpGALtQkCBbK527cA/nJJVKIyAbFZ2b+EbxV0doT5eObYl01k
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="230794578"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="230794578"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 02:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="474487319"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2022 02:24:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7EK5-0004kG-9x; Tue, 11 Jan 2022 10:24:13 +0000
Date:   Tue, 11 Jan 2022 18:23:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 630/2382]
 include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No
 such file or directory
Message-ID: <202201111825.nOYzBDWe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   1a880941a087613ed42f77001229edfcf75ea8a5
commit: e60fbf3d074e5f8a02d0073637b920d61d281ad1 [630/2382] headers/deps: Add header dependencies to .h files: <asm/vdso/processor.h>
config: sh-randconfig-p002-20220111 (https://download.01.org/0day-ci/archive/20220111/202201111825.nOYzBDWe-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e60fbf3d074e5f8a02d0073637b920d61d281ad1
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e60fbf3d074e5f8a02d0073637b920d61d281ad1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh olddefconfig

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sh/include/asm/barrier.h:43,
                    from arch/sh/include/asm/bitops.h:11,
                    from include/linux/bitops.h:28,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> include/asm-generic/barrier.h:16:10: fatal error: asm/vdso/processor.h: No such file or directory
      16 | #include <asm/vdso/processor.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +16 include/asm-generic/barrier.h

    15	
  > 16	#include <asm/vdso/processor.h>
    17	#include <linux/compiler.h>
    18	#include <asm/rwonce.h>
    19	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
