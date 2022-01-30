Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2204F4A3574
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 10:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354517AbiA3Jra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 04:47:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:45032 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346817AbiA3Jr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 04:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643536049; x=1675072049;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tVRtvCsPXxgMqmJoJ8XO7s+RqTi65D8nv0xaAgnvInQ=;
  b=Dn/gJiROuWzLuWOHZorQ8ULbYtSmb6ErtOJA18ZijxXo/xycHoSl49s5
   xF2Bc0u2k/Jk/8teA83shNcsOcw3KrL/iWaoohqq+19saoY/sv3iIpmuk
   iVHMEZsQfDh6efBlQeve+rLE+BVRPlKr9wjM4LLqLZ/PP+rbIVI9Fyfl/
   rzFCT9WtiUutszjoVbfghka0qAltSjFMop6Z51TQmlLRsqs6TDbAttO/W
   aYRt++4EvRxo5OmL0rD6l8Xk/h3lHdz47ZChARFBFJ8NRv4h0nAZmjNm4
   bbqX4hhCVFN1rZsG7fnqleMzzUxzUjirTmcbqe6cRSK0fGtxmAZChPfZh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="234723755"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="234723755"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 01:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="478728465"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2022 01:47:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nE6nv-000QKc-Gi; Sun, 30 Jan 2022 09:47:27 +0000
Date:   Sun, 30 Jan 2022 17:46:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 243d30803744155a54bfb8a844cc964945cfd9a1
Message-ID: <61f65e78.B+vblpmsbCNESJSh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 243d30803744155a54bfb8a844cc964945cfd9a1  Merge tag 'irqchip-fixes-5.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 720m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                           sunxi_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                          amiga_defconfig
arm                           u8500_defconfig
sparc64                             defconfig
powerpc                        cell_defconfig
arm                             rpc_defconfig
arm                             ezx_defconfig
powerpc                  iss476-smp_defconfig
arm                         s3c6400_defconfig
powerpc                      arches_defconfig
mips                       capcella_defconfig
arm                         lubbock_defconfig
mips                      fuloong2e_defconfig
openrisc                            defconfig
sh                          lboxre2_defconfig
xtensa                           allyesconfig
powerpc                 mpc834x_itx_defconfig
arc                        nsim_700_defconfig
sh                        dreamcast_defconfig
arm                      integrator_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
nds32                               defconfig
nds32                             allnoconfig
powerpc                     tqm8541_defconfig
arm                        spear6xx_defconfig
xtensa                           alldefconfig
m68k                                defconfig
i386                             alldefconfig
powerpc                    adder875_defconfig
powerpc                       eiger_defconfig
mips                 decstation_r4k_defconfig
powerpc                      pcm030_defconfig
sh                               allmodconfig
mips                         tb0226_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          polaris_defconfig
sh                         microdev_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     ep8248e_defconfig
sh                      rts7751r2d1_defconfig
openrisc                  or1klitex_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7206_defconfig
powerpc                      ppc6xx_defconfig
sh                          rsk7264_defconfig
sh                             espt_defconfig
sh                           se7712_defconfig
i386                                defconfig
m68k                             allmodconfig
arm                  randconfig-c002-20220130
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
s390                 randconfig-c005-20220130
powerpc                   lite5200b_defconfig
arm                         orion5x_defconfig
mips                         tb0287_defconfig
mips                           ip28_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          moxart_defconfig
mips                   sb1250_swarm_defconfig
arm                          pcm027_defconfig
hexagon                             defconfig
powerpc                      katmai_defconfig
arm                  colibri_pxa300_defconfig
arm                       imx_v4_v5_defconfig
arm                           omap1_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                  colibri_pxa270_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220130
hexagon              randconfig-r041-20220130

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
