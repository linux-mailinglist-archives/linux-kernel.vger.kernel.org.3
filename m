Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139DA57F6B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 21:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiGXTYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 15:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXTYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 15:24:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ABAEE13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658690661; x=1690226661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SvohAPZa96BaN4XatnHwvZCfyOEADAbXgNY9qfj6dHM=;
  b=J3yxLm3u+0Jc8Xj9/D3AO3UdsGt6Ww311meAigJrDOW8WihzXLHK0GqQ
   eD0GK5TDMN2z1s2HxqPmm3SLy/fJBeAFrxnL8jT58UuGLeZ3zBmLHrm4u
   qRsg2WRdlJ4vGs4umYCvQi/A3jRZ4HrqSTfNHnM+Dx4IIFR6LWaBVbRmP
   TBHSKbxLVTpvTpSxGQK7ll//02AMyTNy25VWnBv93I2jnGSAK2IHTXJ76
   m6x55Z07DhPWfQfL/jGZ+00dgnaapk0tFD3Ravnh3u+Ni2isMcZSSX2fa
   WM6oiW3EyZ3sV+QaKH1JzC/WXSKqmtsI0eYCayP/MV6P0177owYitWWty
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="351561459"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="351561459"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 12:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="574789620"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2022 12:24:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFhD8-0004B3-1k;
        Sun, 24 Jul 2022 19:24:18 +0000
Date:   Mon, 25 Jul 2022 03:23:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>
Subject: [atishp04:sstc_v5 4/5] drivers/clocksource/timer-riscv.c:185:6:
 error: call to undeclared function 'riscv_isa_extension_available'; ISO C99
 and later do not support implicit function declarations
Message-ID: <202207250359.HbTGzcp8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
config: riscv-randconfig-r002-20220718 (https://download.01.org/0day-ci/archive/20220725/202207250359.HbTGzcp8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0c1b32717bcffcf8edf95294e98933bd4c1e76ed)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/atishp04/linux/commit/69d668ba2592b6ce82b8d08c327097ccfd69b600
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sstc_v5
        git checkout 69d668ba2592b6ce82b8d08c327097ccfd69b600
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clocksource/timer-riscv.c:185:6: error: call to undeclared function 'riscv_isa_extension_available'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (riscv_isa_extension_available(NULL, SSTC)) {
               ^
>> drivers/clocksource/timer-riscv.c:185:42: error: use of undeclared identifier 'SSTC'
           if (riscv_isa_extension_available(NULL, SSTC)) {
                                                   ^
   2 errors generated.


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
