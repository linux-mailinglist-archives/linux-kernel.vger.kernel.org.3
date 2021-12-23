Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8DA47E126
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347647AbhLWKMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:12:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:27696 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347642AbhLWKMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640254358; x=1671790358;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eJHe8vHJI6YoDqfEDaYvKYVu6oGKe30lVn2Od00p70Y=;
  b=IVvbnHkJTNNb/sNwBl3xojHCdoXjqFj/XJR+l2MHQiVHli9WsLSp29sC
   dPbS4wEfAc74wb5hJAGKw7KGvHiYsI1o7gcHbYgNPzjd+GrQedchNLLFl
   hRcazjs159s16gWBeW1GFDE5CFiE6TlNbucYX7s2yHN1jc09lR5cwlA6j
   DPr6qODdOEm+0nAWAsWxLSktyRV3KhyTNBfTTnfX7TjGz9M74udLC5KNK
   MUMW3noScVsXk/8ZWVmHel+zJJty1xzwzPX8mjGlpUizwafmFvSGk3FKo
   JY7+NDusiMDdlB3GPI/7lufjIBBsTrREaLixkYgrmhX/h49OtMUpqHE+Y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="241024284"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="241024284"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="508811289"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Dec 2021 02:12:36 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0L5P-0001gE-S3; Thu, 23 Dec 2021 10:12:35 +0000
Date:   Thu, 23 Dec 2021 18:12:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 9c42a8706f358ef6699f299916ad31acf2767c45
Message-ID: <61c44b87.nOhLehrSAlK/rdyv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 9c42a8706f358ef6699f299916ad31acf2767c45  x86/boot/compressed: Move CLANG_FLAGS to beginning of KBUILD_CFLAGS

elapsed time: 724m

configs tested: 162
configs skipped: 85

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
i386                 randconfig-c001-20211223
arm                       mainstone_defconfig
powerpc                     ep8248e_defconfig
sh                         microdev_defconfig
arm                         s5pv210_defconfig
mips                        vocore2_defconfig
sh                     magicpanelr2_defconfig
arm                          pxa3xx_defconfig
sh                          r7780mp_defconfig
sh                            titan_defconfig
arm                          pcm027_defconfig
parisc                generic-32bit_defconfig
riscv                               defconfig
powerpc                     tqm5200_defconfig
mips                     loongson1b_defconfig
mips                         bigsur_defconfig
powerpc                  storcenter_defconfig
powerpc                     taishan_defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
mips                   sb1250_swarm_defconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
powerpc                     kilauea_defconfig
arm                       aspeed_g4_defconfig
sh                          landisk_defconfig
arm                        mvebu_v5_defconfig
parisc                           alldefconfig
mips                       bmips_be_defconfig
mips                            gpr_defconfig
sh                             shx3_defconfig
sh                           se7705_defconfig
powerpc                  mpc866_ads_defconfig
mips                           ip27_defconfig
sh                          sdk7780_defconfig
powerpc                     mpc83xx_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
m68k                          atari_defconfig
powerpc                 canyonlands_defconfig
arm                        neponset_defconfig
sh                            migor_defconfig
arm                     davinci_all_defconfig
powerpc                      walnut_defconfig
sh                        sh7763rdp_defconfig
mips                            e55_defconfig
arm                       omap2plus_defconfig
nios2                         10m50_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8313_rdb_defconfig
h8300                            alldefconfig
sh                          lboxre2_defconfig
m68k                       m5475evb_defconfig
arm                        shmobile_defconfig
mips                       capcella_defconfig
mips                          rb532_defconfig
powerpc                      makalu_defconfig
powerpc                        icon_defconfig
sh                          rsk7269_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sama5_defconfig
powerpc                      ppc40x_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
arm                  randconfig-c002-20211223
ia64                             allmodconfig
ia64                                defconfig
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
h8300                            allyesconfig
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
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a001-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a005-20211222
i386                 randconfig-a006-20211222
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222
hexagon              randconfig-r041-20211223
hexagon              randconfig-r045-20211223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
