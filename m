Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64F7489A01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiAJNeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:34:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:13575 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232329AbiAJNd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641821639; x=1673357639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FHH3ntuwOU335ek4Jx/BvjAW6jSw4WkOdxb71pgB48M=;
  b=NsnoEaDOWnG5aJkhI9iWgjwB+tCSdecBfrY63LlAT+whgdc75F00Zs9a
   faOw72WTMQ8AtprkOYT7rkrgwGAW/p+6phuEYr6wn2p7oXtAxfjn+GRtN
   nrUis9ZMDZI6SPbFOwIVDyQfrOC+vltNxE6oNNpKv7650uYPUQpHHzOmv
   mQlS7RA3mJMuo39sgOK39KbMTOu4n/sDTSohqTX7apYHILXzDFYjbHlOJ
   QC83ei2TP6WnXNyV3sDnFUl1Ee6Jnnau55p1d3v7OwGSe4Yi6yuIK3sk+
   1mFnFdJq+b7UFKN+xM2Of8/7RXU4US4UwMajbqIpFOLW/sInU+H5nVMln
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="223918192"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="223918192"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 05:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="557984992"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2022 05:33:57 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6uo8-0003Wx-O2; Mon, 10 Jan 2022 13:33:56 +0000
Date:   Mon, 10 Jan 2022 21:32:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [acme:perf/core 45/46] include/uapi/linux/perf_event.h:1339:18:
 error: 'PERF_MEM_HOPS_2' undeclared; did you mean 'PERF_MEM_HOPS_0'?
Message-ID: <202201102122.s9aPc0vp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
head:   65f8d08cf838df3c3d728cdef908090237931496
commit: af2b24f228a0373ac65eb7a502e0bc31e2c0269d [45/46] perf powerpc: Add data source encodings for power10 platform
config: powerpc64-buildonly-randconfig-r003-20220109 (https://download.01.org/0day-ci/archive/20220110/202201102122.s9aPc0vp-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?id=af2b24f228a0373ac65eb7a502e0bc31e2c0269d
        git remote add acme https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
        git fetch --no-tags acme perf/core
        git checkout af2b24f228a0373ac65eb7a502e0bc31e2c0269d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:17,
                    from arch/powerpc/perf/isa207-common.h:12,
                    from arch/powerpc/perf/isa207-common.c:9:
   arch/powerpc/perf/isa207-common.c: In function 'isa207_find_source':
>> include/uapi/linux/perf_event.h:1339:18: error: 'PERF_MEM_HOPS_2' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
    1339 |         (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
         |                  ^~~~~~~~~
   arch/powerpc/perf/isa207-common.h:273:41: note: in expansion of macro 'PERF_MEM_S'
     273 | #define P(a, b)                         PERF_MEM_S(a, b)
         |                                         ^~~~~~~~~~
   arch/powerpc/perf/isa207-common.c:240:79: note: in expansion of macro 'P'
     240 |                                 ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
         |                                                                               ^
   include/uapi/linux/perf_event.h:1339:18: note: each undeclared identifier is reported only once for each function it appears in
    1339 |         (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
         |                  ^~~~~~~~~
   arch/powerpc/perf/isa207-common.h:273:41: note: in expansion of macro 'PERF_MEM_S'
     273 | #define P(a, b)                         PERF_MEM_S(a, b)
         |                                         ^~~~~~~~~~
   arch/powerpc/perf/isa207-common.c:240:79: note: in expansion of macro 'P'
     240 |                                 ret |= PH(LVL, REM_RAM1) | REM | LEVEL(RAM) | P(HOPS, 2);
         |                                                                               ^
>> include/uapi/linux/perf_event.h:1339:18: error: 'PERF_MEM_HOPS_3' undeclared (first use in this function); did you mean 'PERF_MEM_HOPS_0'?
    1339 |         (((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
         |                  ^~~~~~~~~
   arch/powerpc/perf/isa207-common.h:273:41: note: in expansion of macro 'PERF_MEM_S'
     273 | #define P(a, b)                         PERF_MEM_S(a, b)
         |                                         ^~~~~~~~~~
   arch/powerpc/perf/isa207-common.c:244:79: note: in expansion of macro 'P'
     244 |                                 ret |= PH(LVL, REM_RAM2) | REM | LEVEL(RAM) | P(HOPS, 3);
         |                                                                               ^


vim +1339 include/uapi/linux/perf_event.h

fec9cc6175d0ec Kajol Jain       2021-10-06  1337  
d6be9ad6c960f4 Stephane Eranian 2013-01-24  1338  #define PERF_MEM_S(a, s) \
0d9dfc23f4d8c1 Mike Frysinger   2014-01-23 @1339  	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
d6be9ad6c960f4 Stephane Eranian 2013-01-24  1340  

:::::: The code at line 1339 was first introduced by commit
:::::: 0d9dfc23f4d8c17365c84eb48ecca28b963ba192 uapi: convert u64 to __u64 in exported headers

:::::: TO: Mike Frysinger <vapier@gentoo.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
