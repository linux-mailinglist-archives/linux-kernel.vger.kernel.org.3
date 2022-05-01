Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9398516504
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiEAPnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348271AbiEAPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 11:43:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B3F193DB
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651419582; x=1682955582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/TgsjwlvHAh/qydNuC8PW9CTu2rM/PWkuRUhpecRFsc=;
  b=CBeJSd6dus58U5f3cJbOx9eKMXn4suBBAJJKp9lzLorqJ/HrlBKzeHZM
   XTYOWTW3/ZWwFKJfFplT/ZQ+kg1c+RZX4i+arB1s0OC3Hg5PZF2pOs/Wv
   8+uuVIvvDcPSGd29BoqdGKrihxP1CwATFmvJ5IKOAvQUPAcfNVfqfgkeD
   NIXOmPRXPoDYJT9pEo8NtdmoXvTHuZAuO2j/Ofiqn9/0qlqlih5xt86ZL
   592QFpxWuPLMf6+QWuptexnGBJ/H/TTb53mf0Jw0Ig9UCAy65MrEzsgV6
   3zAVyaFzzgozyy/gh9B/SBOkQ+OJXAp8UERqGW87HZuNWZG1WOool5esl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="327554620"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="327554620"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 08:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="535458123"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 May 2022 08:39:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlBfg-0008rH-3k;
        Sun, 01 May 2022 15:39:40 +0000
Date:   Sun, 1 May 2022 23:39:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: kernel/sched/core.c:5220:20: error: no previous prototype for
 'task_sched_runtime'
Message-ID: <202205012340.UzMUgB84-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   57ae8a492116910bad2b3497ffe555b3a4b4180f
commit: 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies
date:   10 weeks ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20220501/202205012340.UzMUgB84-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4ff8f2ca6ccd9e0cc5665d09f86d631b3ae3a14c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/core.c:3516:6: error: no previous prototype for 'sched_set_stop_task' [-Werror=missing-prototypes]
    3516 | void sched_set_stop_task(int cpu, struct task_struct *stop)
         |      ^~~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:5220:20: error: no previous prototype for 'task_sched_runtime' [-Werror=missing-prototypes]
    5220 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:8931:6: error: no previous prototype for 'idle_task_exit' [-Werror=missing-prototypes]
    8931 | void idle_task_exit(void)
         |      ^~~~~~~~~~~~~~
>> kernel/sched/core.c:9164:5: error: no previous prototype for 'sched_cpu_activate' [-Werror=missing-prototypes]
    9164 | int sched_cpu_activate(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:9209:5: error: no previous prototype for 'sched_cpu_deactivate' [-Werror=missing-prototypes]
    9209 | int sched_cpu_deactivate(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:9284:5: error: no previous prototype for 'sched_cpu_starting' [-Werror=missing-prototypes]
    9284 | int sched_cpu_starting(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:9305:5: error: no previous prototype for 'sched_cpu_wait_empty' [-Werror=missing-prototypes]
    9305 | int sched_cpu_wait_empty(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~~~~~~
>> kernel/sched/core.c:9347:5: error: no previous prototype for 'sched_cpu_dying' [-Werror=missing-prototypes]
    9347 | int sched_cpu_dying(unsigned int cpu)
         |     ^~~~~~~~~~~~~~~
>> kernel/sched/core.c:9370:13: error: no previous prototype for 'sched_init_smp' [-Werror=missing-prototypes]
    9370 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
>> kernel/sched/core.c:9431:13: error: no previous prototype for 'sched_init' [-Werror=missing-prototypes]
    9431 | void __init sched_init(void)
         |             ^~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> kernel/sched/fair.c:10634:6: error: no previous prototype for 'nohz_balance_enter_idle' [-Werror=missing-prototypes]
   10634 | void nohz_balance_enter_idle(int cpu)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from kernel/sched/build_utility.c:79:
>> kernel/sched/loadavg.c:245:6: error: no previous prototype for 'calc_load_nohz_start' [-Werror=missing-prototypes]
     245 | void calc_load_nohz_start(void)
         |      ^~~~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:258:6: error: no previous prototype for 'calc_load_nohz_remote' [-Werror=missing-prototypes]
     258 | void calc_load_nohz_remote(struct rq *rq)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> kernel/sched/loadavg.c:263:6: error: no previous prototype for 'calc_load_nohz_stop' [-Werror=missing-prototypes]
     263 | void calc_load_nohz_stop(void)
         |      ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/task_sched_runtime +5220 kernel/sched/core.c

6075620b0590ea kernel/sched/core.c Giovanni Gherdovich 2016-08-05  5214  
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5215  /*
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5216   * Return accounted runtime for the task.
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5217   * In case the task is currently running, return the runtime plus current's
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5218   * pending runtime that have not been accounted yet.
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5219   */
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31 @5220  unsigned long long task_sched_runtime(struct task_struct *p)
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5221  {
eb58075149b7f0 kernel/sched/core.c Peter Zijlstra      2015-07-31  5222  	struct rq_flags rf;
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5223  	struct rq *rq;
6e998916dfe327 kernel/sched/core.c Stanislaw Gruszka   2014-11-12  5224  	u64 ns;
c5f8d99585d7b5 kernel/sched.c      Hidetoshi Seto      2009-03-31  5225  

:::::: The code at line 5220 was first introduced by commit
:::::: c5f8d99585d7b5b7e857fabf8aefd0174903a98c posixtimers, sched: Fix posix clock monotonicity

:::::: TO: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
