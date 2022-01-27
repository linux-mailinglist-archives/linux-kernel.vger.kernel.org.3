Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1548C49D7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiA0Bwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:52:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:35841 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234673AbiA0Bwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643248351; x=1674784351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JGLShA0tdarHhBN2Mw2kO/f1A6Hwui5VClVfAkM7MNM=;
  b=DO0TvlZimKlYslLng2CqVhhqpu47I7kFTcfRwBx1ccFSCaIFIFmg3IWI
   9aVEEz9je1J6Q8MNjxXaQVdZ5i+SYNSgNOU2K1afitvGX7HLNKfloUNnx
   Ss7YIDwdwTjik9g93bP/6RJxkCVsQ4v7cjLrmC6q1/nVEYUGjO8WjZ9zh
   X8XHyEHv+4dUtaTpC3y4VgGuFmLufvLqWPPhlw8nuDBFN1xLvtneHJaDt
   haX8UHSLz2e8eeeh/QWCiMGPrvLi3qJGr66z1Nqt1p4K5bDDOiwgkivNc
   zl3T11149nBK9MY6ZEFg7X8Ol1ptKA8Jwygol/1E9YHxZiKA+bODnDPuZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271170340"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="271170340"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 17:52:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="581305609"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2022 17:52:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCtxd-000Lxa-8X; Thu, 27 Jan 2022 01:52:29 +0000
Date:   Thu, 27 Jan 2022 09:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 2289/9999] kernel/sched/psi.c:538:3: error: implicit declaration of function
 'trace_android_vh_psi_event'
Message-ID: <202201270959.49bfLJfz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   b0d13db791b8774617b72c9242a7cf49f67720b2
commit: b79d1815c400c3929bb78a209b6e51a38d6ffcb2 [2289/9999] ANDROID: psi: Add vendor hooks for PSI tracing
config: i386-randconfig-a011-20220124 (https://download.01.org/0day-ci/archive/20220127/202201270959.49bfLJfz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2a1b7aa016c0f4b5598806205bdfbab1ea2d92c4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b79d1815c400c3929bb78a209b6e51a38d6ffcb2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout b79d1815c400c3929bb78a209b6e51a38d6ffcb2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/google/android/kernel/common/android12-5.10 HEAD b0d13db791b8774617b72c9242a7cf49f67720b2 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> kernel/sched/psi.c:538:3: error: implicit declaration of function 'trace_android_vh_psi_event' [-Werror,-Wimplicit-function-declaration]
                   trace_android_vh_psi_event(t);
                   ^
>> kernel/sched/psi.c:546:2: error: implicit declaration of function 'trace_android_vh_psi_group' [-Werror,-Wimplicit-function-declaration]
           trace_android_vh_psi_group(group);
           ^
   2 errors generated.


vim +/trace_android_vh_psi_event +538 kernel/sched/psi.c

   503	
   504	static u64 update_triggers(struct psi_group *group, u64 now)
   505	{
   506		struct psi_trigger *t;
   507		bool new_stall = false;
   508		u64 *total = group->total[PSI_POLL];
   509	
   510		/*
   511		 * On subsequent updates, calculate growth deltas and let
   512		 * watchers know when their specified thresholds are exceeded.
   513		 */
   514		list_for_each_entry(t, &group->triggers, node) {
   515			u64 growth;
   516	
   517			/* Check for stall activity */
   518			if (group->polling_total[t->state] == total[t->state])
   519				continue;
   520	
   521			/*
   522			 * Multiple triggers might be looking at the same state,
   523			 * remember to update group->polling_total[] once we've
   524			 * been through all of them. Also remember to extend the
   525			 * polling time if we see new stall activity.
   526			 */
   527			new_stall = true;
   528	
   529			/* Calculate growth since last update */
   530			growth = window_update(&t->win, now, total[t->state]);
   531			if (growth < t->threshold)
   532				continue;
   533	
   534			/* Limit event signaling to once per window */
   535			if (now < t->last_event_time + t->win.size)
   536				continue;
   537	
 > 538			trace_android_vh_psi_event(t);
   539	
   540			/* Generate an event */
   541			if (cmpxchg(&t->event, 0, 1) == 0)
   542				wake_up_interruptible(&t->event_wait);
   543			t->last_event_time = now;
   544		}
   545	
 > 546		trace_android_vh_psi_group(group);
   547	
   548		if (new_stall)
   549			memcpy(group->polling_total, total,
   550					sizeof(group->polling_total));
   551	
   552		return now + group->poll_min_period;
   553	}
   554	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
