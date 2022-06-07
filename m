Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1453F742
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiFGHbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237672AbiFGHau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:30:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6304253B5B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654587048; x=1686123048;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J4H+DmmV0Sf36iZKzFCffzDyO5WW16VgPNs6mbiVKxE=;
  b=Rx/RSZo6pZAoJjqszK03DV+9X3bjx+gmBNgNyyjO09QhmLHXk+igCaoD
   hKH3bNOd01GhdBi6RK2xOlN5zNCFGDPee+tsfb0IPagWfiShSB2rWKmxD
   CBPd674/bB0uzc9me/zYJ4AgToE8xy8ISR3jKbKPiGuPfJ475oBvHgzqs
   +LSeR9TMWefGcq5kb8t8p+0ffu9ngD1BrTDXsA73yAj5E+NH0NcRLMzOV
   xmtx5Ii9qm9AhFldAYJ6gib6wVAa76twDsAxKzyJPvPoEwZ+8OoMiYEoJ
   CFFbd1zs0pk3KH98cklaaiYu06gQd2qTZ8tm5cp8Q4+pt3yM3a/2rfHT5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="256547746"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="256547746"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="826238528"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2022 00:30:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyTfq-000DTZ-2z;
        Tue, 07 Jun 2022 07:30:46 +0000
Date:   Tue, 7 Jun 2022 15:29:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v4 16/20]
 kernel/context_tracking.c:124:39: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202206071536.jNspPAFL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v4
head:   43ac8196f06d6abb21f28143f62d879546ad262c
commit: ab8851bd9c0f3773a18a2c950047d02ec908e03c [16/20] rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220607/202206071536.jNspPAFL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=ab8851bd9c0f3773a18a2c950047d02ec908e03c
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v4
        git checkout ab8851bd9c0f3773a18a2c950047d02ec908e03c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/context_tracking.c:124:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:124:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:124:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c:163:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:163:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:163:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c:204:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:204:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:204:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c:259:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct context_tracking * @@
   kernel/context_tracking.c:259:39: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:259:39: sparse:     got struct context_tracking *
   kernel/context_tracking.c:490:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/context_tracking.c:490:21: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:490:21: sparse:     got int *
   kernel/context_tracking.c:495:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/context_tracking.c:495:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:495:9: sparse:     got int *
   kernel/context_tracking.c:524:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int enum ctx_state * @@
   kernel/context_tracking.c:524:14: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:524:14: sparse:     got int enum ctx_state *
   kernel/context_tracking.c:525:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
   kernel/context_tracking.c:525:21: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:525:21: sparse:     got bool *
   kernel/context_tracking.c:560:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int enum ctx_state * @@
   kernel/context_tracking.c:560:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:560:17: sparse:     got int enum ctx_state *
   kernel/context_tracking.c:624:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int enum ctx_state * @@
   kernel/context_tracking.c:624:13: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:624:13: sparse:     got int enum ctx_state *
   kernel/context_tracking.c:625:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
   kernel/context_tracking.c:625:21: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:625:21: sparse:     got bool *
   kernel/context_tracking.c:638:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int enum ctx_state * @@
   kernel/context_tracking.c:638:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:638:17: sparse:     got int enum ctx_state *
   kernel/context_tracking.c:681:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
   kernel/context_tracking.c:681:14: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:681:14: sparse:     got bool *
   kernel/context_tracking.c:682:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got bool * @@
   kernel/context_tracking.c:682:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:682:17: sparse:     got bool *
   kernel/context_tracking.c:502:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/context_tracking.c:502:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:502:9: sparse:     got int *
   kernel/context_tracking.c:502:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got int * @@
   kernel/context_tracking.c:502:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/context_tracking.c:502:9: sparse:     got int *

vim +124 kernel/context_tracking.c

   113	
   114	/*
   115	 * Enter an RCU extended quiescent state, which can be either the
   116	 * idle loop or adaptive-tickless usermode execution.
   117	 *
   118	 * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
   119	 * the possibility of usermode upcalls having messed up our count
   120	 * of interrupt nesting level during the prior busy period.
   121	 */
   122	static void noinstr rcu_eqs_enter(bool user)
   123	{
 > 124		struct context_tracking *ct = this_cpu_ptr(&context_tracking);
   125	
   126		WARN_ON_ONCE(ct_dynticks_nmi_nesting() != DYNTICK_IRQ_NONIDLE);
   127		WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
   128		WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
   129			     ct_dynticks_nesting() == 0);
   130		if (ct_dynticks_nesting() != 1) {
   131			// RCU will still be watching, so just do accounting and leave.
   132			ct->dynticks_nesting--;
   133			return;
   134		}
   135	
   136		instrumentation_begin();
   137		lockdep_assert_irqs_disabled();
   138		trace_rcu_dyntick(TPS("Start"), ct_dynticks_nesting(), 0, ct_dynticks());
   139		WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
   140		rcu_preempt_deferred_qs(current);
   141	
   142		// instrumentation for the noinstr rcu_dynticks_eqs_enter()
   143		instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
   144	
   145		instrumentation_end();
   146		WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
   147		// RCU is watching here ...
   148		rcu_dynticks_eqs_enter();
   149		// ... but is no longer watching here.
   150		rcu_dynticks_task_enter();
   151	}
   152	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
