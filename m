Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86176571180
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiGLEjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGLEi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:38:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892725C64
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657600739; x=1689136739;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BFAI3Vex6qOybZjRwyHygNl+Ppab/iQX6BXwqhB29YM=;
  b=VpK9UWmt32wbsbXxGUOKWn0ODwO3v1aAV0OGUewTwoq/5rf7RHtKQjqj
   hROSQ5fAHI8wlbF8SSEWn8YIU3f2MlC98Oclzt0Rv0agFAlNtzssrCBu5
   oXAR/HJSIrvZSDgqn6ZoyqP2rZOW7nHvep4tEG5/wUrlICn5LzlWWbqWt
   mG1KrWyShOKBMJfcOVrrz6dyvnuHZW7+yB0cMXjR8slGAxNxvwQTmWEoU
   oQhFBvo65CRbbKhpnb2aMBjaTdoKg4ZPkd81W+zX+Eg0Sct8JyzYMXU6e
   Aw4cPowBLmkFoCF7sbjHixK2PK+QGbbuOo3BK6bt7Deo+bbCkA+FbH1P4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267874415"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="267874415"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 21:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="652750800"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2022 21:38:57 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB7fk-0001gh-Kr;
        Tue, 12 Jul 2022 04:38:56 +0000
Date:   Tue, 12 Jul 2022 12:38:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_osnoise.c:131:1: sparse: sparse: symbol
 '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
Message-ID: <202207121205.3WDa90OI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5a29232d870d9e63fe5ff30b081be6ea7cc2465d
commit: a955d7eac1779b437ceb24fc352026a2cbcec140 trace: Add timerlat tracer
date:   1 year, 1 month ago
config: s390-randconfig-s032-20220712 (https://download.01.org/0day-ci/archive/20220712/202207121205.3WDa90OI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a955d7eac1779b437ceb24fc352026a2cbcec140
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a955d7eac1779b437ceb24fc352026a2cbcec140
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
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
