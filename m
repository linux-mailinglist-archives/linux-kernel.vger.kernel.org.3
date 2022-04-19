Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA65050622D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345159AbiDSCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiDSCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:37:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C23BF69
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650335716; x=1681871716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AQwMGRv0ikhnQ5DHe0mahCyQp8fMCmClmZYB8XfV64w=;
  b=Hm7ww1TeV/fh7bqBhpW0fCAUV5sk1Cw24+r0w67A7IIIqNi1ydPRtEyo
   T1kjoLiBtO2cl4nqzVHuXpsfyNLpTZ52Iae7EUJiVZ7TpLSKLxWJ91dY8
   ay/rgR9GkA1iwVkzBtDUwIjMHrWawscGhjJHtvwr4v8wvFQAyLMhuBIMT
   NEPCq5Ghrm8yusmFvPospSrbyGB+oBgthr5E7PiYmLKke7b89F6DgIFV4
   qHjdboPRLxEMlz4hdEuiAzt1iWulbO3U22IvTfM5/WDaIzui9jYBkN8Pq
   EKXRGcIGYlDurluQGGUNMa3eb8i5NezCQKxyTGybTbdP6n908sCgvRuI0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262517879"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="262517879"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 19:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="657467388"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2022 19:35:14 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngdhx-0005Di-OA;
        Tue, 19 Apr 2022 02:35:13 +0000
Date:   Tue, 19 Apr 2022 10:34:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linu Cherian <lcherian@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: arch/arm64/kernel/cpu_errata.c:218:25: sparse: sparse: symbol
 'cavium_erratum_23154_cpus' was not declared. Should it be static?
Message-ID: <202204191030.DC8873Hc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: 24a147bcef8ca039cb75d6d4b68c7cc339b11178 irqchip/gic-v3: Workaround Marvell erratum 38545 when reading IAR
date:   6 weeks ago
config: arm64-randconfig-s031-20220419 (https://download.01.org/0day-ci/archive/20220419/202204191030.DC8873Hc-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24a147bcef8ca039cb75d6d4b68c7cc339b11178
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 24a147bcef8ca039cb75d6d4b68c7cc339b11178
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/cpu_errata.c:218:25: sparse: sparse: symbol 'cavium_erratum_23154_cpus' was not declared. Should it be static?
   arch/arm64/kernel/cpu_errata.c:314:18: sparse: sparse: Initializer entry defined twice
   arch/arm64/kernel/cpu_errata.c:315:17: sparse:   also defined here
   arch/arm64/kernel/cpu_errata.c:320:18: sparse: sparse: Initializer entry defined twice
   arch/arm64/kernel/cpu_errata.c:321:17: sparse:   also defined here
   arch/arm64/kernel/cpu_errata.c:444:18: sparse: sparse: Initializer entry defined twice
   arch/arm64/kernel/cpu_errata.c:445:17: sparse:   also defined here
   arch/arm64/kernel/cpu_errata.c:552:17: sparse: sparse: Initializer entry defined twice
   arch/arm64/kernel/cpu_errata.c:553:18: sparse:   also defined here
   arch/arm64/kernel/cpu_errata.c:621:18: sparse: sparse: Initializer entry defined twice
   arch/arm64/kernel/cpu_errata.c:622:17: sparse:   also defined here

vim +/cavium_erratum_23154_cpus +218 arch/arm64/kernel/cpu_errata.c

   216	
   217	#ifdef CONFIG_CAVIUM_ERRATUM_23154
 > 218	const struct midr_range cavium_erratum_23154_cpus[] = {
   219		MIDR_ALL_VERSIONS(MIDR_THUNDERX),
   220		MIDR_ALL_VERSIONS(MIDR_THUNDERX_81XX),
   221		MIDR_ALL_VERSIONS(MIDR_THUNDERX_83XX),
   222		MIDR_ALL_VERSIONS(MIDR_OCTX2_98XX),
   223		MIDR_ALL_VERSIONS(MIDR_OCTX2_96XX),
   224		MIDR_ALL_VERSIONS(MIDR_OCTX2_95XX),
   225		MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXN),
   226		MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXMM),
   227		MIDR_ALL_VERSIONS(MIDR_OCTX2_95XXO),
   228		{},
   229	};
   230	#endif
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
