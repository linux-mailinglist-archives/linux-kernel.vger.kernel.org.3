Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8F550825
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 05:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiFSDov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 23:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiFSDor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:44:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58835F5BF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 20:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655610286; x=1687146286;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5QMUnGB6y+SFMHJS9npqrBv+vhYanQVroTSP8A+cC6U=;
  b=NczspYiAZVcGXwBYVmCIAISEhB5mF6AiKQc6V28eYKrflz+GiNo5EUJs
   I0in4PrfXPRlKuXnhkkwknbNEoeQRu3V6rhYwzDj8LStdNrM/h3rt8iow
   QtiAicvsYh0c8/S5eBgX5fFZxdD6iKoM0pI0pjiqRu3p2/lFfADGHpjrZ
   al1/E/7EyVmFpYxLohK8AssX3Mq5pbnGZ3eRdjJIr9AwhDr20+dTzqhGf
   5+cmCVlPozk1XaAs25Hk6tHi77ZLvldQCz6d7c1YPHx6cRSHAWcMccfuN
   dsUNVCdSMSXgZMkW8vMmvknDWHVqy4wIMSJvx6N2NSYSGuRuJsnqlN56p
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280430070"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280430070"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 20:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="561410445"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2022 20:44:44 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2lrf-000Qqb-V8;
        Sun, 19 Jun 2022 03:44:43 +0000
Date:   Sun, 19 Jun 2022 11:44:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.16a] BUILD SUCCESS
 6a69e757b6a65bb81f1f7d12083668dddd3ba930
Message-ID: <62ae9ba8.zOGt0+Ie5WkjJxBm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.16a
branch HEAD: 6a69e757b6a65bb81f1f7d12083668dddd3ba930  rcu: Avoid reporting strict QSes from NMI context

elapsed time: 1320m

configs tested: 175
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
s390                       zfcpdump_defconfig
sh                           se7751_defconfig
sh                            migor_defconfig
mips                            gpr_defconfig
arm                         axm55xx_defconfig
powerpc                  storcenter_defconfig
mips                           xway_defconfig
openrisc                  or1klitex_defconfig
powerpc                    adder875_defconfig
sh                           se7724_defconfig
x86_64                              defconfig
powerpc                         ps3_defconfig
sh                          r7780mp_defconfig
sh                           sh2007_defconfig
arm                         assabet_defconfig
alpha                            alldefconfig
arm                          pxa910_defconfig
arm                            mps2_defconfig
parisc                generic-64bit_defconfig
sh                            titan_defconfig
mips                           ip32_defconfig
xtensa                              defconfig
um                             i386_defconfig
powerpc                         wii_defconfig
sh                              ul2_defconfig
nios2                            alldefconfig
arm                           sunxi_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
arm                            qcom_defconfig
arm                      jornada720_defconfig
m68k                        mvme147_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                       maple_defconfig
m68k                          hp300_defconfig
powerpc                       eiger_defconfig
arm                            pleb_defconfig
mips                     loongson1b_defconfig
mips                     decstation_defconfig
arm                        trizeps4_defconfig
powerpc                  iss476-smp_defconfig
xtensa                  cadence_csp_defconfig
xtensa                  audio_kc705_defconfig
arm                            zeus_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
powerpc                       holly_defconfig
powerpc                        warp_defconfig
m68k                           sun3_defconfig
xtensa                         virt_defconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
sh                               alldefconfig
openrisc                            defconfig
arc                      axs103_smp_defconfig
m68k                         amcore_defconfig
riscv                               defconfig
mips                      maltasmvp_defconfig
mips                  decstation_64_defconfig
m68k                          multi_defconfig
xtensa                generic_kc705_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
csky                             alldefconfig
sh                        sh7763rdp_defconfig
m68k                       m5249evb_defconfig
m68k                             alldefconfig
ia64                            zx1_defconfig
parisc64                         alldefconfig
sh                            shmin_defconfig
m68k                          atari_defconfig
nios2                            allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220617
arm                  randconfig-c002-20220619
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                randconfig-r042-20220619
arc                  randconfig-r043-20220619
s390                 randconfig-r044-20220619
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                          pcm027_defconfig
powerpc                    gamecube_defconfig
arm                       spear13xx_defconfig
powerpc                     tqm8560_defconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc8272_ads_defconfig
arm                          moxart_defconfig
powerpc                   lite5200b_defconfig
mips                      maltaaprp_defconfig
arm                                 defconfig
powerpc                       ebony_defconfig
arm                             mxs_defconfig
s390                             alldefconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          allmodconfig
riscv                          rv32_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220617
hexagon              randconfig-r045-20220617

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
