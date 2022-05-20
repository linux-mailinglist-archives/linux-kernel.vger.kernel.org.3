Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1363852F618
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354042AbiETXU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349382AbiETXUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:20:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254971A35BE
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653088821; x=1684624821;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=c9BIW73hx5JonUVl23AHcBlgkTJnCAYOnWIJ1KF82FI=;
  b=QQSrfPhWeFlRdhesAzW1IcqsZADMmuuMv+CPWJbV16ZFHJDQRWWxfTkV
   eG1nyz6g1xnbDJx/GpHNxQgDu/CtKw1YbDsdzDzbO1tTlqbIQj2F0mWab
   E30Ldd6YAzSSjA/dUmfCxGybKPREIo+jThVMgnnDWpIzSF5NQ6fhdmjzI
   z/o+aGHUOgfu8Spd7/ip4ggAaQb49HMW/HUC0mtfM0SyqyDC6scVIQdde
   I3aWs6YADX2kKcfA5khKFvZ6HLUI84QT6rEUmbrnZ4BqzHpIf+JsOxvcx
   r9OBznLNR+5Jg9NnX1h74u6v/HY8ULR6xIG4h53uPs44jF5OTBvUtsrFd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270350823"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="270350823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 16:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="524870580"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2022 16:20:19 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsBus-0005bW-8U;
        Fri, 20 May 2022 23:20:18 +0000
Date:   Sat, 21 May 2022 07:20:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 c796f02162e428b595ff70196dca161ee46b163b
Message-ID: <62882231.8NgygejD19hvyPbu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: c796f02162e428b595ff70196dca161ee46b163b  x86/tdx: Fix RETs in TDX asm

elapsed time: 731m

configs tested: 142
configs skipped: 65

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                               j2_defconfig
mips                           ci20_defconfig
xtensa                          iss_defconfig
s390                             allyesconfig
ia64                        generic_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
mips                  maltasmvp_eva_defconfig
h8300                            allyesconfig
powerpc                     asp8347_defconfig
arm                          badge4_defconfig
um                                  defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc                    klondike_defconfig
powerpc64                           defconfig
powerpc                        warp_defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
sh                           se7619_defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
alpha                            allyesconfig
powerpc                      ep88xc_defconfig
h8300                       h8s-sim_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc834x_mds_defconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
m68k                            q40_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
arm                             pxa_defconfig
m68k                        mvme147_defconfig
m68k                       bvme6000_defconfig
m68k                       m5208evb_defconfig
powerpc                      mgcoge_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
sh                          sdk7786_defconfig
m68k                          sun3x_defconfig
sh                        sh7757lcr_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a005
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220519
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
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz

clang tested configs:
s390                 randconfig-c005-20220519
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
mips                     loongson2k_defconfig
arm                         s5pv210_defconfig
powerpc                   bluestone_defconfig
powerpc                      katmai_defconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
arm                        mvebu_v5_defconfig
arm                              alldefconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20220519
hexagon              randconfig-r045-20220519
riscv                randconfig-r042-20220519
hexagon              randconfig-r041-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
