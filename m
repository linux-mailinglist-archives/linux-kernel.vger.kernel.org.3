Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EAF4FC44C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbiDKSrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiDKSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:47:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA38252A4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649702692; x=1681238692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P+8m35ft841B/+Q+j3lxElw6g+hJYxxjCWj4A+qeHQw=;
  b=Q0e98u41qvSlA5rS57zoWajgx0zYgjWjuT2OrKy9AKbS32zouee5adU3
   J1+lOUz78XbckG/yqNMcRx/n49VFPYZHbYZ0JcygqBnfStUlGlReWBStH
   nQddcnBSYlDkXn6D8hyM7NhLJC7+/W9urEeVv48gN3Mbkj0L3GDj9n00U
   SJntRUAbwPrmYwZ3aXTIsj2UMfqufXvdSXCVGKmsXg547ZmHERmG3X9jq
   IvIndE0DoaGcC0cFGKWbL4zCYNF0a8O7uc3ZAiLTAs15WppWU/DUnyrJi
   cUO/uuzc8rj/JID62vCFoTGkax8klULwXx3Zz8upKlVZj9v0RgsU6L7z3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261933643"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261933643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 11:44:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="724101796"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 11:44:50 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndz1t-00024M-NP;
        Mon, 11 Apr 2022 18:44:49 +0000
Date:   Tue, 12 Apr 2022 02:44:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 83/131]
 kernel/rcu/tree.c:3778:13: error: implicit declaration of function
 'preempt_mode_full'; did you mean 'preempt_model_full'?
Message-ID: <202204120207.7OoY1hZZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   96d35f716a63bc46750d66a5daec804997ff7cc6
commit: 78b49c815a11d5541a7492b483eb20ec6377cafe [83/131] rcu: Fix preemption mode check on synchronize_rcu[_expedited]()
config: xtensa-buildonly-randconfig-r003-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120207.7OoY1hZZ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/78b49c815a11d5541a7492b483eb20ec6377cafe
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout 78b49c815a11d5541a7492b483eb20ec6377cafe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/paulmck/linux-rcu/dev HEAD 96d35f716a63bc46750d66a5daec804997ff7cc6 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   kernel/rcu/tree.c: In function 'rcu_blocking_is_gp':
>> kernel/rcu/tree.c:3778:13: error: implicit declaration of function 'preempt_mode_full'; did you mean 'preempt_model_full'? [-Werror=implicit-function-declaration]
    3778 |         if (preempt_mode_full() || preempt_mode_rt())
         |             ^~~~~~~~~~~~~~~~~
         |             preempt_model_full
>> kernel/rcu/tree.c:3778:36: error: implicit declaration of function 'preempt_mode_rt'; did you mean 'preempt_model_rt'? [-Werror=implicit-function-declaration]
    3778 |         if (preempt_mode_full() || preempt_mode_rt())
         |                                    ^~~~~~~~~~~~~~~
         |                                    preempt_model_rt
   cc1: some warnings being treated as errors


vim +3778 kernel/rcu/tree.c

  3761	
  3762	/*
  3763	 * During early boot, any blocking grace-period wait automatically
  3764	 * implies a grace period.  Later on, this is never the case for PREEMPTION.
  3765	 *
  3766	 * However, because a context switch is a grace period for !PREEMPTION, any
  3767	 * blocking grace-period wait automatically implies a grace period if
  3768	 * there is only one CPU online at any point time during execution of
  3769	 * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
  3770	 * occasionally incorrectly indicate that there are multiple CPUs online
  3771	 * when there was in fact only one the whole time, as this just adds some
  3772	 * overhead: RCU still operates correctly.
  3773	 */
  3774	static int rcu_blocking_is_gp(void)
  3775	{
  3776		int ret;
  3777	
> 3778		if (preempt_mode_full() || preempt_mode_rt())
  3779			return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
  3780		might_sleep();  /* Check for RCU read-side critical section. */
  3781		preempt_disable();
  3782		/*
  3783		 * If the rcu_state.n_online_cpus counter is equal to one,
  3784		 * there is only one CPU, and that CPU sees all prior accesses
  3785		 * made by any CPU that was online at the time of its access.
  3786		 * Furthermore, if this counter is equal to one, its value cannot
  3787		 * change until after the preempt_enable() below.
  3788		 *
  3789		 * Furthermore, if rcu_state.n_online_cpus is equal to one here,
  3790		 * all later CPUs (both this one and any that come online later
  3791		 * on) are guaranteed to see all accesses prior to this point
  3792		 * in the code, without the need for additional memory barriers.
  3793		 * Those memory barriers are provided by CPU-hotplug code.
  3794		 */
  3795		ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
  3796		preempt_enable();
  3797		return ret;
  3798	}
  3799	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
