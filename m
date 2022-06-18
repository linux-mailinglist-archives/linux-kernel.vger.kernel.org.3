Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27A6550750
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiFRWXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiFRWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:23:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839CA10FFD
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655591016; x=1687127016;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BZjEnfzthlTSTBUS58K+MYmeqofVkjA92SKFMcEt/0k=;
  b=SaqDfQsWfs9hhJIBZfmkRTgVTnpU+kTAX2XIqD3muUjdulAVrGObNcZL
   XpUxF8MnSM2qMRNQY/JUixGohO9tYzeoQXP5OMFZ5NGABX8dLFkJrUnnu
   NDiIJOOOz4Py8xuxEc8/N0ZLd6sTsQlVDE/bdm28BgzDpTNkx1Gew2ip8
   On2Yz49pRb9dwskma1anf43NN0eos5pMwCT8rcc1meXRoBOND8Wu1GzF2
   kuNNURxl4SYLyvfaFtSRBW6cXuTGbA8KdSLzt7iziAff2ys7wsiQJCfwT
   IJsZAqqHb8rtwIuM3ugaM/YoGJLdm8tpxKaj0llCwyLgCURuiF72GWj8M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280742892"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280742892"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 15:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619665913"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2022 15:23:35 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2gqs-000Qe3-Bn;
        Sat, 18 Jun 2022 22:23:34 +0000
Date:   Sun, 19 Jun 2022 06:23:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: riscv64-linux-ld: ttm_bo_vm.c:undefined reference to
 `vmf_insert_pfn_prot'
Message-ID: <202206190651.smtms3Ay-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b35035bcf80ddb47c0112c4fbd84a63a2836a18
commit: 8bb31587820a6e04cb613b49238b1800d1a97223 drm/ttm: remove bo->moving
date:   2 months ago
config: riscv-buildonly-randconfig-r006-20220619 (https://download.01.org/0day-ci/archive/20220619/202206190651.smtms3Ay-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8bb31587820a6e04cb613b49238b1800d1a97223
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8bb31587820a6e04cb613b49238b1800d1a97223
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: riscv64-linux-ld: DWARF error: could not find abbrev number 3991
   drivers/gpu/drm/ttm/ttm_bo_vm.o: in function `.L0 ':
   ttm_bo_vm.c:(.text+0x656): undefined reference to `vmf_insert_pfn_prot'
>> riscv64-linux-ld: ttm_bo_vm.c:(.text+0x7ce): undefined reference to `vmf_insert_pfn_prot'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_TTM
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_TTM_HELPER && HAS_IOMEM && DRM
   - DRM_HISI_HIBMC && HAS_IOMEM && DRM && PCI && (ARM64 || COMPILE_TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
