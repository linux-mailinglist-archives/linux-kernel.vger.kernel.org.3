Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D148357B07E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbiGTFpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiGTFpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:45:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0A111E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658295911; x=1689831911;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QFFyxwKJEVLgLwJNrBwaH2ZIKsyvFq4g+zsg7SwcDhQ=;
  b=kBTNcyPHX0SzEyr5ucMoN1yaAyiqHCXEnPH00BfUkVGB/PSB1SEt+Gyd
   rp0kEatePoS60ANlcQgu4Ye4jQS6I6LQl8mzudGHmFUZeczINBroduMjV
   rujWxiOMrba+6kJR3C2YQx77v/f+tj7AHkP3bVcu39LUkG6nuTgwA4urM
   /fNb8CSZERf24v6Er1MxF29T4ONVvY0gKCxJ4Tc72dXum5SnMp4iBa3Nl
   zNRtUqFt7lLIJii93EQJ/9qeR3Hepx3HIs9h5QP3TXxuO/LSVJXBlPz6Y
   dtnP5ibrAcPK5N5Lee6YXHUhWDRdaQ62AGQIXxzVKZPaG+wROc+i9N8x1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="273521245"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="273521245"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 22:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="925089745"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2022 22:45:09 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE2WC-00004D-EU;
        Wed, 20 Jul 2022 05:45:08 +0000
Date:   Wed, 20 Jul 2022 13:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rt-devel:linux-5.19.y-rt-rebase 9/51] kernel/sched/core.c:3058:1:
 warning: '__sched_setaffinity' used but never defined
Message-ID: <202207201330.PNv5wnSX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.19.y-rt-rebase
head:   398bbc77845fdc2ffca4a523eeadd5707338b0d3
commit: 088b0c2db600fb1a2b5687a9a4d1a069a624eee7 [9/51] sched: Consider task_struct::saved_state in wait_task_inactive().
config: s390-randconfig-r044-20220718 (https://download.01.org/0day-ci/archive/20220720/202207201330.PNv5wnSX-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=088b0c2db600fb1a2b5687a9a4d1a069a624eee7
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.19.y-rt-rebase
        git checkout 088b0c2db600fb1a2b5687a9a4d1a069a624eee7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/core.c: In function 'wait_task_inactive':
   kernel/sched/core.c:11195:2: error: unterminated argument list invoking macro "if"
   11195 | }
         |  ^
   kernel/sched/core.c:11196: error: expected '(' at end of input
   kernel/sched/core.c:3310:33: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
    3310 |                                 if (READ_ONCE(p->__state != match_state)
         |                                 ^~
   kernel/sched/core.c:3310:33: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
   kernel/sched/core.c:3310:33: error: expected declaration or statement at end of input
   kernel/sched/core.c:3308:38: warning: unused variable 'mismatch' [-Wunused-variable]
    3308 |                                 bool mismatch = false;
         |                                      ^~~~~~~~
   kernel/sched/core.c:3310:33: error: expected declaration or statement at end of input
    3310 |                                 if (READ_ONCE(p->__state != match_state)
         |                                 ^~
   kernel/sched/core.c:3310:33: error: expected declaration or statement at end of input
   kernel/sched/core.c:3310:33: error: expected declaration or statement at end of input
   kernel/sched/core.c:3283:14: warning: unused variable 'update_ncsw' [-Wunused-variable]
    3283 |         bool update_ncsw;
         |              ^~~~~~~~~~~
   kernel/sched/core.c:3282:14: warning: unused variable 'saved_state_match' [-Wunused-variable]
    3282 |         bool saved_state_match;
         |              ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:3280:23: warning: unused variable 'ncsw' [-Wunused-variable]
    3280 |         unsigned long ncsw;
         |                       ^~~~
   kernel/sched/core.c:3279:25: warning: unused variable 'rf' [-Wunused-variable]
    3279 |         struct rq_flags rf;
         |                         ^~
   kernel/sched/core.c:3278:22: warning: unused variable 'queued' [-Wunused-variable]
    3278 |         int running, queued;
         |                      ^~~~~~
   kernel/sched/core.c:3278:13: warning: unused variable 'running' [-Wunused-variable]
    3278 |         int running, queued;
         |             ^~~~~~~
   kernel/sched/core.c: At top level:
>> kernel/sched/core.c:3058:1: warning: '__sched_setaffinity' used but never defined
    3058 | __sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
         | ^~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:2210:13: warning: 'migrate_disable_switch' defined but not used [-Wunused-function]
    2210 | static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:2142:12: warning: 'effective_prio' defined but not used [-Wunused-function]
    2142 | static int effective_prio(struct task_struct *p)
         |            ^~~~~~~~~~~~~~
   kernel/sched/core.c:2030:13: warning: '__setscheduler_uclamp' defined but not used [-Wunused-function]
    2030 | static void __setscheduler_uclamp(struct task_struct *p,
         |             ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:1272:13: warning: 'set_load_weight' defined but not used [-Wunused-function]
    1272 | static void set_load_weight(struct task_struct *p, bool update_load)
         |             ^~~~~~~~~~~~~~~
   kernel/sched/core.c:1165:13: warning: 'nohz_csd_func' defined but not used [-Wunused-function]
    1165 | static void nohz_csd_func(void *info)
         |             ^~~~~~~~~~~~~
   kernel/sched/core.c:931:13: warning: 'set_nr_if_polling' defined but not used [-Wunused-function]
     931 | static bool set_nr_if_polling(struct task_struct *p)
         |             ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:851:13: warning: 'hrtick_rq_init' defined but not used [-Wunused-function]
     851 | static void hrtick_rq_init(struct rq *rq)
         |             ^~~~~~~~~~~~~~
   kernel/sched/core.c:761:13: warning: 'hrtick_clear' defined but not used [-Wunused-function]
     761 | static void hrtick_clear(struct rq *rq)
         |             ^~~~~~~~~~~~
   kernel/sched/core.c:282:28: warning: 'sched_core_next' defined but not used [-Wunused-function]
     282 | static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
         |                            ^~~~~~~~~~~~~~~
   kernel/sched/core.c:268:28: warning: 'sched_core_find' defined but not used [-Wunused-function]
     268 | static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
         |                            ^~~~~~~~~~~~~~~


vim +/__sched_setaffinity +3058 kernel/sched/core.c

07ec77a1d4e825 Will Deacon 2021-07-30  3056  
07ec77a1d4e825 Will Deacon 2021-07-30  3057  static int
07ec77a1d4e825 Will Deacon 2021-07-30 @3058  __sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
07ec77a1d4e825 Will Deacon 2021-07-30  3059  

:::::: The code at line 3058 was first introduced by commit
:::::: 07ec77a1d4e82526e1588979fff2f024f8e96df2 sched: Allow task CPU affinity to be restricted on asymmetric systems

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
