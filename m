Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22C4BCE31
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiBTLjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 06:39:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiBTLjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:39:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163262A24E;
        Sun, 20 Feb 2022 03:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645357120; x=1676893120;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2iB1zCNvMxpxf3iA+K+EHTFBJt7u3hTjWXSVeGvomvg=;
  b=MbcKkrCm+63yC8+HZ3fj6466Ba0DXPT1KiwlbWvrOpsMb3MDHpv53IJ8
   RNZgJ+7Picbml/vPR5guD1s5ILA16qI2GsNPwhU6UM79akO9pGgv37RNO
   g+CBrf0udqmyR5ssETaqrn89TgrMJYavbkeM9d314Xcom8A76qPCt4WnW
   s/ueYE+1LTHn3lr/MaI+KSPlKANBzED5xoKGNm75UE9LYWZPHLeEes3UZ
   nmbUhwybCdWBbq1HWCuUk+e/9qznWKn81zqRP91Y85RCbFP3+7zGH1sv3
   cPv42X4aFmoqfwIM0qsNoZzYlxW3ukH6DalgZ52Y4n7uZHFiYLzoTsuuh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="337796819"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="337796819"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 03:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="507296914"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2022 03:38:37 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLkY0-0000Hy-PR; Sun, 20 Feb 2022 11:38:36 +0000
Date:   Sun, 20 Feb 2022 19:38:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [atishp04:sbi_pmu_v6 15/17] drivers/perf/riscv_pmu_sbi.c:498:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202202201931.p5hX32R7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sbi_pmu_v6
head:   876094386d4f915d81ec2ee5b8b412987a10d808
commit: 4d77ea7126a3073504f29575eacacc63547fb579 [15/17] RISC-V: Add sscofpmf extension support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220220/202202201931.p5hX32R7-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/4d77ea7126a3073504f29575eacacc63547fb579
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sbi_pmu_v6
        git checkout 4d77ea7126a3073504f29575eacacc63547fb579
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
