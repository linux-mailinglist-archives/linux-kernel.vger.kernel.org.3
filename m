Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2322A47A547
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhLTHKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:10:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:59278 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234251AbhLTHKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639984200; x=1671520200;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+YeWUJsbJ9KrLaOfHrKT2xETf0o/5xbJfK0lm/z9Kaw=;
  b=T+TxhWe6IiKGw+PP5Rxp1jvSK3gejVzGwtMxjeEZTUt50uHYCw+A/jYQ
   A8Ky6rS5uviO+L288whp+8uENU3SJ+PIG+L0xD1bCcDhyeHrJx/NNvuNi
   ZQn4WRWRiyErxU8BUeEIrGth66NsSeM0ETsIr0OA43Oxo/BxuOZGZ14h2
   jUU0yNf/j0gRDlorarNQ/OBcRgb156hbMa6b1uzTEd58O8Bq//xkLVaVD
   lm5gwJZphyLmgsftkzgonQZMHe5BcaQKk9ZitBu3AYE2ybJVPHukX11V8
   UMQHymbdCnjIlup/ED60R0UByrimHCbrAEwT4u4gxA7XKihjD32kpNjv4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240065441"
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="240065441"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2021 23:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,219,1635231600"; 
   d="scan'208";a="467289804"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Dec 2021 23:09:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzCo1-0007ZV-Eu; Mon, 20 Dec 2021 07:09:57 +0000
Date:   Mon, 20 Dec 2021 15:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ce3cab518d8cd36a1db98fc5e0f93c5ec5451ff3
Message-ID: <61c02c16.h0CEXypul30zqub2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ce3cab518d8cd36a1db98fc5e0f93c5ec5451ff3  Merge branch into tip/master: 'x86/urgent'

elapsed time: 725m

configs tested: 148
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    adder875_defconfig
m68k                       m5249evb_defconfig
powerpc                     sequoia_defconfig
arm                           viper_defconfig
m68k                       m5208evb_defconfig
mips                         bigsur_defconfig
arm                        magician_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      ep88xc_defconfig
powerpc                 xes_mpc85xx_defconfig
um                             i386_defconfig
arm                          iop32x_defconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
sh                             sh03_defconfig
arm                      integrator_defconfig
sh                        edosk7705_defconfig
powerpc                      chrp32_defconfig
arm                         axm55xx_defconfig
arm                         lubbock_defconfig
arm                           tegra_defconfig
sh                            hp6xx_defconfig
mips                         tb0287_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                            defconfig
m68k                       bvme6000_defconfig
sparc                       sparc32_defconfig
m68k                          hp300_defconfig
powerpc                    amigaone_defconfig
csky                                defconfig
s390                       zfcpdump_defconfig
sh                          landisk_defconfig
openrisc                  or1klitex_defconfig
sh                        sh7763rdp_defconfig
arm                       versatile_defconfig
powerpc                      ppc44x_defconfig
powerpc                  mpc885_ads_defconfig
arm                          pxa3xx_defconfig
arm                           stm32_defconfig
sh                        apsh4ad0a_defconfig
m68k                          atari_defconfig
powerpc                     taishan_defconfig
mips                            e55_defconfig
m68k                        m5307c3_defconfig
sh                         apsh4a3a_defconfig
arm                       cns3420vb_defconfig
powerpc                         wii_defconfig
powerpc                 canyonlands_defconfig
mips                           ci20_defconfig
nios2                         10m50_defconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20211220
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a001-20211220
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a005-20211220
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20211220
x86_64               randconfig-a015-20211220
x86_64               randconfig-a014-20211220
x86_64               randconfig-a012-20211220
x86_64               randconfig-a011-20211220
x86_64               randconfig-a016-20211220
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211219
hexagon              randconfig-r041-20211219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
