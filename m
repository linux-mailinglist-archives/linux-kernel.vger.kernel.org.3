Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713344ECA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349058AbiC3QyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347517AbiC3QyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:54:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B3294A3D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648659142; x=1680195142;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=537w59qAEymKnM3nH4zhpL00Rz+Ygt/VT2WvWrsqEpo=;
  b=KRbVqLhMSIcXFUbhuLQa0Y5GONL1M9Xnh7nyJ1AzVzobluFqEysh2r1s
   t7dK05EszOoPPWOkV7H7Dpg8a/GlYLcJx7Bs6XayNo36eb0MskMaOE1iR
   SmKO3JEsX2LvgObHNaiyFkOxY+48Nmk4C4IGwt0rXoLzWNy5+Lgsua7lK
   /BIizDsFHlS7hmf1HYdQRRu/kUuAW5V15DrYLThUXlNA41/ZKIDIxkIXK
   mC5dBrwnqC8yFsJ79fCd8bKmSJzVoajoEnAN9Uko4EfsMt9EMIhC1zG0Q
   HqfHZv9Jd3D3zH4qpVqGCE9TPGGX14noRqvu+mi9Dk6Pgp0+dpX1r8AjO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="239520237"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="239520237"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 09:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="653934788"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 09:52:21 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZbYS-0000Ce-94;
        Wed, 30 Mar 2022 16:52:20 +0000
Date:   Thu, 31 Mar 2022 00:52:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ba5a91cc154f61f6af263973ff33a858f11a0635
Message-ID: <62448abe.qLMNQDJyL2vqu/T4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ba5a91cc154f61f6af263973ff33a858f11a0635  Merge branch into tip/master: 'x86/urgent'

elapsed time: 4086m

configs tested: 167
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
powerpc64                           defconfig
m68k                            mac_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                          urquell_defconfig
alpha                            alldefconfig
powerpc                      bamboo_defconfig
mips                         mpc30x_defconfig
sh                           sh2007_defconfig
mips                       capcella_defconfig
arm                          badge4_defconfig
ia64                      gensparse_defconfig
powerpc                       maple_defconfig
m68k                         apollo_defconfig
sh                      rts7751r2d1_defconfig
i386                             alldefconfig
arc                     haps_hs_smp_defconfig
sparc64                             defconfig
x86_64                              defconfig
sh                          kfr2r09_defconfig
mips                             allyesconfig
parisc                generic-64bit_defconfig
mips                          rb532_defconfig
m68k                       m5208evb_defconfig
sh                          r7780mp_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                           allyesconfig
sh                           se7750_defconfig
arm                         s3c6400_defconfig
ia64                          tiger_defconfig
arm                        realview_defconfig
arm                            hisi_defconfig
powerpc                     redwood_defconfig
m68k                          multi_defconfig
arm                     eseries_pxa_defconfig
sh                            hp6xx_defconfig
h8300                       h8s-sim_defconfig
arc                              allyesconfig
mips                        bcm47xx_defconfig
arm                        trizeps4_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     stx_gp3_defconfig
arm                          pxa910_defconfig
arm                  randconfig-c002-20220327
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a006-20220328
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220328
arc                  randconfig-r043-20220327
riscv                randconfig-r042-20220327
arc                  randconfig-r043-20220330
s390                 randconfig-r044-20220330
riscv                randconfig-r042-20220330
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
i386                          randconfig-c001
s390                 randconfig-c005-20220327
mips                 randconfig-c004-20220328
arm                  randconfig-c002-20220328
x86_64               randconfig-c007-20220328
powerpc              randconfig-c003-20220328
riscv                randconfig-c006-20220328
i386                 randconfig-c001-20220328
mips                  cavium_octeon_defconfig
arm                         mv78xx0_defconfig
mips                           mtx1_defconfig
arm                       imx_v4_v5_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
arm                          imote2_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a014-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a015-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a013-20220328
hexagon              randconfig-r041-20220328
hexagon              randconfig-r045-20220327
hexagon              randconfig-r045-20220328
hexagon              randconfig-r041-20220327
s390                 randconfig-r044-20220328
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220330
hexagon              randconfig-r041-20220330

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
