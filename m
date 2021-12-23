Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02E447DC55
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhLWAsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:48:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:62262 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235262AbhLWAsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640220487; x=1671756487;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/MXkza4Qhh/fbe5qq35sCh9ao/7HSfrBo4PH2DSpeI4=;
  b=K6FvHaJglSUOkMDw2irdpYK4m6CJcBopmwixs3VVtbkKoUpBiAZhqRfm
   U8zWh3SSeyb9fgg4knUoicDf81O42IBcDAhWy54aIzffoOlFcXYr/vcd/
   sXv+pfZu8zzIIt+yc7OPKXWpQeDddEdrBNRYh0zdawEfe3Q8sVuVo0f6c
   YatqShJ78LB6Z8acLz2oHi7F9mn4tmj9ZZABlQgm1usstL3tvglgfic2j
   XwtUoJ83YBkOjTTFDQ8iGQCa5fX6vw7VvmRy3EZnUDYdG5WEQqJpCOs0+
   hUPPcvv6UxRXZU+4CW25yUnDtEQaaX1GNptdKGY9Vu/w5IT2HKbYZLmU9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="220741224"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="220741224"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:48:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="508668884"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Dec 2021 16:48:05 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0CH7-00016O-Al; Thu, 23 Dec 2021 00:48:05 +0000
Date:   Thu, 23 Dec 2021 08:47:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 b64dfcde1ca9cb82e38e573753f0c0db8fb841c2
Message-ID: <61c3c736.fSUZwn9yLTft9upT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: b64dfcde1ca9cb82e38e573753f0c0db8fb841c2  x86/mm: Prevent early boot triple-faults with instrumentation

elapsed time: 730m

configs tested: 120
configs skipped: 95

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211222
arm                         shannon_defconfig
m68k                         apollo_defconfig
powerpc                      katmai_defconfig
arm                        magician_defconfig
powerpc64                        alldefconfig
arm                       aspeed_g4_defconfig
parisc                              defconfig
powerpc                     pseries_defconfig
xtensa                         virt_defconfig
sh                          polaris_defconfig
mips                         tb0226_defconfig
microblaze                      mmu_defconfig
sh                        sh7757lcr_defconfig
arm                             ezx_defconfig
mips                           ip32_defconfig
powerpc                     ksi8560_defconfig
arm                      jornada720_defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
xtensa                           allyesconfig
powerpc                  mpc866_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           rs90_defconfig
mips                          ath25_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
ia64                             allyesconfig
powerpc                     kilauea_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
arm                         lpc32xx_defconfig
arm                          pxa168_defconfig
powerpc                      makalu_defconfig
arm                        trizeps4_defconfig
arm                          moxart_defconfig
powerpc                     tqm8555_defconfig
arm                         mv78xx0_defconfig
arm                          lpd270_defconfig
sh                      rts7751r2d1_defconfig
s390                             allyesconfig
openrisc                            defconfig
m68k                       bvme6000_defconfig
alpha                               defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         bcm2835_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     sequoia_defconfig
mips                        bcm47xx_defconfig
arm                        multi_v7_defconfig
i386                             allyesconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
nds32                             allnoconfig
nios2                            alldefconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8272_ads_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     stx_gp3_defconfig
arm                        shmobile_defconfig
sh                            titan_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20211222
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a002-20211222
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a001-20211222
i386                 randconfig-a005-20211222
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
