Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5517149C4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiAZH4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:56:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:35499 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbiAZH4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643183799; x=1674719799;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=yURxiOHqqSqdbNKW2HA0dNQoNeLBSfI5T/kCi+0pSmI=;
  b=iFGpIDZkxykaYz4kVfB866MH1277XNdwCiVIao2V/50usX627ej10OuN
   yvlCMMQilQAGmy9OU0ibuJ4IVoqpU32cUXXqcxLphR9H/yuiv+5iFLGDB
   1bD3ocNeiLf7vCvlPPgvVnO1bTJi0jw+FA/Ug/5ooMIR8dO3oXkVKvtkh
   BpZFHZT8ekMglsvqTTq2yxPo4A8F6GhYmrGaHqqj8325OQMbpfUziag/Z
   0NM4YJW4PH2DF8IXaLvn+lCpxnlFrlh7MtnSw3i0zFVQ5ZBkLLneRdbxa
   +mXEpCT8tADw2jScElBq3t+2dZdMXtkTwGu3uBL0zmItxW9V7SH93MPnQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309815871"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="309815871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 23:56:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="563336409"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2022 23:56:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCdAT-000KxA-Js; Wed, 26 Jan 2022 07:56:37 +0000
Date:   Wed, 26 Jan 2022 15:56:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e464121f2d40eabc7d11823fb26db807ce945df4
Message-ID: <61f0feac.eQXCV0oSz/f7eVk2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e464121f2d40eabc7d11823fb26db807ce945df4  x86/cpu: Add Xeon Icelake-D to list of CPUs that support PPIN

elapsed time: 722m

configs tested: 142
configs skipped: 103

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
i386                          randconfig-c001
powerpc              randconfig-c003-20220124
arm                        spear6xx_defconfig
powerpc64                           defconfig
ia64                          tiger_defconfig
sparc                       sparc64_defconfig
sh                           se7206_defconfig
powerpc                     redwood_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          gemini_defconfig
sparc                               defconfig
mips                            ar7_defconfig
m68k                             allyesconfig
powerpc                    sam440ep_defconfig
h8300                       h8s-sim_defconfig
sh                         ap325rxa_defconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
mips                         db1xxx_defconfig
s390                             allyesconfig
xtensa                  audio_kc705_defconfig
sh                           se7780_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
mips                           xway_defconfig
sh                            hp6xx_defconfig
arc                          axs101_defconfig
arm                     eseries_pxa_defconfig
arc                        nsim_700_defconfig
sh                         apsh4a3a_defconfig
um                               alldefconfig
sh                           se7721_defconfig
sh                          sdk7780_defconfig
arc                            hsdk_defconfig
arm                        mini2440_defconfig
mips                  decstation_64_defconfig
xtensa                           alldefconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20220124
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
powerpc                      katmai_defconfig
powerpc                   lite5200b_defconfig
arm                           omap1_defconfig
powerpc                    socrates_defconfig
arm                         orion5x_defconfig
mips                          malta_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kmeter1_defconfig
mips                           ip27_defconfig
powerpc                      ppc64e_defconfig
powerpc                        fsp2_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r041-20220124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
