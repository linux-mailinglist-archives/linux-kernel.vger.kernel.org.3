Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3556CDC7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGJIbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:31:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4945D12AC8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 01:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657441868; x=1688977868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6FVmqDKnH06qguVC98H0Ol1nrwZjNM8dzIO+SidbAVU=;
  b=JxgIV88v2F34mzB1oR5SWhnwCaBByktYTfxGAInafNul6x3FLIHTAeZg
   ndXb0NSAtTMzMZv5KinMgJOEERzT4ufk+ZX6Swn1+T4aZW0K5ii6sPdTv
   nQI8D2aj8hpkiBfYVRaRBOYmzTaJ+fyKoOV0PQPCsp4qzR4BlgOrD1esw
   OKDGK0aw1ypXrre8AOP2gsEIXdK/OsB6hC/cI5svSWTuc2bMTkiHP9tO/
   NSzimcqccl8bXbOQBdg2nX0Uf898DDKfFKFnVJpxlK4pFPTcnIBUL8csA
   fpAG58pVF/txcphPi9wl6nO5VTFlUvbNCDKqVmpPhzV+A3WElLfnfp40K
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="285235628"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="285235628"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 01:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="544670439"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2022 01:31:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oASLG-000Pay-76;
        Sun, 10 Jul 2022 08:31:02 +0000
Date:   Sun, 10 Jul 2022 16:30:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: [ammarfaizi2-block:broonie/sound/for-next 304/377] ERROR: modpost:
 "__clk_get_name" [sound/soc/fsl/snd-soc-fsl-utils.ko] undefined!
Message-ID: <202207101657.epyuWfeR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-next
head:   b5ba0a8fe36ef651f01cabe4b074611745333e71
commit: 34dcdebecf2f05e1b275e1da8352f8e4c1aab6f6 [304/377] ASoC: fsl_spdif: Add support for PLL switch at runtime.
config: m68k-randconfig-r032-20220707 (https://download.01.org/0day-ci/archive/20220710/202207101657.epyuWfeR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/34dcdebecf2f05e1b275e1da8352f8e4c1aab6f6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-next
        git checkout 34dcdebecf2f05e1b275e1da8352f8e4c1aab6f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__clk_get_name" [sound/soc/fsl/snd-soc-fsl-utils.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
