Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9342759947C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbiHSFZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbiHSFZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:25:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C7D7CEB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660886738; x=1692422738;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=celAXFYhYIBeIXTNVJHvJRxadLl05scfywBA4tBXOgo=;
  b=WjqwiUYx+cFlyQw1/8WTEtzwFYJ6cMA0GJOe5jnvmGAAWBS6pICsOTSA
   0eBfnSjj5NQcnv02Nm6G+lkQa0uuOAFne/wESHW3AHqbYV/Gs3ebh2awm
   iFZ5/Ag0817nHXzYK/vo9uz0hV6UeZSWEJZb5ODfM2Ypw5a+pqIErlZ5C
   vQ9M4dk0s7PoKUkXokI6eKVnuW3NcF8KaG/D0aeyhAP8iJGhgKeSGLfbu
   mUfOKvgDzyErV4CZhasWFxTAhrieNqIcwF24szLNIeUxq+xQRVluoUBCm
   75uKWyfqh44YSgFSG/mSWpY/XPEqBGDs7uBMs+7gCwUZqevwRPl9HCYGM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272710137"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="272710137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 22:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="637134128"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2022 22:25:36 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOuVj-00016Z-2M;
        Fri, 19 Aug 2022 05:25:35 +0000
Date:   Fri, 19 Aug 2022 13:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 f27a25312701380f4748e013e57afdb3076b71fe
Message-ID: <62ff1ec2.5pcZUIOniYKKp2sr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: f27a25312701380f4748e013e57afdb3076b71fe  Merge branch into tip/master: 'x86/timers'

elapsed time: 2811m

configs tested: 224
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20220817
arm                                 defconfig
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
arc                  randconfig-r043-20220815
x86_64                           rhel-8.3-kvm
alpha                            allyesconfig
m68k                             allyesconfig
i386                 randconfig-a003-20220815
x86_64                           rhel-8.3-syz
i386                 randconfig-a004-20220815
x86_64               randconfig-a001-20220815
arc                              allyesconfig
i386                 randconfig-a002-20220815
x86_64                              defconfig
x86_64               randconfig-a003-20220815
arm                              allyesconfig
i386                                defconfig
i386                 randconfig-a001-20220815
x86_64               randconfig-a005-20220815
arm64                            allyesconfig
i386                 randconfig-a006-20220815
x86_64               randconfig-a004-20220815
i386                 randconfig-a005-20220815
x86_64                               rhel-8.3
x86_64               randconfig-a002-20220815
x86_64               randconfig-a006-20220815
x86_64                           allyesconfig
ia64                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                             allyesconfig
sh                               allmodconfig
i386                             allyesconfig
powerpc                         wii_defconfig
sh                          landisk_defconfig
arm                         vf610m4_defconfig
parisc64                         alldefconfig
arm                         lubbock_defconfig
csky                                defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                 randconfig-c001-20220815
powerpc              randconfig-c003-20220815
m68k                        stmark2_defconfig
sh                        sh7757lcr_defconfig
mips                            gpr_defconfig
riscv                randconfig-r042-20220818
s390                 randconfig-r044-20220818
arc                  randconfig-r043-20220818
arm                         s3c6400_defconfig
riscv                    nommu_k210_defconfig
arm                            zeus_defconfig
nios2                         3c120_defconfig
sh                           se7712_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                             sh03_defconfig
arm                          simpad_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                        m5307c3_defconfig
i386                          randconfig-c001
arm                           stm32_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220818
m68k                          hp300_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8548_defconfig
arm                          pxa3xx_defconfig
mips                           ip32_defconfig
arm                            xcep_defconfig
sh                               alldefconfig
arc                          axs101_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       maple_defconfig
alpha                            alldefconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
sh                         ecovec24_defconfig
sh                        edosk7705_defconfig
arm                             ezx_defconfig
mips                        vocore2_defconfig
arm                        oxnas_v6_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                 nsimosci_hs_smp_defconfig
sh                         microdev_defconfig
sh                          lboxre2_defconfig
mips                      loongson3_defconfig
sh                          polaris_defconfig
arc                          axs103_defconfig
powerpc                      arches_defconfig
ia64                        generic_defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                      cm5200_defconfig
arm                           sunxi_defconfig
loongarch                        alldefconfig
m68k                                defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
sparc                             allnoconfig
m68k                         amcore_defconfig
xtensa                              defconfig
ia64                                defconfig
arm                           sama5_defconfig
um                                  defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
sparc                       sparc64_defconfig
m68k                           sun3_defconfig
sh                           sh2007_defconfig
arm                          gemini_defconfig
arm64                               defconfig
openrisc                       virt_defconfig
arm                          pxa910_defconfig
sh                        apsh4ad0a_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                          rsk7201_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
arm                        clps711x_defconfig
arm                      footbridge_defconfig
arm                            qcom_defconfig
arm                        realview_defconfig
arm                        keystone_defconfig
xtensa                  audio_kc705_defconfig
sparc                               defconfig
xtensa                           allyesconfig
sparc                            allyesconfig
x86_64                                  kexec
powerpc                  iss476-smp_defconfig
arm                         cm_x300_defconfig

clang tested configs:
riscv                randconfig-r042-20220817
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220817
riscv                randconfig-r042-20220815
hexagon              randconfig-r041-20220815
hexagon              randconfig-r045-20220817
s390                 randconfig-r044-20220815
s390                 randconfig-r044-20220817
i386                 randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a013-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a016-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a012-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a016-20220815
powerpc                      ppc64e_defconfig
powerpc                 mpc832x_mds_defconfig
s390                             alldefconfig
mips                          ath79_defconfig
arm                    vt8500_v6_v7_defconfig
x86_64               randconfig-k001-20220815
powerpc                     ksi8560_defconfig
mips                        omega2p_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        multi_v5_defconfig
mips                      pic32mzda_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
riscv                    nommu_virt_defconfig
mips                        qi_lb60_defconfig
x86_64                        randconfig-k001
powerpc                          g5_defconfig
arm64                            allyesconfig
arm                          ixp4xx_defconfig
arm                       versatile_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                          moxart_defconfig
mips                           ip22_defconfig
hexagon              randconfig-r045-20220818
hexagon              randconfig-r041-20220818
mips                          ath25_defconfig
powerpc                          allmodconfig
arm                             mxs_defconfig
arm                  colibri_pxa270_defconfig
hexagon                             defconfig
arm                         bcm2835_defconfig
arm                         s5pv210_defconfig
arm                         shannon_defconfig
riscv                randconfig-r042-20220819
s390                 randconfig-r044-20220819
hexagon              randconfig-r045-20220819
hexagon              randconfig-r041-20220819

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
