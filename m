Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFC467D72
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhLCSqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:46:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:60167 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233187AbhLCSqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:46:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="236848888"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="236848888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 10:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460977144"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2021 10:43:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtDWf-000Hv9-VB; Fri, 03 Dec 2021 18:43:17 +0000
Date:   Sat, 4 Dec 2021 02:42:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33:
 sparse: sparse: incorrect type in argument 3 (different base types)
Message-ID: <202112040259.mr8Sk1Bn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f58da2befa58edf3a70b91ed87ed9bf77f1e70e
commit: 18b13ff23fab34a9d35cec60ed19aceab61dc3f9 ASoC: mediatek: mt8192: add machine driver with mt6359, rt1015 and rt5682
date:   1 year, 1 month ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211204/202112040259.mr8Sk1Bn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18b13ff23fab34a9d35cec60ed19aceab61dc3f9
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 18b13ff23fab34a9d35cec60ed19aceab61dc3f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-imx/ arch/arm/mach-mvebu/ arch/arm/mach-rockchip/ arch/arm/mach-socfpga/ arch/arm/mach-tegra/ drivers/dma/ drivers/edac/ drivers/gpu/drm/msm/ drivers/gpu/drm/tegra/ drivers/interconnect/qcom/ drivers/irqchip/ drivers/mtd/nand/onenand/ drivers/net/ethernet/mediatek/ drivers/net/vmxnet3/ drivers/net/wireless/mediatek/mt76/mt7915/ drivers/remoteproc/ drivers/scsi/bnx2fc/ drivers/scsi/lpfc/ drivers/soc/bcm/brcmstb/pm/ drivers/staging/ fs/proc/ net/sched/ sound/soc/mediatek/mt8192/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int to @@     got restricted snd_pcm_format_t [usertype] @@
   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:     expected unsigned int to
   sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c:370:33: sparse:     got restricted snd_pcm_format_t [usertype]

vim +370 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c

   364	
   365	static int mt8192_i2s_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
   366					      struct snd_pcm_hw_params *params)
   367	{
   368		/* fix BE i2s format to 32bit, clean param mask first */
   369		snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
 > 370				     0, SNDRV_PCM_FORMAT_LAST);
   371	
   372		params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
   373	
   374		return 0;
   375	}
   376	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
