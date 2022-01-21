Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7A496870
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiAUX7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:59:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:4739 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbiAUX7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642809549; x=1674345549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BwKfyZTR9pd4F5ZvbwcXYeoggEr6vNtt/61NARKWbvI=;
  b=kH+mCa5Up89FA0mSMRvS2MYV3nGiXCJQxTR/XwW4YDZame7UjN5TDuLX
   fBhb5hP8dTgCQ/iKwOLIHgghEbRY3PEzPMHn3M++XMPlikhEHty8kRwRA
   emqFCKt3pFcq3X6taegDKidAMYFPJPgfYvkTtsSoOhXZkgk+BmBbhqWqv
   6Y9UKSVYmJA00z8c3bij53TutEcBaHXD1jsXty2w2Y3nM4gxDT1L5osAW
   95klWdLIONXLS/Q5YxijcUxcVdOrYdyiLudLfVuOzDcCwXZlL/VXkVz99
   aEM6LBHoHflGiL6+SBBwiS+kiSr3iIDGshP8Vve5fHnO8T/0keNlJGTPl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="306485666"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="306485666"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 15:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="478413870"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2022 15:59:07 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB3oA-000Fmt-K2; Fri, 21 Jan 2022 23:59:06 +0000
Date:   Sat, 22 Jan 2022 07:58:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-stable
 204/9999] kernel/sched/stubs.c:8:5: warning: no previous prototype for
 'sched_isolate_cpu'
Message-ID: <202201220740.3itLwKmy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-stable
head:   90a691fca4c2525068d9908ac203e9f09e4e33c0
commit: eead51495c8760858c32d9ad0332ffc94397aa82 [204/9999] ANDROID: GKI: sched: stub sched_isolate symbols
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220122/202201220740.3itLwKmy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/eead51495c8760858c32d9ad0332ffc94397aa82
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-stable
        git checkout eead51495c8760858c32d9ad0332ffc94397aa82
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvmem/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/stubs.c:8:5: warning: no previous prototype for 'sched_isolate_cpu' [-Wmissing-prototypes]
       8 | int sched_isolate_cpu(int cpu)
         |     ^~~~~~~~~~~~~~~~~
>> kernel/sched/stubs.c:14:5: warning: no previous prototype for 'sched_unisolate_cpu_unlocked' [-Wmissing-prototypes]
      14 | int sched_unisolate_cpu_unlocked(int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/stubs.c:20:5: warning: no previous prototype for 'sched_unisolate_cpu' [-Wmissing-prototypes]
      20 | int sched_unisolate_cpu(int cpu)
         |     ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/stubs.c:26:5: warning: no previous prototype for 'set_task_boost' [-Wmissing-prototypes]
      26 | int set_task_boost(int boost, u64 period)
         |     ^~~~~~~~~~~~~~


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
