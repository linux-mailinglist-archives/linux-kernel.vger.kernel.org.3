Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD515A5A12
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3Dds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiH3DdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:33:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3964B0EE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661830383; x=1693366383;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/RD3mo+ZIkEnMQJAuGYKB2qgeLq50V390erl+ZAAVPI=;
  b=NBEKdn1mlOsu7Bdh6hcbu8NbaIRrJWwCKj9HwQgOGGygUwpvVBXoyclW
   oH0j3mEBb6asvwfKfJoLStm4OfofAbWH22XdRhUGwq+fDaP4oiFEw9ghO
   VIYiQWloI96DVkpIi7OtmMvh8kS/XbMMF4xA6SclFqPBYXbij8x+0d1OG
   0VpKk0w6Ueef6STrJ5W4nYHZK+YE0jziXy1EIoZtxxwlk3XSxgkOsCfQG
   2wUmwBtz2ErbnYSkiEbiRF6ZWjSJOjHGI6OdNF5+sRZ0/VN73xvRLfvYD
   4YYNhNrIxraj+tZRPYMAzib2fAiAqX0p/qMaa9DJR+P8NUbEYHbvO8H2p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321194923"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="321194923"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 20:32:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="715140457"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2022 20:32:57 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSrzl-0000UV-0F;
        Tue, 30 Aug 2022 03:32:57 +0000
Date:   Tue, 30 Aug 2022 11:32:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.08.26a] BUILD SUCCESS
 3b47e7a1675d4ac5cc51b20b7356a53947768b70
Message-ID: <630d84da.5DNthz4wcOiKHuQV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.08.26a
branch HEAD: 3b47e7a1675d4ac5cc51b20b7356a53947768b70  torture: Use mktemp instead of guessing at unique names

elapsed time: 3234m

configs tested: 181
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
um                             i386_defconfig
loongarch                           defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                         debian-10.3-func
i386                        debian-10.3-kunit
x86_64                        randconfig-a002
parisc                           allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a015
i386                          debian-10.3-kvm
i386                          randconfig-a003
parisc64                            defconfig
parisc                              defconfig
arc                              allyesconfig
csky                              allnoconfig
arc                  randconfig-r043-20220828
alpha                            allyesconfig
i386                          randconfig-a014
nios2                               defconfig
x86_64                        randconfig-a004
x86_64                              defconfig
x86_64                           allyesconfig
i386                          randconfig-a012
nios2                            allyesconfig
riscv                             allnoconfig
i386                          randconfig-a005
x86_64                        randconfig-a006
i386                          randconfig-a016
s390                 randconfig-r044-20220828
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
i386                   debian-10.3-kselftests
m68k                             allyesconfig
powerpc                          allyesconfig
i386                              debian-10.3
riscv                            allyesconfig
x86_64                               rhel-8.3
m68k                             allmodconfig
riscv                    nommu_k210_defconfig
riscv                               defconfig
arc                               allnoconfig
csky                                defconfig
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20220828
sparc                               defconfig
x86_64                         rhel-8.3-kunit
alpha                             allnoconfig
arc                                 defconfig
x86_64                                  kexec
powerpc                          allmodconfig
s390                             allmodconfig
sparc                            allyesconfig
alpha                               defconfig
mips                             allyesconfig
s390                                defconfig
i386                                defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
sh                               allmodconfig
arm                                 defconfig
x86_64                           alldefconfig
arm                         nhk8815_defconfig
xtensa                           alldefconfig
i386                             allyesconfig
arm                              allyesconfig
arm                          gemini_defconfig
mips                         cobalt_defconfig
arm64                            allyesconfig
arm                         lpc18xx_defconfig
powerpc                        warp_defconfig
mips                     loongson1b_defconfig
ia64                             allmodconfig
arc                 nsimosci_hs_smp_defconfig
sh                           se7750_defconfig
mips                    maltaup_xpa_defconfig
sh                        edosk7705_defconfig
powerpc                         ps3_defconfig
i386                          randconfig-c001
arm64                               defconfig
ia64                                defconfig
xtensa                           allyesconfig
m68k                                defconfig
arm                              allmodconfig
mips                             allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220828
powerpc                      mgcoge_defconfig
sh                            titan_defconfig
xtensa                              defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
s390                       zfcpdump_defconfig
arm                           stm32_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                          axs103_defconfig
openrisc                 simple_smp_defconfig
i386                             alldefconfig
sh                        dreamcast_defconfig
sh                            hp6xx_defconfig
xtensa                  nommu_kc705_defconfig
mips                     decstation_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                generic_kc705_defconfig
sh                             sh03_defconfig
arm                         s3c6400_defconfig
powerpc                      makalu_defconfig
x86_64               randconfig-a003-20220829
arm                         vf610m4_defconfig
x86_64               randconfig-a002-20220829
x86_64               randconfig-a001-20220829
x86_64               randconfig-a004-20220829
arc                  randconfig-r043-20220829
powerpc                      tqm8xx_defconfig
x86_64               randconfig-a005-20220829
powerpc                     tqm8548_defconfig
x86_64               randconfig-a006-20220829
i386                 randconfig-a004-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
i386                 randconfig-a002-20220829
xtensa                          iss_defconfig
arm                          badge4_defconfig
powerpc                    amigaone_defconfig
powerpc                  storcenter_defconfig
sh                        sh7785lcr_defconfig

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a001
x86_64                        randconfig-a014
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a002
i386                          randconfig-a004
hexagon              randconfig-r041-20220828
i386                          randconfig-a011
x86_64                        randconfig-a005
i386                          randconfig-a015
hexagon              randconfig-r045-20220828
i386                          randconfig-a006
arm                          sp7021_defconfig
arm                  colibri_pxa270_defconfig
arm                       spear13xx_defconfig
arm                     am200epdkit_defconfig
x86_64                        randconfig-k001
riscv                    nommu_virt_defconfig
arm                     davinci_all_defconfig
powerpc                    ge_imp3a_defconfig
riscv                            alldefconfig
mips                        qi_lb60_defconfig
arm                         shannon_defconfig
mips                        bcm63xx_defconfig
hexagon              randconfig-r041-20220829
powerpc                     pseries_defconfig
riscv                randconfig-r042-20220829
i386                 randconfig-a015-20220829
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220829
i386                 randconfig-a016-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
mips                           ip28_defconfig
arm                        vexpress_defconfig
arm                         socfpga_defconfig
powerpc                 xes_mpc85xx_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
