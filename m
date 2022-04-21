Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D095098C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385566AbiDUHJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiDUHJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:09:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21A16585
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650524815; x=1682060815;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WYxovo6fYu6pP21wbxbUzNXnneCANdbhHpH49GnDGis=;
  b=BLGHEacNoBGHTAPEQElTqGfDtiF2/c+ONYlZKNwZqEVBt+72JZv2UUd4
   8w3ILCo8C1GbpyalcYm4dyPsTUOlbRSb+KL61x/VYjfGRq8hQHtSvToFY
   hGII8v/K7bQeJoABZGZWOtXXWm8pPvtCdgkY66AvR7N8tKpiy9xYroNI/
   WwbrwY4742w6wEQlQ+of3JYznLOv+2mOY2/yMwy6mOySi7P1cltSHFtUs
   vMr8gT7XSyLETq2JKmEdgBF4rotjDq4ueL5Arfz9CI3Fr7UjGEWVkLU0D
   A9EMSgKhPxXnIgKK5l54+IbsbiA4FQkoMwsjiI7kr81fKzZf3H0UurlMo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="251575635"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="251575635"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="510926204"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2022 00:06:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQtw-00084H-Vk;
        Thu, 21 Apr 2022 07:06:52 +0000
Date:   Thu, 21 Apr 2022 15:05:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1822/2579] kernel/signal.c:2990:2: error:
 implicit declaration of function 'cgroup_threadgroup_change_begin' is
 invalid in C99
Message-ID: <202204211446.ajV6GlxA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 5256e0b3a0d316629bf14a3e23258fc69496eee1 [1822/2579] headers/deps: cgroup: Move the cgroup_threadgroup_*() inline functions from <linux/cgroup_types.h> to <linux/cgroup_api.h>
config: mips-randconfig-r026-20220419 (https://download.01.org/0day-ci/archive/20220421/202204211446.ajV6GlxA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5256e0b3a0d316629bf14a3e23258fc69496eee1
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5256e0b3a0d316629bf14a3e23258fc69496eee1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/signal.c:190:6: error: implicit declaration of function 'cgroup_task_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
               cgroup_task_frozen(t)) {
               ^
   kernel/signal.c:2325:3: error: implicit declaration of function 'cgroup_enter_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cgroup_enter_frozen();
                   ^
   kernel/signal.c:2328:3: error: implicit declaration of function 'cgroup_leave_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cgroup_leave_frozen(true);
                   ^
   kernel/signal.c:2328:3: note: did you mean 'cgroup_enter_frozen'?
   kernel/signal.c:2325:3: note: 'cgroup_enter_frozen' declared here
                   cgroup_enter_frozen();
                   ^
   kernel/signal.c:2516:3: error: implicit declaration of function 'cgroup_enter_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cgroup_enter_frozen();
                   ^
   kernel/signal.c:2595:2: error: implicit declaration of function 'cgroup_enter_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cgroup_enter_frozen();
           ^
   kernel/signal.c:2763:16: error: implicit declaration of function 'cgroup_task_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   if (unlikely(cgroup_task_frozen(current))) {
                                ^
   kernel/signal.c:2765:4: error: implicit declaration of function 'cgroup_leave_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           cgroup_leave_frozen(false);
                           ^
   kernel/signal.c:2865:4: error: implicit declaration of function 'cgroup_leave_frozen' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           cgroup_leave_frozen(true);
                           ^
>> kernel/signal.c:2990:2: error: implicit declaration of function 'cgroup_threadgroup_change_begin' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cgroup_threadgroup_change_begin(tsk);
           ^
>> kernel/signal.c:2994:3: error: implicit declaration of function 'cgroup_threadgroup_change_end' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   cgroup_threadgroup_change_end(tsk);
                   ^
   kernel/signal.c:2994:3: note: did you mean 'cgroup_threadgroup_change_begin'?
   kernel/signal.c:2990:2: note: 'cgroup_threadgroup_change_begin' declared here
           cgroup_threadgroup_change_begin(tsk);
           ^
   kernel/signal.c:3005:2: error: implicit declaration of function 'cgroup_threadgroup_change_end' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           cgroup_threadgroup_change_end(tsk);
           ^
   11 errors generated.


vim +/cgroup_threadgroup_change_begin +2990 kernel/signal.c

0edceb7bcd82802 Oleg Nesterov     2011-04-27  2980  
d12619b5ff56646 Oleg Nesterov     2008-02-08  2981  void exit_signals(struct task_struct *tsk)
d12619b5ff56646 Oleg Nesterov     2008-02-08  2982  {
d12619b5ff56646 Oleg Nesterov     2008-02-08  2983  	int group_stop = 0;
f646e227b88a164 Oleg Nesterov     2011-04-27  2984  	sigset_t unblocked;
d12619b5ff56646 Oleg Nesterov     2008-02-08  2985  
77e4ef99d1c596a Tejun Heo         2011-12-12  2986  	/*
77e4ef99d1c596a Tejun Heo         2011-12-12  2987  	 * @tsk is about to have PF_EXITING set - lock out users which
77e4ef99d1c596a Tejun Heo         2011-12-12  2988  	 * expect stable threadgroup.
77e4ef99d1c596a Tejun Heo         2011-12-12  2989  	 */
780de9dd2720deb Ingo Molnar       2017-02-02 @2990  	cgroup_threadgroup_change_begin(tsk);
77e4ef99d1c596a Tejun Heo         2011-12-12  2991  
49697335e0b441b Eric W. Biederman 2021-06-24  2992  	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
b5b5c995e31d80e Ingo Molnar       2022-04-14  2993  		task_flags(tsk) |= PF_EXITING;
780de9dd2720deb Ingo Molnar       2017-02-02 @2994  		cgroup_threadgroup_change_end(tsk);
5dee1707dfbfc55 Oleg Nesterov     2008-02-08  2995  		return;
d12619b5ff56646 Oleg Nesterov     2008-02-08  2996  	}
d12619b5ff56646 Oleg Nesterov     2008-02-08  2997  
5dee1707dfbfc55 Oleg Nesterov     2008-02-08  2998  	spin_lock_irq(&tsk->sighand->siglock);
d12619b5ff56646 Oleg Nesterov     2008-02-08  2999  	/*
d12619b5ff56646 Oleg Nesterov     2008-02-08  3000  	 * From now this task is not visible for group-wide signals,
d12619b5ff56646 Oleg Nesterov     2008-02-08  3001  	 * see wants_signal(), do_signal_stop().
d12619b5ff56646 Oleg Nesterov     2008-02-08  3002  	 */
b5b5c995e31d80e Ingo Molnar       2022-04-14  3003  	task_flags(tsk) |= PF_EXITING;
77e4ef99d1c596a Tejun Heo         2011-12-12  3004  
780de9dd2720deb Ingo Molnar       2017-02-02  3005  	cgroup_threadgroup_change_end(tsk);
77e4ef99d1c596a Tejun Heo         2011-12-12  3006  
5c251e9dc0e127b Jens Axboe        2020-10-26  3007  	if (!task_sigpending(tsk))
5dee1707dfbfc55 Oleg Nesterov     2008-02-08  3008  		goto out;
5dee1707dfbfc55 Oleg Nesterov     2008-02-08  3009  
ec2f4babb822f72 Ingo Molnar       2022-01-28  3010  	unblocked = per_task(tsk, blocked);
f646e227b88a164 Oleg Nesterov     2011-04-27  3011  	signotset(&unblocked);
f646e227b88a164 Oleg Nesterov     2011-04-27  3012  	retarget_shared_pending(tsk, &unblocked);
5dee1707dfbfc55 Oleg Nesterov     2008-02-08  3013  
a8f072c1d624a62 Tejun Heo         2011-06-02  3014  	if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING) &&
e5c1902e9260a00 Tejun Heo         2011-03-23  3015  	    task_participate_group_stop(tsk))
edf2ed153bcae52 Tejun Heo         2011-03-23  3016  		group_stop = CLD_STOPPED;
5dee1707dfbfc55 Oleg Nesterov     2008-02-08  3017  out:
d12619b5ff56646 Oleg Nesterov     2008-02-08  3018  	spin_unlock_irq(&tsk->sighand->siglock);
d12619b5ff56646 Oleg Nesterov     2008-02-08  3019  
62bcf9d992ecc19 Tejun Heo         2011-03-23  3020  	/*
62bcf9d992ecc19 Tejun Heo         2011-03-23  3021  	 * If group stop has completed, deliver the notification.  This
62bcf9d992ecc19 Tejun Heo         2011-03-23  3022  	 * should always go to the real parent of the group leader.
62bcf9d992ecc19 Tejun Heo         2011-03-23  3023  	 */
ae6d2ed7bb3877f Roland McGrath    2009-09-23  3024  	if (unlikely(group_stop)) {
d12619b5ff56646 Oleg Nesterov     2008-02-08  3025  		read_lock(&tasklist_lock);
62bcf9d992ecc19 Tejun Heo         2011-03-23  3026  		do_notify_parent_cldstop(tsk, false, group_stop);
d12619b5ff56646 Oleg Nesterov     2008-02-08  3027  		read_unlock(&tasklist_lock);
d12619b5ff56646 Oleg Nesterov     2008-02-08  3028  	}
d12619b5ff56646 Oleg Nesterov     2008-02-08  3029  }
d12619b5ff56646 Oleg Nesterov     2008-02-08  3030  

:::::: The code at line 2990 was first introduced by commit
:::::: 780de9dd2720debc14c501dab4dc80d1f75ad50e sched/headers, cgroups: Remove the threadgroup_change_*() wrappery

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
