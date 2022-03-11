Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28804D57E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbiCKCGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiCKCGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:06:18 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44481A6149;
        Thu, 10 Mar 2022 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646964315; x=1678500315;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f7icsPcwe22Y3Rkg4PbfygTUhgxSU2Ht81aYqhv3kAM=;
  b=LQu706m5eSHRFVvodmFkVn3k+F3PzQMBD8xTSnnE6Ia9rb5Ch00gbxdg
   5RERn8qxCgTDVsrqBQI66+IMfLZ2JZUlsGDFQvWU1qN/3tcsSL0DTxEkc
   QII3Q2KZvQ6Rp2XFRoX85ps8KK99C8UC2pbN/UBSMxXV455qcVVc5xruw
   DMdEUjVsmDou9BM9k+e2u3hF4tBNDcDkHbiO0BEFMvcFTMsWctwZzCp2k
   a4I7KEVmnH25YnAhELX60X5C/tb1eJOYB+P23LXAcaKD8eFkQlC/ohPFh
   yjfwZqsOfKVkQHMlaz6PO4pKvbRwSPqWZTBG7aDJI4rbD6GFLmYvc7+VO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316195969"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="316195969"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="712675009"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2022 18:05:13 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSUeW-0005hD-OH; Fri, 11 Mar 2022 02:05:12 +0000
Date:   Fri, 11 Mar 2022 10:04:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-pmu 4/10]
 drivers/perf/riscv_pmu_legacy.c:76: warning: This comment starts with '/**',
 but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202203110927.3ArrLPWM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-pmu
head:   7a94c6fb363cfe62906cb0503d763204b0fe32b8
commit: e4d5f33e63b1260f378512c0f6e5a117ed6b894a [4/10] RISC-V: Add a simple platform driver for RISC-V legacy perf
config: riscv-randconfig-r042-20211213 (https://download.01.org/0day-ci/archive/20220311/202203110927.3ArrLPWM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e4d5f33e63b1260f378512c0f6e5a117ed6b894a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-pmu
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
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
