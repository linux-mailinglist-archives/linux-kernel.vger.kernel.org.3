Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078854E24C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377217AbiFPNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiFPNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:45:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DD03120C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655387114; x=1686923114;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ju6h7rgQB6lh017pku1L3ySHfZoceC68RJ6EoO0nhE0=;
  b=ZuKQF9xqjNZqaNo9msYv+nMzpwWxTLIxUrCPGTvdVMOeHWCLOnj7z7xd
   WC2XEs+YGC3U25F7Bioe73eIdbr9YEXsaf+8mSTnfeGdcdIQaQTeYWSVX
   UClGYtQhgGmKBk/JZQT+ArzfnU3xVWNKUStpB6aIxkEgLCbHo5+Jou2tv
   wSlA7gdBVUwAsrkx0icrcUvZaOFF3TgE5xnwtiY9U8QOpIvS0tloKlMTy
   xcZy6CHeIaX3gFKToydFlZOUYXInQBsjsvWlcYWgo/hm/jX5Un34vHsNn
   3iiUdApn5gcQKgzEK5z5aerfORscTkBHbASYdDOwQsCXStUS7LQQK05kC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259104597"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="259104597"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="589651322"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jun 2022 06:45:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1pnw-000OQ5-LZ;
        Thu, 16 Jun 2022 13:45:00 +0000
Date:   Thu, 16 Jun 2022 21:44:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.15b] BUILD SUCCESS
 acebd55c715587be8ca6655a70090a9205fc1388
Message-ID: <62ab33ca.LezuMs8j2FlIC8s7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.15b
branch HEAD: acebd55c715587be8ca6655a70090a9205fc1388  memory-model: Prohibit nested SRCU read-side critical sections

elapsed time: 727m

configs tested: 126
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
mips                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                         ap325rxa_defconfig
sh                      rts7751r2d1_defconfig
arm                        keystone_defconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
s390                          debug_defconfig
arm                         at91_dt_defconfig
sh                   secureedge5410_defconfig
um                                  defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      cm5200_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
m68k                        m5307c3_defconfig
arc                              allyesconfig
sh                          landisk_defconfig
sh                             shx3_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5249evb_defconfig
powerpc                      makalu_defconfig
m68k                       m5275evb_defconfig
arm                            xcep_defconfig
arm                         nhk8815_defconfig
xtensa                         virt_defconfig
arm                        clps711x_defconfig
arm                           sunxi_defconfig
mips                       capcella_defconfig
nios2                         10m50_defconfig
microblaze                      mmu_defconfig
arc                         haps_hs_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
mips                             allmodconfig
sparc                               defconfig
m68k                          hp300_defconfig
m68k                        stmark2_defconfig
powerpc                         wii_defconfig
arm                        trizeps4_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
arm                      integrator_defconfig
s390                                defconfig
powerpc                     pq2fads_defconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath25_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8540_defconfig
powerpc                       ebony_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    socrates_defconfig
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
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
