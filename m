Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1DC4A5D4A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiBANPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:15:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:13888 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235274AbiBANPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643721349; x=1675257349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YIrB/RjwUQuB/lErIj+v5pUNuBA3zxVy4nUv15hlRCw=;
  b=WwpV396CBUz1S6JyfJvAXMEGOxg2VunsQPW+xa3PdTq3xWRJDrM1Rs2v
   9Pc0LSjRLYwuX1tE0W7+jJiNexkT+jG09aV7oHU0xJBrm1nj9ETgYB0ne
   7r1XJ5YxoaU77xt+6d6Gcfbkw9JdV3/umpX10UFuizOwcsGMPrr6Fn3EE
   2riXB1H7Xl2CZJVLe6hhvg9hEXOurew7WGAty0S+a4MmglKY2FTrtKT/z
   M8/nuPt18opwsZeuLVFSayzbCUllXWoAAZoVuOzPmNpM1sf7cW+JGba4t
   Ulidq31QegskfuQqEUABQ77EhMWXEDzUWAn7h5zAjsbwqPzbZL76kP6mc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246519414"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="246519414"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 05:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="630392461"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2022 05:15:41 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEt0W-000TIk-EP; Tue, 01 Feb 2022 13:15:40 +0000
Date:   Tue, 1 Feb 2022 21:15:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 201/9999] kernel/sched/stubs.c:8:5: warning: no previous prototype for
 function 'sched_isolate_cpu'
Message-ID: <202202012133.0supCHiV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   b45c5eeda8dea785e3d411380b486a209768f6b2
commit: eead51495c8760858c32d9ad0332ffc94397aa82 [201/9999] ANDROID: GKI: sched: stub sched_isolate symbols
config: x86_64-randconfig-r026-20220131 (https://download.01.org/0day-ci/archive/20220201/202202012133.0supCHiV-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/eead51495c8760858c32d9ad0332ffc94397aa82
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout eead51495c8760858c32d9ad0332ffc94397aa82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvmem/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/stubs.c:8:5: warning: no previous prototype for function 'sched_isolate_cpu' [-Wmissing-prototypes]
   int sched_isolate_cpu(int cpu)
       ^
   kernel/sched/stubs.c:8:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_isolate_cpu(int cpu)
   ^
   static 
>> kernel/sched/stubs.c:14:5: warning: no previous prototype for function 'sched_unisolate_cpu_unlocked' [-Wmissing-prototypes]
   int sched_unisolate_cpu_unlocked(int cpu)
       ^
   kernel/sched/stubs.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_unisolate_cpu_unlocked(int cpu)
   ^
   static 
>> kernel/sched/stubs.c:20:5: warning: no previous prototype for function 'sched_unisolate_cpu' [-Wmissing-prototypes]
   int sched_unisolate_cpu(int cpu)
       ^
   kernel/sched/stubs.c:20:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_unisolate_cpu(int cpu)
   ^
   static 
>> kernel/sched/stubs.c:26:5: warning: no previous prototype for function 'set_task_boost' [-Wmissing-prototypes]
   int set_task_boost(int boost, u64 period)
       ^
   kernel/sched/stubs.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int set_task_boost(int boost, u64 period)
   ^
   static 
   4 warnings generated.


vim +/sched_isolate_cpu +8 kernel/sched/stubs.c

     7	
   > 8	int sched_isolate_cpu(int cpu)
     9	{
    10		return -EINVAL;
    11	}
    12	EXPORT_SYMBOL_GPL(sched_isolate_cpu);
    13	
  > 14	int sched_unisolate_cpu_unlocked(int cpu)
    15	{
    16		return -EINVAL;
    17	}
    18	EXPORT_SYMBOL_GPL(sched_unisolate_cpu_unlocked);
    19	
  > 20	int sched_unisolate_cpu(int cpu)
    21	{
    22		return -EINVAL;
    23	}
    24	EXPORT_SYMBOL_GPL(sched_unisolate_cpu);
    25	
  > 26	int set_task_boost(int boost, u64 period)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
