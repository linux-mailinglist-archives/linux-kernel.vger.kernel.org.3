Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1547E8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 21:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbhLWUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 15:16:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:59463 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240680AbhLWUQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 15:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640290567; x=1671826567;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oNWsLojkVqsLKRAEsIIxvhQRXZa19MlVEnYJiima8zU=;
  b=ZJ7A1DbeuI2F1nQjAwm0tuakj8Pe+YQMkxfgLkU8nYIfMCrsC97zgqTI
   pfc/mx2heIE+1Mp5U6DODS7iTtrzZX4weYadm0lf53j0n7qPpko5fZZli
   LGo0BD1T0p4YhyRVkoG+Kuf+kX+HIKlUp9q0M8r4JrT73+ytAPTnnd6nk
   IzZcCkr23Bcng/5dug5430P1Q1XCq/VtWPI+ru8nEaa0sJu3udI4c6Lha
   eIsMfSReOWN3tNvktuaq03ZISgMxLY2zFphKXdwUzDTvGkk/huDCdGsz4
   M6AVHplZacPLkmKKVRYMTSCaZw3CUVbbPE/sAmdGMtNBzyxK9/4yoRxTk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="227725401"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="227725401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 12:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="508956988"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Dec 2021 12:16:05 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0UVQ-0002Ey-Oy; Thu, 23 Dec 2021 20:16:04 +0000
Date:   Fri, 24 Dec 2021 04:15:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 6a654e5501a6930af14a7dfb3e8cb0c7efc31493
Message-ID: <61c4d8f5.McMQbCHrn0kXRkUH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 6a654e5501a6930af14a7dfb3e8cb0c7efc31493  fixup! rcu: Rework rcu_barrier() and callback-migration logic

elapsed time: 792m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
powerpc                   bluestone_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     loongson1b_defconfig
mips                        maltaup_defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
mips                             allmodconfig
m68k                        mvme147_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
arm                             pxa_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             allyesconfig
powerpc                     skiroot_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
arm                         hackkit_defconfig
mips                     loongson2k_defconfig
ia64                         bigsur_defconfig
mips                          ath25_defconfig
mips                          ath79_defconfig
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
i386                              debian-10.3
i386                   debian-10.3-kselftests
sparc                               defconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
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
hexagon              randconfig-r041-20211223
hexagon              randconfig-r045-20211223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
