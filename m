Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9712652552B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357804AbiELSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357799AbiELSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:52:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858875EBD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652381569; x=1683917569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1DoZl2rSXcnMqAtYs3OhYqDo8oaR9mD3IvRU4ByO3u8=;
  b=KAoQnKZ4+PgebhVjSi8gBCmiJq6lFvq+pqeEsrtV7ju1I78dKaryt/Oa
   hRuvcNFex4Ba95nQO8a9IRqYYk+HO+iaFXDUgqm7lk+xqPAU92YJdiFu1
   LFheVkL22GuUbAlQfBrwTwNPG7wi0VpsvJDbQ5hVzj6wN5Ehv7ke6CmIx
   dj6jjSPa3tycVAWVpLuuvsqT0WosulEnm4Wm0sc41Ai+bUz+2HNen7uLU
   Myl/PijOBxDuho2kaJUJdUrimHoUhYr5akGuw/hJcGjb8dxIS46SE+SOU
   s5+Lp0sSm4Ti6JKXSz3rG5ZdHK6+aVi1UjocetG2Oi4PY2mYKuCEGNVq/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250010493"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="250010493"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="603508215"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2022 11:52:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npDvZ-000KpM-2U;
        Thu, 12 May 2022 18:52:45 +0000
Date:   Fri, 13 May 2022 02:52:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: drivers/gpu/drm/msm/adreno/a6xx_gmu.h:136:16: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202205130223.lCVpC6fr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: 3f4a80cbf968466c5ba0c78ef41cae8292965bd8 drm/msm: move msm_readl/_writel to msm_drv.h
date:   3 months ago
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220513/202205130223.lCVpC6fr-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3f4a80cbf968466c5ba0c78ef41cae8292965bd8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3f4a80cbf968466c5ba0c78ef41cae8292965bd8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/gpu/drm/msm/ drivers/video/fbdev/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:136:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:136:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:136:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:136:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:136:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1515:36: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *llc_mmio @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1515:36: sparse:     expected void [noderef] __iomem *llc_mmio
   drivers/gpu/drm/msm/adreno/a6xx_gpu.c:1515:36: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gpu.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:124:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:124:21: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:124:21: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:125:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:125:23: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:125:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:124:21: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:124:21: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:125:23: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:125:23: sparse: sparse: dereference of noderef expression
--
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:322:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:366:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:391:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:464:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:471:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:497:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1418:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1424:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1424:31: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1424:31: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:862:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:864:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:866:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:868:9: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1070:23: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1464:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1464:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1464:20: sparse:     got void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1466:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1466:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1466:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1573:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] mmio @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1573:19: sparse:     expected void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1573:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1580:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[noderef] rscc @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1580:27: sparse:     expected void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1580:27: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1611:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] mmio @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1611:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1611:20: sparse:     got void *[noderef] mmio
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1613:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *[noderef] rscc @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1613:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:1613:28: sparse:     got void *[noderef] rscc
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c: note: in included file (through drivers/gpu/drm/msm/adreno/a6xx_gpu.h):
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:96:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:224:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.c:240:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: too many warnings
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c: note: in included file:
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_hfi.c:108:15: sparse: sparse: dereference of noderef expression
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse:     got void *
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression
   drivers/gpu/drm/msm/adreno/a6xx_gmu.h:101:16: sparse: sparse: dereference of noderef expression

vim +136 drivers/gpu/drm/msm/adreno/a6xx_gmu.h

4b565ca5a2cbbbb Jordan Crouse  2018-08-06   98  
4b565ca5a2cbbbb Jordan Crouse  2018-08-06   99  static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  100  {
4b565ca5a2cbbbb Jordan Crouse  2018-08-06 @101  	return msm_writel(value, gmu->mmio + (offset << 2));
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  102  }
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  103  
c6ed04f856a4ebb Jonathan Marek 2020-04-23  104  static inline void
c6ed04f856a4ebb Jonathan Marek 2020-04-23  105  gmu_write_bulk(struct a6xx_gmu *gmu, u32 offset, const u32 *data, u32 size)
c6ed04f856a4ebb Jonathan Marek 2020-04-23  106  {
c6ed04f856a4ebb Jonathan Marek 2020-04-23  107  	memcpy_toio(gmu->mmio + (offset << 2), data, size);
c6ed04f856a4ebb Jonathan Marek 2020-04-23  108  	wmb();
c6ed04f856a4ebb Jonathan Marek 2020-04-23  109  }
c6ed04f856a4ebb Jonathan Marek 2020-04-23  110  
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  111  static inline void gmu_rmw(struct a6xx_gmu *gmu, u32 reg, u32 mask, u32 or)
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  112  {
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  113  	u32 val = gmu_read(gmu, reg);
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  114  
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  115  	val &= ~mask;
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  116  
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  117  	gmu_write(gmu, reg, val | or);
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  118  }
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  119  
c28aa2031f64701 Sharat Masetty 2018-10-04  120  static inline u64 gmu_read64(struct a6xx_gmu *gmu, u32 lo, u32 hi)
c28aa2031f64701 Sharat Masetty 2018-10-04  121  {
c28aa2031f64701 Sharat Masetty 2018-10-04  122  	u64 val;
c28aa2031f64701 Sharat Masetty 2018-10-04  123  
c28aa2031f64701 Sharat Masetty 2018-10-04  124  	val = (u64) msm_readl(gmu->mmio + (lo << 2));
c28aa2031f64701 Sharat Masetty 2018-10-04  125  	val |= ((u64) msm_readl(gmu->mmio + (hi << 2)) << 32);
c28aa2031f64701 Sharat Masetty 2018-10-04  126  
c28aa2031f64701 Sharat Masetty 2018-10-04  127  	return val;
c28aa2031f64701 Sharat Masetty 2018-10-04  128  }
c28aa2031f64701 Sharat Masetty 2018-10-04  129  
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  130  #define gmu_poll_timeout(gmu, addr, val, cond, interval, timeout) \
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  131  	readl_poll_timeout((gmu)->mmio + ((addr) << 2), val, cond, \
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  132  		interval, timeout)
4b565ca5a2cbbbb Jordan Crouse  2018-08-06  133  
142639a52a01e90 Jonathan Marek 2020-06-29  134  static inline u32 gmu_read_rscc(struct a6xx_gmu *gmu, u32 offset)
142639a52a01e90 Jonathan Marek 2020-06-29  135  {
142639a52a01e90 Jonathan Marek 2020-06-29 @136  	return msm_readl(gmu->rscc + (offset << 2));
142639a52a01e90 Jonathan Marek 2020-06-29  137  }
142639a52a01e90 Jonathan Marek 2020-06-29  138  

:::::: The code at line 136 was first introduced by commit
:::::: 142639a52a01e90c512a9a8d2156997e02a65b53 drm/msm/a6xx: fix crashstate capture for A650

:::::: TO: Jonathan Marek <jonathan@marek.ca>
:::::: CC: Rob Clark <robdclark@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
