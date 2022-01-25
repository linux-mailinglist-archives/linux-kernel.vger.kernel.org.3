Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C5049A814
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316259AbiAYCzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:1109 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3412899AbiAYAh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643071079; x=1674607079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xADFYjtp43qyO+CIOIsghZgbI9d5poWSqca6xjSn2SY=;
  b=NNZz/p+MmoWb5lB9hh+E2K2UhBj0Ygfxwf33KBz/fjuKxdgrgjEC0t6Q
   fTLLv9QTjcvUTCh+7obvuHDm25abLKTglqKew7n+dIyr2VAocVloaiQ/N
   gekoYeJ6ShioxbhHvxvluxT/dC2oRxD7M521mkNuTBFVFhaatHkCGIQNI
   bPIjhKSAmu0OXvNsQoo4PTBiSr8mVz7KQHH86HqvouuOOyGvKRsZ9+sn4
   FCafDe7WFQBQwQ3NFn7VbWmq6zLak+PFxLACHY51o1BbK5+G3vEqINYy/
   Rlj8RlGrv8jBLcSZb/AOdwaWY8uCCKKoDG1Hj1CAPtNtmqVEZykLTs81I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309501730"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="309501730"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 16:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="580573139"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2022 16:27:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC9g2-000J6t-CL; Tue, 25 Jan 2022 00:27:14 +0000
Date:   Tue, 25 Jan 2022 08:26:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Dickey <quic_dickey@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 2898/2936] kernel/sched/sched.h:1553:15: error: must use 'struct' tag to
 refer to type 'rq'
Message-ID: <202201250831.PBiV30bo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   b7e4947b29bb8d0351c581d9365780d9b6f4d702
commit: 50f5345c8756129044a3246800f51f04ae2f55b0 [2898/2936] ANDROID: __migrate_task header
config: arm-randconfig-r003-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250831.PBiV30bo-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/ammarfaizi2/linux-block/commit/50f5345c8756129044a3246800f51f04ae2f55b0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout 50f5345c8756129044a3246800f51f04ae2f55b0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:13:
>> kernel/sched/sched.h:1553:15: error: must use 'struct' tag to refer to type 'rq'
   static inline rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
                 ^
                 struct 
   1 error generated.
--
   In file included from kernel/sched/fair.c:23:
>> kernel/sched/sched.h:1553:15: error: must use 'struct' tag to refer to type 'rq'
   static inline rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
                 ^
                 struct 
   kernel/sched/fair.c:628:5: warning: no previous prototype for function 'sched_update_scaling' [-Wmissing-prototypes]
   int sched_update_scaling(void)
       ^
   kernel/sched/fair.c:628:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int sched_update_scaling(void)
   ^
   static 
   kernel/sched/fair.c:4494:6: warning: no previous prototype for function 'set_next_entity' [-Wmissing-prototypes]
   void set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
        ^
   kernel/sched/fair.c:4494:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
   ^
   static 
   2 warnings and 1 error generated.
--
   In file included from kernel/sched/rt.c:6:
>> kernel/sched/sched.h:1553:15: error: must use 'struct' tag to refer to type 'rq'
   static inline rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
                 ^
                 struct 
   kernel/sched/rt.c:677:6: warning: no previous prototype for function 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
        ^
   kernel/sched/rt.c:677:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
   ^
   static 
   1 warning and 1 error generated.


vim +1553 kernel/sched/sched.h

  1548	
  1549	#ifdef CONFIG_SMP
  1550	extern struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  1551					 struct task_struct *p, int dest_cpu);
  1552	#else /* !CONFIG_SMP */
> 1553	static inline rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  1554					 struct task_struct *p, int dest_cpu) { return rq; }
  1555	#endif
  1556	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
