Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3915849DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiG2CjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiG2CjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:39:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6037B34C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659062350; x=1690598350;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q3zrx4UCHlK57YlBLf4pbI7diFMk4njT/phr3YEwp7Y=;
  b=TS/+YBCDIIyy13ydAImTq1yBhU4XX0Ov4nQuIvlpROkskkIAfrS92i+B
   hw43exBWdWrpDEfUXgLQ6R1du/YEB12vWSWueBFUS3vfyiFwkQPl1ck9i
   0H0zdxQlOlMOWfPGhDm9iDWjVcLdttUt0v5MagLtAf4B00Cw8GxGK3EYx
   gp+AEaxtjtILpFpg7OJq9oy8LSUDR9avZSG0kM/qRLE0ZiwumR9qPv5/o
   K0aVGrWjD982KBOVnqcs0au6T5VhdU+8Ild3RRz72rZCnT6uqIaswal3W
   kZLkhUBv95RIKzBM2MBNAYBr+cuSwYwBvgkr8v+pNdlhfJcikZfXjGlyy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="268438797"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="268438797"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="604823463"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2022 19:39:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHFu8-000AwU-0i;
        Fri, 29 Jul 2022 02:39:08 +0000
Date:   Fri, 29 Jul 2022 10:38:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 a1a5482a2c6e38a3ebed32e571625c56a8cc41a6
Message-ID: <62e34810.psKhsnpD/CFysWf/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/core
branch HEAD: a1a5482a2c6e38a3ebed32e571625c56a8cc41a6  x86/extable: Fix ex_handler_msr() print condition

elapsed time: 2441m

configs tested: 188
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc                      ppc40x_defconfig
sparc64                             defconfig
powerpc                     ep8248e_defconfig
parisc                              defconfig
arm                         at91_dt_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
mips                     decstation_defconfig
powerpc                      bamboo_defconfig
ia64                        generic_defconfig
m68k                        m5307c3_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                            lart_defconfig
ia64                          tiger_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          rsk7269_defconfig
sh                           sh2007_defconfig
openrisc                            defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                    amigaone_defconfig
arm                           tegra_defconfig
parisc                generic-64bit_defconfig
sh                          landisk_defconfig
sh                           se7343_defconfig
powerpc                     asp8347_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220727
nios2                            allyesconfig
parisc64                            defconfig
parisc                           allyesconfig
m68k                                defconfig
sh                      rts7751r2d1_defconfig
loongarch                 loongson3_defconfig
sh                          urquell_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
sh                           se7712_defconfig
arc                        vdk_hs38_defconfig
mips                            ar7_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
nios2                               defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      makalu_defconfig
sparc                       sparc64_defconfig
arm                           sama5_defconfig
arm                            qcom_defconfig
sh                          rsk7264_defconfig
mips                  decstation_64_defconfig
arm                         assabet_defconfig
sh                         ecovec24_defconfig
xtensa                    smp_lx200_defconfig
mips                 randconfig-c004-20220728
powerpc              randconfig-c003-20220728
s390                 randconfig-r044-20220728
riscv                randconfig-r042-20220728
arc                  randconfig-r043-20220728
powerpc                 mpc837x_rdb_defconfig
csky                             alldefconfig
arm                           viper_defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
m68k                        m5272c3_defconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
arm                  randconfig-c002-20220728
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
mips                           ip32_defconfig
arc                            hsdk_defconfig
sh                 kfr2r09-romimage_defconfig
sh                     sh7710voipgw_defconfig
m68k                        m5407c3_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig
m68k                            mac_defconfig

clang tested configs:
hexagon              randconfig-r041-20220727
hexagon              randconfig-r045-20220727
s390                 randconfig-r044-20220727
riscv                randconfig-r042-20220727
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-k001
powerpc                  mpc885_ads_defconfig
arm                         socfpga_defconfig
riscv                    nommu_virt_defconfig
mips                        maltaup_defconfig
powerpc                     ksi8560_defconfig
arm                         bcm2835_defconfig
powerpc                        icon_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip27_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        fsp2_defconfig
mips                     decstation_defconfig
powerpc                      pasemi_defconfig
powerpc                     tqm5200_defconfig
arm                         s5pv210_defconfig
arm                        neponset_defconfig
hexagon              randconfig-r041-20220728
hexagon              randconfig-r045-20220728
powerpc                    mvme5100_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
arm                     davinci_all_defconfig
mips                      pic32mzda_defconfig
hexagon                             defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
mips                 randconfig-c004-20220728
x86_64                        randconfig-c007
s390                 randconfig-c005-20220728
powerpc              randconfig-c003-20220728
i386                          randconfig-c001
riscv                randconfig-c006-20220728
arm                  randconfig-c002-20220728
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
powerpc                      katmai_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig
mips                          rm200_defconfig
arm                  colibri_pxa270_defconfig
arm                      pxa255-idp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
