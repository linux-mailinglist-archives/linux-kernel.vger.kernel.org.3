Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CD84CB35D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiCBXz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiCBXz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:55:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD770131112
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646265313; x=1677801313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MhUQaja/NcVj8kw9fjRzNWwu1H0JU2FYXWCdvlaoY6k=;
  b=HOIjDO/CCbUYYArHDX1kr0EGRursI1wzvRYeSdYstiodv21KN8YYRBxI
   A+OpneKVVd4xaYDMCSq04hkisl4rG1LxzwRu/rGjD+g487P2r1RhQJkmL
   s9dfQ3n3MjlqYYx+QcEjnOQZxHsVTS5avtCfSiGJy2GDlNSyj4+V6FCtc
   MTYCU+lDz99fyixNhWky8jJKPQ8ctmgmRwiP0l9g20emzgilTTYdZ5RZQ
   biwTbnA+41bL0OR1dYDIPGW7px4b9JUQ2qUfnkSdEDQYzmISSV6rEbMRh
   EyVqrkCz763SOJaGtHdaQGr8vCwDYL8V4zKlxZ26lQNNOPceWM93T+yvo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233496793"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="233496793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="594181258"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2022 15:33:00 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPYSp-00024v-Lf; Wed, 02 Mar 2022 23:32:59 +0000
Date:   Thu, 3 Mar 2022 07:32:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking 14/19]
 kernel/rcu/tree_plugin.h:932:13: error: static declaration of
 'rcu_preempt_deferred_qs' follows non-static declaration
Message-ID: <202203030729.s3AJ15rL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking
head:   e4eaff86ec91c1cbde9a113cf5232dac9f897337
commit: 5a91f02835a27bd066154ab87408505806710e19 [14/19] rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220303/202203030729.s3AJ15rL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=5a91f02835a27bd066154ab87408505806710e19
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking
        git checkout 5a91f02835a27bd066154ab87408505806710e19
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4457:
>> kernel/rcu/tree_plugin.h:932:13: error: static declaration of 'rcu_preempt_deferred_qs' follows non-static declaration
     932 | static void rcu_preempt_deferred_qs(struct task_struct *t)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rcupdate.h:227,
                    from include/linux/rcupdate_wait.h:9,
                    from kernel/rcu/tree.c:25:
   include/linux/rcutree.h:63:6: note: previous declaration of 'rcu_preempt_deferred_qs' was here
      63 | void rcu_preempt_deferred_qs(struct task_struct *t);
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/tree.c:4457:
   kernel/rcu/tree_plugin.h:932:13: warning: 'rcu_preempt_deferred_qs' defined but not used [-Wunused-function]
     932 | static void rcu_preempt_deferred_qs(struct task_struct *t)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/rcu_preempt_deferred_qs +932 kernel/rcu/tree_plugin.h

790da248978a072 Paul E. McKenney 2021-09-29  927  
790da248978a072 Paul E. McKenney 2021-09-29  928  // Except that we do need to respond to a request by an expedited grace
790da248978a072 Paul E. McKenney 2021-09-29  929  // period for a quiescent state from this CPU.  Note that requests from
790da248978a072 Paul E. McKenney 2021-09-29  930  // tasks are handled when removing the task from the blocked-tasks list
790da248978a072 Paul E. McKenney 2021-09-29  931  // below.
790da248978a072 Paul E. McKenney 2021-09-29 @932  static void rcu_preempt_deferred_qs(struct task_struct *t)
790da248978a072 Paul E. McKenney 2021-09-29  933  {
790da248978a072 Paul E. McKenney 2021-09-29  934  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
790da248978a072 Paul E. McKenney 2021-09-29  935  
790da248978a072 Paul E. McKenney 2021-09-29  936  	if (rdp->cpu_no_qs.b.exp)
790da248978a072 Paul E. McKenney 2021-09-29  937  		rcu_report_exp_rdp(rdp);
790da248978a072 Paul E. McKenney 2021-09-29  938  }
3e31009898699df Paul E. McKenney 2018-06-21  939  

:::::: The code at line 932 was first introduced by commit
:::::: 790da248978a0722d92d1471630c881704f7eb0d rcu: Make idle entry report expedited quiescent states

:::::: TO: Paul E. McKenney <paulmck@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
