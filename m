Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA96D4BCDEB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiBTKSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:18:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBTKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:17:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9AEBC9A;
        Sun, 20 Feb 2022 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645352257; x=1676888257;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FJWA/e2ARCT6IKuYx267KSV+f+20WZxwf0RWSo+k1TA=;
  b=Kx0NVxhHyj46y7lZ2Zw2xqZQDioTVQ+Zfy9uaP8lONlrkx5YovGF2DCu
   5yj306r5YJ3ScBWT/UDxuVlZEQsOPFvCVDb6kmYp3/QyY0KuFRztNE4Ca
   2duOGRqxchK2VkIhdqSVnw5/T9YfNtFh/VOUX9CrbUPGDTRKWNrm7Gc/z
   4svGWsZe5pon2yo7h3LDdX3XUoES//TZ6OxARRN+8eKwAwl4b0peIFexx
   q1/vAGmY2yCly9yns8IFfYLpn6HPetNZ6KoXqrjUNabJ8j6pSeYQPuwTc
   /riVsH/izjSDnWRCWIbI4tTb+N03oyu4yxuvKLgSkWbuRGwEHRupYSwum
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="231331065"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="231331065"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 02:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="590651267"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Feb 2022 02:17:35 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLjHa-0000EX-Nt; Sun, 20 Feb 2022 10:17:34 +0000
Date:   Sun, 20 Feb 2022 18:17:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        linux-doc@vger.kernel.org
Subject: [atishp04:sbi_pmu_v6 12/17] drivers/perf/riscv_pmu_legacy.c:76:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202202201838.kdXweR8L-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sbi_pmu_v6
head:   876094386d4f915d81ec2ee5b8b412987a10d808
commit: 9cba22b308da91d7cf0781fcc18b3ad34abdf9b0 [12/17] RISC-V: Add a simple platform driver for RISC-V legacy perf
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220220/202202201838.kdXweR8L-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/9cba22b308da91d7cf0781fcc18b3ad34abdf9b0
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sbi_pmu_v6
        git checkout 9cba22b308da91d7cf0781fcc18b3ad34abdf9b0
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
