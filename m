Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F0476767
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhLPB02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:26:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:22743 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhLPB02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639617988; x=1671153988;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bnbu/dQZlYpapXzv/zhkFBHlhyZKevv7DTTrqK8aWDY=;
  b=elbUdo9XzN4zXNtgdhFFciuOVugeYwFkU2McAuVB7lBBGW3wVAGCjAlJ
   bWxjKBK3cvU2Xy658TcvEcnfkWnwUYyYPMPy0C+KgqW+m94Vdv6cSqfTu
   HUqg0VXOKxZDkVLXOhXEkxJu4cWWJI2XWXUa9jWhYmA1yOcuWLZRsouvz
   /levSS8I7ozpuLQyx23bIVtI04spzIaDSudwT0P1rYNfbJSGLWYC4y+dw
   4b2wSfZDtIa2cGXWxUBiIj/9FK+reCKJr6abuMVuQt0TsK2Jakuwl2p8u
   yFnayzCuRMyuJwG77pbNhLNx4CSWK+jRMtkYEe/S5D9zZ4MbApTC1Pv6q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236915998"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="236915998"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 17:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="464492688"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2021 17:26:26 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxfXO-0002Zm-1p; Thu, 16 Dec 2021 01:26:26 +0000
Date:   Thu, 16 Dec 2021 09:25:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 086fea69d94ae54d4d30f8b8659f4394607106c8
Message-ID: <61ba9591.tPl3/vK+BS9Fp2SO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 086fea69d94ae54d4d30f8b8659f4394607106c8  Merge branch into tip/master: 'core/urgent'

elapsed time: 882m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
openrisc                         alldefconfig
powerpc                      cm5200_defconfig
arm                           u8500_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            zeus_defconfig
powerpc                      ppc64e_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
powerpc                     asp8347_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
m68k                        mvme147_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                   motionpro_defconfig
arm                        shmobile_defconfig
sh                           se7724_defconfig
arm                        magician_defconfig
arm                       omap2plus_defconfig
mips                          rm200_defconfig
powerpc                        warp_defconfig
powerpc                         wii_defconfig
powerpc                  mpc866_ads_defconfig
arm                         axm55xx_defconfig
m68k                          atari_defconfig
powerpc                      arches_defconfig
arm                        realview_defconfig
sh                           se7780_defconfig
arm                  randconfig-c002-20211214
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
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
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
arc                  randconfig-r043-20211215
riscv                randconfig-r042-20211215
s390                 randconfig-r044-20211215
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a011-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
x86_64               randconfig-a014-20211214
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a012-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a015-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214
hexagon              randconfig-r045-20211215
hexagon              randconfig-r041-20211215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
