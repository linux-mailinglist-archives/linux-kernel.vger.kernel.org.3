Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E851BD58
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354658AbiEEKlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiEEKlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:41:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73415A03
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651747081; x=1683283081;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wV603nhnDa9kVJXVMArqUFut9nS+nq9L91q9VkdDoSY=;
  b=bPOQmHdVqb9MjLYoOHMkXQtWb1V32mYS8GsZbc6xQUwhH5na3ljLy+io
   CmSs5su0Bj2dt8Fi/jjIpysj5gVMQW5Eu27P5G/lPPMub8v1tgwQl4khK
   nrbcgodPRDE0Ec+oUXFqd5NuwrFp4Y78+yIMtx3HOesFOAbDDLgV/x33D
   pEez04nOk33Ruhwke5hSzvLI5hI0Tt4Q+8Q8wZ26pcsUkx7pKZ6Qihihc
   PeLTliwAXqJgM+SD4Yd/CtEAS6JA5cD2U9JTrDgcEDmWizmUP/Si2P+wG
   xqKFPmECPhSgaajOu22Cot0h4ytSSde62DNfGykv5nvrUQ78TN1ADAtgF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="328609822"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="328609822"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="664911279"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2022 03:37:58 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmYrt-000CIL-LW;
        Thu, 05 May 2022 10:37:57 +0000
Date:   Thu, 5 May 2022 18:37:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [ulfh-mmc:next 43/52] drivers/mmc/host/sdhci-brcmstb.c:51:6:
 warning: no previous prototype for function 'brcmstb_reset'
Message-ID: <202205051804.E5PoKkYL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
head:   0662d797d5962fd0a21aceb0cf651a6ff308e924
commit: 6bcc55fe648b860ef0c2b8dc23adc05bcddb93c2 [43/52] mmc: sdhci-brcmstb: Enable Clock Gating to save power
config: mips-bmips_stb_defconfig (https://download.01.org/0day-ci/archive/20220505/202205051804.E5PoKkYL-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?id=6bcc55fe648b860ef0c2b8dc23adc05bcddb93c2
        git remote add ulfh-mmc git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
        git fetch --no-tags ulfh-mmc next
        git checkout 6bcc55fe648b860ef0c2b8dc23adc05bcddb93c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-brcmstb.c:51:6: warning: no previous prototype for function 'brcmstb_reset' [-Wmissing-prototypes]
   void brcmstb_reset(struct sdhci_host *host, u8 mask)
        ^
   drivers/mmc/host/sdhci-brcmstb.c:51:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void brcmstb_reset(struct sdhci_host *host, u8 mask)
   ^
   static 
   1 warning generated.


vim +/brcmstb_reset +51 drivers/mmc/host/sdhci-brcmstb.c

    50	
  > 51	void brcmstb_reset(struct sdhci_host *host, u8 mask)
    52	{
    53		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
    54		struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
    55	
    56		sdhci_reset(host, mask);
    57	
    58		/* Reset will clear this, so re-enable it */
    59		if (priv->flags & BRCMSTB_PRIV_FLAGS_GATE_CLOCK)
    60			enable_clock_gating(host);
    61	}
    62	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
