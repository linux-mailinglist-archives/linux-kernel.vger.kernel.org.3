Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F75F4964B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351906AbiAUSCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:02:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:65286 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382074AbiAUSCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642788165; x=1674324165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kVr133G4QQEACtNcARQL4cMXIgv0co62FF/BdQCLGCU=;
  b=hYdGJWf66CEpI25k9NeCm1Cl17++HwqaIM+hX29ii5cpgOwweh+XiDRO
   YEImHLRzmbnYlHLQuuGWeoDutASooNnwMtqsXLUvy5VjvsrAvKAKw85k1
   8U3Z29+ok5VAjTg+X7tpQUL4I2CEFbkYKm8FBCG8zBfwf6FF7WW6SWVZJ
   RfRSNDY8QAkQpKJbforJYyKwFpk8gIdx7l9VN+S823Jdc+CDm+T38vRI7
   7xAl/N0ejwJdolwXoYt/NWvSzTp+xMu/V5BXRMGGyJiuahVEyWpDk1iAD
   KPwkFPva2yRDUEyb/uZ3YlRhXdKA4j1ktK243pFA83cEZFtkSG8zGLkZp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="233069471"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="233069471"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 10:00:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="765775155"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jan 2022 10:00:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAyCd-000FXx-IG; Fri, 21 Jan 2022 17:59:59 +0000
Date:   Sat, 22 Jan 2022 01:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chevron Li <chevron.li@bayhubtech.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com, xiaoguang.yu@bayhubtech.com
Subject: Re: [PATCH 2/2] mmc:sdhci-bayhub:provide a solution to improve sd
 host card compatibility
Message-ID: <202201220136.LTeGkEsu-lkp@intel.com>
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
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220122/202201220136.LTeGkEsu-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8916351ffe4bd538ba3bf2c5e16a151fb47674fe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chevron-Li/mmc-sdhci-msm-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220121-191113
        git checkout 8916351ffe4bd538ba3bf2c5e16a151fb47674fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_decode_cid':
>> sdhci-msm.c:(.text.mmc_decode_cid+0x0): multiple definition of `mmc_decode_cid'; drivers/mmc/core/sd.o:sd.c:(.text.mmc_decode_cid+0x0): first defined here
   mips-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_switch_hs':
>> sdhci-msm.c:(.text.mmc_sd_switch_hs+0x0): multiple definition of `mmc_sd_switch_hs'; drivers/mmc/core/sd.o:sd.c:(.text.mmc_sd_switch_hs+0x0): first defined here
   mips-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_get_cid':
>> sdhci-msm.c:(.text.mmc_sd_get_cid+0x0): multiple definition of `mmc_sd_get_cid'; drivers/mmc/core/sd.o:sd.c:(.text.mmc_sd_get_cid+0x0): first defined here
   mips-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_get_csd':
>> sdhci-msm.c:(.text.mmc_sd_get_csd+0x0): multiple definition of `mmc_sd_get_csd'; drivers/mmc/core/sd.o:sd.c:(.text.mmc_sd_get_csd+0x0): first defined here
   mips-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_setup_card':
>> sdhci-msm.c:(.text.mmc_sd_setup_card+0x0): multiple definition of `mmc_sd_setup_card'; drivers/mmc/core/sd.o:sd.c:(.text.mmc_sd_setup_card+0x0): first defined here
>> mips-linux-ld: drivers/mmc/host/sdhci-msm.o:(.data.sd_type+0x0): multiple definition of `sd_type'; drivers/mmc/core/sd.o:(.data.sd_type+0x0): first defined here
   mips-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_sd_get_max_clock':
>> sdhci-msm.c:(.text.mmc_sd_get_max_clock+0x0): multiple definition of `mmc_sd_get_max_clock'; drivers/mmc/core/sd.o:sd.c:(.text.mmc_sd_get_max_clock+0x0): first defined here
   mips-linux-ld: drivers/mmc/host/sdhci-msm.o: in function `mmc_attach_sd':
>> sdhci-msm.c:(.text.mmc_attach_sd+0x0): multiple definition of `mmc_attach_sd'; drivers/mmc/core/sd.o:sd.c:(.text.mmc_attach_sd+0x0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
