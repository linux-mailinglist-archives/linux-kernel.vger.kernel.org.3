Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9052E075
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbiESXTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbiESXTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:19:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC70F74A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653002385; x=1684538385;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uYjQ/hKu+SjdZ2gVGfOOuy9U6ZT54F6cyI1GN2N+zkA=;
  b=Qkf6s71giD5o9M6qMWu90gbN4ya0yLwfzfWDAGD+DQl/mXuudzAie1qm
   qoYvTeZScFwTbwbJT08pg/k2mUDLjxmkZ/+0cqOmSasZ5WIfAG3TzDv+7
   byQb6ktupmjJYyw4mM1AosHKvjo2CFYp8HzIVFN91RbvXMvSzz5b7q5fJ
   kbsIPpqYLViv78dcO8sleEmdc4gN5CRRRVl6k0CB59cW9dO0KRThMZO7s
   vHoileEGvAnnGYYjN+FkbmvqiYWULkjXeE7abmC5VbpnJfJp0xXIeO8qU
   L3T4gYduYXhw+jC61ZSZnIUrVbHdqSO4YhphAz65fyCeedUZPzHCsxuhe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="270005169"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="270005169"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743188562"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2022 16:19:43 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrpQl-00042b-6J;
        Thu, 19 May 2022 23:19:43 +0000
Date:   Fri, 20 May 2022 07:18:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 aeb84412037b89e06f45e382f044da6f200e12f8
Message-ID: <6286d05b.BAWB0W0W2sujM6aS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: aeb84412037b89e06f45e382f044da6f200e12f8  x86/boot: Wrap literal addresses in absolute_pointer()

elapsed time: 728m

configs tested: 167
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                          hp300_defconfig
m68k                             alldefconfig
openrisc                 simple_smp_defconfig
sh                         microdev_defconfig
xtensa                generic_kc705_defconfig
sh                           se7724_defconfig
powerpc                     rainier_defconfig
m68k                            mac_defconfig
sh                        sh7785lcr_defconfig
m68k                           sun3_defconfig
mips                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     mpc83xx_defconfig
riscv                               defconfig
mips                           ci20_defconfig
arm                      footbridge_defconfig
s390                          debug_defconfig
xtensa                    xip_kc705_defconfig
xtensa                          iss_defconfig
s390                             allyesconfig
sh                           se7705_defconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sequoia_defconfig
riscv                            allyesconfig
arm                      jornada720_defconfig
powerpc64                           defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
powerpc                        warp_defconfig
h8300                            allyesconfig
powerpc                      ppc40x_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
mips                  decstation_64_defconfig
m68k                        stmark2_defconfig
sh                          landisk_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
nios2                            alldefconfig
arm                        mini2440_defconfig
arc                            hsdk_defconfig
mips                    maltaup_xpa_defconfig
arc                      axs103_smp_defconfig
powerpc                      ep88xc_defconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                         virt_defconfig
arm                        keystone_defconfig
parisc64                            defconfig
xtensa                       common_defconfig
m68k                       m5208evb_defconfig
m68k                       bvme6000_defconfig
powerpc                      arches_defconfig
m68k                          sun3x_defconfig
mips                           gcw0_defconfig
sh                          sdk7786_defconfig
mips                 decstation_r4k_defconfig
um                             i386_defconfig
mips                         mpc30x_defconfig
arm                        realview_defconfig
sh                   rts7751r2dplus_defconfig
sh                          urquell_defconfig
ia64                         bigsur_defconfig
mips                         rt305x_defconfig
arc                         haps_hs_defconfig
sh                        sh7757lcr_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
s390                 randconfig-c005-20220519
powerpc                          g5_defconfig
hexagon                             defconfig
mips                     loongson2k_defconfig
arm                          pxa168_defconfig
mips                      pic32mzda_defconfig
mips                malta_qemu_32r6_defconfig
mips                  cavium_octeon_defconfig
riscv                          rv32_defconfig
powerpc                     akebono_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
