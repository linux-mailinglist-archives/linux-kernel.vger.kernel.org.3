Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C418249A80F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316160AbiAYCzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:55:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:4654 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350876AbiAYAeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643070843; x=1674606843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BS5IDXDe8XnXPVJucjLc+CPuOafY6g9M7d/3D9gVmzU=;
  b=RllhXgpcYRO0wCFtKhUUTvzEI9GFvwrDSmrMgThjQRMSthqfMLUgy3o8
   qRCWxSjTlTf1MSj3ezx1GQxVZS/f+ASNSNtuPlBqEUZoeUrwmEuLdTvhN
   RI0tsde22/aolYDTd/qT4eLuIjOfdKBGuCdAkDaRkLCocK34nLBEF794N
   KmQ+NFYH4Xfp61BD1UcWL5zLqJRO4yKmCbUl1CA76gyoHq14mgVkX9+Gu
   Yvn1r+aUv4Retbj2aljVEZvOcMsCZVL53URysK2zuWw7taGGHARiqkCvK
   e0tYvyT5sZLmKS/m8PoIr6I5VNWjfR5pb6wd/MZfVXmSD4lHGDvQrm42p
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233548771"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="233548771"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 16:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="479288857"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 16:27:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC9g2-000J6k-7j; Tue, 25 Jan 2022 00:27:14 +0000
Date:   Tue, 25 Jan 2022 08:26:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: kernel/sched/psi.c:1193:6: warning: no previous prototype for
 'psi_trigger_destroy'
Message-ID: <202201250818.178Aw4sD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: a06247c6804f1a7c86a2e5398a4c1f1db1471848 psi: Fix uaf issue when psi trigger is destroyed while being polled
date:   7 days ago
config: sh-randconfig-r012-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250818.178Aw4sD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a06247c6804f1a7c86a2e5398a4c1f1db1471848
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a06247c6804f1a7c86a2e5398a4c1f1db1471848
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/psi.c:1123:21: warning: no previous prototype for 'psi_trigger_create' [-Wmissing-prototypes]
    1123 | struct psi_trigger *psi_trigger_create(struct psi_group *group,
         |                     ^~~~~~~~~~~~~~~~~~
>> kernel/sched/psi.c:1193:6: warning: no previous prototype for 'psi_trigger_destroy' [-Wmissing-prototypes]
    1193 | void psi_trigger_destroy(struct psi_trigger *t)
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/psi.c:1260:10: warning: no previous prototype for 'psi_trigger_poll' [-Wmissing-prototypes]
    1260 | __poll_t psi_trigger_poll(void **trigger_ptr,
         |          ^~~~~~~~~~~~~~~~


vim +/psi_trigger_destroy +1193 kernel/sched/psi.c

  1192	
> 1193	void psi_trigger_destroy(struct psi_trigger *t)
  1194	{
  1195		struct psi_group *group;
  1196		struct task_struct *task_to_destroy = NULL;
  1197	
  1198		/*
  1199		 * We do not check psi_disabled since it might have been disabled after
  1200		 * the trigger got created.
  1201		 */
  1202		if (!t)
  1203			return;
  1204	
  1205		group = t->group;
  1206		/*
  1207		 * Wakeup waiters to stop polling. Can happen if cgroup is deleted
  1208		 * from under a polling process.
  1209		 */
  1210		wake_up_interruptible(&t->event_wait);
  1211	
  1212		mutex_lock(&group->trigger_lock);
  1213	
  1214		if (!list_empty(&t->node)) {
  1215			struct psi_trigger *tmp;
  1216			u64 period = ULLONG_MAX;
  1217	
  1218			list_del(&t->node);
  1219			group->nr_triggers[t->state]--;
  1220			if (!group->nr_triggers[t->state])
  1221				group->poll_states &= ~(1 << t->state);
  1222			/* reset min update period for the remaining triggers */
  1223			list_for_each_entry(tmp, &group->triggers, node)
  1224				period = min(period, div_u64(tmp->win.size,
  1225						UPDATES_PER_WINDOW));
  1226			group->poll_min_period = period;
  1227			/* Destroy poll_task when the last trigger is destroyed */
  1228			if (group->poll_states == 0) {
  1229				group->polling_until = 0;
  1230				task_to_destroy = rcu_dereference_protected(
  1231						group->poll_task,
  1232						lockdep_is_held(&group->trigger_lock));
  1233				rcu_assign_pointer(group->poll_task, NULL);
  1234				del_timer(&group->poll_timer);
  1235			}
  1236		}
  1237	
  1238		mutex_unlock(&group->trigger_lock);
  1239	
  1240		/*
  1241		 * Wait for psi_schedule_poll_work RCU to complete its read-side
  1242		 * critical section before destroying the trigger and optionally the
  1243		 * poll_task.
  1244		 */
  1245		synchronize_rcu();
  1246		/*
  1247		 * Stop kthread 'psimon' after releasing trigger_lock to prevent a
  1248		 * deadlock while waiting for psi_poll_work to acquire trigger_lock
  1249		 */
  1250		if (task_to_destroy) {
  1251			/*
  1252			 * After the RCU grace period has expired, the worker
  1253			 * can no longer be found through group->poll_task.
  1254			 */
  1255			kthread_stop(task_to_destroy);
  1256		}
  1257		kfree(t);
  1258	}
  1259	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
