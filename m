Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC2458590B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiG3IFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3IFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:05:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D853B4A8;
        Sat, 30 Jul 2022 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659168299; x=1690704299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i9PZjSKHc8+lT55MmOtDDDgcK8IIEd7ggADGrkaA+sg=;
  b=AUqg+C6IlAFX8sab3B+f0tkmNPt6RNIVE7h4YZX9WBuTZBKorACKXLkJ
   4dMr7xk+dq7l0kmWwfB7c9KGrFLL5eKjGDyuLMFHzR10EhwjnVpg6e70d
   GxtNzRPrW2087kmTk7PMUwiGb52GRomd5+Lj7E/xOpA8PbbxZiiuXwIIv
   wE40Q8HvlJgMuAQQjreGcvQ9mJNZ13WZv1KSALcnQch12XSHGsWakxo/b
   2zvzhoPtZCx4IhlGQtsAe7lpoZMM8jHBws45JMfpJsCSpmnioo8D6CIlV
   /KMkyHAR9M1Qf5L8cep9K6TEEpdJIICinv2U85v3raQ312fxFsBif7Mes
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287657806"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="287657806"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 01:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="928998625"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2022 01:04:56 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHhSy-000Ccl-0X;
        Sat, 30 Jul 2022 08:04:56 +0000
Date:   Sat, 30 Jul 2022 16:04:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liming Sun <limings@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Woods <davwoods@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Liming Sun <limings@nvidia.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: add ACPI match data for
 BlueField-3 SoC
Message-ID: <202207301544.6K8iGuvp-lkp@intel.com>
References: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a50873fdbf69f4a95b931a5d05cade04c1dacd0.1659099154.git.limings@nvidia.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v5.19-rc8]
[cannot apply to next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liming-Sun/mmc-sdhci-of-dwcmshc-add-ACPI-match-data-for-BlueField-3-SoC/20220729-211808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6e2c0490769ef8a95b61304389116ccc85c53e12
config: riscv-buildonly-randconfig-r002-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301544.6K8iGuvp-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/0826c5e41791f253a28b7284805be00108b1f841
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liming-Sun/mmc-sdhci-of-dwcmshc-add-ACPI-match-data-for-BlueField-3-SoC/20220729-211808
        git checkout 0826c5e41791f253a28b7284805be00108b1f841
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-of-dwcmshc.c:282:38: warning: unused variable 'sdhci_dwcmshc_bf3_pdata' [-Wunused-const-variable]
   static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
                                        ^
   1 warning generated.


vim +/sdhci_dwcmshc_bf3_pdata +282 drivers/mmc/host/sdhci-of-dwcmshc.c

   281	
 > 282	static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
   283		.ops = &sdhci_dwcmshc_ops,
   284		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
   285		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
   286			   SDHCI_QUIRK2_ACMD23_BROKEN,
   287	};
   288	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
