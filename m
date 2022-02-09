Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ED74AF2A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiBIN0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiBIN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:26:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75AC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644413210; x=1675949210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6DKxCFQJ9oU5QPYSOOtg3CCeMrAr4BbVYfGJoLooKVs=;
  b=nTFaeOLLY84ikTJTAQZUH9oTgXTWAWK48uSB61a+YGIbgQdquwRG8utd
   dnWtXfi7EuVajVtGSI1NskxYauKSo8i81XtMF2K+XmHpCyMo13doi2FlR
   pMTiVXb1tWvLwvRZnRdrg6KjTsB6RMbHQz+OaFYp2Us9Yu48LT0reOKuu
   hRspMrQq9MzZiUdGUvJ7udTC/8WQslVUKrGP4rW8c8d1714Li+RQ6DbFB
   IaUv4VPDalzMTIHmoN5JzmkGNFguKRVc0KHo66svnD/goxMsJK9e/1jNI
   GXU6lwTqFqhcwDiOhTD+SE1X7KEbsYORWiWSxQ/4XIe8HrHRUOWCr0OHl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229849497"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229849497"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:26:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="585560489"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2022 05:26:48 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHmzf-0001rX-V6; Wed, 09 Feb 2022 13:26:47 +0000
Date:   Wed, 9 Feb 2022 21:26:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/core 29/29] kernel/sched/fair.c:230:9: error:
 implicit declaration of function 'sched_cfs_bandwidth_sysctl_init'
Message-ID: <202202092104.f0q3gfHV-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
head:   bf8d9ef490e0600b3b30ac2244858ecd327123ab
commit: bf8d9ef490e0600b3b30ac2244858ecd327123ab [29/29] sched: Move cfs_bandwidth_slice sysctls to fair.c
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220209/202202092104.f0q3gfHV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=bf8d9ef490e0600b3b30ac2244858ecd327123ab
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/core
        git checkout bf8d9ef490e0600b3b30ac2244858ecd327123ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'sched_init_granularity':
>> kernel/sched/fair.c:230:9: error: implicit declaration of function 'sched_cfs_bandwidth_sysctl_init' [-Werror=implicit-function-declaration]
     230 |         sched_cfs_bandwidth_sysctl_init();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:652:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     652 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:5469:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5469 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11694:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11694 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11696:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11696 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11701:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11701 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11703:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11703 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sched_cfs_bandwidth_sysctl_init +230 kernel/sched/fair.c

   226	
   227	void __init sched_init_granularity(void)
   228	{
   229		update_sysctl();
 > 230		sched_cfs_bandwidth_sysctl_init();
   231	}
   232	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
