Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5774880F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 03:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiAHCoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 21:44:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:22453 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230174AbiAHCoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 21:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641609872; x=1673145872;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PtctAWIEnQqRKJOz0FTv5G04uaLdee7FzheU9sSh2hA=;
  b=aQfxMOkC4zLTLZ3pk4mn1xcEw81rRBLWeEXgjhVEuQotKEhEgs7QYpYG
   tz1nMNoXsotQhbqoiAYVpdxR7iTGBbT/HFsVEhDYXsaMY/2ZnyRjFBmUt
   s20/IVyc0PAkIdsJIeWCRYtFbIKzud49EaiFSoXGNTrdIjGQ1JNTHvn+L
   OTjgHA4H4CKlN8r7OosbleH2BuZA/O0G3TF3KLkTFzwhCfFuS9icSutMt
   D4+9JNl3XqZJpD5Fnwg5c9/aZ893Vqqcya+UJ2NQVSm2ztTdvPCDk/Xtm
   R+wLUlo/nJgPeBKnO4ejK0sXcrnONvTTpe4/M5l9FnMM/rADaEMhWDe5L
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="241793129"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="241793129"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 18:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="471500822"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2022 18:44:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n61iX-0000Be-Rr; Sat, 08 Jan 2022 02:44:29 +0000
Date:   Sat, 8 Jan 2022 10:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pintu Kumar <quic_pintu@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>,
        Pintu Agarwal <pintu.ping@gmail.com>
Subject: include/uapi/linux/sysinfo.h:23:14: error: size of array '_f' is too
 large
Message-ID: <202201081013.w2UXbEsE-lkp@intel.com>
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
date:   9 hours ago
config: ia64-randconfig-r015-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081013.w2UXbEsE-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/85f46444fa2eff4f03aeb701d44edd62af00ee44
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220108-020953/Pintu-Kumar/sysinfo-include-availram-field-in-sysinfo-struct/20220106-233557
        git checkout 85f46444fa2eff4f03aeb701d44edd62af00ee44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/kernel.h:5,
                    from include/linux/cache.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/uapi/linux/sysinfo.h:23:14: error: size of array '_f' is too large
      23 |         char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses this.. */
         |              ^~
   make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1197: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/_f +23 include/uapi/linux/sysinfo.h

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
