Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E52F5097E1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385041AbiDUGoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384996AbiDUGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:43:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5840713F86
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523255; x=1682059255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xMQgOVRkbDTO+DeBS+AKoWRlOQN0FaktFHbrmsy40Eo=;
  b=ILlxkV0vcRlAzzELqfIfQyN2IYzY+8+RtonpUydK0HuXwk5LHO6jIoeJ
   tbAMT5+ZiNU3mVlbzLtrNAF02eFSbkYrpRG+UCdHBfSQMDCmr4vwBkP7H
   M22hyvztzvpn8BumyvyV2O6P/PWUCju4/tMbqyA7L6Jai9BYsl1EGVASt
   uneXBmJIQG/wATdtnfiHHQXUOOy62U91NPo/bbHWsqTu4oso7vr+C01tm
   de1tT3GMhL06mz1NMA3S8SuSAmbV3uBG0M+4BJt15lZmQKS1YBv54mS8I
   NjV/InnqcpGeP9TAXalCvaQFB1ILWysg7A3n8gPZuXTo6f//r97QkAqUt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="327160571"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="327160571"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="805383627"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2022 23:40:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQUj-0007y7-Nh;
        Thu, 21 Apr 2022 06:40:49 +0000
Date:   Thu, 21 Apr 2022 14:40:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev 28/28]
 kernel/rcu/tree_nocb.h:1217:9: error: expected identifier or '(' before 'if'
Message-ID: <202204202111.gA58hkDX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
head:   ad68d8bf085421e4f22731c8b64c0b774a154e06
commit: ad68d8bf085421e4f22731c8b64c0b774a154e06 [28/28] rcu/nocb: Add an option to offload all CPUs on boot
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220420/202204202111.gA58hkDX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/ad68d8bf085421e4f22731c8b64c0b774a154e06
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
        git checkout ad68d8bf085421e4f22731c8b64c0b774a154e06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:5031:
   kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
   kernel/rcu/tree_nocb.h:1211:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1211 |         if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
         |         ^~
   kernel/rcu/tree_nocb.h:1213:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1213 |                 offload_all = false; /* NO_HZ_FULL has its own mask. */
         |                 ^~~~~~~~~~~
   kernel/rcu/tree_nocb.h:1201:26: warning: unused variable 'rdp' [-Wunused-variable]
    1201 |         struct rcu_data *rdp;
         |                          ^~~
   kernel/rcu/tree_nocb.h:1200:14: warning: variable 'offload_all' set but not used [-Wunused-but-set-variable]
    1200 |         bool offload_all = false;
         |              ^~~~~~~~~~~
   kernel/rcu/tree_nocb.h:1199:14: warning: variable 'need_rcu_nocb_mask' set but not used [-Wunused-but-set-variable]
    1199 |         bool need_rcu_nocb_mask = false;
         |              ^~~~~~~~~~~~~~~~~~
   kernel/rcu/tree_nocb.h:1198:13: warning: unused variable 'cpu' [-Wunused-variable]
    1198 |         int cpu;
         |             ^~~
   kernel/rcu/tree_nocb.h: At top level:
>> kernel/rcu/tree_nocb.h:1217:9: error: expected identifier or '(' before 'if'
    1217 |         if (need_rcu_nocb_mask) {
         |         ^~
   kernel/rcu/tree_nocb.h:1227:9: error: expected identifier or '(' before 'if'
    1227 |         if (!rcu_state.nocb_is_setup)
         |         ^~
   kernel/rcu/tree_nocb.h:1231:9: error: expected identifier or '(' before 'if'
    1231 |         if (tick_nohz_full_running)
         |         ^~
   kernel/rcu/tree_nocb.h:1235:9: error: expected identifier or '(' before 'if'
    1235 |         if (offload_all)
         |         ^~
   kernel/rcu/tree_nocb.h:1238:9: error: expected identifier or '(' before 'if'
    1238 |         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
         |         ^~
   kernel/rcu/tree_nocb.h:1243:9: error: expected identifier or '(' before 'if'
    1243 |         if (cpumask_empty(rcu_nocb_mask))
         |         ^~
   In file included from include/linux/kernel.h:29,
                    from kernel/rcu/tree.c:21:
   include/linux/printk.h:419:10: error: expected identifier or '(' before ')' token
     419 |         })
         |          ^
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/rcu/tree_nocb.h:1244:17: note: in expansion of macro 'pr_info'
    1244 |                 pr_info("\tOffload RCU callbacks from CPUs: (none).\n");
         |                 ^~~~~~~
   In file included from kernel/rcu/tree.c:5031:
>> kernel/rcu/tree_nocb.h:1245:9: error: expected identifier or '(' before 'else'
    1245 |         else
         |         ^~~~
   In file included from include/linux/kernel.h:29,
                    from kernel/rcu/tree.c:21:
   include/linux/printk.h:419:10: error: expected identifier or '(' before ')' token
     419 |         })
         |          ^
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/rcu/tree_nocb.h:1246:17: note: in expansion of macro 'pr_info'
    1246 |                 pr_info("\tOffload RCU callbacks from CPUs: %*pbl.\n",
         |                 ^~~~~~~
   In file included from kernel/rcu/tree.c:5031:
   kernel/rcu/tree_nocb.h:1248:9: error: expected identifier or '(' before 'if'
    1248 |         if (rcu_nocb_poll)
         |         ^~
   In file included from include/linux/kernel.h:29,
                    from kernel/rcu/tree.c:21:
   include/linux/printk.h:419:10: error: expected identifier or '(' before ')' token
     419 |         })
         |          ^
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:519:9: note: in expansion of macro 'printk'
     519 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/rcu/tree_nocb.h:1249:17: note: in expansion of macro 'pr_info'
    1249 |                 pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
         |                 ^~~~~~~
   In file included from arch/x86/include/asm/cpumask.h:5,
                    from arch/x86/include/asm/msr.h:11,
                    from arch/x86/include/asm/processor.h:22,
                    from arch/x86/include/asm/cpufeature.h:5,
                    from arch/x86/include/asm/thread_info.h:53,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from kernel/rcu/tree.c:23:
>> include/linux/cpumask.h:276:9: error: expected identifier or '(' before 'for'
     276 |         for ((cpu) = -1;                                \
         |         ^~~
   kernel/rcu/tree_nocb.h:1251:9: note: in expansion of macro 'for_each_cpu'
    1251 |         for_each_cpu(cpu, rcu_nocb_mask) {
         |         ^~~~~~~~~~~~
   include/linux/cpumask.h:277:17: warning: data definition has no type or storage class
     277 |                 (cpu) = cpumask_next((cpu), (mask)),    \
         |                 ^
   kernel/rcu/tree_nocb.h:1251:9: note: in expansion of macro 'for_each_cpu'
    1251 |         for_each_cpu(cpu, rcu_nocb_mask) {
         |         ^~~~~~~~~~~~
>> kernel/rcu/tree_nocb.h:1251:22: error: type defaults to 'int' in declaration of 'cpu' [-Werror=implicit-int]
    1251 |         for_each_cpu(cpu, rcu_nocb_mask) {
         |                      ^~~
   include/linux/cpumask.h:277:18: note: in definition of macro 'for_each_cpu'
     277 |                 (cpu) = cpumask_next((cpu), (mask)),    \
         |                  ^~~
>> include/linux/cpumask.h:277:25: error: initializer element is not constant
     277 |                 (cpu) = cpumask_next((cpu), (mask)),    \
         |                         ^~~~~~~~~~~~
   kernel/rcu/tree_nocb.h:1251:9: note: in expansion of macro 'for_each_cpu'
    1251 |         for_each_cpu(cpu, rcu_nocb_mask) {
         |         ^~~~~~~~~~~~
>> include/linux/cpumask.h:278:23: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
     278 |                 (cpu) < nr_cpu_ids;)
         |                       ^
   kernel/rcu/tree_nocb.h:1251:9: note: in expansion of macro 'for_each_cpu'
    1251 |         for_each_cpu(cpu, rcu_nocb_mask) {
         |         ^~~~~~~~~~~~
>> include/linux/cpumask.h:278:36: error: expected identifier or '(' before ')' token
     278 |                 (cpu) < nr_cpu_ids;)
         |                                    ^
   kernel/rcu/tree_nocb.h:1251:9: note: in expansion of macro 'for_each_cpu'
    1251 |         for_each_cpu(cpu, rcu_nocb_mask) {
         |         ^~~~~~~~~~~~
   In file included from kernel/rcu/tree.c:5031:
   kernel/rcu/tree_nocb.h:1259:9: warning: data definition has no type or storage class
    1259 |         rcu_organize_nocb_kthreads();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/rcu/tree_nocb.h:1259:9: error: type defaults to 'int' in declaration of 'rcu_organize_nocb_kthreads' [-Werror=implicit-int]
>> kernel/rcu/tree_nocb.h:1259:9: error: function declaration isn't a prototype [-Werror=strict-prototypes]
>> kernel/rcu/tree_nocb.h:1259:9: error: conflicting types for 'rcu_organize_nocb_kthreads'; have 'int()'
   In file included from kernel/rcu/tree.c:67:
   kernel/rcu/tree.h:463:20: note: previous declaration of 'rcu_organize_nocb_kthreads' with type 'void(void)'
     463 | static void __init rcu_organize_nocb_kthreads(void);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/rcu/tree.c:5031:
>> kernel/rcu/tree_nocb.h:1260:1: error: expected identifier or '(' before '}' token
    1260 | }
         | ^
>> kernel/rcu/tree_nocb.h:1339:20: error: conflicting types for 'rcu_organize_nocb_kthreads'; have 'void(void)'
    1339 | static void __init rcu_organize_nocb_kthreads(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/rcu/tree_nocb.h:1259:9: note: previous declaration of 'rcu_organize_nocb_kthreads' with type 'int()'
    1259 |         rcu_organize_nocb_kthreads();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/rcu/tree_nocb.h:1339:20: warning: 'rcu_organize_nocb_kthreads' defined but not used [-Wunused-function]
    1339 | static void __init rcu_organize_nocb_kthreads(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1217 kernel/rcu/tree_nocb.h

dfcb27540213e8 Frederic Weisbecker 2021-05-19  1216  
a81aeaf7a1de51 Frederic Weisbecker 2021-11-23 @1217  	if (need_rcu_nocb_mask) {
a81aeaf7a1de51 Frederic Weisbecker 2021-11-23  1218  		if (!cpumask_available(rcu_nocb_mask)) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1219  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1220  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1221  				return;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1222  			}
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1223  		}
8d2aaa9b7c290e Frederic Weisbecker 2022-02-14  1224  		rcu_state.nocb_is_setup = true;
a81aeaf7a1de51 Frederic Weisbecker 2021-11-23  1225  	}
a81aeaf7a1de51 Frederic Weisbecker 2021-11-23  1226  
8d2aaa9b7c290e Frederic Weisbecker 2022-02-14  1227  	if (!rcu_state.nocb_is_setup)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1228  		return;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1229  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1230  #if defined(CONFIG_NO_HZ_FULL)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1231  	if (tick_nohz_full_running)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1232  		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1233  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1234  
ad68d8bf085421 Joel Fernandes      2022-04-19  1235  	if (offload_all)
ad68d8bf085421 Joel Fernandes      2022-04-19  1236  		cpumask_setall(rcu_nocb_mask);
ad68d8bf085421 Joel Fernandes      2022-04-19  1237  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1238  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1239  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1240  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1241  			    rcu_nocb_mask);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1242  	}
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1243  	if (cpumask_empty(rcu_nocb_mask))
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1244  		pr_info("\tOffload RCU callbacks from CPUs: (none).\n");
dfcb27540213e8 Frederic Weisbecker 2021-05-19 @1245  	else
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1246  		pr_info("\tOffload RCU callbacks from CPUs: %*pbl.\n",
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1247  			cpumask_pr_args(rcu_nocb_mask));
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1248  	if (rcu_nocb_poll)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1249  		pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1250  
dfcb27540213e8 Frederic Weisbecker 2021-05-19 @1251  	for_each_cpu(cpu, rcu_nocb_mask) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1252  		rdp = per_cpu_ptr(&rcu_data, cpu);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1253  		if (rcu_segcblist_empty(&rdp->cblist))
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1254  			rcu_segcblist_init(&rdp->cblist);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1255  		rcu_segcblist_offload(&rdp->cblist, true);
213d56bf33bdda Frederic Weisbecker 2021-10-19  1256  		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
213d56bf33bdda Frederic Weisbecker 2021-10-19  1257  		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1258  	}
dfcb27540213e8 Frederic Weisbecker 2021-05-19 @1259  	rcu_organize_nocb_kthreads();
dfcb27540213e8 Frederic Weisbecker 2021-05-19 @1260  }
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1261  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1262  /* Initialize per-rcu_data variables for no-CBs CPUs. */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1263  static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1264  {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1265  	init_swait_queue_head(&rdp->nocb_cb_wq);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1266  	init_swait_queue_head(&rdp->nocb_gp_wq);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1267  	init_swait_queue_head(&rdp->nocb_state_wq);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1268  	raw_spin_lock_init(&rdp->nocb_lock);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1269  	raw_spin_lock_init(&rdp->nocb_bypass_lock);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1270  	raw_spin_lock_init(&rdp->nocb_gp_lock);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1271  	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1272  	rcu_cblist_init(&rdp->nocb_bypass);
02e3024175274e Neeraj Upadhyay     2021-12-11  1273  	mutex_init(&rdp->nocb_gp_kthread_mutex);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1274  }
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1275  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1276  /*
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1277   * If the specified CPU is a no-CBs CPU that does not already have its
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1278   * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1279   * for this CPU's group has not yet been created, spawn it as well.
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1280   */
10d4703154a72f Frederic Weisbecker 2021-11-23  1281  static void rcu_spawn_cpu_nocb_kthread(int cpu)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1282  {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1283  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1284  	struct rcu_data *rdp_gp;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1285  	struct task_struct *t;
54577e23fa0791 Alison Chaiken      2022-01-11  1286  	struct sched_param sp;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1287  
8d2aaa9b7c290e Frederic Weisbecker 2022-02-14  1288  	if (!rcu_scheduler_fully_active || !rcu_state.nocb_is_setup)
10d4703154a72f Frederic Weisbecker 2021-11-23  1289  		return;
10d4703154a72f Frederic Weisbecker 2021-11-23  1290  
2cf4528d6dd6f5 Frederic Weisbecker 2021-11-23  1291  	/* If there already is an rcuo kthread, then nothing to do. */
2cf4528d6dd6f5 Frederic Weisbecker 2021-11-23  1292  	if (rdp->nocb_cb_kthread)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1293  		return;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1294  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1295  	/* If we didn't spawn the GP kthread first, reorganize! */
54577e23fa0791 Alison Chaiken      2022-01-11  1296  	sp.sched_priority = kthread_prio;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1297  	rdp_gp = rdp->nocb_gp_rdp;
02e3024175274e Neeraj Upadhyay     2021-12-11  1298  	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1299  	if (!rdp_gp->nocb_gp_kthread) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1300  		t = kthread_run(rcu_nocb_gp_kthread, rdp_gp,
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1301  				"rcuog/%d", rdp_gp->cpu);
02e3024175274e Neeraj Upadhyay     2021-12-11  1302  		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
02e3024175274e Neeraj Upadhyay     2021-12-11  1303  			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
3932ce26dc6822 Zqiang              2022-04-19  1304  			goto end;
02e3024175274e Neeraj Upadhyay     2021-12-11  1305  		}
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1306  		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
54577e23fa0791 Alison Chaiken      2022-01-11  1307  		if (kthread_prio)
54577e23fa0791 Alison Chaiken      2022-01-11  1308  			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1309  	}
02e3024175274e Neeraj Upadhyay     2021-12-11  1310  	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1311  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1312  	/* Spawn the kthread for this CPU. */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1313  	t = kthread_run(rcu_nocb_cb_kthread, rdp,
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1314  			"rcuo%c/%d", rcu_state.abbr, cpu);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1315  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
3932ce26dc6822 Zqiang              2022-04-19  1316  		goto end;
c8b16a65267e35 Alison Chaiken      2022-01-11  1317  
c8b16a65267e35 Alison Chaiken      2022-01-11  1318  	if (kthread_prio)
c8b16a65267e35 Alison Chaiken      2022-01-11  1319  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1320  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1321  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
3932ce26dc6822 Zqiang              2022-04-19  1322  	return;
3932ce26dc6822 Zqiang              2022-04-19  1323  end:
3932ce26dc6822 Zqiang              2022-04-19  1324  	mutex_lock(&rcu_state.barrier_mutex);
3932ce26dc6822 Zqiang              2022-04-19  1325  	if (rcu_rdp_is_offloaded(rdp)) {
3932ce26dc6822 Zqiang              2022-04-19  1326  		rcu_nocb_rdp_deoffload(rdp);
3932ce26dc6822 Zqiang              2022-04-19  1327  		cpumask_clear_cpu(cpu, rcu_nocb_mask);
3932ce26dc6822 Zqiang              2022-04-19  1328  	}
3932ce26dc6822 Zqiang              2022-04-19  1329  	mutex_unlock(&rcu_state.barrier_mutex);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1330  }
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1331  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1332  /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1333  static int rcu_nocb_gp_stride = -1;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1334  module_param(rcu_nocb_gp_stride, int, 0444);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1335  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1336  /*
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1337   * Initialize GP-CB relationships for all no-CBs CPU.
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1338   */
dfcb27540213e8 Frederic Weisbecker 2021-05-19 @1339  static void __init rcu_organize_nocb_kthreads(void)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1340  {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1341  	int cpu;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1342  	bool firsttime = true;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1343  	bool gotnocbs = false;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1344  	bool gotnocbscbs = true;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1345  	int ls = rcu_nocb_gp_stride;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1346  	int nl = 0;  /* Next GP kthread. */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1347  	struct rcu_data *rdp;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1348  	struct rcu_data *rdp_gp = NULL;  /* Suppress misguided gcc warn. */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1349  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1350  	if (!cpumask_available(rcu_nocb_mask))
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1351  		return;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1352  	if (ls == -1) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1353  		ls = nr_cpu_ids / int_sqrt(nr_cpu_ids);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1354  		rcu_nocb_gp_stride = ls;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1355  	}
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1356  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1357  	/*
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1358  	 * Each pass through this loop sets up one rcu_data structure.
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1359  	 * Should the corresponding CPU come online in the future, then
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1360  	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1361  	 */
2cf4528d6dd6f5 Frederic Weisbecker 2021-11-23  1362  	for_each_possible_cpu(cpu) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1363  		rdp = per_cpu_ptr(&rcu_data, cpu);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1364  		if (rdp->cpu >= nl) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1365  			/* New GP kthread, set up for CBs & next GP. */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1366  			gotnocbs = true;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1367  			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1368  			rdp_gp = rdp;
2ebc45c44c4f3c Frederic Weisbecker 2021-11-23  1369  			INIT_LIST_HEAD(&rdp->nocb_head_rdp);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1370  			if (dump_tree) {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1371  				if (!firsttime)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1372  					pr_cont("%s\n", gotnocbscbs
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1373  							? "" : " (self only)");
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1374  				gotnocbscbs = false;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1375  				firsttime = false;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1376  				pr_alert("%s: No-CB GP kthread CPU %d:",
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1377  					 __func__, cpu);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1378  			}
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1379  		} else {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1380  			/* Another CB kthread, link to previous GP kthread. */
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1381  			gotnocbscbs = true;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1382  			if (dump_tree)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1383  				pr_cont(" %d", cpu);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1384  		}
2ebc45c44c4f3c Frederic Weisbecker 2021-11-23  1385  		rdp->nocb_gp_rdp = rdp_gp;
2cf4528d6dd6f5 Frederic Weisbecker 2021-11-23  1386  		if (cpumask_test_cpu(cpu, rcu_nocb_mask))
2ebc45c44c4f3c Frederic Weisbecker 2021-11-23  1387  			list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1388  	}
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1389  	if (gotnocbs && dump_tree)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1390  		pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1391  }
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1392  

:::::: The code at line 1217 was first introduced by commit
:::::: a81aeaf7a1de51400374a8e3982a3cc3ff130dd1 rcu/nocb: Optimize kthreads and rdp initialization

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
