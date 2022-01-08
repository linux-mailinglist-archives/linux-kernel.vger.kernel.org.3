Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F01488313
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 11:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiAHKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 05:43:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:12799 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231232AbiAHKny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 05:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641638634; x=1673174634;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6YbQrnMcQA5+BPCkyY5BHW2Z3rlPfkppDF4M7vJLRLk=;
  b=Ko+JQ6EICpxW8WTV+nzS4tDXa52evseB4OTk9sDWkrQwjLum6LNwU0pb
   BF7BNZgH4M0YgrKC4ruQb4b0bH0ryusmWZWrPjuWICLAeovTZfhIjySCQ
   QgfQksk9H3Ml7HgVyoAkZhS2nQHke3SayF6TxAHwbZVhaux9WJp4xWs2a
   eGu98/RimHk5500rAw+3itAVuOZfXoOCWHsuteSU94OFDzl4quIpzYCOe
   LdUXF2ZOvnjquqCc8OExONzhg3ZYspkvZcz9iNny2mtJ/MjKV+Y+SIbQS
   iuD5DnOxQABRnG5KZHtdGh76JEVk4w5OwFs+GNVhVMn/O/1IRehxbkAKv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="222992423"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="222992423"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 02:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="690072772"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Jan 2022 02:43:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n69CR-0000XI-1n; Sat, 08 Jan 2022 10:43:51 +0000
Date:   Sat, 8 Jan 2022 18:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pintu Kumar <quic_pintu@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>,
        Pintu Agarwal <pintu.ping@gmail.com>
Subject: include/uapi/linux/sysinfo.h:23:10: error: array is too large
 (18446744073709551608 elements)
Message-ID: <202201081822.SPIpoaId-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220108-020953/Pintu-Kumar/sysinfo-include-availram-field-in-sysinfo-struct/20220106-233557
head:   85f46444fa2eff4f03aeb701d44edd62af00ee44
commit: 85f46444fa2eff4f03aeb701d44edd62af00ee44 sysinfo: include availram field in sysinfo struct
date:   17 hours ago
config: s390-randconfig-r015-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081822.SPIpoaId-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/85f46444fa2eff4f03aeb701d44edd62af00ee44
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220108-020953/Pintu-Kumar/sysinfo-include-availram-field-in-sysinfo-struct/20220106-233557
        git checkout 85f46444fa2eff4f03aeb701d44edd62af00ee44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:10:
   In file included from include/linux/page-flags.h:10:
   In file included from include/linux/bug.h:5:
   In file included from arch/s390/include/asm/bug.h:68:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/cache.h:5:
   In file included from include/uapi/linux/kernel.h:5:
>> include/uapi/linux/sysinfo.h:23:10: error: array is too large (18446744073709551608 elements)
           char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses this.. */
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +23 include/uapi/linux/sysinfo.h

     6	
     7	#define SI_LOAD_SHIFT	16
     8	struct sysinfo {
     9		__kernel_long_t uptime;		/* Seconds since boot */
    10		__kernel_ulong_t loads[3];	/* 1, 5, and 15 minute load averages */
    11		__kernel_ulong_t totalram;	/* Total usable main memory size */
    12		__kernel_ulong_t freeram;	/* Available memory size */
    13		__kernel_ulong_t sharedram;	/* Amount of shared memory */
    14		__kernel_ulong_t bufferram;	/* Memory used by buffers */
    15		__kernel_ulong_t totalswap;	/* Total swap space size */
    16		__kernel_ulong_t freeswap;	/* swap space still available */
    17		__u16 procs;		   	/* Number of current processes */
    18		__u16 pad;		   	/* Explicit padding for m68k */
    19		__kernel_ulong_t totalhigh;	/* Total high memory size */
    20		__kernel_ulong_t freehigh;	/* Available high memory size */
    21		__u32 mem_unit;			/* Memory unit size in bytes */
    22		__kernel_ulong_t availram;	/* Memory available for allocation */
  > 23		char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];	/* Padding: libc5 uses this.. */
    24	};
    25	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
