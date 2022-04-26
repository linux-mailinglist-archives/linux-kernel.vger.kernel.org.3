Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77BE51060D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349464AbiDZR7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353643AbiDZR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:59:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D333DDC6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650995760; x=1682531760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N2x2LXk+r++AMqXB9ywRqVW7milvAS5JXMJ3BbkKtTg=;
  b=W1/0EVplnP3br3UlyuiuvNNXTekJN3spwY+F59pTUWoaKQ1s0F+BomH/
   ZckF8FVDT8g7FkXg9twbm/95bZP1SL2mWNMd7pUq2WnMcezL9XWy4YUCx
   X+91LHeuZYRs/x23Kymi/drDO8OkJEfdc7/HibkMfXB423T+atuvsFnf1
   NlA5pJ10dJPVqL7Ix7FavFXe6yjlXp0I3ymQpaShldcrBcZtmTPmQtK/X
   YumbvH2lHLV/nys5P0TPd+so24tYf+W+50iiUvo+eliWXIx4X7nShsbhT
   4H+K2WPSkY7Nt9C7YMXEDU8YNwg6ffgujM3+de/sALrzRA+V2pbPHbcnG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="263266406"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="263266406"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 10:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="617116800"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Apr 2022 10:55:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njPPo-0003sC-GI;
        Tue, 26 Apr 2022 17:55:56 +0000
Date:   Wed, 27 Apr 2022 01:55:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_osnoise.c:101:1: sparse: sparse: symbol
 '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
Message-ID: <202204270146.IRxXM4hU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d615b5416f8a1afeb82d13b238f8152c572d59c0
commit: bce29ac9ce0bb0b0b146b687ab978378c21e9078 trace: Add osnoise tracer
date:   10 months ago
config: parisc-randconfig-s031-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270146.IRxXM4hU-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bce29ac9ce0bb0b0b146b687ab978378c21e9078
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bce29ac9ce0bb0b0b146b687ab978378c21e9078
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_osnoise.c:101:1: sparse: sparse: symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:160:14: sparse: sparse: symbol 'interface_lock' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:438:6: sparse: sparse: symbol 'osnoise_trace_irq_entry' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:461:6: sparse: sparse: symbol 'osnoise_trace_irq_exit' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:520:5: sparse: sparse: symbol 'hook_irq_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:552:6: sparse: sparse: symbol 'unhook_irq_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:569:6: sparse: sparse: symbol 'trace_softirq_entry_callback' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:592:6: sparse: sparse: symbol 'trace_softirq_exit_callback' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:706:1: sparse: sparse: symbol 'trace_sched_switch_callback' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:724:5: sparse: sparse: symbol 'hook_thread_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:741:6: sparse: sparse: symbol 'unhook_thread_events' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:753:6: sparse: sparse: symbol 'save_osn_sample_stats' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:768:6: sparse: sparse: symbol 'diff_osn_sample_stats' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:966:17: sparse: sparse: incompatible types in comparison expression (different signedness):
   kernel/trace/trace_osnoise.c:966:17: sparse:    signed long long *
   kernel/trace/trace_osnoise.c:966:17: sparse:    unsigned long long [usertype] *

vim +/__pcpu_scope_per_cpu_osnoise_var +101 kernel/trace/trace_osnoise.c

    85	
    86	/*
    87	 * osnoise_register_instance - register a new trace instance
    88	 *
    89	 * Register a trace_array *tr in the list of instances running
    90	 * osnoise/timerlat tracers.
    91	 */
    92	static int osnoise_register_instance(struct trace_array *tr)
    93	{
    94		struct osnoise_instance *inst;
    95	
    96		/*
    97		 * register/unregister serialization is provided by trace's
    98		 * trace_types_lock.
    99		 */
   100		lockdep_assert_held(&trace_types_lock);
 > 101	
   102		inst = kmalloc(sizeof(*inst), GFP_KERNEL);
   103		if (!inst)
   104			return -ENOMEM;
   105	
   106		INIT_LIST_HEAD_RCU(&inst->list);
   107		inst->tr = tr;
   108		list_add_tail_rcu(&inst->list, &osnoise_instances);
   109	
   110		return 0;
   111	}
   112	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
