Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DD0472240
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhLMITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:19:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:3580 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhLMITm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639383582; x=1670919582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DeywiFxxsk/ZyY6KtjoJKAnfXkLSOgyppPjYHTezEKg=;
  b=kGVroz+ZWV2C+SxiRGknW8ZGh9is8qwe0xmVI5UcBW8HYTllVFS8sRXD
   NG75eAoUpnuhY4FuoZJ1f0JFtD1AgHIc1+dW/wuHpNPg8mIXcnX51QOIv
   +0NHQZTdP6EhmA7g6GCqcSi3Aoz9nr1TFg8ypo8zD+218XgGK/BN9V7/f
   ts+lY+B8OCj/dABUw10XGLgyP1YIByNkS3R0Rjgl6aig8BpTa1Si+523w
   xZnioQ2eYAH0qjLdtqPpUgKYTBC22yFYjxYHCtd0dgSerAObHvxV+4bnb
   s/scsrIL4XESI3RAQ7gUKKqnV1i2LbFa+v6mQX5420MEsmt9zyxEmaBTw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="219368219"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="219368219"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 00:19:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="464534114"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2021 00:19:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwgYe-0006SO-DQ; Mon, 13 Dec 2021 08:19:40 +0000
Date:   Mon, 13 Dec 2021 16:18:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/mmc/host/sdhci-of-aspeed-test.c:47:1: warning: the frame
 size of 1152 bytes is larger than 1024 bytes
Message-ID: <202112131659.GRmtsTh2-lkp@intel.com>
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
head:   2585cf9dfaaddf00b069673f27bb3f8530e2039c
commit: 0bbcd22556ef203b29e39a6ce1bd7e9523b6032e mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
date:   11 months ago
config: arm-randconfig-r014-20211212 (https://download.01.org/0day-ci/archive/20211213/202112131659.GRmtsTh2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0bbcd22556ef203b29e39a6ce1bd7e9523b6032e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0bbcd22556ef203b29e39a6ce1bd7e9523b6032e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/mmc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci-of-aspeed.c:583:
   drivers/mmc/host/sdhci-of-aspeed-test.c: In function 'aspeed_sdhci_phase_ddr52':
>> drivers/mmc/host/sdhci-of-aspeed-test.c:47:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      47 | }
         | ^
   drivers/mmc/host/sdhci-of-aspeed-test.c: In function 'aspeed_sdhci_phase_hs200':
   drivers/mmc/host/sdhci-of-aspeed-test.c:86:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      86 | }
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
