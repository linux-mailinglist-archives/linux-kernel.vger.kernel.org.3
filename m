Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2245B10FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIHA0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIHA0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:26:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAA2C2E9B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662596803; x=1694132803;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4VOaq0fqoiwbbQNqM2KZ/LJRb7qiSdsMjH1FbutKIDU=;
  b=GL1+2DCD1rgXrm8RohaxpgOeYz626R4CTqRR9xSTUkasW4Yt13fNGuzi
   2bt+jgK4yII4mleCL0lLNrkkssouQJGw6LbUSU3h9IeQglc+TaxynE0ja
   GjcJB3cE8/y+fnk7cKtQrV6uPEm8rF+u1PhvUeRK0m4J+SQTzn1tq2LP1
   kiLG/nXB2+uAhFpcBgmi9i7rtOA8sFh2gnWbD/Xxvb5OUs1ajKwAg4os2
   SftlKguOS2Kz/prFCt1anPTChADZXAsgcm1fugo9Ii77tSv+rL36rF1aE
   OBMMFIr8uFEWo3NwJlniZkkUwnupVZvOB48UFT7kxqlQP3b5OT39Eq1+Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="277420035"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="277420035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="943118718"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2022 17:26:40 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW5NP-00079D-1u;
        Thu, 08 Sep 2022 00:26:39 +0000
Date:   Thu, 08 Sep 2022 08:25:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 7139c19d2ea117976aa892de4fb75682e989ba12
Message-ID: <6319368e.CBRQfV9BYQt5TqA1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 7139c19d2ea117976aa892de4fb75682e989ba12  rcu: Synchronize ->qsmaskinitnext in rcu_boost_kthread_setaffinity()

elapsed time: 1723m

configs tested: 194
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
riscv                randconfig-r042-20220906
arc                  randconfig-r043-20220906
s390                 randconfig-r044-20220906
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                           se7750_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
sh                           se7705_defconfig
i386                          randconfig-c001
powerpc                      bamboo_defconfig
powerpc                      makalu_defconfig
arc                         haps_hs_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
nios2                         10m50_defconfig
arc                          axs103_defconfig
xtensa                          iss_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
csky                             alldefconfig
m68k                                defconfig
powerpc                     pq2fads_defconfig
alpha                               defconfig
sh                          r7780mp_defconfig
sparc                       sparc64_defconfig
parisc64                            defconfig
powerpc                 canyonlands_defconfig
arm                           viper_defconfig
arm                         lubbock_defconfig
m68k                       m5475evb_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
s390                             allmodconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                              defconfig
m68k                        mvme16x_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
powerpc                mpc7448_hpc2_defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
arm                          iop32x_defconfig
mips                           ip32_defconfig
sh                            titan_defconfig
sh                     sh7710voipgw_defconfig
sh                          rsk7264_defconfig
sh                 kfr2r09-romimage_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
powerpc                 mpc837x_mds_defconfig
m68k                          hp300_defconfig
sh                   sh7724_generic_defconfig
powerpc                  storcenter_defconfig
powerpc                      tqm8xx_defconfig
sh                  sh7785lcr_32bit_defconfig
openrisc                            defconfig
arm                            mps2_defconfig
s390                                defconfig
arc                                 defconfig
s390                             allyesconfig
m68k                          atari_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                      rts7751r2d1_defconfig
sh                          landisk_defconfig
arm                           u8500_defconfig
ia64                             alldefconfig
powerpc                    sam440ep_defconfig
m68k                          amiga_defconfig
m68k                        stmark2_defconfig
sh                                  defconfig
mips                     loongson1b_defconfig
xtensa                         virt_defconfig
ia64                         bigsur_defconfig
arm                        keystone_defconfig
m68k                          multi_defconfig
arm                             pxa_defconfig
mips                           gcw0_defconfig
parisc64                         alldefconfig
sparc                               defconfig
i386                             alldefconfig
powerpc                     ep8248e_defconfig
m68k                        m5272c3_defconfig
arm                          exynos_defconfig
sparc                             allnoconfig
powerpc                      arches_defconfig
openrisc                 simple_smp_defconfig
powerpc                     asp8347_defconfig
sparc                            alldefconfig
arm                          pxa3xx_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arm64                            alldefconfig
sh                           se7722_defconfig
sh                             sh03_defconfig
xtensa                       common_defconfig
sh                          r7785rp_defconfig
powerpc                     mpc83xx_defconfig
xtensa                generic_kc705_defconfig
csky                                defconfig
um                                  defconfig
arm                            qcom_defconfig
ia64                          tiger_defconfig
arc                              alldefconfig
xtensa                           allyesconfig
x86_64                                  kexec
x86_64                        randconfig-c001
arm                  randconfig-c002-20220907
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                       spear13xx_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     davinci_all_defconfig
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
x86_64                        randconfig-k001
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
arm                              alldefconfig
powerpc                        icon_defconfig
powerpc                      obs600_defconfig
powerpc                     tqm5200_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
riscv                randconfig-r042-20220907
hexagon              randconfig-r041-20220907
hexagon              randconfig-r045-20220907
s390                 randconfig-r044-20220907
powerpc                     tqm8540_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           ip22_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
