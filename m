Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4C51985B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbiEDHhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345850AbiEDHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:36:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D63B23BE6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651649578; x=1683185578;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ajnx99ABp6tA/2m410hjcF5ACaLgpwsHk+Symc5zi30=;
  b=F5Utr7HvNeEC+tyRxspG61vE6j6bKe/Xttjl8TzSQrQLVUSywgDre89u
   eCwQPA5xpmRsj4RtfqlWTgcrs0hlATG64lJcf4ViYVsubY6EVRXNxA7uF
   +NYyvCKzoibcmrzbIVEeZHpsfTCVfD9+CZ0yI5y8BAK4DkyWkgFSz/O9j
   O60M3rywMNnxR5MkQS0abXtwjwXTcIOpetATPz3YAKPe+jZGPMuuxo4ms
   Bi3WcMo4J1nhm5FxkdguI0/nKVl+Su9WGp54UdVOhwc1zFfCJVGSC5EVg
   0/QuAMYg2eB6JCgyK68rjZChdI++a0zdvW8cFkY/hHvamdjBZOpA4xyvJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249669899"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="249669899"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 00:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="664361168"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 May 2022 00:32:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm9VI-000BB5-Aw;
        Wed, 04 May 2022 07:32:56 +0000
Date:   Wed, 4 May 2022 15:32:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8180x-next-20220502 6/29] dp_hpd.c:undefined
 reference to `typec_mux_unregister'
Message-ID: <202205041521.5SKLbNky-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8180x-next-20220502
head:   6199153320a3b7d1dce23ad1ea4d894a86793cb6
commit: be6e31f126bed33f684250905b79d76f7664d985 [6/29] drm/msm/dp: Add typec_mux implementation
config: openrisc-randconfig-r024-20220501 (https://download.01.org/0day-ci/archive/20220504/202205041521.5SKLbNky-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/be6e31f126bed33f684250905b79d76f7664d985
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8180x-next-20220502
        git checkout be6e31f126bed33f684250905b79d76f7664d985
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_unregister_typec_mux':
>> dp_hpd.c:(.text+0xc): undefined reference to `typec_mux_unregister'
   dp_hpd.c:(.text+0xc): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_unregister'
   or1k-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_mux_set':
>> dp_hpd.c:(.text+0x38): undefined reference to `typec_mux_get_drvdata'
   dp_hpd.c:(.text+0x38): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_get_drvdata'
   or1k-linux-ld: drivers/gpu/drm/msm/dp/dp_hpd.o: in function `dp_hpd_get':
>> dp_hpd.c:(.text+0x268): undefined reference to `typec_mux_register'
   dp_hpd.c:(.text+0x268): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_register'
>> or1k-linux-ld: dp_hpd.c:(.text+0x2c8): undefined reference to `typec_mux_unregister'
   dp_hpd.c:(.text+0x2c8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `typec_mux_unregister'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
