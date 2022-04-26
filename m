Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF59510AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355268AbiDZVLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241959AbiDZVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:11:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39806D849
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651007313; x=1682543313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SPjew8K2LP/aFKzQMmxOnyOHAKOzU/L4qyxzZ+S4+m0=;
  b=m1mDmjotFS1QZsFw3XcDTEc2tnd59eHRmExfEfHeGp+7lxmJKaZm41p1
   GlMOcdy00yp6HWw934IU5oyuF7WbffIBq0R4F1KXIZnlPFRDdK5wrZDns
   ar06nxJQD2ElUUMFAU0wyVOVF8bdAQ4R1ob7e/2o2NsUptbW/ya/Hujt3
   jJJGp1qLQsfuuB+r2U6Nn2hSgomi5/gzfac6AUzd6BT0UTfRUOPU580/L
   ttUcimlPTly7iag7/lbFjbpmxEA7tdaIfLZRSA4VyYUol+BuAjBIhjW6H
   ma5deCvpCIKQSl1MYMEuHgNQP012IkNfzkJb9RUhurSP3deQwTHuMFj/B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326211422"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326211422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 14:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="513349273"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2022 14:08:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njSQA-0003zG-4u;
        Tue, 26 Apr 2022 21:08:30 +0000
Date:   Wed, 27 Apr 2022 05:08:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_osnoise.c:131:1: sparse: sparse: symbol
 '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
Message-ID: <202204270534.hS2vHyWX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cf424ef014ac30b0da27125dd1fbdf10b0d3a520
commit: a955d7eac1779b437ceb24fc352026a2cbcec140 trace: Add timerlat tracer
date:   10 months ago
config: parisc-randconfig-s031-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270534.hS2vHyWX-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a955d7eac1779b437ceb24fc352026a2cbcec140
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a955d7eac1779b437ceb24fc352026a2cbcec140
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace_osnoise.c:108:1: sparse: sparse: symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
>> kernel/trace/trace_osnoise.c:131:1: sparse: sparse: symbol '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:223:14: sparse: sparse: symbol 'interface_lock' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:657:6: sparse: sparse: symbol 'osnoise_trace_irq_entry' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:680:6: sparse: sparse: symbol 'osnoise_trace_irq_exit' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:739:5: sparse: sparse: symbol 'hook_irq_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:771:6: sparse: sparse: symbol 'unhook_irq_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:788:6: sparse: sparse: symbol 'trace_softirq_entry_callback' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:811:6: sparse: sparse: symbol 'trace_softirq_exit_callback' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:953:1: sparse: sparse: symbol 'trace_sched_switch_callback' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:971:5: sparse: sparse: symbol 'hook_thread_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:988:6: sparse: sparse: symbol 'unhook_thread_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:1000:6: sparse: sparse: symbol 'save_osn_sample_stats' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:1015:6: sparse: sparse: symbol 'diff_osn_sample_stats' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:1213:17: sparse: sparse: incompatible types in comparison expression (different signedness):
   kernel/trace/trace_osnoise.c:1213:17: sparse:    signed long long *
   kernel/trace/trace_osnoise.c:1213:17: sparse:    unsigned long long [usertype] *
   kernel/trace/trace_osnoise.c:1657:5: sparse: sparse: symbol 'timerlat_min_period' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:1658:5: sparse: sparse: symbol 'timerlat_max_period' was not declared. Should it be static?

vim +/__pcpu_scope_per_cpu_timerlat_var +131 kernel/trace/trace_osnoise.c

   112	
   113	/*
   114	 *  osnoise_unregister_instance - unregister a registered trace instance
   115	 *
   116	 * Remove the trace_array *tr from the list of instances running
   117	 * osnoise/timerlat tracers.
   118	 */
   119	static void osnoise_unregister_instance(struct trace_array *tr)
   120	{
   121		struct osnoise_instance *inst;
   122		int found = 0;
   123	
   124		/*
   125		 * register/unregister serialization is provided by trace's
   126		 * trace_types_lock.
   127		 */
   128		lockdep_assert_held(&trace_types_lock);
   129	
   130		list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 > 131			if (inst->tr == tr) {
   132				list_del_rcu(&inst->list);
   133				found = 1;
   134				break;
   135			}
   136		}
   137	
   138		if (!found)
   139			return;
   140	
   141		kvfree_rcu(inst);
   142	}
   143	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
