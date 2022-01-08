Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0048814D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 05:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiAHEgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 23:36:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:26192 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbiAHEgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 23:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641616596; x=1673152596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jJIYD2+JxGdZJd7hRTmLQg4dIy8Hi2EawL1T3h9xbsU=;
  b=Zy9nE22yiugLAXKigt3ccfhmOx8G7tw4TW7hol/OPpNZhB/1CW8GIaHF
   1Ydo7YMDRvNYYD7qetktD+hXg5N2+sTE6ThyHjD9DLvGcbxywWEus7NuP
   +pTNvKfSML8SZ+j9cXO66BvFRBt2XEd/6nA9asFbYWP0xT1mP+ccnGVGL
   yhSUcjRPgGz7ikETmiLVefGCDPab0iV6Ymsh9GnBbbmWME/X/f+cclWcI
   p1YxiBdAcP56nsF1zNpEf5IWqiIJzjGeDxi/2tsqNKLpJapTFoDzoPmk1
   jUDfNww4oMH19btVkEYyPfqQoBWiparihS+ubJ+8pqBmYU7CwZ1KKzkgZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="242936644"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="242936644"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 20:36:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="690010525"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Jan 2022 20:36:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n63T0-0000Fp-8O; Sat, 08 Jan 2022 04:36:34 +0000
Date:   Sat, 8 Jan 2022 12:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1785/2372] kernel/sched/core.c:5331:20:
 warning: no previous prototype for 'task_sched_runtime'
Message-ID: <202201081252.k0vPJH1N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   67f8f45b4d0cf00f8e53fc1c2b50c67608ede063
commit: b0906e7a2f182e8f595888b41c1fc6f0c80c4f6d [1785/2372] headers/deps: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220108/202201081252.k0vPJH1N-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b0906e7a2f182e8f595888b41c1fc6f0c80c4f6d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b0906e7a2f182e8f595888b41c1fc6f0c80c4f6d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/core.c:5331:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
    5331 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:9450:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
    9450 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
   kernel/sched/core.c:9480:13: warning: no previous prototype for 'per_task_init' [-Wmissing-prototypes]
    9480 | void __init per_task_init(void)
         |             ^~~~~~~~~~~~~
>> kernel/sched/core.c:9489:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
    9489 | void __init sched_init(void)
         |             ^~~~~~~~~~


vim +/task_sched_runtime +5331 kernel/sched/core.c

6075620b0590ea kernel/sched/core.c Giovanni Gherdovich 2016-08-05  5325  
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5326  /*
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5327   * Return accounted runtime for the task.
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5328   * In case the task is currently running, return the runtime plus current's
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5329   * pending runtime that have not been accounted yet.
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5330   */
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31 @5331  unsigned long long task_sched_runtime(struct task_struct *p)
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5332  {
eb58075149b7f0 kernel/sched/core.c Peter Zijlstra      2015-07-31  5333  	struct rq_flags rf;
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5334  	struct rq *rq;
6e998916dfe327 kernel/sched/core.c Stanislaw Gruszka   2014-11-12  5335  	u64 ns;
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5336  

:::::: The code at line 5331 was first introduced by commit
:::::: c5f8d99585d7b5b7e857fabf8aefd0174903a98c posixtimers, sched: Fix posix clock monotonicity

:::::: TO: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
