Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD1585C76
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 00:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiG3WAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 18:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiG3WAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 18:00:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C343015A1B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659218450; x=1690754450;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0KbOo47c6MO9HsT5NbdV6Em5xp1ZF+XPHCb7Qjg4AnY=;
  b=i8DMQLNTGR1IV+akbLcJfeXa9Uo2EWdbdnwEytzvH82NKAUfUQVpazNR
   3HRF1fpqSwIHYoA5e5su75NyaNHvSHAT8LzTgFc3fU/9J/iHm+/v1HXnm
   wAWqsZNOmZavtTxjS/U0F1M7w1uUrBdklLKMmSvqS04k5T9vTYsLssSb2
   Ettlp3O3nzzeuIZBOElQZnS2HR8nLPjzkk1Y1Nt4Id9GkfH2ZRgchPr4F
   2ICZxjwJsXHiTJv7/WvrNVQgzvoEyn8xJfxpjl9zLGMAFhI9S2v0na3P7
   +/ulpiLehqImOLDC8qPxF17B6EroKFeuIyG/VjTrDkk1dt4/2bX+EDM3l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="288962906"
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="288962906"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 15:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,205,1654585200"; 
   d="scan'208";a="669624488"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2022 15:00:49 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHuVs-000DNn-1m;
        Sat, 30 Jul 2022 22:00:48 +0000
Date:   Sun, 31 Jul 2022 06:00:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_sbi_dbcn_v1 20/45]
 drivers/clocksource/timer-clint.c:250:9: error: too few arguments to
 function 'clint_clear_ipi'
Message-ID: <202207310505.Bbec7lMz-lkp@intel.com>
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

tree:   https://github.com/avpatel/linux.git riscv_sbi_dbcn_v1
head:   9d220d614f299a3841990e7890aba88262b29012
commit: 3ab8ce4cbcd9f740c610e181649b1eb108bc7a05 [20/45] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220731/202207310505.Bbec7lMz-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/3ab8ce4cbcd9f740c610e181649b1eb108bc7a05
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_sbi_dbcn_v1
        git checkout 3ab8ce4cbcd9f740c610e181649b1eb108bc7a05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clocksource/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clocksource/timer-clint.c: In function 'clint_timer_init_dt':
>> drivers/clocksource/timer-clint.c:250:9: error: too few arguments to function 'clint_clear_ipi'
     250 |         clint_clear_ipi(clint_ipi_irq);
         |         ^~~~~~~~~~~~~~~
   drivers/clocksource/timer-clint.c:56:13: note: declared here
      56 | static void clint_clear_ipi(unsigned int parent_virq, void *data)
         |             ^~~~~~~~~~~~~~~


vim +/clint_clear_ipi +250 drivers/clocksource/timer-clint.c

   214	
   215		pr_info("%pOFP: timer running at %ld Hz\n", np, clint_timer_freq);
   216	
   217		rc = clocksource_register_hz(&clint_clocksource, clint_timer_freq);
   218		if (rc) {
   219			pr_err("%pOFP: clocksource register failed [%d]\n", np, rc);
   220			goto fail_iounmap;
   221		}
   222	
   223		sched_clock_register(clint_get_cycles64, 64, clint_timer_freq);
   224	
   225		rc = request_percpu_irq(clint_timer_irq, clint_timer_interrupt,
   226					 "clint-timer", &clint_clock_event);
   227		if (rc) {
   228			pr_err("registering percpu irq failed [%d]\n", rc);
   229			goto fail_iounmap;
   230		}
   231	
   232		rc = cpuhp_setup_state(CPUHP_AP_CLINT_TIMER_STARTING,
   233					"clockevents/clint/timer:starting",
   234					clint_timer_starting_cpu,
   235					clint_timer_dying_cpu);
   236		if (rc) {
   237			pr_err("%pOFP: cpuhp setup state failed [%d]\n", np, rc);
   238			goto fail_free_irq;
   239		}
   240	
   241		virq = ipi_mux_create(clint_ipi_irq, BITS_PER_BYTE,
   242				      &clint_ipi_ops, NULL);
   243		if (virq <= 0) {
   244			pr_err("unable to create muxed IPIs\n");
   245			rc = (virq < 0) ? virq : -ENODEV;
   246			goto fail_remove_cpuhp;
   247		}
   248	
   249		riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
 > 250		clint_clear_ipi(clint_ipi_irq);
   251	
   252		return 0;
   253	
   254	fail_remove_cpuhp:
   255		cpuhp_remove_state(CPUHP_AP_CLINT_TIMER_STARTING);
   256	fail_free_irq:
   257		free_irq(clint_timer_irq, &clint_clock_event);
   258	fail_iounmap:
   259		iounmap(base);
   260		return rc;
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
