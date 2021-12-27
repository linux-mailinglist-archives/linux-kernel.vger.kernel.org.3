Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC6B47F9FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhL0DmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:42:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:48957 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233071AbhL0DmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640576530; x=1672112530;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ut9Ey05HWZLJhGDyoV3LpQ3PEY18/Kb/FsGYvj7q3CU=;
  b=jb7a5ipx2TDhtvAFX+m8T6J3CcOf0phDdCz/USkCL9X4+obDthSC6IYB
   CeTZklU08QzJq+bel5Gj47H2sv9hd+N2e4pEajW9a/qQ2U2+9kdb53vIm
   nm2qH1zia/zxdMCXUKoumBuALzPzJci8CRjmxVvVLVTOHL/P7VaUxYbYe
   9lfYPu2XfYVuQF8zxCTzOSodIHrj8tQ9lvGR1aXxBXdhfPGRMzmDYz74/
   TBKQKIKxMsdg4yaU4RvGDKXXb30VyaKE00VWANO1ROJnrpvKivvaAN3vI
   0PM0ZAqAlKPYlGU6xdprmA6cWjJMI6l6Gi1ssGLI5SouxHDGhRtHK/cDX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="327482038"
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="327482038"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 19:42:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="553645307"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Dec 2021 19:42:09 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1gtk-00060t-JY; Mon, 27 Dec 2021 03:42:08 +0000
Date:   Mon, 27 Dec 2021 11:41:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/mmc/host/sdhci-of-aspeed-test.c:47:1: warning: the frame
 size of 1152 bytes is larger than 1024 bytes
Message-ID: <202112271108.eI8nE2E5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2
commit: 0bbcd22556ef203b29e39a6ce1bd7e9523b6032e mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
date:   11 months ago
config: powerpc-randconfig-p001-20211227 (https://download.01.org/0day-ci/archive/20211227/202112271108.eI8nE2E5-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0bbcd22556ef203b29e39a6ce1bd7e9523b6032e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0bbcd22556ef203b29e39a6ce1bd7e9523b6032e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/mmc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci-of-aspeed.c:583:
   drivers/mmc/host/sdhci-of-aspeed-test.c: In function 'aspeed_sdhci_phase_ddr52':
>> drivers/mmc/host/sdhci-of-aspeed-test.c:47:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      47 | }
         | ^


vim +47 drivers/mmc/host/sdhci-of-aspeed-test.c

     5	
     6	static void aspeed_sdhci_phase_ddr52(struct kunit *test)
     7	{
     8		int rate = 52000000;
     9	
    10		KUNIT_EXPECT_EQ(test, 0,
    11				aspeed_sdhci_phase_to_tap(NULL, rate, 0));
    12		KUNIT_EXPECT_EQ(test, 0,
    13				aspeed_sdhci_phase_to_tap(NULL, rate, 1));
    14		KUNIT_EXPECT_EQ(test, 1,
    15				aspeed_sdhci_phase_to_tap(NULL, rate, 2));
    16		KUNIT_EXPECT_EQ(test, 1,
    17				aspeed_sdhci_phase_to_tap(NULL, rate, 3));
    18		KUNIT_EXPECT_EQ(test, 2,
    19				aspeed_sdhci_phase_to_tap(NULL, rate, 4));
    20		KUNIT_EXPECT_EQ(test, 3,
    21				aspeed_sdhci_phase_to_tap(NULL, rate, 5));
    22		KUNIT_EXPECT_EQ(test, 14,
    23				aspeed_sdhci_phase_to_tap(NULL, rate, 23));
    24		KUNIT_EXPECT_EQ(test, 15,
    25				aspeed_sdhci_phase_to_tap(NULL, rate, 24));
    26		KUNIT_EXPECT_EQ(test, 15,
    27				aspeed_sdhci_phase_to_tap(NULL, rate, 25));
    28	
    29		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
    30				aspeed_sdhci_phase_to_tap(NULL, rate, 180));
    31		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
    32				aspeed_sdhci_phase_to_tap(NULL, rate, 181));
    33		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
    34				aspeed_sdhci_phase_to_tap(NULL, rate, 182));
    35		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
    36				aspeed_sdhci_phase_to_tap(NULL, rate, 183));
    37		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
    38				aspeed_sdhci_phase_to_tap(NULL, rate, 184));
    39		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
    40				aspeed_sdhci_phase_to_tap(NULL, rate, 185));
    41		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
    42				aspeed_sdhci_phase_to_tap(NULL, rate, 203));
    43		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
    44				aspeed_sdhci_phase_to_tap(NULL, rate, 204));
    45		KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
    46				aspeed_sdhci_phase_to_tap(NULL, rate, 205));
  > 47	}
    48	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
