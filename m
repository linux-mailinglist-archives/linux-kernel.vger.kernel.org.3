Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B078C4E3E75
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiCVM3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbiCVM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:29:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B8A7DA8C;
        Tue, 22 Mar 2022 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647952053; x=1679488053;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=odqputHphRLEGTlFQVeQHC2Df4Gj0dQyFtRFLzNNbhY=;
  b=F0G340R9k9AmYY+KygMQ6IgbmuqDtS2Yq98Pwq9c46zryFKtD0MlObtV
   AewBbsEYDbprfd8W8H2vVanKMVKpgB6HfIr0XQ74LChoYTXN7dTXENqEe
   ZY4wFhs6IfK70sI9PheHoIO6ZW1QaVVamcLZmV5LvigvpYHoo2/6hMdk/
   Ht/l1Tehr+f4GAY5Ij1b4RCvmub1ST7I3YUWhBqa5S1H4z7mGWnBaKl1N
   unoLLKFuNiGEN21pUaYEvKrFpzEhfA+xOWcx4DaAeEZJIFic4yip+tJ3q
   lWPhuVW+RYFOtTRkzL8xC+OpH1J8DcCHDcy7rOfKnULpoUZLLpUoqd0Lb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="245278821"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="245278821"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 05:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="583238545"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2022 05:27:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWdbj-000Im3-R3; Tue, 22 Mar 2022 12:27:27 +0000
Date:   Tue, 22 Mar 2022 20:27:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>, linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-pmu 10/15]
 drivers/perf/riscv_pmu_legacy.c:76: warning: This comment starts with '/**',
 but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203222043.1RKgCxBP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-pmu
head:   33363c336516e4beb9dd7e8265b369ff96d07dcb
commit: 9b3e150e310ee71d7bae1e31c38a300cfa5e951b [10/15] RISC-V: Add a simple platform driver for RISC-V legacy perf
config: riscv-randconfig-r006-20220320 (https://download.01.org/0day-ci/archive/20220322/202203222043.1RKgCxBP-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9b3e150e310ee71d7bae1e31c38a300cfa5e951b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-pmu
        git checkout 9b3e150e310ee71d7bae1e31c38a300cfa5e951b
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
