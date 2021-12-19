Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B383E479ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 03:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhLSCXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 21:23:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:47333 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhLSCXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 21:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639880592; x=1671416592;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dZzUy/ylE8HDIfzxo7aLmBaw93MJXZM/7zylurdRbGs=;
  b=KklyRLLa+uLlz9Co7wFkw4TwdedfFh+7p/PUXQCdxMvcITBRgYpMMYTQ
   Ud28lPn9ejaiQa8XcIKKJgDFj+RS5fMkQgQ5QNh8binS7k8OTA/EgPbiE
   aDvURkY76EXxKLQii5L8z/Vjr+OSRHPwZK+UJrSHQ8yWHPvJvr9aKIQA8
   dcr87Ksoiy+befmuJ8K+hJ6metar52mOVHFc/Y+rmrSaa4X42sS18gkI8
   TAgG9jzyV0pF0t1YLHqguGfcg+AiOKhsYz1lI82ETmmZTZv+DXKtDJGJ8
   RbZHG81meJk+zalBKeJMrQR1v9tXBlyvplfUJxTfuWdZQgu7vmdSVUH7L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="237509053"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="237509053"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 18:23:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="683827717"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2021 18:23:11 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mylqw-0006dB-A9; Sun, 19 Dec 2021 02:23:10 +0000
Date:   Sun, 19 Dec 2021 10:22:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 f16cc980d649e664b8f41e1bbaba50255d24e5d1
Message-ID: <61be9781.MHdj6IFjutwWdtiU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: f16cc980d649e664b8f41e1bbaba50255d24e5d1  Merge branch 'locking/urgent' into locking/core

elapsed time: 938m

configs tested: 197
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211218
mips                 randconfig-c004-20211218
powerpc                       maple_defconfig
nds32                               defconfig
arm                          simpad_defconfig
mips                        bcm63xx_defconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
openrisc                            defconfig
powerpc                   motionpro_defconfig
powerpc                    socrates_defconfig
powerpc                      arches_defconfig
powerpc                          g5_defconfig
powerpc                 canyonlands_defconfig
arm                        trizeps4_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                   sb1250_swarm_defconfig
parisc                              defconfig
m68k                        m5307c3_defconfig
mips                      malta_kvm_defconfig
um                             i386_defconfig
sparc64                             defconfig
arm                        mvebu_v7_defconfig
mips                malta_qemu_32r6_defconfig
mips                             allmodconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    ge_imp3a_defconfig
alpha                            alldefconfig
arc                        nsim_700_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                                 defconfig
sparc                               defconfig
arm                       imx_v6_v7_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
arm                      pxa255-idp_defconfig
h8300                            alldefconfig
arm                       spear13xx_defconfig
mips                         cobalt_defconfig
mips                           ip28_defconfig
powerpc                      pasemi_defconfig
nds32                             allnoconfig
powerpc                        fsp2_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                       common_defconfig
arm                         shannon_defconfig
arm                        clps711x_defconfig
m68k                       m5249evb_defconfig
arm                            dove_defconfig
powerpc                     powernv_defconfig
um                           x86_64_defconfig
mips                        jmr3927_defconfig
powerpc                     stx_gp3_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                             alldefconfig
mips                         tb0219_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
arm                  colibri_pxa270_defconfig
sh                         ecovec24_defconfig
m68k                         apollo_defconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
mips                             allyesconfig
sh                   sh7770_generic_defconfig
arm                         mv78xx0_defconfig
powerpc                     tqm8560_defconfig
mips                  cavium_octeon_defconfig
m68k                          hp300_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7269_defconfig
arm                          pxa168_defconfig
nios2                            alldefconfig
powerpc                     taishan_defconfig
powerpc                      acadia_defconfig
xtensa                  nommu_kc705_defconfig
arm                       aspeed_g4_defconfig
sh                             espt_defconfig
parisc                           allyesconfig
powerpc                      makalu_defconfig
arc                     haps_hs_smp_defconfig
mips                          rb532_defconfig
m68k                            mac_defconfig
arc                     nsimosci_hs_defconfig
powerpc                         ps3_defconfig
parisc                           alldefconfig
m68k                       m5208evb_defconfig
powerpc                     tqm5200_defconfig
arm                  randconfig-c002-20211218
arm                  randconfig-c002-20211219
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
h8300                            allyesconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211218
x86_64               randconfig-a005-20211218
x86_64               randconfig-a001-20211218
x86_64               randconfig-a003-20211218
x86_64               randconfig-a002-20211218
x86_64               randconfig-a004-20211218
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
i386                 randconfig-a001-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a002-20211218
i386                 randconfig-a005-20211218
i386                 randconfig-a003-20211218
i386                 randconfig-a006-20211218
i386                 randconfig-a004-20211218
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a012-20211219
arc                  randconfig-r043-20211216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a002-20211219
i386                 randconfig-a001-20211219
i386                 randconfig-a005-20211219
i386                 randconfig-a003-20211219
i386                 randconfig-a006-20211219
i386                 randconfig-a004-20211219
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
x86_64               randconfig-a011-20211218
x86_64               randconfig-a015-20211218
x86_64               randconfig-a016-20211218
i386                 randconfig-a013-20211218
i386                 randconfig-a011-20211218
i386                 randconfig-a016-20211218
i386                 randconfig-a015-20211218
i386                 randconfig-a014-20211218
i386                 randconfig-a012-20211218
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216
hexagon              randconfig-r045-20211219
hexagon              randconfig-r041-20211219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
