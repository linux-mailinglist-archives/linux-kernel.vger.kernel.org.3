Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA7E583F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiG1NJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiG1NJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:09:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A353D2D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659013770; x=1690549770;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3MgBwbc0refq+yyTgfk6KPiYpx4ERt95FMWK5yF301E=;
  b=iY90SiX/A/qu8R/9dzFaslPrJJK/5VilpzMZsho8mElD0mN9LxhzDNlg
   EL31dh4r5veoKtD52hqPh4mmZOaSKNX8QIz7BPVE33n8/IDUnBRFFIxp6
   Yp9foLqYuPi9C22O1dTiP7gghQihTzpCa2jCjJag9GVb9ndzRP0wlpgS/
   3AHHlfWsH7NmQI6PfHMU74EmUC/kHU9gIjZ8y1VAESDq1HGCjpWcew6X7
   TTuWknmCisXrkEQcBDTJHC/ffMBLCoi55X8Q/EUpKBwdsTWwjNvMhZVgN
   sV+paGTwfmqsYOulX/Jw4I6qvtYBKZANsPxXaVM6BHU5W1LPp7R+Q7Eff
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="287259937"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="287259937"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 06:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="551302314"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2022 06:09:12 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH3GJ-000A1P-1E;
        Thu, 28 Jul 2022 13:09:11 +0000
Date:   Thu, 28 Jul 2022 21:08:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/for-next-fam1] BUILD SUCCESS
 48029084552f2e57390bf17985252b16b474b6f3
Message-ID: <62e28a41.iANUd4Zo0i3gTFtO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/for-next-fam1
branch HEAD: 48029084552f2e57390bf17985252b16b474b6f3  cifs: replace one-element array with flexible-array member

elapsed time: 1634m

configs tested: 189
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
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
nios2                         3c120_defconfig
arm                           viper_defconfig
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
arm                            lart_defconfig
ia64                          tiger_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          rsk7269_defconfig
sh                           sh2007_defconfig
openrisc                            defconfig
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
x86_64                        randconfig-c001
arm                  randconfig-c002-20220727
m68k                         amcore_defconfig
sparc                       sparc32_defconfig
powerpc                      mgcoge_defconfig
powerpc                mpc7448_hpc2_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
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
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                     sequoia_defconfig
nios2                               defconfig
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
