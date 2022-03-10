Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5044D4247
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbiCJIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiCJIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:15:43 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAF23DDC0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646900082; x=1678436082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DQpLRL+t7gIBZp5H5cqRKxXL5RtnKEURvHaY1Fda1rU=;
  b=Z4XcZs3yYV+R1C3g3XO5pjjbNb/L4Q6VNqrOSpR0SUhVZadyzPOFBMv3
   fD4FsbOuPIOKsmqLMBFoBc9PyBpAHSgwTktlrSYG0OndDh5MwEQhuNLW7
   +gJIkmqjeE08IoleaME4h9MeYrKkYnhrm2V2tvaOiOYeGaHPyeqWMnWFl
   JUGlM0l25UeL8Sz4F28SWUfutQd3VbsrQ27ouQFdddVe7/wcl2JQwJT1G
   eMBXFLeBQrCCpFbKoHQyySnnszFxusBkHR2PYGCtq63bTYjOKrYeDOM5H
   M4AsJZlX3+RtJgPcS0qa5QDZ0RCm6tZ6ScrpfJJMoSUCtZSzYGt0vjYvI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255377022"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255377022"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642467634"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 10 Mar 2022 00:14:41 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSDwW-0004by-DF; Thu, 10 Mar 2022 08:14:40 +0000
Date:   Thu, 10 Mar 2022 16:14:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     lijianzhong <lijianzhong@xiaomi.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 2257/9999] kernel/sched/fair.c:4424:6: warning: no previous prototype for
 'set_next_entity'
Message-ID: <202203101619.QCheEDyN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lijianzhong,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   786bcb11099e8926ac5b5270de844d01c394ab89
commit: 54f66141a8834e27601fe594d68a97db01bb86b6 [2257/9999] ANDROID: sched: Add vendor hooks for sched.
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220310/202203101619.QCheEDyN-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/54f66141a8834e27601fe594d68a97db01bb86b6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout 54f66141a8834e27601fe594d68a97db01bb86b6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/printk/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/fair.c:4424:6: warning: no previous prototype for 'set_next_entity' [-Wmissing-prototypes]
    4424 | void set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
         |      ^~~~~~~~~~~~~~~
   kernel/sched/fair.c:5408:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5408 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11341:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11341 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11343:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11343 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11348:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11348 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11350:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11350 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/set_next_entity +4424 kernel/sched/fair.c

  4423	
> 4424	void set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
  4425	{
  4426		/* 'current' is not kept within the tree. */
  4427		if (se->on_rq) {
  4428			/*
  4429			 * Any task has to be enqueued before it get to execute on
  4430			 * a CPU. So account for the time it spent waiting on the
  4431			 * runqueue.
  4432			 */
  4433			update_stats_wait_end(cfs_rq, se);
  4434			__dequeue_entity(cfs_rq, se);
  4435			update_load_avg(cfs_rq, se, UPDATE_TG);
  4436		}
  4437	
  4438		update_stats_curr_start(cfs_rq, se);
  4439		cfs_rq->curr = se;
  4440	
  4441		/*
  4442		 * Track our maximum slice length, if the CPU's load is at
  4443		 * least twice that of our own weight (i.e. dont track it
  4444		 * when there are only lesser-weight tasks around):
  4445		 */
  4446		if (schedstat_enabled() &&
  4447		    rq_of(cfs_rq)->cfs.load.weight >= 2*se->load.weight) {
  4448			schedstat_set(se->statistics.slice_max,
  4449				max((u64)schedstat_val(se->statistics.slice_max),
  4450				    se->sum_exec_runtime - se->prev_sum_exec_runtime));
  4451		}
  4452	
  4453		se->prev_sum_exec_runtime = se->sum_exec_runtime;
  4454	}
  4455	EXPORT_SYMBOL_GPL(set_next_entity);
  4456	
  4457	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
