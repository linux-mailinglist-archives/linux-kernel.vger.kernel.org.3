Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4044967FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiAUWsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:48:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:54535 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbiAUWsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642805289; x=1674341289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tlUQiyL4eSm/VUPM7odQaO7ee7yMO/f9FkqdD/vlNQ=;
  b=nL4yVo/+a+bS9oeyMNEOQMO/EwzdaKoDYB0QJDHY/YTYKsR18ez1eVCE
   VXZXXZCR8BZYg0xp92lt0Ofb1DGu3lUnFurOLsWlfdUOZjX+zdOa9tzAz
   IBT5w31B2P4MYWxMj+sYfx4nnbqHpj1uEGnT1mjWP5KEnisRY8+sc5K0L
   +eb1taHRe4MOJhdX4vfd0N5MGovxcGlIR2G/nvgLG99Q0c9uNCbWBXgzB
   Px0zp7zTg1jILRDDfa3OR4VJHUFKp0JC6SM8CqgZIVyJCTkHnm9hGrPRL
   3aM8LYhcsss+qvSWZlAI1jk6ZsLY1EmLnIq/NbYHZQNWSKC9mqAb3Krmj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="245978800"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="245978800"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 14:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="626886592"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2022 14:48:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB2hR-000FjV-5S; Fri, 21 Jan 2022 22:48:05 +0000
Date:   Sat, 22 Jan 2022 06:47:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chevron Li <chevron.li@bayhubtech.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com, xiaoguang.yu@bayhubtech.com
Subject: Re: [PATCH 2/2] mmc:sdhci-bayhub:provide a solution to improve sd
 host card compatibility
Message-ID: <202201220601.vDkqlC2r-lkp@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on c9e6606c7fe92b50a02ce51dda82586ebdf99b48]

url:    https://github.com/0day-ci/linux/commits/Chevron-Li/mmc-sdhci-msm-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220121-191113
base:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
config: arm64-randconfig-s032-20220118 (https://download.01.org/0day-ci/archive/20220122/202201220601.vDkqlC2r-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/8916351ffe4bd538ba3bf2c5e16a151fb47674fe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chevron-Li/mmc-sdhci-msm-fix-Qualcomm-sd-host-7180-SD-card-compatibility-issue/20220121-191113
        git checkout 8916351ffe4bd538ba3bf2c5e16a151fb47674fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/mmc/host/sdhci-msm.c: note: in included file:
>> drivers/mmc/host/sdhci-bayhub.c:1498:28: sparse: sparse: Using plain integer as NULL pointer
   drivers/mmc/host/sdhci-bayhub.c:2945:40: sparse: sparse: Using plain integer as NULL pointer
   drivers/mmc/host/sdhci-bayhub.c:2945:43: sparse: sparse: Using plain integer as NULL pointer
   drivers/mmc/host/sdhci-bayhub.c:2945:46: sparse: sparse: Using plain integer as NULL pointer

vim +1498 drivers/mmc/host/sdhci-bayhub.c

  1480	
  1481	static bool ggc_read_registers_ext(struct sdhci_host *host,
  1482			bool *card_status, bool *read_status,
  1483			struct ggc_reg_op *gg_reg_arr, u8 num)
  1484	{
  1485		u8 get_idx = 0;
  1486		bool ret = false;
  1487		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
  1488		struct sdhci_msm_host *vendor_host = sdhci_pltfm_priv(pltfm_host);
  1489		struct sdhci_bht_host *ggc = sdhci_msm_priv(vendor_host);
  1490	
  1491		if (read_status)
  1492			*read_status = false;
  1493		if (card_status)
  1494			*card_status = false;
  1495	
  1496		memset(ggc->cur_read_buf, 0, 512);
  1497		ret = gg_emulator_read_ext(host, card_status, read_status, ggc->cur_read_buf, 512);
> 1498		if (read_status == false)
  1499			goto exit;
  1500	
  1501		for (get_idx = 0; get_idx < num; get_idx++)
  1502			(gg_reg_arr + get_idx)->value =
  1503				_read_status_data_read_register(ggc->cur_read_buf, (gg_reg_arr + get_idx));
  1504	
  1505	exit:
  1506		return ret;
  1507	}
  1508	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
