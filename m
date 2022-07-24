Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7D57F276
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiGXBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiGXBYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:24:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C78165BB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658625859; x=1690161859;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0zcHayIvMltXVPaIrLswah13KrVDXAYgwLHpMQhwB2k=;
  b=KJ8pTYZmSZTajgTvLJiZ9AXBFriwsZTKQDakEdYe6bEkdoE8fo0S2Xa6
   SfFEyvh5E0Ab5BCLpU57YCz+etZqJgGDOLsGQRyVO2eBW+SFEycl1zUsr
   ZMt7ULBkWQ/dRUJPHnmJhf8HEEucdVOmitl7Udr6pmZSu6kGV68oaeK7o
   2mnVxjaXoPzgvE666uD2tvFN9E3XU17kevk3vIq0dOq11shH21R6c6mxP
   xNd9hZYqwh2z4A0IaqBb6uTEEU56nO3Z4e8dBHqlwLMsumfYVxAeYxQ80
   5/mALmwB/7UwK8NwUoh/SG+n0k9sTjJs6d62TBl7xTO10nK4ge/35T6RK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="274363943"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="274363943"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 18:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="926465824"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2022 18:24:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFQLw-0003Lr-2j;
        Sun, 24 Jul 2022 01:24:16 +0000
Date:   Sun, 24 Jul 2022 09:24:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/proton-pack.c:1117:13: warning: no previous
 prototype for 'spectre_bhb_patch_clearbhb'
Message-ID: <202207240915.0vl43AvY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 228a26b912287934789023b4132ba76065d9491c arm64: Use the clearbhb instruction in mitigations
date:   5 months ago
config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20220724/202207240915.0vl43AvY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=228a26b912287934789023b4132ba76065d9491c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 228a26b912287934789023b4132ba76065d9491c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/proton-pack.c:564:13: warning: no previous prototype for 'spectre_v4_patch_fw_mitigation_enable' [-Wmissing-prototypes]
     564 | void __init spectre_v4_patch_fw_mitigation_enable(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:584:13: warning: no previous prototype for 'smccc_patch_fw_mitigation_conduit' [-Wmissing-prototypes]
     584 | void __init smccc_patch_fw_mitigation_conduit(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:1048:14: warning: no previous prototype for 'spectre_bhb_patch_loop_mitigation_enable' [-Wmissing-prototypes]
    1048 | void noinstr spectre_bhb_patch_loop_mitigation_enable(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:1059:14: warning: no previous prototype for 'spectre_bhb_patch_fw_mitigation_enabled' [-Wmissing-prototypes]
    1059 | void noinstr spectre_bhb_patch_fw_mitigation_enabled(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:1070:14: warning: no previous prototype for 'spectre_bhb_patch_loop_iter' [-Wmissing-prototypes]
    1070 | void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:1091:14: warning: no previous prototype for 'spectre_bhb_patch_wa3' [-Wmissing-prototypes]
    1091 | void noinstr spectre_bhb_patch_wa3(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kernel/proton-pack.c:1117:13: warning: no previous prototype for 'spectre_bhb_patch_clearbhb' [-Wmissing-prototypes]
    1117 | void __init spectre_bhb_patch_clearbhb(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/spectre_bhb_patch_clearbhb +1117 arch/arm64/kernel/proton-pack.c

  1115	
  1116	/* Patched to NOP when not supported */
> 1117	void __init spectre_bhb_patch_clearbhb(struct alt_instr *alt,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
