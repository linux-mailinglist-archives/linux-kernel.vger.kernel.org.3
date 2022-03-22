Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89FA4E3F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiCVN0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiCVN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:26:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0552E3B2A3;
        Tue, 22 Mar 2022 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647955490; x=1679491490;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lWXVrca+VfCcFsSg7/+CoGYp9Og1yz0JFXNobcYW3so=;
  b=CkC1CygRAfPTQifZDMrU1LD+aH0IqRPxrUciWBxt3YHs1s9T3GLC6Mt8
   yFOQNyq+Qv0/HFkF75uDUewHeQ8tDufHToZlEU8XK9LuLNsGLQUduUoat
   7uPVxj6aOLUDAjPo2KXKO1HS7w20YjUbSgWp1ZA5IA0sJt+awXVCXhrZR
   SyKb88Tj+ghOe8mZN/AxjFitsawPvPlpWzXsYCV0ztcK3Lf7J67aSr2Vn
   pdlDBXQr/qIm9EEA7HQWhV/WIHaWzKFF9E7qbfycX4307RYZgn3c062tz
   yb6o2r/WINPHs7htAEc7YxSpt0Dfc4bB+zdt6ENk18gA8z+gjJS6LldhC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="258006011"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="258006011"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="560382844"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2022 06:24:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWeVE-000Iqx-0Q; Tue, 22 Mar 2022 13:24:48 +0000
Date:   Tue, 22 Mar 2022 21:24:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-pmu 13/15]
 drivers/perf/riscv_pmu_sbi.c:498: warning: This comment starts with '/**',
 but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203222137.eK8TFhiJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-pmu
head:   33363c336516e4beb9dd7e8265b369ff96d07dcb
commit: 4905ec2fb7e6421c14c9fb7276f5aa92f60f2b98 [13/15] RISC-V: Add sscofpmf extension support
config: riscv-randconfig-r006-20220320 (https://download.01.org/0day-ci/archive/20220322/202203222137.eK8TFhiJ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4905ec2fb7e6421c14c9fb7276f5aa92f60f2b98
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-pmu
        git checkout 4905ec2fb7e6421c14c9fb7276f5aa92f60f2b98
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/perf/riscv_pmu_sbi.c:42: warning: cannot understand function prototype: 'union sbi_pmu_ctr_info *pmu_ctr_list; '
>> drivers/perf/riscv_pmu_sbi.c:498: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This function starts all the used counters in two step approach.


vim +498 drivers/perf/riscv_pmu_sbi.c

   496	
   497	/**
 > 498	 * This function starts all the used counters in two step approach.
   499	 * Any counter that did not overflow can be start in a single step
   500	 * while the overflowed counters need to be started with updated initialization
   501	 * value.
   502	 */
   503	static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
   504						       unsigned long ctr_ovf_mask)
   505	{
   506		int idx = 0;
   507		struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
   508		struct perf_event *event;
   509		unsigned long flag = SBI_PMU_START_FLAG_SET_INIT_VALUE;
   510		unsigned long ctr_start_mask = 0;
   511		uint64_t max_period;
   512		struct hw_perf_event *hwc;
   513		u64 init_val = 0;
   514	
   515		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[0] & ~ctr_ovf_mask;
   516	
   517		/* Start all the counters that did not overflow in a single shot */
   518		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, 0, ctr_start_mask,
   519			  0, 0, 0, 0);
   520	
   521		/* Reinitialize and start all the counter that overflowed */
   522		while (ctr_ovf_mask) {
   523			if (ctr_ovf_mask & 0x01) {
   524				event = cpu_hw_evt->events[idx];
   525				hwc = &event->hw;
   526				max_period = riscv_pmu_ctr_get_width_mask(event);
   527				init_val = local64_read(&hwc->prev_count) & max_period;
   528				sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
   529					  flag, init_val, 0, 0);
   530			}
   531			ctr_ovf_mask = ctr_ovf_mask >> 1;
   532			idx++;
   533		}
   534	}
   535	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
