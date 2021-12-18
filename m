Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81857479A97
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhLRLbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:31:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:34140 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhLRLbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639827104; x=1671363104;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nuGmSnBYYFXmrB7f2KGu3IZLVMfIk7crqp0hp+7e0zI=;
  b=U9bypiByT3UPHyv8M0YzRJhppHw+Hoqyxi4BA5JICPGMlBP0bjDnO2rL
   rOmg+2Z0sF4GH2G7vEfw5NXt+9iIfH+no7kkXx26KP/R6bzpjRuYsMuEg
   7k4muH919a03dywr9mjp5BgWQJdQxegzxVAhXKbuVAreWiGEHQudnx5eK
   R0GT2pnU31qyjHEi8hBAlJIUJ/EGsb4G1i6Ye3C7x2GlBvhheuuPANTof
   gJdNDKt8wiFj9TYV2RVt6EgEAFryI5z3Q2LlQZtNUoYo3ZBfj7L4ShCth
   xbD73fAqsUuWtvSqIC6dl1qu8YYr3OM6RuOsBkJ7o4O2th5XtWWMbwjy/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219927957"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="219927957"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 03:31:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="507093817"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2021 03:31:42 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myXwD-0005v8-Ms; Sat, 18 Dec 2021 11:31:41 +0000
Date:   Sat, 18 Dec 2021 19:31:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme/dev 19/19] nios2-linux-ld: apple.c:undefined
 reference to `devm_apple_rtkit_init'
Message-ID: <202112181927.rVMtiuCD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux nvme/dev
head:   462512213a677fa8bca25bbe2928f188848f5411
commit: 462512213a677fa8bca25bbe2928f188848f5411 [19/19] HACK/DO-NOT-MERGE: nvme-apple: add initial Apple SoC NVMe driver
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20211218/202112181927.rVMtiuCD-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/462512213a677fa8bca25bbe2928f188848f5411
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme/dev
        git checkout 462512213a677fa8bca25bbe2928f188848f5411
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_free':
   apple.c:(.text+0x5f4): undefined reference to `apple_sart_remove_allowed_region'
   apple.c:(.text+0x5f4): relocation truncated to fit: R_NIOS2_CALL26 against `apple_sart_remove_allowed_region'
   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_alloc':
   apple.c:(.text+0x68c): undefined reference to `apple_sart_add_allowed_region'
   apple.c:(.text+0x68c): relocation truncated to fit: R_NIOS2_CALL26 against `apple_sart_add_allowed_region'
   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
   apple.c:(.text+0x1754): undefined reference to `apple_sart_get'
   apple.c:(.text+0x1754): relocation truncated to fit: R_NIOS2_CALL26 against `apple_sart_get'
>> nios2-linux-ld: apple.c:(.text+0x1970): undefined reference to `devm_apple_rtkit_init'
   apple.c:(.text+0x1970): relocation truncated to fit: R_NIOS2_CALL26 against `devm_apple_rtkit_init'
   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
   apple.c:(.text+0x1bb0): undefined reference to `apple_rtkit_is_crashed'
   apple.c:(.text+0x1bb0): relocation truncated to fit: R_NIOS2_CALL26 against `apple_rtkit_is_crashed'
   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
   apple.c:(.text+0x1de0): undefined reference to `apple_rtkit_is_running'
   apple.c:(.text+0x1de0): relocation truncated to fit: R_NIOS2_CALL26 against `apple_rtkit_is_running'
>> nios2-linux-ld: apple.c:(.text+0x1df0): undefined reference to `apple_rtkit_shutdown'
   apple.c:(.text+0x1df0): relocation truncated to fit: R_NIOS2_CALL26 against `apple_rtkit_shutdown'
   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x1e94): undefined reference to `apple_rtkit_is_running'
   apple.c:(.text+0x1e94): relocation truncated to fit: R_NIOS2_CALL26 against `apple_rtkit_is_running'
   nios2-linux-ld: apple.c:(.text+0x1ea4): undefined reference to `apple_rtkit_shutdown'
   apple.c:(.text+0x1ea4): relocation truncated to fit: R_NIOS2_CALL26 against `apple_rtkit_shutdown'
   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x1f5c): undefined reference to `apple_rtkit_is_crashed'
   apple.c:(.text+0x1f5c): relocation truncated to fit: R_NIOS2_CALL26 against `apple_rtkit_is_crashed'
>> nios2-linux-ld: apple.c:(.text+0x1fb4): undefined reference to `apple_rtkit_is_running'
   apple.c:(.text+0x1fb4): additional relocation overflows omitted from the output
   nios2-linux-ld: apple.c:(.text+0x2014): undefined reference to `apple_rtkit_shutdown'
>> nios2-linux-ld: apple.c:(.text+0x2028): undefined reference to `apple_rtkit_reinit'
>> nios2-linux-ld: apple.c:(.text+0x205c): undefined reference to `apple_rtkit_boot'
   nios2-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   apple.c:(.text+0x2750): undefined reference to `apple_rtkit_is_crashed'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
