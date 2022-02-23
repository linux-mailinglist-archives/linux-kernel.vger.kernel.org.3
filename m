Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775614C1F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244688AbiBWXC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiBWXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:02:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34A75622E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645657316; x=1677193316;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8nPmIxmtXYqAyhRT6COYK8620ZXK4lvOet6lsed/32g=;
  b=AH7vzPJl/PIXFujh93MNfl9Vql6kny5WEVV2MdEGAO5oiFIye4kZgd+h
   ZFPOFPfgChatwNSuGM2ZV2k0wynKa4NzubG5BacBN7aFT4dyG1rqsLyN9
   x6onabEUJjasiqlDv7PE54G57IkGWdGkLpn+1KoVsmml9WgQJouXiYXgq
   hOY/lvFv01wBZHn9ra6ZCYNs+qb5O4gT3MAGlNTaPKsIQ+AKNiiDsPAIo
   VzpYXfmpsFSdNNd0+JL1nlHXOoxDZdg3eOsUWs4TBo2dASX0IXFNdcN3A
   bREsG33vTI/gKI2wbbYXIf0O1+EcxTrO3QMy1PZRztDB5a4POPAeTJiOi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235610550"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235610550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607226336"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2022 15:01:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN0dq-0001v0-P1; Wed, 23 Feb 2022 23:01:50 +0000
Date:   Thu, 24 Feb 2022 07:01:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [mingo-tip:sched/headers 13/2340] include/linux/rcupdate.h:414:36:
 error: dereferencing pointer to incomplete type 'struct css_set'
Message-ID: <202202240645.bKyoBrpQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: c4ad6fcb67c42d65481c85733c8009c8afdfdf4e [13/2340] sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220224/202202240645.bKyoBrpQ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c4ad6fcb67c42d65481c85733c8009c8afdfdf4e
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout c4ad6fcb67c42d65481c85733c8009c8afdfdf4e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/sched/headers HEAD 97c5eeb4de3ad324ed2a4656b46465299cfd010a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:255,
                    from include/linux/export.h:43,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:17,
                    from include/linux/cpumask.h:10,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   include/linux/psi.h: In function 'cgroup_move_task':
>> include/linux/rcupdate.h:414:36: error: dereferencing pointer to incomplete type 'struct css_set'
     414 | #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
         |                                    ^~~~
   include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONCE'
      55 |  *(volatile typeof(x) *)&(x) = (val);    \
         |                                 ^~~
   arch/x86/include/asm/barrier.h:67:2: note: in expansion of macro 'WRITE_ONCE'
      67 |  WRITE_ONCE(*p, v);      \
         |  ^~~~~~~~~~
   include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
     164 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:455:3: note: in expansion of macro 'smp_store_release'
     455 |   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |   ^~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:455:25: note: in expansion of macro 'RCU_INITIALIZER'
     455 |   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
         |                         ^~~~~~~~~~~~~~~
   include/linux/psi.h:58:2: note: in expansion of macro 'rcu_assign_pointer'
      58 |  rcu_assign_pointer(p->cgroups, to);
         |  ^~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/fair.c:52:
   kernel/sched/sched.h: In function 'sched_core_account_forceidle':
   kernel/sched/sched.h:1934:6: error: implicit declaration of function 'schedstat_enabled'; did you mean 'sched_core_enabled'? [-Werror=implicit-function-declaration]
    1934 |  if (schedstat_enabled())
         |      ^~~~~~~~~~~~~~~~~
         |      sched_core_enabled
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:11136:6: warning: no previous prototype for 'task_vruntime_update' [-Wmissing-prototypes]
   11136 | void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi)
         |      ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +414 include/linux/rcupdate.h

ca5ecddfa8fcbd Paul E. McKenney 2010-04-28  409  
462225ae47d717 Paul E. McKenney 2013-11-11  410  /**
462225ae47d717 Paul E. McKenney 2013-11-11  411   * RCU_INITIALIZER() - statically initialize an RCU-protected global variable
462225ae47d717 Paul E. McKenney 2013-11-11  412   * @v: The value to statically initialize with.
462225ae47d717 Paul E. McKenney 2013-11-11  413   */
462225ae47d717 Paul E. McKenney 2013-11-11 @414  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
462225ae47d717 Paul E. McKenney 2013-11-11  415  

:::::: The code at line 414 was first introduced by commit
:::::: 462225ae47d7175f886281d8a91708550cd5178c rcu: Add an RCU_INITIALIZER for global RCU-protected pointers

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
