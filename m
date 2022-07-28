Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1658430B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiG1P03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiG1P02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:26:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764E54CAE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659021986; x=1690557986;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=kidvyMRamFX8RsCr04mGGvP2AXekq3DofEV/E4wWErE=;
  b=WFtDNwcG8Gw8AiPHKivhGMmHEkplcEt+014YUXBvdy02ZsjiCsFBSDCY
   5KmUa24ygWs2LseGI3BLTuBb3gpXu5wBEgKgPgQcr8u4oUqBkuhsKx1UW
   lZREdmOFPJ/r1N9xqXJWJs/JeF8n9/K1eb4aKYBKp2vf2F8BuUBhzc7Id
   Fb+q2HPFa+vpIYnTOAB8rNECNDKnaQr/dsTNIBH8cpqz04iuOx/Nh4/vJ
   N/TCrG8LYEmNbnpESUerPyQOYt6cgaJUtYiNcj65gE3lu0EY96j6xwveP
   Ov41THgoLxFw8Vzm+JZDY9Lo3HnvRcTetxstVqHbqabbG9ghyJ4fflDzR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="314331013"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="314331013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 08:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="576518887"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 08:26:25 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH5P6-000AH4-1L;
        Thu, 28 Jul 2022 15:26:24 +0000
Date:   Thu, 28 Jul 2022 23:25:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5
Message-ID: <62e2aa69.vOESjgmyY9nb4GDH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 326ecc15c61c349cd49d1700ff9e3e31c6fd1cd5  perf/x86/ibs: Add new IBS register bits into header

elapsed time: 1601m

configs tested: 135
configs skipped: 101

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                             allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
sh                          landisk_defconfig
sh                           se7343_defconfig
powerpc                     asp8347_defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
xtensa                  cadence_csp_defconfig
powerpc                      pasemi_defconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
mips                            ar7_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
loongarch                 loongson3_defconfig
sh                          urquell_defconfig
arc                              alldefconfig
powerpc                        cell_defconfig
mips                           gcw0_defconfig
m68k                            q40_defconfig
sh                            titan_defconfig
m68k                          sun3x_defconfig
mips                      fuloong2e_defconfig
sh                           se7712_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                       sparc32_defconfig
powerpc                      mgcoge_defconfig
powerpc                mpc7448_hpc2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220727
m68k                         amcore_defconfig
arm                            lart_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
powerpc                         ps3_defconfig
arm                        mvebu_v7_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                            hisi_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc8540_ads_defconfig
sh                   sh7770_generic_defconfig
m68k                          amiga_defconfig
arm                         cm_x300_defconfig
ia64                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
csky                             alldefconfig
arm                           viper_defconfig
loongarch                         allnoconfig
xtensa                           allyesconfig
arm                           u8500_defconfig
powerpc                 linkstation_defconfig
s390                 randconfig-r044-20220728
riscv                randconfig-r042-20220728
arc                  randconfig-r043-20220728
powerpc                    amigaone_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
mips                           ip27_defconfig
arm                          ixp4xx_defconfig
riscv                    nommu_virt_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        neponset_defconfig
arm                             mxs_defconfig
hexagon              randconfig-r041-20220728
hexagon              randconfig-r045-20220728
x86_64                        randconfig-k001
powerpc                    mvme5100_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                 mpc8315_rdb_defconfig
mips                      pic32mzda_defconfig
hexagon                             defconfig
mips                 randconfig-c004-20220728
x86_64                        randconfig-c007
s390                 randconfig-c005-20220728
powerpc              randconfig-c003-20220728
i386                          randconfig-c001
riscv                randconfig-c006-20220728
arm                  randconfig-c002-20220728
mips                malta_qemu_32r6_defconfig
powerpc                    gamecube_defconfig
arm                          collie_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
