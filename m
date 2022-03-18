Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8F4DE470
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiCRXOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbiCRXOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:14:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D67112D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647645173; x=1679181173;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+37l6VhLvMOfjePs+2KrK6+EHrgl4qSAJMmK1zIg7eg=;
  b=k417+cg5BBvqnxhPtDijFtS1MZCEHi5vqgUs2BTV5p596+YsIOZnGSLv
   dfdfhSfT0JB+9bh5I4n4fFpFiZH6ngn1x0lyVJQoKm5oOYfQavOvizsRU
   yETa/rLBxze/V38Hly+0jp1ax45U03FL5354VqUWrVeD+dmOkzSPL0AJc
   Szlw88WUa80+Li9SOvy98OnH7y2gY6pET/Nl7b6Bk6nrgd7fC4i83TWxj
   xypuReQPZ70LrlgwCAtbEroJDsfO3n0km249hyqSBOMObjgOGvdoGxa5n
   I7FPF0Z4TSNgdl6Fd2oRfqEgOftx0ECmlR3MJQyYyFz4lpg77lRQr3Mcu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="237854538"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237854538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 16:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="558706495"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2022 16:12:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVLm7-000FGx-9u; Fri, 18 Mar 2022 23:12:51 +0000
Date:   Sat, 19 Mar 2022 07:12:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:asahi 169/174] apple.c:(.text.apple_nvme_suspend+0x40):
 undefined reference to `apple_rtkit_is_running'
Message-ID: <202203190706.DQ5sFFlc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   c1fcb91bbcc8fd1b1f874e45f55cbba682351f3c
commit: 287f6be4f50a324ac0b189f6e2f8fad003c4ec2b [169/174] apple-nvme: Add support for suspend/resume
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220319/202203190706.DQ5sFFlc-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/287f6be4f50a324ac0b189f6e2f8fad003c4ec2b
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 287f6be4f50a324ac0b189f6e2f8fad003c4ec2b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `kernel_entry':
   (.ref.text+0xac): relocation truncated to fit: R_MIPS_26 against `start_kernel'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x20): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x30): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0xa4): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xb4): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x128): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x138): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0x1ac): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x1bc): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x238): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x258): additional relocation overflows omitted from the output
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_setup':
   apple.c:(.text.apple_nvme_sart_dma_setup+0x8c): undefined reference to `apple_sart_add_allowed_region'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_destroy':
   apple.c:(.text.apple_nvme_sart_dma_destroy+0x34): undefined reference to `apple_sart_remove_allowed_region'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
   apple.c:(.text.apple_nvme_probe+0x3e8): undefined reference to `apple_sart_get'
   mips-linux-ld: apple.c:(.text.apple_nvme_probe+0x75c): undefined reference to `devm_apple_rtkit_init'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
   apple.c:(.text.apple_nvme_disable+0x6c): undefined reference to `apple_rtkit_is_crashed'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_suspend':
>> apple.c:(.text.apple_nvme_suspend+0x40): undefined reference to `apple_rtkit_is_running'
>> mips-linux-ld: apple.c:(.text.apple_nvme_suspend+0x68): undefined reference to `apple_rtkit_shutdown'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text.apple_nvme_shutdown+0x40): undefined reference to `apple_rtkit_is_running'
   mips-linux-ld: apple.c:(.text.apple_nvme_shutdown+0x68): undefined reference to `apple_rtkit_shutdown'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text.apple_nvme_remove+0x68): undefined reference to `apple_rtkit_is_running'
   mips-linux-ld: apple.c:(.text.apple_nvme_remove+0x90): undefined reference to `apple_rtkit_shutdown'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text.apple_nvme_reset_work+0xa4): undefined reference to `apple_rtkit_is_crashed'
   mips-linux-ld: apple.c:(.text.apple_nvme_reset_work+0x124): undefined reference to `apple_rtkit_is_running'
   mips-linux-ld: apple.c:(.text.apple_nvme_reset_work+0x1dc): undefined reference to `apple_rtkit_shutdown'
   mips-linux-ld: apple.c:(.text.apple_nvme_reset_work+0x20c): undefined reference to `apple_rtkit_reinit'
   mips-linux-ld: apple.c:(.text.apple_nvme_reset_work+0x278): undefined reference to `apple_rtkit_boot'
   mips-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   apple.c:(.text.apple_nvme_timeout+0x1a0): undefined reference to `apple_rtkit_is_crashed'
   mips-linux-ld: drivers/media/platform/amphion/vpu_windsor.o: in function `vpu_windsor_pack_cmd':
   vpu_windsor.c:(.text.vpu_windsor_pack_cmd+0xfc): undefined reference to `__divdi3'
   mips-linux-ld: vpu_windsor.c:(.text.vpu_windsor_pack_cmd+0x118): undefined reference to `__moddi3'
   mips-linux-ld: drivers/media/platform/amphion/vpu_malone.o: in function `vpu_malone_pack_cmd':
   vpu_malone.c:(.text.vpu_malone_pack_cmd+0x260): undefined reference to `__divdi3'
   mips-linux-ld: vpu_malone.c:(.text.vpu_malone_pack_cmd+0x27c): undefined reference to `__moddi3'
   mips-linux-ld: drivers/media/platform/amphion/vdec.o: in function `vdec_get_debug_info':
   vdec.c:(.text.vdec_get_debug_info+0x2a8): undefined reference to `__moddi3'
   mips-linux-ld: vdec.c:(.text.vdec_get_debug_info+0x2d8): undefined reference to `__divdi3'
   mips-linux-ld: vdec.c:(.text.vdec_get_debug_info+0x2f8): undefined reference to `__moddi3'
   mips-linux-ld: vdec.c:(.text.vdec_get_debug_info+0x318): undefined reference to `__divdi3'
   mips-linux-ld: vdec.c:(.text.vdec_get_debug_info+0x338): undefined reference to `__moddi3'
   mips-linux-ld: vdec.c:(.text.vdec_get_debug_info+0x358): undefined reference to `__divdi3'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
