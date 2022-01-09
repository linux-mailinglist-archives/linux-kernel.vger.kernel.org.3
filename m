Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C4A48894C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiAIMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:16:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:64211 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbiAIMQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641730594; x=1673266594;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cupE+ksXC9+TUQRzF31OGKHfxEzRZolFDCvckFInPI8=;
  b=CvvAalyTtvNw+M1xlVJvcpiPykllOisBGf+g8K2IS4su0bpz7R0c2/gk
   NbduWAKwDCWFTX071K3+3yA3tG8mgh7vIi/dxbXi7Gy+skttCnLXX9dCW
   S0Cq8oIlcisQ53BmU1qVCRv+9bNhPG2r+/V9eMcrFIvOIfvxmAwOIXSxX
   qfP8zIRhAflttongRMkK8lA3LVaTugWsxTI+X0rt6Vl75bL+/MgBQcndn
   reNDUT8SSzKoiGxblgOGoLpZ1FXJqDKYHdedVkjeEGXo4Q10N/eElTEYs
   uTlaROcm45tmNNmjugYiZww58m15w5uJNoEZXbFhZgQT7ynz8s1OrnmsT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="242880962"
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="242880962"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 04:16:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,274,1635231600"; 
   d="scan'208";a="557722634"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2022 04:16:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6X7g-0001Z4-92; Sun, 09 Jan 2022 12:16:32 +0000
Date:   Sun, 09 Jan 2022 20:16:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 b6aa86cff44cf099299d3a5e66348cb709cd7964
Message-ID: <61dad218.FMVdwWZfRh5Xu3y/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: b6aa86cff44cf099299d3a5e66348cb709cd7964  x86/kbuild: Enable CONFIG_KALLSYMS_ALL=y in the defconfigs

elapsed time: 728m

configs tested: 142
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
nios2                         10m50_defconfig
mips                         db1xxx_defconfig
m68k                        m5272c3_defconfig
riscv                            allmodconfig
mips                            ar7_defconfig
powerpc                     taishan_defconfig
powerpc                        warp_defconfig
sh                        dreamcast_defconfig
m68k                             alldefconfig
powerpc                 mpc8540_ads_defconfig
um                                  defconfig
um                             i386_defconfig
powerpc                      ppc6xx_defconfig
m68k                            mac_defconfig
sh                            migor_defconfig
nds32                            alldefconfig
arc                          axs101_defconfig
arc                     nsimosci_hs_defconfig
openrisc                  or1klitex_defconfig
sh                            hp6xx_defconfig
arm                        multi_v7_defconfig
arc                        vdk_hs38_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          badge4_defconfig
powerpc                     tqm8541_defconfig
i386                             alldefconfig
alpha                               defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        stmark2_defconfig
sh                           sh2007_defconfig
sh                           se7619_defconfig
arm                        oxnas_v6_defconfig
sh                                  defconfig
nios2                            alldefconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          kfr2r09_defconfig
sh                     sh7710voipgw_defconfig
m68k                                defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
arm                            qcom_defconfig
arm                          exynos_defconfig
powerpc                      makalu_defconfig
sh                           se7780_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      cm5200_defconfig
x86_64                           alldefconfig
sh                        sh7757lcr_defconfig
powerpc                      chrp32_defconfig
m68k                            q40_defconfig
sh                         ecovec24_defconfig
sh                          rsk7264_defconfig
mips                         bigsur_defconfig
arm                  randconfig-c002-20220109
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
x86_64               randconfig-a005-20220109
x86_64               randconfig-a001-20220109
x86_64               randconfig-a004-20220109
x86_64               randconfig-a006-20220109
x86_64               randconfig-a003-20220109
x86_64               randconfig-a002-20220109
i386                 randconfig-a003-20220109
i386                 randconfig-a005-20220109
i386                 randconfig-a006-20220109
i386                 randconfig-a004-20220109
i386                 randconfig-a001-20220109
i386                 randconfig-a002-20220109
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220109
mips                 randconfig-c004-20220109
i386                 randconfig-c001-20220109
riscv                randconfig-c006-20220109
powerpc              randconfig-c003-20220109
x86_64               randconfig-c007-20220109
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
powerpc                          allyesconfig
powerpc                     ksi8560_defconfig
x86_64               randconfig-a015-20220109
x86_64               randconfig-a012-20220109
x86_64               randconfig-a014-20220109
x86_64               randconfig-a013-20220109
x86_64               randconfig-a011-20220109
x86_64               randconfig-a016-20220109
i386                 randconfig-a012-20220109
i386                 randconfig-a016-20220109
i386                 randconfig-a015-20220109
i386                 randconfig-a014-20220109
i386                 randconfig-a011-20220109
i386                 randconfig-a013-20220109
hexagon              randconfig-r041-20220109
riscv                randconfig-r042-20220109
hexagon              randconfig-r045-20220109
s390                 randconfig-r044-20220109

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
