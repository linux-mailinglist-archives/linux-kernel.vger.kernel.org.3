Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D401E4A2E74
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbiA2L5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:57:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:28873 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240332AbiA2L5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643457426; x=1674993426;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6Qn6Nz3CVj0GK0u7Ow+pSh0AFpPGVF2G0H6EUY93syc=;
  b=POL0cGzdvZz2XACcbpiS6Lr0JRy0FonGJbAf5VdCSGmo4qOtH0cHP5sc
   Yf8aNYhv/i1mD56WuZTAXecHixg6V9BPbpiNoJljznlArRzAbzshQQFhT
   NI6K9+mqvS5+r6tn2ZVLOUCurbIObkXX4nj4YRs+3TohrrSk3iHNXROAJ
   nIWbYOGvk4JTduTUdIfRRJPjfRB33E0BjQgn3PmLggWRJkPbyiHw5nfKz
   HkKcNyab3Nz0dBgFfR28hu8qK+4rP8eq24mSVhyAf/eGO/X2O6Nohz58h
   RPJzkzsrGaWGjf1JFUHCrouWZFVgr6JSirma5Ks2rwEwQBoO6MhRAYdzU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="307994510"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="307994510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 03:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="481027486"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2022 03:57:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDmLo-000P9N-Cp; Sat, 29 Jan 2022 11:57:04 +0000
Date:   Sat, 29 Jan 2022 19:56:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_aclint_v5 3/12] arch/riscv/kernel/smp.c:166:50:
 sparse: sparse: incorrect type in argument 4 (different address spaces)
Message-ID: <202201291952.3uJSTKvp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_aclint_v5
head:   7f4564bd884ddd6e785f4718ed46c5d4a59bf310
commit: bbfd82cb293e2c4fe309a1c9bf59d3a4d9459d26 [3/12] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-s032-20220129 (https://download.01.org/0day-ci/archive/20220129/202201291952.3uJSTKvp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/avpatel/linux/commit/bbfd82cb293e2c4fe309a1c9bf59d3a4d9459d26
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_aclint_v5
        git checkout bbfd82cb293e2c4fe309a1c9bf59d3a4d9459d26
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:166:50: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected void [noderef] __percpu *percpu_dev_id @@     got int * @@
   arch/riscv/kernel/smp.c:166:50: sparse:     expected void [noderef] __percpu *percpu_dev_id
   arch/riscv/kernel/smp.c:166:50: sparse:     got int *

vim +166 arch/riscv/kernel/smp.c

   151	
   152	void riscv_ipi_set_virq_range(int virq, int nr)
   153	{
   154		int i, err;
   155	
   156		if (WARN_ON(ipi_virq_base))
   157			return;
   158	
   159		WARN_ON(nr < IPI_MAX);
   160		nr_ipi = min(nr, IPI_MAX);
   161		ipi_virq_base = virq;
   162	
   163		/* Request IPIs */
   164		for (i = 0; i < nr_ipi; i++) {
   165			err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
 > 166						 "IPI", &ipi_virq_base);
   167			WARN_ON(err);
   168	
   169			ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
   170			irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
   171		}
   172	
   173		/* Enabled IPIs for boot CPU immediately */
   174		riscv_ipi_enable();
   175	}
   176	EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
   177	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
