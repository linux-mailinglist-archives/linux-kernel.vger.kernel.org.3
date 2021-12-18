Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E91479A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhLRLmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:42:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:33246 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhLRLms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639827768; x=1671363768;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WP9zqflrkmvZown8R4hE5524WUDL4isfId9iOMCz69A=;
  b=gt8cyQXR+hVwpCU9+MIPcx5NbQsSPbKKOI+dCwilVec5rndC839QkzOs
   RcZaKUvNxE6vjrFXivdUF1N4oe0cwr35E5CzPb00ZcbXLCLqtMA6zmSRu
   RdK9OpyXHGDvn0gnUvkdzvGEk0FZCYvq73QM0iY2n0bMMReL7TXmXPy4d
   RVnM1z+JF1JV3QRzGjp03vdwMPf2R0jSBUmSzKe2m7cleN2romecoARwI
   yyEzFa5E2kxZnML/z3flqnfkJ++Hdozprf3fVkbRD6EXIjfWRxdeGBHxh
   aDC30xioKs4yxLr4LtGrmh/t1gjyvd2RMKxOeIx4tDD8PLJY+LZfe9m04
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="238659365"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="238659365"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 03:42:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="756745917"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Dec 2021 03:42:42 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myY6r-0005vf-Qn; Sat, 18 Dec 2021 11:42:41 +0000
Date:   Sat, 18 Dec 2021 19:41:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [atishp04:sbi_pmu_v5 9/12] drivers/perf/riscv_pmu_sbi.c:470:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202112181958.puDbjktS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sbi_pmu_v5
head:   f9c08d001f70231844a69743e2d1655ece0e6628
commit: 7b33e2daa65b35b1541d0061a5066efdbac70a4d [9/12] RISC-V: Add interrupt support for perf
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20211218/202112181958.puDbjktS-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/7b33e2daa65b35b1541d0061a5066efdbac70a4d
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sbi_pmu_v5
        git checkout 7b33e2daa65b35b1541d0061a5066efdbac70a4d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/perf/riscv_pmu_sbi.c:38: warning: cannot understand function prototype: 'union sbi_pmu_ctr_info *pmu_ctr_list; '
>> drivers/perf/riscv_pmu_sbi.c:470: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function starts all the used counters in two step approach.


vim +470 drivers/perf/riscv_pmu_sbi.c

   468	
   469	/**
 > 470	 * This function starts all the used counters in two step approach.
   471	 * Any counter that did not overflow can be start in a single step
   472	 * while the overflowed counters need to be started with updated initialization
   473	 * value.
   474	 */
   475	static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
   476						       unsigned long ctr_ovf_mask)
   477	{
   478		int idx = 0;
   479		struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
   480		struct perf_event *event;
   481		unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
   482		unsigned long ctr_start_mask = 0;
   483		uint64_t max_period;
   484		struct hw_perf_event *hwc;
   485		u64 init_val = 0;
   486	
   487		ctr_start_mask = cpu_hw_evt->used_event_ctrs[0] & ~ctr_ovf_mask;
   488	
   489		/* Start all the counters that did not overflow in a single shot */
   490		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
   491			  0, 0, 0, 0);
   492	
   493		/* Reinitialize and start all the counter that overflowed */
   494		while(ctr_ovf_mask) {
   495			if (ctr_ovf_mask & 0x01) {
   496				event = cpu_hw_evt->events[idx];
   497				hwc = &event->hw;
   498				max_period = riscv_pmu_ctr_get_width_mask(event);
   499				init_val = local64_read(&hwc->prev_count) & max_period;
   500				sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
   501					  flag, init_val, 0, 0);
   502			}
   503			ctr_ovf_mask = ctr_ovf_mask >> 1;
   504			idx++;
   505		}
   506	}
   507	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
