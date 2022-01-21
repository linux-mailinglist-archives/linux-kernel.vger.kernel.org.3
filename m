Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DC749654F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiAUSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:51:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:46622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbiAUSvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642791064; x=1674327064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lt5/Oi2mP9bz3yAmfCJghuUssAFKa9GcwZolpGn47YQ=;
  b=c5+skyMYH3Zdf1eLR2mgmpt+/1HpaibIcQq+8OMChYoF22YGH2FM9Kmy
   NnX0G9xqizfGqF2HjP31CuFaVR33q9mqVL97DnbXUsLHZJyJplwSV95Nm
   y7Hq0oKc0P6Hi/0bAY3+DYSDK0NmecneW+43B8Jsx4ebZ6wB6rSPqwEu3
   zI/2by8wn/0xBAEuOldelv3JJIEOKonnBS3SV5CYe0nJ8KceEc50CGP09
   +Aq22JMEhcdS4rSEdxxE9mRE+vCheRsZk4oazJjB5M+bpeciPBVREtTvz
   rB7T1oVkOdD7YM0rl/N1FpEHBhcZ7V9qGH4kr2Li71HB2wXMv4uZ2k8Qf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="245667692"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="245667692"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 10:51:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="623415270"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jan 2022 10:51:01 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAz00-000FaM-K6; Fri, 21 Jan 2022 18:51:00 +0000
Date:   Sat, 22 Jan 2022 02:50:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chevron Li <chevron.li@bayhubtech.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com, xiaoguang.yu@bayhubtech.com
Subject: Re: [PATCH 2/2] mmc:sdhci-bayhub:provide a solution to improve sd
 host card compatibility
Message-ID: <202201220201.tDKCGfmj-lkp@intel.com>
References: <20220121110909.104-2-chevron.li@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121110909.104-2-chevron.li@bayhubtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chevron,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on c9e6606c7fe92b50a02ce51dda82586ebdf99b48]

url:    https://github.com/0day-ci/linux/commits/Chevron-Li/mmc-sdhci-msm-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220121-191113
base:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220122/202201220201.tDKCGfmj-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8916351ffe4bd538ba3bf2c5e16a151fb47674fe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chevron-Li/mmc-sdhci-msm-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220121-191113
        git checkout 8916351ffe4bd538ba3bf2c5e16a151fb47674fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_decode_cid':
   sdhci-msm.c:(.text+0x8640): multiple definition of `mmc_decode_cid'; drivers/mmc/core/sd.o:sd.c:(.text+0x1720): first defined here
   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_switch_hs':
   sdhci-msm.c:(.text+0x86c0): multiple definition of `mmc_sd_switch_hs'; drivers/mmc/core/sd.o:sd.c:(.text+0x17a0): first defined here
   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_get_cid':
   sdhci-msm.c:(.text+0x87a4): multiple definition of `mmc_sd_get_cid'; drivers/mmc/core/sd.o:sd.c:(.text+0x1884): first defined here
   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_get_csd':
   sdhci-msm.c:(.text+0x8900): multiple definition of `mmc_sd_get_csd'; drivers/mmc/core/sd.o:sd.c:(.text+0x19e0): first defined here
   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_setup_card':
   sdhci-msm.c:(.text+0x8924): multiple definition of `mmc_sd_setup_card'; drivers/mmc/core/sd.o:sd.c:(.text+0x1a04): first defined here
   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_get_max_clock':
   sdhci-msm.c:(.text+0x99ac): multiple definition of `mmc_sd_get_max_clock'; drivers/mmc/core/sd.o:sd.c:(.text+0x2208): first defined here
   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_attach_sd':
   sdhci-msm.c:(.text+0x99c8): multiple definition of `mmc_attach_sd'; drivers/mmc/core/sd.o:sd.c:(.text+0x2224): first defined here
   arm-linux-gnueabi-ld: drivers/mmc/host/sdhci-msm.o: in function `.LANCHOR0':
>> sdhci-msm.c:(.data+0xd8): multiple definition of `sd_type'; drivers/mmc/core/sd.o:sd.c:(.data+0x70): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
