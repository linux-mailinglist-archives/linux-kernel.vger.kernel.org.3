Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B98B58BB49
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiHGO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHGO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437356413
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659882576; x=1691418576;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pOjwQ4Ae/N8n14BKl5wLeO5q1515E0rN+/Nda3JXb4A=;
  b=mr/IMuQv3Q77eoujy0TVLeJU3EtaUuHIohx2tw3z0CXjWY1cED4p6uDx
   KA7GU7BNDBQG6WbjB7/YfGENzXZhXra13W034o+03ogJtPZJc3Z/Ji6VG
   8kDVGRmw84fUIHCcD2RMu0qZTPw+BKCGSLXmCJ7TyB7XNHwOQAIZDN4Y0
   DabOdqz66NGtY6Q5ku07FegHEu0geFxVO9pHha0FYS5IKcxas2mESInId
   agBndEHtEgq2ROkMWkCA/wfCynlegMor1suHhKiZ4XIiGvaXTzlMOTbUB
   Yoy7eXtdzRzj8ZdCHbTl1sX5iTu8dRrE3RNcGFglfDR0S1g5zh8PDRsGy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="277369613"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="277369613"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 07:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672190020"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 07:29:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKhHa-000LMQ-0S;
        Sun, 07 Aug 2022 14:29:34 +0000
Date:   Sun, 7 Aug 2022 22:28:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/clk/clk-stm32mp1.c:158:30: sparse: sparse: symbol
 'ethrx_src' was not declared. Should it be static?
Message-ID: <202208072229.r4Bp7nZD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1612c382ffbdf1f673caec76502b1c00e6d35363
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   4 months ago
config: arm-randconfig-s053-20220804 (https://download.01.org/0day-ci/archive/20220807/202208072229.r4Bp7nZD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/clk-stm32mp1.c:158:30: sparse: sparse: symbol 'ethrx_src' was not declared. Should it be static?

vim +/ethrx_src +158 drivers/clk/clk-stm32mp1.c

1f80590b6bdabf Gabriel Fernandez 2018-03-08  157  
e9ed1ef18a37a9 Marek Vasut       2022-01-18 @158  const struct clk_parent_data ethrx_src[] = {
e9ed1ef18a37a9 Marek Vasut       2022-01-18  159  	{ .name = "ethck_k", .fw_name = "ETH_RX_CLK/ETH_REF_CLK" },
e9ed1ef18a37a9 Marek Vasut       2022-01-18  160  };
e9ed1ef18a37a9 Marek Vasut       2022-01-18  161  

:::::: The code at line 158 was first introduced by commit
:::::: e9ed1ef18a37a97899dca8d5b2693d5c218bb774 clk: stm32mp1: Add parent_data to ETHRX clock

:::::: TO: Marek Vasut <marex@denx.de>
:::::: CC: Stephen Boyd <sboyd@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
