Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4D493439
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiASFQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:16:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:13228 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229714AbiASFQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642569381; x=1674105381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hLLH1uHBd2Ro0xf+R6F9x/SXJzNWWsanxj0VWmr1JYo=;
  b=L0HooX731S9a3ApMnwL6U94naJNFm8BKtlrG+cJ1Kuy6M4qxDUolKKaI
   0H2u4EFV0cYBa60ediWiaU4dgl2p5w8nhptQgW69BpYEAzgT1r5yzWZDs
   212qkXLFdGorgaialXyXElugXunLQx7R8XRxULdzLIcVBcASxpt+jGFBw
   kWejC/ukUkQU+NudwaHWdaHAOfh7p0FrtZ9ckLkrAVERDWdKl6OIqWK5b
   kO39PTpd5hmglf8KaLwwDNWMfyXKJXFAy9XKhJ1USQ7MZIdHBTMJQipPr
   RWyfErbywG6ymueJTJnzdN8CImS39ZMwUg5VVJ4ohr4TmqQWW8Sl0LMDU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305715665"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="305715665"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 21:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="625756384"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 21:16:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA3KV-000DHk-23; Wed, 19 Jan 2022 05:16:19 +0000
Date:   Wed, 19 Jan 2022 13:16:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "sw.multimedia" <sw.multimedia@starfivetech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        "jack.zhu" <jack.zhu@starfivetech.com>,
        "keith.zhao" <keith.zhao@starfivetech.com>
Subject: [esmil:visionfive 64/80]
 drivers/gpu/drm/starfive/starfive_drm_vpp.c:602:9: error: implicit
 declaration of function 'sifive_l2_flush64_range'
Message-ID: <202201191349.mJZAPYfE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 1eb3575230496368002bc06d59b7d219c09af47b [64/80] drm/starfive: Add StarFive drm driver
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220119/202201191349.mJZAPYfE-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/1eb3575230496368002bc06d59b7d219c09af47b
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 1eb3575230496368002bc06d59b7d219c09af47b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/starfive/starfive_drm_vpp.c: In function 'vpp1_isr_handler':
>> drivers/gpu/drm/starfive/starfive_drm_vpp.c:602:9: error: implicit declaration of function 'sifive_l2_flush64_range' [-Werror=implicit-function-declaration]
     602 |         sifive_l2_flush64_range(sf_crtc->dma_addr, sf_crtc->size);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/starfive/starfive_drm_vpp.c:598:13: warning: variable 'intr_status' set but not used [-Wunused-but-set-variable]
     598 |         u32 intr_status = 0;
         |             ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/sifive_l2_flush64_range +602 drivers/gpu/drm/starfive/starfive_drm_vpp.c

   594	
   595	irqreturn_t vpp1_isr_handler(int this_irq, void *dev_id)
   596	{
   597		struct starfive_crtc *sf_crtc = dev_id;
   598		u32 intr_status = 0;
   599	
   600		intr_status = sf_fb_vppread32(sf_crtc, 1, PP_INT_STATUS);
   601		sf_fb_vppwrite32(sf_crtc, 1, PP_INT_CLR, 0xf);
 > 602		sifive_l2_flush64_range(sf_crtc->dma_addr, sf_crtc->size);
   603	
   604		return IRQ_HANDLED;
   605	}
   606	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
