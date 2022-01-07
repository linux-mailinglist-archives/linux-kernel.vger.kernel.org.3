Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E866487BCE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbiAGSHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:07:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:57947 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240587AbiAGSHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641578828; x=1673114828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uJCOkQpN6ukIBCDg2aSBzPeLplMavJxmP1Qjzga/9wE=;
  b=FeSr3/4Tidy7oESlXRGbB9XtdUGpC2m+ridLEzopWeroC0W3bp3M2SHg
   qscFiB+ThDnuCNyIFw+RAdEhPgdasuslDjSfWxz23UGdAE2dhMjnfQVwa
   4oymZoIKUqHUdZzigeBHFiMCg6Z/aYQCTYKVbdxV0QMRUmTNRh9Uw8HMx
   pgzgVJHdcbywXy2vS9K1XuLJCOiLv9Houjbs8iLKAiSzfvDjU9nCHVHhE
   f67BvjfmZytlDP+jEmwvu9DeRAfjrpjYCi8hEcXBz92Y9e6OxzkyMe2jg
   9GJaFqTmCFZlpnHLkz6O0zCKnsG6RLBfTFONj7vrEMhsrx1xeuC9mxb7R
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="303655048"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="303655048"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="622007250"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 10:07:06 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5tdq-000Iv9-7i; Fri, 07 Jan 2022 18:07:06 +0000
Date:   Sat, 8 Jan 2022 02:06:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephen Dickey <quic_dickey@quicinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.15
 21/2544] kernel/sched/core.c:2308:12: warning: no previous prototype for
 '__migrate_task'
Message-ID: <202201080130.BU3Jp2mc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.15
head:   1d50adbe5ad4df334a576ab1d43c176306255e8a
commit: ca2177d4a03ddc4e6b64e54e0e7a176e282b4e18 [21/2544] ANDROID: sched: allow access to critical common code for CPU Pause
config: arc-randconfig-r043-20220107 (https://download.01.org/0day-ci/archive/20220108/202201080130.BU3Jp2mc-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ca2177d4a03ddc4e6b64e54e0e7a176e282b4e18
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.15
        git checkout ca2177d4a03ddc4e6b64e54e0e7a176e282b4e18
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:2308:12: warning: no previous prototype for '__migrate_task' [-Wmissing-prototypes]
    2308 | struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
         |            ^~~~~~~~~~~~~~
   kernel/sched/core.c:3459:6: warning: no previous prototype for 'sched_set_stop_task' [-Wmissing-prototypes]
    3459 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/__migrate_task +2308 kernel/sched/core.c

  2298	
  2299	/*
  2300	 * Move (not current) task off this CPU, onto the destination CPU. We're doing
  2301	 * this because either it can't run here any more (set_cpus_allowed()
  2302	 * away from this CPU, or CPU going down), or because we're
  2303	 * attempting to rebalance this task on exec (sched_exec).
  2304	 *
  2305	 * So we race with normal scheduler movements, but that's OK, as long
  2306	 * as the task is no longer on this CPU.
  2307	 */
> 2308	struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  2309				  struct task_struct *p, int dest_cpu)
  2310	{
  2311		/* Affinity changed (again). */
  2312		if (!is_cpu_allowed(p, dest_cpu))
  2313			return rq;
  2314	
  2315		update_rq_clock(rq);
  2316		rq = move_queued_task(rq, rf, p, dest_cpu);
  2317	
  2318		return rq;
  2319	}
  2320	EXPORT_SYMBOL_GPL(__migrate_task);
  2321	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
