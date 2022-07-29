Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1FB5849B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiG2CYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2CYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:24:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D467AB35
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659061449; x=1690597449;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mMhcYlnsww9WFVCsxeD5qaNs2SGNqJrxRSw7IojEUQs=;
  b=igmqplUttH3Ni5Zjne+Vc4M714JPFsMGfn1XJn8605Q1TOjfOqpeUIXq
   3p2y4ybGlY77fWuuW6dATcR2v+fyewxgN6YfXwvTLnviZcDUeaxfJs6TK
   Dt/oSJ6uGehyzG4bzX2Htjh6QMf2S9FdXfZVbpqnBM01ZQUbtiHPDcdnW
   9wHlvktc8dgK/xh5oXU8VOk807YKGgT+4i+f9d+rvkD3Ol4WbEsfBL4Lm
   kt2qlI2s4wUn/UndwwLPE9NBedUPMSJaubt8/rWZEF3GSPrzutyzMj5Pq
   q8XKVrckyBcEyiN/hBpiYvRuto5D09siS9bVY3P4ghaJY3MKOvyZps8RD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="352671820"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="352671820"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="576764384"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 19:24:07 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHFfa-000Auk-2b;
        Fri, 29 Jul 2022 02:24:06 +0000
Date:   Fri, 29 Jul 2022 10:23:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 ddfc710395cccc61247348df9eb18ea50321cbed
Message-ID: <62e344b9.oBGH41OCXqBgy2Xl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent
branch HEAD: ddfc710395cccc61247348df9eb18ea50321cbed  sched/deadline: Fix BUG_ON condition for deboosted tasks

elapsed time: 2427m

configs tested: 185
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
i386                                defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
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
