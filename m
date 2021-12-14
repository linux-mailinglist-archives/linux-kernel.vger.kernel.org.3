Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B61473D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhLNGcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:32:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:49234 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhLNGcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639463533; x=1670999533;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BFTZJHLiFvx9dfj9r67PpNP1+pbqUuTKz8LXfuK6360=;
  b=YCySEwEmd+AKpsIDnbUBQGgnEYwuIT5r2lpiDNdalzOGPGK62euMQWBg
   NwTykucNB7C5B3qG5vR9xUyO9Ns3U92IWcI59fAfaMJ74p2P1B73ZRk+I
   LyL7Vu1sr2QR1QTevdc7JAUBeUKKdMlH+MNnp2dsjCtl4X+QRO+f34W+G
   gb5h1UYFUltHbDxp0sftXhoGXnPG8aodpK6LBu+Tx/kMb/tVpcKn9l1+I
   6RYzs7i4mCnxQL6+22XEDSGaVMBcLUBxKwhCEUmgOyT5ca4iJ2Hg3W02o
   u777ggBfZkHiL7GVHrLYjk3PKkfLDevL6lR/YIagzGrn9OPo2+fMGQsBI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263047173"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="263047173"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 22:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="464950100"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 22:32:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx1MA-0007Vk-4g; Tue, 14 Dec 2021 06:32:10 +0000
Date:   Tue, 14 Dec 2021 14:32:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>, linux-doc@vger.kernel.org
Subject: [palmer:riscv-pmu 4/10] drivers/perf/riscv_pmu_legacy.c:76: warning:
 This comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202112141442.yPBMCGPB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git riscv-pmu
head:   7a94c6fb363cfe62906cb0503d763204b0fe32b8
commit: e4d5f33e63b1260f378512c0f6e5a117ed6b894a [4/10] RISC-V: Add a simple platform driver for RISC-V legacy perf
config: riscv-randconfig-r042-20211213 (https://download.01.org/0day-ci/archive/20211214/202112141442.yPBMCGPB-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=e4d5f33e63b1260f378512c0f6e5a117ed6b894a
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer riscv-pmu
        git checkout e4d5f33e63b1260f378512c0f6e5a117ed6b894a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/perf/riscv_pmu_legacy.c:76: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This is just a simple implementation to allow legacy implementations


vim +76 drivers/perf/riscv_pmu_legacy.c

    74	
    75	/**
  > 76	 * This is just a simple implementation to allow legacy implementations
    77	 * compatible with new RISC-V PMU driver framework.
    78	 * This driver only allows reading two counters i.e CYCLE & INSTRET.
    79	 * However, it can not start or stop the counter. Thus, it is not very useful
    80	 * will be removed in future.
    81	 */
    82	static void pmu_legacy_init(struct riscv_pmu *pmu)
    83	{
    84		pr_info("Legacy PMU implementation is available\n");
    85	
    86		pmu->num_counters = RISCV_PMU_LEGACY_NUM_CTR;
    87		pmu->ctr_start = pmu_legacy_ctr_start;
    88		pmu->ctr_stop = NULL;
    89		pmu->event_map = pmu_legacy_event_map;
    90		pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
    91		pmu->ctr_get_width = NULL;
    92		pmu->ctr_clear_idx = NULL;
    93		pmu->ctr_read = pmu_legacy_read_ctr;
    94	
    95		perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
    96	}
    97	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
