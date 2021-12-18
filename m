Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57252479911
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 07:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhLRGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 01:00:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:40155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhLRGAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 01:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639807236; x=1671343236;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BgE1CBTkPkP8hv+DKYa8xUgjSbTUegAyvNpH+Kxd+pA=;
  b=ZygTpgMrjfN6u2j2Jc2CrU9zETO+QSmqVVwowYvLUFVcw2HL/pWb3UTJ
   id81IFpCHUrtGyedIidXlEWbGZdASAZi1rxITpZ4isXOCxHc9hkTok1GY
   m3iJgq5xCnvhv23NlNjTGA/DGARqXkEjuaiKjscgNkLRtS3SyV19ESOma
   ltcu2rHZ7CcB3W4LcsTKCeCclylGANQNo56GjXrjTi0NSC88tNfNqayV5
   jET8RR248iR0brqlmR4TgImKp8Y4Lj/bmX8rQ3NC0s2ziyJFMX2xu2uiL
   L9uxdiHgkxmDEMjOkiZOCgNUzeQVXBGMWvdL6Xf/Kb6OtDilfrmGGq/5+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="239702942"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="239702942"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 22:00:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="683637009"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2021 22:00:35 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mySlm-0005fp-FE; Sat, 18 Dec 2021 06:00:34 +0000
Date:   Sat, 18 Dec 2021 14:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 53c80bfc1eb1f0742bde18e1f562991459631451
Message-ID: <61bd78f0.UiKU5XTlAv8t3if5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 53c80bfc1eb1f0742bde18e1f562991459631451  rcutorture: Increase visibility of forward-progress hangs

elapsed time: 723m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211216
xtensa                         virt_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
arc                        nsimosci_defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                              alldefconfig
sparc                               defconfig
arm                       imx_v6_v7_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
powerpc                      tqm8xx_defconfig
mips                         tb0219_defconfig
mips                           rs90_defconfig
arc                           tb10x_defconfig
nds32                             allnoconfig
i386                             alldefconfig
powerpc                     powernv_defconfig
m68k                         apollo_defconfig
m68k                        m5407c3_defconfig
mips                       capcella_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
riscv                          rv32_defconfig
m68k                        stmark2_defconfig
powerpc                      makalu_defconfig
arm                  randconfig-c002-20211216
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
i386                 randconfig-a013-20211217
i386                 randconfig-a011-20211217
i386                 randconfig-a016-20211217
i386                 randconfig-a014-20211217
i386                 randconfig-a015-20211217
i386                 randconfig-a012-20211217
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
arc                  randconfig-r043-20211216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
