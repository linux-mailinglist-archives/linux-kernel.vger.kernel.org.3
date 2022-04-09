Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9BA4FA553
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiDIGMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiDIGMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:12:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5750E11
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649484600; x=1681020600;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y9fFMSbHT3dSK74mWR/kmrJc9IJkM9rjzo0StktOQYk=;
  b=JCHSQDgDnbz1nqSRvgs1RtwBywAjLPPn6nNL/6E+dKBouZwWmE5XoCRl
   L2657ZQw0PtIiW6BLpy4RG53PYcF30Pe3qjkafTWIWS5Eke6F7SmIf2bs
   BwkyMlbXtcA+hD543VklRJ+kzDA3UZYZ20GAQbb2XZE3F/Z3yhb+Ji01b
   aBXjzFHLegTCY95y5eslBsvQuRflvyLHh/z5AuNwt+a34GpHPrNeFoBJB
   BhhXrTDgENS2UHTxUDpVZZ3pItsFDkut9aPjiVmQS6cmoaG4aw4r7QwLc
   7DEQqPZO6zeU2UB619ESgJfqKiV2qRZxuAfYD1O/98InFkF+RGDNB98Kk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="286762995"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="286762995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 23:09:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="653611830"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2022 23:09:58 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd4IH-0000wu-Mx;
        Sat, 09 Apr 2022 06:09:57 +0000
Date:   Sat, 09 Apr 2022 14:09:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 b9c7ba58777acfd0892b808aea25074d46e0618f
Message-ID: <62512315./GmcXraRDJOKks+9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: b9c7ba58777acfd0892b808aea25074d46e0618f  Documentation/x86: Document TDX kernel architecture

elapsed time: 722m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
microblaze                      mmu_defconfig
powerpc                    sam440ep_defconfig
xtensa                              defconfig
sh                        edosk7760_defconfig
h8300                            alldefconfig
sh                           se7722_defconfig
arc                          axs103_defconfig
m68k                        m5407c3_defconfig
powerpc                    adder875_defconfig
sh                            migor_defconfig
arm64                            alldefconfig
nios2                         10m50_defconfig
mips                    maltaup_xpa_defconfig
sh                           se7206_defconfig
powerpc                      chrp32_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
sh                        sh7785lcr_defconfig
arm                          exynos_defconfig
s390                       zfcpdump_defconfig
xtensa                generic_kc705_defconfig
ia64                             allmodconfig
arc                     haps_hs_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                  nommu_kc705_defconfig
h8300                       h8s-sim_defconfig
parisc                generic-32bit_defconfig
mips                         db1xxx_defconfig
mips                         cobalt_defconfig
arm                            qcom_defconfig
arm                  randconfig-c002-20220408
x86_64                        randconfig-c001
ia64                             allyesconfig
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
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220408
s390                 randconfig-r044-20220408
riscv                randconfig-r042-20220408
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220408
powerpc              randconfig-c003-20220408
riscv                randconfig-c006-20220408
mips                 randconfig-c004-20220408
arm                  randconfig-c002-20220408
arm                     am200epdkit_defconfig
mips                      pic32mzda_defconfig
powerpc                     pseries_defconfig
powerpc                   bluestone_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8560_ads_defconfig
mips                malta_qemu_32r6_defconfig
mips                        qi_lb60_defconfig
mips                     cu1000-neo_defconfig
riscv                             allnoconfig
mips                   sb1250_swarm_defconfig
mips                     loongson1c_defconfig
powerpc                       ebony_defconfig
powerpc                     mpc5200_defconfig
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
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220408
hexagon              randconfig-r041-20220408

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
