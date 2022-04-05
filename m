Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F1D4F49CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450609AbiDEW2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiDEN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:59:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE514FBAA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649163434; x=1680699434;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2q7sW0rn8Ns+LywvaZX0V3eZDG1xfvT+nNNN6muh2nE=;
  b=IdO+f9gIa/5Iij4M7458Pob8Gk6HKI4ZcRcoPZqW21AJxsowTYoEpRf0
   IUynjdcL3TKkqT4TzDlE2dNB4WZvVF4elGiDaTgax7gQyRVcoiYea8QtN
   Z6UeekjPeoow9djqv4z1B4V1zDP+npwm4zZdyynEWQqJe8U6lEEqU4ppB
   yKksr7XWAj5o4nFYX6UN1exXjqSPSQXDg5in5xFf5GPXfgSP02C4vWGdi
   7cHaIHoexwbW3+fWOh+5XyrAX79TT2XYgcwyuMcrSKlwcsrKVEptsAd4h
   N7YZg5GZRtiiDodmkAiMppLqMViGt/Z/oGQrilgo276lAybPx/1RNY5qP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="242882813"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="242882813"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 05:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523982834"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 05:57:12 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbikB-0003IJ-Vt;
        Tue, 05 Apr 2022 12:57:11 +0000
Date:   Tue, 05 Apr 2022 20:56:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 5a0893088a20252cc268cbeabb25e883c2b6f94f
Message-ID: <624c3c78.6HPriL6iyFZbaf0s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 5a0893088a20252cc268cbeabb25e883c2b6f94f  x86/pkeys: Remove __arch_set_user_pkey_access() declaration

elapsed time: 725m

configs tested: 140
configs skipped: 89

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                         at91_dt_defconfig
sh                           se7751_defconfig
mips                        vocore2_defconfig
arm                         lpc18xx_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
arm                       imx_v6_v7_defconfig
arc                        vdk_hs38_defconfig
m68k                       m5475evb_defconfig
sh                             sh03_defconfig
powerpc                         wii_defconfig
arm                             ezx_defconfig
mips                  maltasmvp_eva_defconfig
sh                          sdk7786_defconfig
powerpc                        cell_defconfig
powerpc                      chrp32_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                          tiger_defconfig
powerpc                     stx_gp3_defconfig
parisc                           alldefconfig
powerpc                  storcenter_defconfig
powerpc                      tqm8xx_defconfig
arm                            hisi_defconfig
arm                        keystone_defconfig
xtensa                    smp_lx200_defconfig
m68k                          multi_defconfig
xtensa                       common_defconfig
mips                           jazz_defconfig
sh                ecovec24-romimage_defconfig
sh                     magicpanelr2_defconfig
sh                        edosk7760_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                generic_kc705_defconfig
arm                       multi_v4t_defconfig
mips                         cobalt_defconfig
m68k                         apollo_defconfig
mips                         tb0226_defconfig
m68k                        mvme147_defconfig
ia64                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220405
ia64                             allmodconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
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
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220405
riscv                randconfig-c006-20220405
mips                 randconfig-c004-20220405
arm                  randconfig-c002-20220405
arm                          moxart_defconfig
powerpc                        icon_defconfig
mips                      pic32mzda_defconfig
arm                         socfpga_defconfig
mips                      maltaaprp_defconfig
powerpc                   bluestone_defconfig
arm                  colibri_pxa300_defconfig
mips                     loongson1c_defconfig
arm                        neponset_defconfig
mips                           rs90_defconfig
arm                         s3c2410_defconfig
mips                         tb0219_defconfig
arm                       spear13xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a006
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220405
riscv                randconfig-r042-20220405
hexagon              randconfig-r041-20220405

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
