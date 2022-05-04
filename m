Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72228519BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiEDJ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347191AbiEDJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:28:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615541FCD0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651656320; x=1683192320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RS4O6T59/rL0NmtNBaTkGbjHAgtDtRZzqREcH6ArbLw=;
  b=XlOZKCpj0SP2ZfwnI8bDz7IlYva+iNEO1UAr0+zFHVjFtZ1ELH3wEJ3y
   EAbMdBy8dEu6FazwDLQR8mV9BRgzjy8k54Q7TRFjFKSuIJMwTctiED1uM
   wd8RUuo0p4Baq5k3WzIs69Hrwip4YXrAF25bF7RYzYstQOZ0tqoAbSovT
   aRQDIufFHQO1kB9CSZcxJCPW+KR/v3iQpmHEn0CAjlc+i5EvWObE66Ubk
   oXiT1NQMCfgyJzyn+ax2CfopcMRodteAMsiwLLnRKno4blGsNuzk8HQEC
   ZFw+UuHVeCpOhx2YdOc3T1gX6MfsimjFhQPxvUygvoMCWJk6SF4IyqxSK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="292902698"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="292902698"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="734316108"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 May 2022 02:25:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmBFz-000BG1-RP;
        Wed, 04 May 2022 09:25:15 +0000
Date:   Wed, 4 May 2022 17:24:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [andersson:wip/sc8180x-next-20220502 7/29] phy-qcom-qmp.c:undefined
 reference to `typec_switch_get_drvdata'
Message-ID: <202205041734.dMEFSXWf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220502
head:   6199153320a3b7d1dce23ad1ea4d894a86793cb6
commit: 5cc3b17921dda08e833aa7933dc2da40d7e47b43 [7/29] phy: qcom-qmp: Register as a typec switch for orientation detection
config: openrisc-randconfig-r024-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041734.dMEFSXWf-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/5cc3b17921dda08e833aa7933dc2da40d7e47b43
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220502
        git checkout 5cc3b17921dda08e833aa7933dc2da40d7e47b43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_typec_switch_set':
>> phy-qcom-qmp.c:(.text+0x470): undefined reference to `typec_switch_get_drvdata'
   phy-qcom-qmp.c:(.text+0x470): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_switch_get_drvdata'
   or1k-linux-ld: drivers/phy/qualcomm/phy-qcom-qmp.o: in function `qcom_qmp_phy_probe':
>> phy-qcom-qmp.c:(.text+0x119c): undefined reference to `typec_switch_register'
   phy-qcom-qmp.c:(.text+0x119c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_switch_register'
   or1k-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_unregister_typec_mux':
   dp_hpd.c:(.text+0xc): undefined reference to `typec_mux_unregister'
   dp_hpd.c:(.text+0xc): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_unregister'
   or1k-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_mux_set':
   dp_hpd.c:(.text+0x38): undefined reference to `typec_mux_get_drvdata'
   dp_hpd.c:(.text+0x38): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_get_drvdata'
   or1k-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_get':
   dp_hpd.c:(.text+0x268): undefined reference to `typec_mux_register'
   dp_hpd.c:(.text+0x268): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_register'
   or1k-linux-ld: dp_hpd.c:(.text+0x2c8): undefined reference to `typec_mux_unregister'
   dp_hpd.c:(.text+0x2c8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_unregister'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
