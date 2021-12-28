Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643054806A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhL1GCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:02:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:48782 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234974AbhL1GCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640671325; x=1672207325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Eq5xKh+1C+iNFI+0PwCle38sDWZVf8PAkyabY5jLFno=;
  b=AuhonQu1/3ME+eZqL8NrB/JHCojEwnGWY8MxPUbFPeLkWmcQp/7SC6nS
   hS2C9KGfuKddYAcCPwLmxiWUUR6ENyKiT1b0rxO/z13fxJ2jwW72Vkrz8
   3RfLaf6CM9tknr/F2Jl1Ru/VaDqMd14uc6bE8PZd0drBS0blGHESJ3t1r
   kdu2ryNsCZD8vOIpAlYGgVrcQii/k6/Dnc4BpNylwxe1jsmQ5hwOVbzFY
   jmiCrfYjRoVrLMR9/3/zXlmjCeYDz50B8w5W+qgwS1dx+vwjeZ6csHilc
   d63qGjY/FKLUevvOqhGTOF05XUXh8aIrkjVRZtBOMMatveY+pGdvg1umW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="327643103"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="327643103"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 22:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="554075225"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2021 22:01:52 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n25YW-0007IV-1N; Tue, 28 Dec 2021 06:01:52 +0000
Date:   Tue, 28 Dec 2021 14:01:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/ufs/ufs-exynos.c:1268:34: warning: unused variable
 'exynos_ufs_of_match'
Message-ID: <202112281324.w3VTX6oh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alim,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a8ad9a2434dc7967ab285437f443cae633b6fc1c
commit: d31503fe395d1d7e17b85eb7b291cc1a4bff2671 scsi: ufs: Allow exynos ufs driver to build as module
date:   1 year, 6 months ago
config: hexagon-randconfig-r032-20211228 (https://download.01.org/0day-ci/archive/20211228/202112281324.w3VTX6oh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d31503fe395d1d7e17b85eb7b291cc1a4bff2671
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d31503fe395d1d7e17b85eb7b291cc1a4bff2671
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/ufs/ufs-exynos.c:1268:34: warning: unused variable 'exynos_ufs_of_match' [-Wunused-const-variable]
   static const struct of_device_id exynos_ufs_of_match[] = {
                                    ^
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS
   Selected by
   - LOCKDEP && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86


vim +/exynos_ufs_of_match +1268 drivers/scsi/ufs/ufs-exynos.c

55f4b1f73631a0 Alim Akhtar 2020-05-28  1267  
55f4b1f73631a0 Alim Akhtar 2020-05-28 @1268  static const struct of_device_id exynos_ufs_of_match[] = {
55f4b1f73631a0 Alim Akhtar 2020-05-28  1269  	{ .compatible = "samsung,exynos7-ufs",
55f4b1f73631a0 Alim Akhtar 2020-05-28  1270  	  .data	      = &exynos_ufs_drvs },
55f4b1f73631a0 Alim Akhtar 2020-05-28  1271  	{},
55f4b1f73631a0 Alim Akhtar 2020-05-28  1272  };
55f4b1f73631a0 Alim Akhtar 2020-05-28  1273  

:::::: The code at line 1268 was first introduced by commit
:::::: 55f4b1f73631a0817717fe6e98517de51b4c3527 scsi: ufs: ufs-exynos: Add UFS host support for Exynos SoCs

:::::: TO: Alim Akhtar <alim.akhtar@samsung.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
