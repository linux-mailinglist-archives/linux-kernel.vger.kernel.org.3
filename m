Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B4E57C1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 03:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiGUBoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 21:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGUBo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 21:44:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB07539C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658367868; x=1689903868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CiD6uhGvP9ofUtlt7cQbW+MsOPjTeQB7WvsVPTLaYhM=;
  b=n66YwKoC2697X9azDAdEFPjhLzNQXtaizlxrcCftOGw3IRc3ICZZ8SK9
   cVAA6Z/kMqjoVpFrYMbr/DxTSUJ2kV9G6ppXi0DeYLy6AXykNv7YSce9/
   KdIVaIsTP757YJuQd5UQbmEctXrvVoI9d20ORXNoJsjQ36zH1Q99SAM9U
   rNdwIw23QLaJj0ukGndjpdbsRQ3jeUTxPc6BmPq33/PFXQrDCyWqOnBPT
   WGRScpvuoS8+Egv0Y8SJs5Y5lJnEmsqg0QC083UoIYNDyw8Enxec8PIpf
   dqq8U/bCuckq4fUvggLTAcZWhPsAZENJg82RBi63KXaLpnlroBgrRmU/5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="348620915"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="348620915"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 18:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="630984223"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Jul 2022 18:44:26 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oELEi-0001Fb-MF;
        Thu, 21 Jul 2022 01:44:20 +0000
Date:   Thu, 21 Jul 2022 09:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
Subject: [atishp04:sstc_v5 4/5] drivers/clocksource/timer-riscv.c:185:13:
 error: implicit declaration of function 'riscv_isa_extension_available'
Message-ID: <202207210943.M8zIbeEX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sstc_v5
head:   1b65346e11303beea1c67b3557ae56aee68e7a57
commit: 69d668ba2592b6ce82b8d08c327097ccfd69b600 [4/5] RISC-V: Prefer sstc extension if available
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220721/202207210943.M8zIbeEX-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/69d668ba2592b6ce82b8d08c327097ccfd69b600
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sstc_v5
        git checkout 69d668ba2592b6ce82b8d08c327097ccfd69b600
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clocksource/timer-riscv.c: In function 'riscv_timer_init_dt':
>> drivers/clocksource/timer-riscv.c:185:13: error: implicit declaration of function 'riscv_isa_extension_available' [-Werror=implicit-function-declaration]
     185 |         if (riscv_isa_extension_available(NULL, SSTC)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-riscv.c:185:49: error: 'SSTC' undeclared (first use in this function)
     185 |         if (riscv_isa_extension_available(NULL, SSTC)) {
         |                                                 ^~~~
   drivers/clocksource/timer-riscv.c:185:49: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/riscv_isa_extension_available +185 drivers/clocksource/timer-riscv.c

   117	
   118	static int __init riscv_timer_init_dt(struct device_node *n)
   119	{
   120		int cpuid, hartid, error;
   121		struct device_node *child;
   122		struct irq_domain *domain;
   123	
   124		hartid = riscv_of_processor_hartid(n);
   125		if (hartid < 0) {
   126			pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
   127				n, hartid);
   128			return hartid;
   129		}
   130	
   131		cpuid = riscv_hartid_to_cpuid(hartid);
   132		if (cpuid < 0) {
   133			pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
   134			return cpuid;
   135		}
   136	
   137		if (cpuid != smp_processor_id())
   138			return 0;
   139	
   140		domain = NULL;
   141		child = of_get_compatible_child(n, "riscv,cpu-intc");
   142		if (!child) {
   143			pr_err("Failed to find INTC node [%pOF]\n", n);
   144			return -ENODEV;
   145		}
   146		domain = irq_find_host(child);
   147		of_node_put(child);
   148		if (!domain) {
   149			pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
   150			return -ENODEV;
   151		}
   152	
   153		riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
   154		if (!riscv_clock_event_irq) {
   155			pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
   156			return -ENODEV;
   157		}
   158	
   159		pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
   160		       __func__, cpuid, hartid);
   161		error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
   162		if (error) {
   163			pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
   164			       error, cpuid);
   165			return error;
   166		}
   167	
   168		sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
   169	
   170		error = request_percpu_irq(riscv_clock_event_irq,
   171					    riscv_timer_interrupt,
   172					    "riscv-timer", &riscv_clock_event);
   173		if (error) {
   174			pr_err("registering percpu irq failed [%d]\n", error);
   175			return error;
   176		}
   177	
   178		error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
   179				 "clockevents/riscv/timer:starting",
   180				 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
   181		if (error)
   182			pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
   183			       error);
   184	
 > 185		if (riscv_isa_extension_available(NULL, SSTC)) {
   186			pr_info("Timer interrupt in S-mode is available via sstc extension\n");
   187			static_branch_enable(&riscv_sstc_available);
   188		}
   189	
   190		return error;
   191	}
   192	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
