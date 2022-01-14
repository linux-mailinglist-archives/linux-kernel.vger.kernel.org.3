Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E105C48E7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiANJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:49:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:50426 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240107AbiANJtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642153779; x=1673689779;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=C2fUKW3KYv9f6U5s+DUvkZkV3JRjDsnBvziK3O7gcxk=;
  b=mh8K3CIA1r25V2AJ8ryS7K0CofBpn2DXH1CKbijy1dxhOvtglVOJb5Da
   vofUTdKTPY4HzZQ/r0I4gvbmQIRQ+UfjHEmDjjaVK3xjShf6MU+BTDd2i
   0sdM1Z2RdSD1UZqgXUSELKnS78cDc+21Ucpsyx802neM4umRlBzP+PFWX
   tEHx9GscwHy71ScELU3VK7QZCcRhBCntufE3PpHNzThLofqheYB+s6Q3I
   +NLQDXTR2hII6Pmw0Zq2GlqM29G+AHC3yh0t+5XtjsD77f5o+QeHqx9Nz
   VIOnhKexZ33SeJTC9/U332paxSs6mUOGIkzNki1Rkf6BlSupP3+ISfaYN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244173573"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="244173573"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 01:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="516321424"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2022 01:49:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8JDE-0008NG-Bm; Fri, 14 Jan 2022 09:49:36 +0000
Date:   Fri, 14 Jan 2022 17:48:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 85538cc07d6b6dcffc1df64a22308fcb05ecddf4
Message-ID: <61e146f4.fQFGHLLnjcUERCYQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 85538cc07d6b6dcffc1df64a22308fcb05ecddf4  Merge branch into tip/master: 'x86/core'

elapsed time: 1462m

configs tested: 142
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
arm                          gemini_defconfig
arm                         at91_dt_defconfig
nios2                         10m50_defconfig
sparc64                             defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        mvme16x_defconfig
powerpc                     tqm8555_defconfig
arm                            hisi_defconfig
mips                       capcella_defconfig
arm                         axm55xx_defconfig
arm                           h5000_defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
sh                        sh7757lcr_defconfig
sh                          landisk_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
arm                           sunxi_defconfig
arm                            pleb_defconfig
arm                           stm32_defconfig
m68k                       m5475evb_defconfig
arm                        trizeps4_defconfig
powerpc                      pasemi_defconfig
sh                               j2_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
powerpc                      tqm8xx_defconfig
arm                          iop32x_defconfig
mips                         tb0226_defconfig
arm                            mps2_defconfig
arm                          lpd270_defconfig
riscv                            allmodconfig
arm                            qcom_defconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
s390                          debug_defconfig
sh                          rsk7264_defconfig
sh                          r7785rp_defconfig
arm                            xcep_defconfig
sh                           se7343_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
m68k                             allmodconfig
sh                              ul2_defconfig
arm                  randconfig-c002-20220113
arm                  randconfig-c002-20220114
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
mips                           ip28_defconfig
arm                          pxa168_defconfig
powerpc                     powernv_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
mips                     loongson1c_defconfig
powerpc                     mpc5200_defconfig
mips                            e55_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
