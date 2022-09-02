Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7785AA791
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiIBGDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiIBGDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:03:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1761AACA3E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662098588; x=1693634588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NJKydQMWuJR4Hk5wOCHCqrngro4PcBYvu9VGzJxWzNA=;
  b=gR5mxJj6HgUQRbwwMRb2eNDF6Gco6I1GkpVo+NFMFLGBnoiUWwuTfcWg
   svXKZ+CjOpvNPKkr3QIVGhmiTNyhCP3I/eS/tpXiAbFkcevwPuU01zry2
   X8cfIkZmaAGilJMLNgYuAsYrDteZtbG+ZQ7q2rbxS+iEJz5JHaE8hdf+Y
   aSHmDvdCbR+2wz7EBDH/bwOuH6u+Og9NcneTQkD0QzghU3B4T6GHwoqmg
   J20D2sX6aAhapQpQ2lCyCWm6EOCtCuq10DwGu5pqu6xEE7n10GvWPR+dF
   Ah3gfOxRFOfcvf2ynCW94CmWALwUwrSheeaS9G89zZVQiR9NGsJsR2ttT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275647092"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="275647092"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 23:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="563847977"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 23:03:06 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTzlh-0000FT-0z;
        Fri, 02 Sep 2022 06:03:05 +0000
Date:   Fri, 2 Sep 2022 14:02:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14-rebase 1501/9999]
 include/trace/events/sched.h:683:14: error: 'struct cfs_rq' has no member
 named 'rq'
Message-ID: <202209021329.6FZDTS9b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14-rebase
head:   18a233f3f676a98dde00947535d99ab1a54da340
commit: bc584b9ba0463b430a0875cbc25256f964754701 [1501/9999] ANDROID: trace: Add WALT util signal to trace event sched_load_cfs_rq
config: sparc64-randconfig-c042-20220901 (https://download.01.org/0day-ci/archive/20220902/202209021329.6FZDTS9b-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/bc584b9ba0463b430a0875cbc25256f964754701
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14-rebase
        git checkout bc584b9ba0463b430a0875cbc25256f964754701
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/cpuset.h:13:0,
                    from kernel/sched/core.c:14:
   include/linux/sched/topology.h:196:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
   In file included from include/trace/define_trace.h:96:0,
                    from include/trace/events/sched.h:1150,
                    from kernel/sched/core.c:41:
   include/trace/events/sched.h: In function 'trace_event_raw_event_sched_load_cfs_rq':
>> include/trace/events/sched.h:683:14: error: 'struct cfs_rq' has no member named 'rq'
      if (&cfs_rq->rq->cfs == cfs_rq) {
                 ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:683:3: note: in expansion of macro 'if'
      if (&cfs_rq->rq->cfs == cfs_rq) {
      ^~
>> include/trace/events/sched.h:683:14: error: 'struct cfs_rq' has no member named 'rq'
      if (&cfs_rq->rq->cfs == cfs_rq) {
                 ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:683:3: note: in expansion of macro 'if'
      if (&cfs_rq->rq->cfs == cfs_rq) {
      ^~
>> include/trace/events/sched.h:683:14: error: 'struct cfs_rq' has no member named 'rq'
      if (&cfs_rq->rq->cfs == cfs_rq) {
                 ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:683:3: note: in expansion of macro 'if'
      if (&cfs_rq->rq->cfs == cfs_rq) {
      ^~
   include/trace/events/sched.h:685:13: error: 'struct cfs_rq' has no member named 'rq'
          cfs_rq->rq->prev_runnable_sum);
                ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/trace/events/sched.h:684:4: note: in expansion of macro 'walt_util'
       walt_util(__entry->util_walt,
       ^~~~~~~~~
   include/trace/events/sched.h: In function 'trace_event_raw_event_sched_load_se':
   include/trace/events/sched.h:758:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:725:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:743:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:758:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
   include/trace/events/sched.h:758:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:725:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:743:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:758:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
   include/trace/events/sched.h:758:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/trace_events.h:719:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:725:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:743:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:758:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
   In file included from include/trace/define_trace.h:97:0,
                    from include/trace/events/sched.h:1150,
                    from kernel/sched/core.c:41:
   include/trace/events/sched.h: In function 'perf_trace_sched_load_cfs_rq':
>> include/trace/events/sched.h:683:14: error: 'struct cfs_rq' has no member named 'rq'
      if (&cfs_rq->rq->cfs == cfs_rq) {
                 ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:683:3: note: in expansion of macro 'if'
      if (&cfs_rq->rq->cfs == cfs_rq) {
      ^~
>> include/trace/events/sched.h:683:14: error: 'struct cfs_rq' has no member named 'rq'
      if (&cfs_rq->rq->cfs == cfs_rq) {
                 ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:683:3: note: in expansion of macro 'if'
      if (&cfs_rq->rq->cfs == cfs_rq) {
      ^~
>> include/trace/events/sched.h:683:14: error: 'struct cfs_rq' has no member named 'rq'
      if (&cfs_rq->rq->cfs == cfs_rq) {
                 ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:683:3: note: in expansion of macro 'if'
      if (&cfs_rq->rq->cfs == cfs_rq) {
      ^~
   include/trace/events/sched.h:685:13: error: 'struct cfs_rq' has no member named 'rq'
          cfs_rq->rq->prev_runnable_sum);
                ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:658:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_cfs_rq,
    ^~~~~~~~~~~
   include/trace/events/sched.h:674:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/trace/events/sched.h:684:4: note: in expansion of macro 'walt_util'
       walt_util(__entry->util_walt,
       ^~~~~~~~~
   include/trace/events/sched.h: In function 'perf_trace_sched_load_se':
   include/trace/events/sched.h:758:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:725:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:743:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:758:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
   include/trace/events/sched.h:758:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:725:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:743:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:758:3: note: in expansion of macro 'if'
      if (!se->my_q) {
      ^~
   include/trace/events/sched.h:758:10: error: 'struct sched_entity' has no member named 'my_q'
      if (!se->my_q) {
             ^
   include/trace/perf.h:66:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:78:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/sched.h:725:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(sched_load_se,
    ^~~~~~~~~~~
   include/trace/events/sched.h:743:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/trace/events/sched.h:758:3: note: in expansion of macro 'if'


vim +683 include/trace/events/sched.h

   659	
   660		TP_PROTO(struct cfs_rq *cfs_rq),
   661	
   662		TP_ARGS(cfs_rq),
   663	
   664		TP_STRUCT__entry(
   665			__field(	int,		cpu			)
   666			__dynamic_array(char,		path,
   667					__trace_sched_path(cfs_rq, NULL, 0)	)
   668			__field(	unsigned long,	load			)
   669			__field(	unsigned long,	util			)
   670			__field(	unsigned long,	util_pelt          	)
   671			__field(	unsigned long,	util_walt          	)
   672		),
   673	
   674		TP_fast_assign(
   675			__entry->cpu	= __trace_sched_cpu(cfs_rq, NULL);
   676			__trace_sched_path(cfs_rq, __get_dynamic_array(path),
   677					   __get_dynamic_array_len(path));
   678			__entry->load	= cfs_rq->runnable_load_avg;
   679			__entry->util	= cfs_rq->avg.util_avg;
   680			__entry->util_pelt = cfs_rq->avg.util_avg;
   681			__entry->util_walt = 0;
   682	#ifdef CONFIG_SCHED_WALT
 > 683			if (&cfs_rq->rq->cfs == cfs_rq) {
   684				walt_util(__entry->util_walt,
   685					  cfs_rq->rq->prev_runnable_sum);
   686				if (!walt_disabled && sysctl_sched_use_walt_cpu_util)
   687					__entry->util = __entry->util_walt;
   688			}
   689	#endif
   690		),
   691	
   692		TP_printk("cpu=%d path=%s load=%lu util=%lu util_pelt=%lu util_walt=%lu",
   693			  __entry->cpu, __get_str(path), __entry->load, __entry->util,
   694			  __entry->util_pelt, __entry->util_walt)
   695	);
   696	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
