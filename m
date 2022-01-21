Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18FB49608A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380997AbiAUONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:13:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:7732 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380987AbiAUONw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642774432; x=1674310432;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ly82YDpS6kOS1tplbkgrLx2+OGCLu7nM81p0LvUa8k0=;
  b=iS3Fucmy1KYoA+6qv5LGWebn4qoygKFWjmZ8NNWwuLOLNS8jBbT2sDzm
   P+wHhoRtrzyoIrIfsr37lLcVHpNsD1zVb2YG8Hks3WEyjPNG7nV8UzT3q
   6mZDAuFmsg7A4uhxl99y2Y9txGPHFVcPwKehbG+lS+HjTmEDG53n5nJPg
   YTrfJG0ZpqbAtx9B0/hDSkGeeObIAtMMyR13VK6IyiqV5QZNVsB7FRLRj
   2jMFKGuB1KB+t/RbYNqLCGWRc5JGgycRrPhDUMh6ox4m4BIF4hxwsxksI
   NqE8XISrZkqhtGJGIg8IbWqMETU6C3UUcPJQozXlkaHhifeBZmlcuQdFB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245879268"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="245879268"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 06:13:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="519086227"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2022 06:13:49 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAufk-000FMr-9Y; Fri, 21 Jan 2022 14:13:48 +0000
Date:   Fri, 21 Jan 2022 22:13:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 a0af3d1104f752b6d0dba71788e3fddd67c857a7
Message-ID: <61eabf8a.DINqYgbymuNymrOe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: a0af3d1104f752b6d0dba71788e3fddd67c857a7  PCI/MSI: Prevent UAF in error path

elapsed time: 724m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                 randconfig-c004-20220120
i386                          randconfig-c001
powerpc              randconfig-c003-20220120
sh                          urquell_defconfig
sh                               j2_defconfig
arm                           stm32_defconfig
m68k                       m5208evb_defconfig
powerpc                     rainier_defconfig
arm                           h5000_defconfig
um                             i386_defconfig
arm                        realview_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
sh                            hp6xx_defconfig
h8300                            allyesconfig
sh                          sdk7780_defconfig
m68k                          sun3x_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5475evb_defconfig
x86_64                              defconfig
powerpc                         wii_defconfig
sh                           se7724_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                  randconfig-c002-20220120
arm                  randconfig-c002-20220121
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220119
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220119
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
arc                  randconfig-r043-20220119
riscv                randconfig-r042-20220121
arc                  randconfig-r043-20220121
s390                 randconfig-r044-20220121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
i386                          randconfig-c001
powerpc                       ebony_defconfig
mips                        omega2p_defconfig
i386                             allyesconfig
arm                         hackkit_defconfig
powerpc                        icon_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
