Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0968447F4BA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 00:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhLYXk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 18:40:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:5730 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhLYXk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 18:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640475627; x=1672011627;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/mcavOgGIvIY6gBbOD3VaA+ZurKclGrTFFEGc2mQD/M=;
  b=AjLdaNQ9oHasVq3Ak5vtrndc0QZe+zBZy1DO1G2G7xLkBVfqohtkMY6u
   2UcP8LZDSDMZdhy8niSiYu19nU35PRaMNnB/mgyPKayIlXWOwa2wXClqp
   X+O3xkDH8BNeY38M5XVlubcukhJbeCkeSsHqLQcF3p3Bh8v8+xhfMaSCx
   y4gD+nQPJPwQ7VG3EuoWC34VOmgSRUbfld5uP7R3CGleejHq71Inhn+yk
   h7dY813gAOJ1eFjWQU96k3ZGDXgf2bc6IpKjTwHdt7NcEHRXy87Ud45f6
   Hc6mU9kTCsdjPge74JcFVunJNP+arldXtE3OTD8A7fFyYYE7dx/6pRt1f
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="241025053"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="241025053"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 15:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="618033027"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Dec 2021 15:40:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1GeG-0004r4-Nb; Sat, 25 Dec 2021 23:40:24 +0000
Date:   Sun, 26 Dec 2021 07:39:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 be59580168baab3d0f4e11892625ce881ddbbcd5
Message-ID: <61c7abb9.2d28XSQ7SpVZd3DQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: be59580168baab3d0f4e11892625ce881ddbbcd5  Merge branch into tip/master: 'core/entry'

elapsed time: 722m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                       zfcpdump_defconfig
arm                       cns3420vb_defconfig
x86_64                              defconfig
sh                              ul2_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         ap325rxa_defconfig
sh                               alldefconfig
mips                     decstation_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
powerpc                      ep88xc_defconfig
sparc64                             defconfig
arm                        neponset_defconfig
microblaze                      mmu_defconfig
powerpc                     ppa8548_defconfig
h8300                       h8s-sim_defconfig
powerpc                      acadia_defconfig
powerpc                       eiger_defconfig
arm                            dove_defconfig
arm                           viper_defconfig
arm                        trizeps4_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                   lite5200b_defconfig
sh                   secureedge5410_defconfig
arm                         cm_x300_defconfig
sh                      rts7751r2d1_defconfig
mips                           mtx1_defconfig
arm                          pcm027_defconfig
powerpc                       ppc64_defconfig
s390                             alldefconfig
sh                          landisk_defconfig
parisc                              defconfig
sh                          sdk7786_defconfig
arm                         nhk8815_defconfig
powerpc                         ps3_defconfig
powerpc                 canyonlands_defconfig
powerpc                     kilauea_defconfig
arc                          axs103_defconfig
arm                          moxart_defconfig
ia64                      gensparse_defconfig
arm                         orion5x_defconfig
powerpc                     tqm5200_defconfig
h8300                    h8300h-sim_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                           sunxi_defconfig
arm                              alldefconfig
arc                          axs101_defconfig
arm                           omap1_defconfig
arm                        cerfcube_defconfig
sh                            hp6xx_defconfig
arm                          imote2_defconfig
arm                       imx_v4_v5_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20211225
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
x86_64               randconfig-a003-20211226
x86_64               randconfig-a001-20211226
x86_64               randconfig-a005-20211226
x86_64               randconfig-a006-20211226
x86_64               randconfig-a004-20211226
x86_64               randconfig-a002-20211226
i386                 randconfig-a006-20211226
i386                 randconfig-a004-20211226
i386                 randconfig-a002-20211226
i386                 randconfig-a003-20211226
i386                 randconfig-a005-20211226
i386                 randconfig-a001-20211226
x86_64               randconfig-a013-20211225
x86_64               randconfig-a014-20211225
x86_64               randconfig-a015-20211225
x86_64               randconfig-a011-20211225
x86_64               randconfig-a012-20211225
x86_64               randconfig-a016-20211225
i386                 randconfig-a012-20211225
i386                 randconfig-a011-20211225
i386                 randconfig-a013-20211225
i386                 randconfig-a014-20211225
i386                 randconfig-a016-20211225
i386                 randconfig-a015-20211225
arc                  randconfig-r043-20211225
riscv                randconfig-r042-20211225
s390                 randconfig-r044-20211225
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r041-20211225
hexagon              randconfig-r045-20211225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
