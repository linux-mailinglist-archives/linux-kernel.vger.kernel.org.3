Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90A752A983
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351567AbiEQRn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245720AbiEQRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:43:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B44EDCF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652809432; x=1684345432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q8XY6d4ZpgotsD2gQWqWI8X7Sm3sp5fM+v4FHPP72tQ=;
  b=WVR5vMoVmupn/SN9pif9DWIj+JGdMQwBDiHTFcUKj7bXVfD23cGo60r1
   Byh4Esysc/3x307pApcNjfajYcYzOJLMSW5GPVo7rlhG13mo7JGF7Dmv0
   YivsQtOwVVZVZsA0rlWXYnL8pzG/2RIprFkox14m6QRzJm5ftLM7RMwlH
   iFW0uKfi/dFPsgt9ZEptJUARqBdW45s+n2xR6ver8N70htIfSAUH6lRbN
   CaOgKr3kyOhuUO/hKTwudyx0SiViT0Xei2N/PggUUscvLs2u/p0kWEcPo
   /U0BL5J4qVvU+HmIOR2y9dGbPYJMhAlgR/XzWMtrWvl/J2BO0nliOcHI0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251777854"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251777854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 10:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="713964331"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2022 10:43:51 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nr1Ec-0001DN-BT;
        Tue, 17 May 2022 17:43:50 +0000
Date:   Wed, 18 May 2022 01:43:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [iwlwifi-next:pending 1/10]
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c:1093: warning: "CAUSE"
 redefined
Message-ID: <202205180129.UFh9AXxx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git pending
head:   a786b171b90fe097fda151935ffb1c7789a4cf82
commit: 19abe9a4d1710f54a91469350530775ee0f894f0 [1/10] iwlwifi: pcie: simplify MSI-X cause mapping
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220518/202205180129.UFh9AXxx-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/commit/?id=19abe9a4d1710f54a91469350530775ee0f894f0
        git remote add iwlwifi-next https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git
        git fetch --no-tags iwlwifi-next pending
        git checkout 19abe9a4d1710f54a91469350530775ee0f894f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/pcie/trans.c:1093: warning: "CAUSE" redefined
    1093 | #define CAUSE(reg, mask)                                                \
         | 
   In file included from arch/mips/include/asm/ptrace.h:19,
                    from include/linux/sched/signal.h:14,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from arch/mips/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/pci.h:37,
                    from drivers/net/wireless/intel/iwlwifi/pcie/trans.c:7:
   arch/mips/include/uapi/asm/ptrace.h:18: note: this is the location of the previous definition
      18 | #define CAUSE           65
         | 


vim +/CAUSE +1093 drivers/net/wireless/intel/iwlwifi/pcie/trans.c

  1092	
> 1093	#define CAUSE(reg, mask)						\
  1094		{								\
  1095			.mask_reg = reg,					\
  1096			.bit = ilog2(mask),					\
  1097			.addr = ilog2(mask) +					\
  1098				((reg) == CSR_MSIX_FH_INT_MASK_AD ? -16 :	\
  1099				 (reg) == CSR_MSIX_HW_INT_MASK_AD ? 16 :	\
  1100				 0xffff),	/* causes overflow warning */	\
  1101		}
  1102	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
