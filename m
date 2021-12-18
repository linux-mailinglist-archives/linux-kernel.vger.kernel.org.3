Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE347479851
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 04:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhLRDKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:10:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:58429 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhLRDKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639797031; x=1671333031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iaGT2JEm+FoYf6CxXOR8SGx5sqfUuJk9Q/5YqlFXRfA=;
  b=e/+0IRHxvJt6dSFMRenoze8B/bR13QKh99jeObEfVJE8rRhJPly+JuKg
   HTs7mEHtK8Bm4z+C9+IGHQc3Yf5Fy2APNAnljrWMvlQtHpgIivMBW8lqV
   X3NlKf2PY2w+yLRRNnUFKsgHYv9olUGZlQkNMJCBPP4ogbeTUvFxhEuVr
   Jr4MjPE3ttPmbwa0ttLDFnqr13BgwY8Sqdmp0JQo3XZvI6mpP0x5odC/M
   o1tGBhmGpUPsTy5jQoypHvGWjtHqDSj9gxq6CxklDaUH46zqBP4Y3xomd
   7r58fxjw5awyAL69ZgY2RiOvIn+YrlZw7PpxLBnkiQ3Ze5kfahTn/U0fe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="227167780"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="227167780"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 19:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="606087157"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2021 19:10:29 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myQ7A-0005Uf-NY; Sat, 18 Dec 2021 03:10:28 +0000
Date:   Sat, 18 Dec 2021 11:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:nvme/dev 19/19] apple.c:undefined reference to
 `apple_sart_remove_allowed_region'
Message-ID: <202112181118.zRu1n8Nv-lkp@intel.com>
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20211218/202112181118.zRu1n8Nv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/462512213a677fa8bca25bbe2928f188848f5411
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux nvme/dev
        git checkout 462512213a677fa8bca25bbe2928f188848f5411
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_free':
>> apple.c:(.text+0x51e): undefined reference to `apple_sart_remove_allowed_region'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_sart_dma_alloc':
>> apple.c:(.text+0x5c4): undefined reference to `apple_sart_add_allowed_region'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_probe':
>> apple.c:(.text+0x1332): undefined reference to `apple_sart_get'
>> m68k-linux-ld: apple.c:(.text+0x152e): undefined reference to `devm_apple_rtkit_init'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_disable':
>> apple.c:(.text+0x16e4): undefined reference to `apple_rtkit_is_crashed'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_shutdown':
>> apple.c:(.text+0x191e): undefined reference to `apple_rtkit_is_running'
>> m68k-linux-ld: apple.c:(.text+0x1930): undefined reference to `apple_rtkit_shutdown'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_remove':
   apple.c:(.text+0x19d6): undefined reference to `apple_rtkit_is_running'
   m68k-linux-ld: apple.c:(.text+0x19e6): undefined reference to `apple_rtkit_shutdown'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_timeout':
   apple.c:(.text+0x1a80): undefined reference to `apple_rtkit_is_crashed'
   m68k-linux-ld: drivers/nvme/host/apple.o: in function `apple_nvme_reset_work':
   apple.c:(.text+0x1b8e): undefined reference to `apple_rtkit_is_crashed'
>> m68k-linux-ld: apple.c:(.text+0x1bec): undefined reference to `apple_rtkit_is_running'
   m68k-linux-ld: apple.c:(.text+0x1c44): undefined reference to `apple_rtkit_shutdown'
>> m68k-linux-ld: apple.c:(.text+0x1c58): undefined reference to `apple_rtkit_reinit'
>> m68k-linux-ld: apple.c:(.text+0x1c94): undefined reference to `apple_rtkit_boot'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
