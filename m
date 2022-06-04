Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDF153D8C0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 00:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiFDWlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiFDWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 18:41:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2562BF79
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654382478; x=1685918478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Knviwl19JMIauYk8cJGoyLOmq4c2nR30uFsE9VFNTeg=;
  b=jeExOVO2lQrXRN81+yivNb9+BSD5X1MPVxw/zjWblfiR6xR061TZ/m2H
   3pZfX2F9zcYQZiCmHnZhDEb8upB0iNHwUkToG8OHKni3GLsEZsV++Zvw0
   MZAxgm3yzQI46OSeTP4RwwVx8qvFMpeoQKkXZ2rIZQ2pY7twsXAPlkEiS
   Re+Fr6NEzsNlvjizJegMfPF0K0DA0Jc/FYnWKIGEYazXYw/V7hVjuWWD/
   +TtPsKy1Ek9NXMuiQfy2J0bRZ5VjISQHzXVg17Ej3geJGI6C1BpnvlKoj
   cfLVycNykhc3dPa41+fWE20AAxbT3dMtkJx5ILZ3jmt/xjo1U1GZmxAeJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="274048659"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="274048659"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 15:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="708522241"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2022 15:41:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxcSJ-000BFx-PI;
        Sat, 04 Jun 2022 22:41:15 +0000
Date:   Sun, 5 Jun 2022 06:40:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/context-tracking-v4 10/20]
 kernel/entry/common.c:452: undefined reference to `ct_nmi_enter'
Message-ID: <202206050647.OqMhvNtv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/context-tracking-v4
head:   77493b1db618c61dec140cbab830832f77203d69
commit: d3d60b6390751cda15d2295725673f78303e4ea4 [10/20] context_tracking: Take NMI eqs entrypoints over RCU
config: x86_64-randconfig-a008 (https://download.01.org/0day-ci/archive/20220605/202206050647.OqMhvNtv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=d3d60b6390751cda15d2295725673f78303e4ea4
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/context-tracking-v4
        git checkout d3d60b6390751cda15d2295725673f78303e4ea4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: pvh_start_xen()+0x0: unreachable instruction
   ld: vmlinux.o: in function `irq_enter':
   kernel/softirq.c:610: undefined reference to `ct_irq_enter'
   ld: vmlinux.o: in function `irq_exit':
   kernel/softirq.c:662: undefined reference to `ct_irq_exit'
   ld: vmlinux.o: in function `trace_console_rcuidle':
   include/trace/events/printk.h:10: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/printk.h:10: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `bc_set_next':
   kernel/time/tick-broadcast-hrtimer.c:64: undefined reference to `ct_irq_enter_irqson'
   ld: kernel/time/tick-broadcast-hrtimer.c:64: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_irq_disable_rcuidle':
   include/trace/events/preemptirq.h:36: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/preemptirq.h:36: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_irq_enable_rcuidle':
   include/trace/events/preemptirq.h:40: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/preemptirq.h:40: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_disable_rcuidle':
   include/trace/events/clk.h:46: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/clk.h:46: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_disable_complete_rcuidle':
   include/trace/events/clk.h:53: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/clk.h:53: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_enable_rcuidle':
   include/trace/events/clk.h:32: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/clk.h:32: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `trace_clk_enable_complete_rcuidle':
   include/trace/events/clk.h:39: undefined reference to `ct_irq_enter_irqson'
   ld: include/trace/events/clk.h:39: undefined reference to `ct_irq_exit_irqson'
   ld: vmlinux.o: in function `irqentry_nmi_enter':
>> kernel/entry/common.c:452: undefined reference to `ct_nmi_enter'
   ld: vmlinux.o: in function `irqentry_nmi_exit':
>> kernel/entry/common.c:472: undefined reference to `ct_nmi_exit'
   ld: vmlinux.o: in function `irqentry_exit':
   kernel/entry/common.c:421: undefined reference to `ct_irq_exit'
   ld: kernel/entry/common.c:439: undefined reference to `ct_irq_exit'


vim +452 kernel/entry/common.c

   442	
   443	irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
   444	{
   445		irqentry_state_t irq_state;
   446	
   447		irq_state.lockdep = lockdep_hardirqs_enabled();
   448	
   449		__nmi_enter();
   450		lockdep_hardirqs_off(CALLER_ADDR0);
   451		lockdep_hardirq_enter();
 > 452		ct_nmi_enter();
   453	
   454		instrumentation_begin();
   455		trace_hardirqs_off_finish();
   456		ftrace_nmi_enter();
   457		instrumentation_end();
   458	
   459		return irq_state;
   460	}
   461	
   462	void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
   463	{
   464		instrumentation_begin();
   465		ftrace_nmi_exit();
   466		if (irq_state.lockdep) {
   467			trace_hardirqs_on_prepare();
   468			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
   469		}
   470		instrumentation_end();
   471	
 > 472		ct_nmi_exit();

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
