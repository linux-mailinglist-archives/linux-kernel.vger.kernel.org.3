Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CA5AA693
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiIBDsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBDr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:47:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89126173C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662090475; x=1693626475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7sucorTp1vQIxnnFSXOKgTXhFMZm2gZwRa+wCAfZt3g=;
  b=S1znl32uWl2wqDSg8rLkqYoJJLDfRVT8G6rBHOgYOlEXm/v4lVttk7jc
   uwWm/uiWYTNg4NvkNXyCvQJpI/LoUbWPh8Zn+TfOksdRQqzkDrJgVClsV
   eXK202RShHqVg8/zehc5OGR7TlXdAe5KMWpnjv/s//NenNejfjx05cEt4
   +dKrMX4aCaU4ZrPE7Ws9j5H0BlqwQ03kbXLusJULKNpsUML0jdqhQCnFn
   8J3z4BCweFhmbAt2y8FFYz79oSMvUZGBYXvhNqAXEciKXLmzr3iZnYgjx
   ttF5CtwGhwaG2zH0EjhwrOOvRK63SoaqMyK5aqzhoMh5U29lUpBRKrxWw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276287550"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="276287550"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 20:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589881735"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 20:47:53 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTxeq-00005t-2X;
        Fri, 02 Sep 2022 03:47:52 +0000
Date:   Fri, 2 Sep 2022 11:47:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Chris Redpath <chris.redpath@arm.com>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 1458/9999]
 include/trace/events/sched.h:778:10: error: 'struct sched_entity' has no
 member named 'my_q'
Message-ID: <202209021116.DszurHSD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: 77f68474fcca7a861a745c4dc1ffd488d17797a5 [1458/9999] ANDROID: sched: Introduce Window Assisted Load Tracking (WALT)
config: sparc64-randconfig-c042-20220901 (https://download.01.org/0day-ci/archive/20220902/202209021116.DszurHSD-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/77f68474fcca7a861a745c4dc1ffd488d17797a5
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14-rebase
        git checkout 77f68474fcca7a861a745c4dc1ffd488d17797a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/mm/ kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/mm/init_64.c: In function 'setup_hugepagesz':
   arch/sparc/mm/init_64.c:368:17: error: variable 'hv_pgsz_idx' set but not used [-Werror=unused-but-set-variable]
     unsigned short hv_pgsz_idx;
                    ^~~~~~~~~~~
   arch/sparc/mm/init_64.c: At top level:
>> arch/sparc/mm/init_64.c:2685:6: error: no previous declaration for 'vmemmap_free' [-Werror=missing-declarations]
    void vmemmap_free(unsigned long start, unsigned long end)
         ^~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/cpuset.h:13:0,
                    from kernel/sched/core.c:14:
   include/linux/sched/topology.h:196:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   In file included from kernel/sched/core.c:36:0:
   kernel/sched/sched.h:1127:34: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
     const struct sched_group_energy const *sge;
                                     ^~~~~
   In file included from include/trace/define_trace.h:96:0,
                    from include/trace/events/sched.h:1171,
                    from kernel/sched/core.c:41:
   include/trace/events/sched.h: In function 'trace_event_raw_event_sched_load_se':
>> include/trace/events/sched.h:778:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:745:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:763:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:778:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
>> include/trace/events/sched.h:778:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:745:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:763:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:778:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
>> include/trace/events/sched.h:778:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:745:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:763:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:778:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
   In file included from include/trace/define_trace.h:97:0,
                    from include/trace/events/sched.h:1171,
                    from kernel/sched/core.c:41:
   include/trace/events/sched.h: In function 'perf_trace_sched_load_se':
>> include/trace/events/sched.h:778:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:745:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:763:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:778:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
>> include/trace/events/sched.h:778:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:745:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:763:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:778:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
>> include/trace/events/sched.h:778:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:745:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:763:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:778:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:1303:5: warning: no previous declaration for 'migrate_swap' [-Wmissing-declarations]
    int migrate_swap(struct task_struct *cur, struct task_struct *p)
        ^~~~~~~~~~~~
   kernel/sched/core.c:1599:6: warning: no previous declaration for 'sched_set_stop_task' [-Wmissing-declarations]
    void sched_set_stop_task(int cpu, struct task_struct *stop)
         ^~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:3657:35: warning: no previous declaration for 'preempt_schedule_irq' [-Wmissing-declarations]
    asmlinkage __visible void __sched preempt_schedule_irq(void)
                                      ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c: In function 'sched_init':
   kernel/sched/core.c:5858:32: warning: variable 'ptr' set but not used [-Wunused-but-set-variable]
     unsigned long alloc_size = 0, ptr;
                                   ^~~


vim +778 include/trace/events/sched.h

   746	
   747		TP_PROTO(struct sched_entity *se),
   748	
   749		TP_ARGS(se),
   750	
   751		TP_STRUCT__entry(
   752			__field(	int,		cpu			      )
   753			__dynamic_array(char,		path,
   754			  __trace_sched_path(__trace_sched_group_cfs_rq(se), NULL, 0) )
   755			__array(	char,		comm,	TASK_COMM_LEN	      )
   756			__field(	pid_t,		pid			      )
   757			__field(	unsigned long,	load			      )
   758			__field(	unsigned long,	util			      )
   759			__field(	unsigned long,	util_pelt		      )
   760			__field(	unsigned long,	util_walt		      )
   761		),
   762	
   763		TP_fast_assign(
   764			struct cfs_rq *gcfs_rq = __trace_sched_group_cfs_rq(se);
   765			struct task_struct *p = gcfs_rq ? NULL
   766					    : container_of(se, struct task_struct, se);
   767	
   768			__entry->cpu = __trace_sched_cpu(gcfs_rq, se);
   769			__trace_sched_path(gcfs_rq, __get_dynamic_array(path),
   770					   __get_dynamic_array_len(path));
   771			memcpy(__entry->comm, p ? p->comm : "(null)", TASK_COMM_LEN);
   772			__entry->pid = p ? p->pid : -1;
   773			__entry->load = se->avg.load_avg;
   774			__entry->util = se->avg.util_avg;
   775			__entry->util_pelt  = __entry->util;
   776			__entry->util_walt  = 0;
   777	#ifdef CONFIG_SCHED_WALT
 > 778			if (!se->my_q) {
   779				struct task_struct *p = container_of(se, struct task_struct, se);
   780				__entry->util_walt = p->ravg.demand;
   781				do_div(__entry->util_walt, walt_ravg_window >> SCHED_CAPACITY_SHIFT);
   782				if (!walt_disabled && sysctl_sched_use_walt_task_util)
   783					__entry->util = __entry->util_walt;
   784			}
   785	#endif
   786		),
   787	
   788		TP_printk("cpu=%d path=%s comm=%s pid=%d load=%lu util=%lu util_pelt=%lu util_walt=%lu",
   789			  __entry->cpu, __get_str(path), __entry->comm,
   790			  __entry->pid, __entry->load, __entry->util,
   791			  __entry->util_pelt, __entry->util_walt)
   792	);
   793	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
