Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B849FD2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349717AbiA1Pzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:55:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:15366 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239060AbiA1Pzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643385339; x=1674921339;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tMFh88oOv4njvacRP3WgZ4WpJIw1jYw9JQiDlZ3hgEY=;
  b=m73U7x3uYQCJzg6/wVDocPETHi5kRlgF04I1sq1A0BECKz0gjIpzKFXD
   3qGIlwp1IESpcu27v8ORo+adTx8/9Igmd7lnEuGnr7UgpFB67nk19pwHK
   +zIPUP1wNlSi4jBLbJwvKYWwOhVwp7xMSi+PD582LMTpD/G4HeAD7kk8O
   lZ1h3VXqxrD7w3H6RDRRWF751Ddl17j0gVmgIyZ8Esy0F/gNPqXcrZ2Dl
   jd6yQIWifs1MbRs78yBjGeTe0/Kv7z5Y4+QcaNAkkr2CclGx+b9vj3gJv
   n/UUtD94+fdIJFS0ecFDqUp4NkKXg4TmGzlBuydzP4UonrEV6R/t1pYra
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227121789"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227121789"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 07:55:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="480777733"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jan 2022 07:55:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDTb6-000O3O-5O; Fri, 28 Jan 2022 15:55:36 +0000
Date:   Fri, 28 Jan 2022 23:55:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:memperf_test_v1 7/7] memperf_test.c:undefined reference to
 `__udivdi3'
Message-ID: <202201282324.f40yinlV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git memperf_test_v1
head:   ad86979ac717673ec1647f1148a5c7cd214a1f39
commit: ad86979ac717673ec1647f1148a5c7cd214a1f39 [7/7] lib: Add memperf test
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201282324.f40yinlV-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/ad86979ac717673ec1647f1148a5c7cd214a1f39
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel memperf_test_v1
        git checkout ad86979ac717673ec1647f1148a5c7cd214a1f39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   m68k-linux-ld: lib/memperf_test.o: in function `memcpy_memmove_perf_test':
>> memperf_test.c:(.init.text+0x1b4): undefined reference to `__udivdi3'
   m68k-linux-ld: lib/memperf_test.o: in function `memperf_test_init':
   memperf_test.c:(.init.text+0x3ac): undefined reference to `__udivdi3'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
--
   In file included from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/memperf_test.c:3:
   lib/memperf_test.c: In function 'memcpy_memmove_perf_test':
>> lib/memperf_test.c:76:32: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
      76 |                         printk("memperf: %s(dst+%d, src+%d), distance %lu: %llu Mb/s\n",
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      77 |                                 (cpy) ? "memcpy" : "memmove", i, j,
      78 |                                 (j - i) % sizeof(long), mbps);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         unsigned int
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   lib/memperf_test.c:76:25: note: in expansion of macro 'printk'
      76 |                         printk("memperf: %s(dst+%d, src+%d), distance %lu: %llu Mb/s\n",
         |                         ^~~~~~
   lib/memperf_test.c:76:73: note: format string is defined here
      76 |                         printk("memperf: %s(dst+%d, src+%d), distance %lu: %llu Mb/s\n",
         |                                                                       ~~^
         |                                                                         |
         |                                                                         long unsigned int
         |                                                                       %u

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
