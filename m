Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820725849D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiG2CiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiG2CiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:38:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F99B6D9E1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659062291; x=1690598291;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nSJTdb6HQ/ONct68ubZL/lTOT2DIQjRYM3xhVaD31/U=;
  b=C9LtmoL4DRK8MMlT0RJOw5scMiqnJLQ/tPxWcDsyRsatYgytCoFB9gS4
   CJEsopw1zGyfbkBhPbES4I+yO471P6hnDYzh9qe6+UiqecgQcwMGBmtnx
   XBnFK1MHQnmppJYMd/btnKUfAC1ZtK4ks+80eMpoYeA1rFoCQNq0l7H9A
   Hc0dahCM79sSlx6IoKTqEw6L+BVOJVOQbRH5HEUaJjvOBKlBlq9dvfPKH
   VPwkiY0xhLnWL8HsW0+LxKSvnx9MIFqnbpiUHq+mmbHh3ZvYXO5FdxXaD
   00aHQlU6auE6iAcNCtDVj+xXGg03kYsxurOB1RQBVWWTAmdzeYe3zE+wc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289871401"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289871401"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 19:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="777399895"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2022 19:38:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHFtA-000AwQ-0Y;
        Fri, 29 Jul 2022 02:38:08 +0000
Date:   Fri, 29 Jul 2022 10:37:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/kdump] BUILD SUCCESS
 b9887d0fb9dd2e06891f35f441e4cddca9ee078d
Message-ID: <62e347dc.Zz5P5V0xS50SKZAF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/kdump
branch HEAD: b9887d0fb9dd2e06891f35f441e4cddca9ee078d  Merge branch 'x86/build' into x86/kdump, to resolve conflict

elapsed time: 2441m

configs tested: 219
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           rhel-8.3-syz
sh                               allmodconfig
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
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
powerpc                      ppc40x_defconfig
sparc64                             defconfig
nios2                         3c120_defconfig
arm                           viper_defconfig
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
sh                          rsk7269_defconfig
sh                           sh2007_defconfig
openrisc                            defconfig
arm                            lart_defconfig
ia64                          tiger_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                            shmin_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     asp8347_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                    amigaone_defconfig
arm                           tegra_defconfig
parisc                generic-64bit_defconfig
openrisc                         alldefconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                          landisk_defconfig
sh                           se7343_defconfig
m68k                            q40_defconfig
sh                            titan_defconfig
m68k                          sun3x_defconfig
mips                      fuloong2e_defconfig
sh                           se7712_defconfig
m68k                         amcore_defconfig
sparc                       sparc32_defconfig
powerpc                      mgcoge_defconfig
powerpc                mpc7448_hpc2_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220727
xtensa                  cadence_csp_defconfig
powerpc                      pasemi_defconfig
nios2                            allyesconfig
parisc64                            defconfig
parisc                           allyesconfig
m68k                                defconfig
sh                      rts7751r2d1_defconfig
arc                        vdk_hs38_defconfig
mips                            ar7_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
loongarch                 loongson3_defconfig
sh                          urquell_defconfig
nios2                               defconfig
powerpc                     sequoia_defconfig
arc                              alldefconfig
powerpc                        cell_defconfig
mips                           gcw0_defconfig
sh                        sh7763rdp_defconfig
powerpc                         wii_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         ps3_defconfig
arm                        mvebu_v7_defconfig
arm                         vf610m4_defconfig
xtensa                       common_defconfig
sparc                       sparc64_defconfig
arm                           sama5_defconfig
arm                            qcom_defconfig
arm                            hisi_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7264_defconfig
mips                  decstation_64_defconfig
arm                         assabet_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc8540_ads_defconfig
sh                   sh7770_generic_defconfig
m68k                          amiga_defconfig
arm                         cm_x300_defconfig
ia64                                defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
mips                 randconfig-c004-20220728
powerpc              randconfig-c003-20220728
s390                 randconfig-r044-20220728
riscv                randconfig-r042-20220728
arc                  randconfig-r043-20220728
arm                           u8500_defconfig
powerpc                 linkstation_defconfig
powerpc                     taishan_defconfig
arc                            hsdk_defconfig
arc                           tb10x_defconfig
m68k                       m5475evb_defconfig
arm                  randconfig-c002-20220728
s390                       zfcpdump_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
mips                           ip32_defconfig
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
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-k001
arm                         bcm2835_defconfig
powerpc                        icon_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                    nommu_virt_defconfig
mips                        maltaup_defconfig
powerpc                     ksi8560_defconfig
powerpc                     tqm5200_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     kmeter1_defconfig
mips                           ip27_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        neponset_defconfig
powerpc                        fsp2_defconfig
powerpc                  mpc885_ads_defconfig
mips                     decstation_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
arm                         s5pv210_defconfig
hexagon              randconfig-r041-20220728
hexagon              randconfig-r045-20220728
powerpc                    mvme5100_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
mips                      pic32mzda_defconfig
hexagon                             defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                    gamecube_defconfig
arm                          collie_defconfig
mips                 randconfig-c004-20220728
x86_64                        randconfig-c007
s390                 randconfig-c005-20220728
powerpc              randconfig-c003-20220728
i386                          randconfig-c001
riscv                randconfig-c006-20220728
arm                  randconfig-c002-20220728
arm                       imx_v4_v5_defconfig
arm                       versatile_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
powerpc                      katmai_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig
mips                          rm200_defconfig
arm                  colibri_pxa270_defconfig
arm                      pxa255-idp_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
