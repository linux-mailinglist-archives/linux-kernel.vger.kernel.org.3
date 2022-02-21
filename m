Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243544BD470
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbiBUDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:45:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiBUDp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:45:29 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472C3C70E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 19:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645415107; x=1676951107;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mXaE3NrZ/6rQAuz2OlCanXe+El280BbMnY6fc1exphw=;
  b=AWgN2GZZmWPf0F56FfAykwrFDxt1Ppg9g6ypER5Oehj34zyDqCnJntbQ
   njR6mCxwowDP2c/7ICbxQGwJhmgPCRnmkvGhyO9S9Wq0L2kbwFEDQbAGX
   psQI3Tb5Ii+WbEBds/cyPFxYuldjFSoqJgiLHs4Cs73ES3AX/B14dBlEm
   xR70T0z7tzea6SKUape+7RQquNn9DhREET46LJYLxVJ4bLufCT6dW+j1Q
   dT7OLr+I/JDPO21HmOdGLfyYAvZm00Trob+VKHcZwoD3z85zPBpIx72jR
   /wlYbWkYUEB46UeAyc84UeAhj5Y5ozF7TtKl9+Jy9Nsb8jq0//Kcg84Ez
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251376475"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251376475"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 19:45:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="490305833"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2022 19:45:05 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLzdI-0001Gy-U0; Mon, 21 Feb 2022 03:45:04 +0000
Date:   Mon, 21 Feb 2022 11:44:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 90/2574] kernel/sched/deadline.c:1883:50:
 sparse: sparse: cast removes address space '__rcu' of expression
Message-ID: <202202211135.6YTPVoRB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: d58c0a66fcb697b448eee902e4d8faa3ebe21c0d [90/2574] headers/deps: sched/deadline: Move task->dl to per_task
config: sparc64-randconfig-s031-20220220 (https://download.01.org/0day-ci/archive/20220221/202202211135.6YTPVoRB-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=d58c0a66fcb697b448eee902e4d8faa3ebe21c0d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout d58c0a66fcb697b448eee902e4d8faa3ebe21c0d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/sched/deadline.c:1883:50: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/sched/deadline.c:1114:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1114:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1114:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1243:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1243:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1243:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1738:9: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/sched/deadline.c:2587:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2587:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2587:22: sparse:    struct task_struct *
   kernel/sched/deadline.c:1142:24: sparse: sparse: context imbalance in 'dl_task_timer' - wrong count at exit
   kernel/sched/deadline.c:1383:24: sparse: sparse: context imbalance in 'inactive_task_timer' - wrong count at exit
   kernel/sched/deadline.c: note: in included file:
   kernel/sched/sched.h:2036:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2036:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2036:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2036:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2036:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2036:25: sparse:    struct task_struct *

vim +/__rcu +1883 kernel/sched/deadline.c

  1875	
  1876	/*
  1877	 * Only called when both the current and waking task are -deadline
  1878	 * tasks.
  1879	 */
  1880	static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
  1881					  int flags)
  1882	{
> 1883		if (dl_entity_preempt(&per_task(p, dl), &per_task(rq->curr, dl))) {
  1884			resched_curr(rq);
  1885			return;
  1886		}
  1887	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
