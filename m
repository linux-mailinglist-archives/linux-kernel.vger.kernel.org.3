Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE58481284
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhL2MQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:16:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:38432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhL2MQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640780162; x=1672316162;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tScp8yE41X419/4XMv1Y44kBpAubrzuQaA5i+tAjXLo=;
  b=Qvu15CFVM2oPuSrJD50OEel2N/rc+CVzvxMO1wwwTENiq+53v41IY+3P
   Mx1dmcVgC0YaywFlKMa9dCjMWCNb7YD4S7m2+b2rPlT99+SV4cK4w7xPn
   ltgTfEeYH8CH5jWMXoMNa5fnhbIzqflMMU3bOsd2487Vg4Dp7iqzgEuzc
   EAr1BLW259BfUhIKgIYF+RMuBpYPubDtKtAXsEgS23MilzH+DSiOZLtnt
   eYz73FPNgZ3mbtLopV0rXHaAPNyq7rw9DbI7oacIjGWK7jWtBRPNIDd/Z
   4ACWHOv/+0aDCoPm9w8wEkCsZbV0UA1fOEE49hLY27lE7F7K2zqgZVHBe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241722975"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="241722975"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 04:16:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="470330297"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Dec 2021 04:16:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2Xs8-0008tY-Aw; Wed, 29 Dec 2021 12:16:00 +0000
Date:   Wed, 29 Dec 2021 20:15:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 f35bfa4630a75753b4dd4d11b0aab70149d57f05
Message-ID: <61cc5146.qtLG8n8f2h/8OJSb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: f35bfa4630a75753b4dd4d11b0aab70149d57f05  kasan: Record work creation stack trace with interrupts enabled

elapsed time: 730m

configs tested: 171
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20211228
powerpc              randconfig-c003-20211229
arc                     haps_hs_smp_defconfig
mips                         db1xxx_defconfig
arm                             mxs_defconfig
parisc                generic-32bit_defconfig
arm                          simpad_defconfig
powerpc                     mpc5200_defconfig
arc                                 defconfig
m68k                        mvme16x_defconfig
um                             i386_defconfig
riscv                    nommu_virt_defconfig
mips                         tb0226_defconfig
mips                        workpad_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip32_defconfig
mips                           gcw0_defconfig
arm                        clps711x_defconfig
mips                       lemote2f_defconfig
mips                     decstation_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
sh                           se7724_defconfig
parisc                generic-64bit_defconfig
xtensa                       common_defconfig
powerpc                     mpc512x_defconfig
arm                          pxa168_defconfig
mips                     loongson2k_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          pxa3xx_defconfig
sh                           se7343_defconfig
mips                  cavium_octeon_defconfig
h8300                     edosk2674_defconfig
powerpc                    ge_imp3a_defconfig
arm                             rpc_defconfig
ia64                            zx1_defconfig
powerpc                 mpc836x_mds_defconfig
sh                          urquell_defconfig
arm                      pxa255-idp_defconfig
powerpc                     kmeter1_defconfig
mips                         bigsur_defconfig
mips                          rm200_defconfig
riscv                            allyesconfig
powerpc                         wii_defconfig
i386                                defconfig
mips                         cobalt_defconfig
mips                            ar7_defconfig
powerpc                      cm5200_defconfig
ia64                          tiger_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                            defconfig
sh                         ecovec24_defconfig
sh                        edosk7705_defconfig
sparc                               defconfig
m68k                       m5249evb_defconfig
microblaze                      mmu_defconfig
sh                        sh7757lcr_defconfig
powerpc                         ps3_defconfig
powerpc                       maple_defconfig
mips                        maltaup_defconfig
arm                            xcep_defconfig
mips                          ath79_defconfig
powerpc                  mpc885_ads_defconfig
arm                           sama5_defconfig
arm                          pxa910_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                       h8s-sim_defconfig
m68k                          atari_defconfig
m68k                          sun3x_defconfig
arm                     davinci_all_defconfig
powerpc                    amigaone_defconfig
m68k                        m5272c3_defconfig
arm                  randconfig-c002-20211229
arm                  randconfig-c002-20211228
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
sparc                            allyesconfig
nios2                               defconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20211228
i386                 randconfig-a004-20211228
i386                 randconfig-a002-20211228
i386                 randconfig-a003-20211228
i386                 randconfig-a001-20211228
i386                 randconfig-a005-20211228
x86_64               randconfig-a001-20211228
x86_64               randconfig-a003-20211228
x86_64               randconfig-a006-20211228
x86_64               randconfig-a015-20211229
x86_64               randconfig-a014-20211229
x86_64               randconfig-a013-20211229
x86_64               randconfig-a011-20211229
x86_64               randconfig-a012-20211229
x86_64               randconfig-a016-20211229
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20211228
mips                 randconfig-c004-20211228
powerpc              randconfig-c003-20211228
arm                  randconfig-c002-20211228
x86_64               randconfig-c007-20211228
i386                 randconfig-c001-20211228
x86_64               randconfig-a005-20211229
x86_64               randconfig-a001-20211229
x86_64               randconfig-a003-20211229
x86_64               randconfig-a004-20211229
x86_64               randconfig-a006-20211229
x86_64               randconfig-a002-20211229
i386                 randconfig-a006-20211229
i386                 randconfig-a004-20211229
i386                 randconfig-a002-20211229
i386                 randconfig-a003-20211229
i386                 randconfig-a001-20211229
i386                 randconfig-a005-20211229
x86_64               randconfig-a015-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a015-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
hexagon              randconfig-r045-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r041-20211229
hexagon              randconfig-r045-20211229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
