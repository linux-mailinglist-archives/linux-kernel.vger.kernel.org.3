Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E174D6C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiCLDAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 22:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLDAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:00:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90F2254AA0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 18:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647053949; x=1678589949;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=HmpLRb7NG49YJMVKARq0Vu5+P5oofbHZ5SXTFLIsgio=;
  b=Jc6/c/pdBqn4/Mv6+jXxPMga0y0TaNxk5KbnSzaDmjjrnxyX6TH3XF/Z
   M55UyqudCThLskFfvMNBkVbQVLrCSsAFIyhnoNeFB9oaV1C9UXW1vXG25
   mui8HtWO/ZxSW8E1lmdaXEPQ2HbTs87EMT1RNZ4NWkSbnh3huT7jEaIIt
   tvji7HrnQt00/05yq/7N+RNpP3vBfYmkoihTmQKIBI1vR1Zbvgv3Fk0Aa
   bHAIuSeWgc2gwFShh07tyuIOJEncnSaCKn8y243OcbD/OQaMX0g1TE5BP
   JhO+NfTJ+fGT82Ve3YGx4czQVB9DZx2Y808esU/9niV0VLhheDC2qThn7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="254556575"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="254556575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 18:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="496987280"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2022 18:59:08 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSryF-0007RH-6a; Sat, 12 Mar 2022 02:59:07 +0000
Date:   Sat, 12 Mar 2022 10:58:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 f9444ea5e20847d1dd4a98d4dff4cc97655834bb
Message-ID: <622c0c4f.Cw3FpTSAL5H2vzDW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: f9444ea5e20847d1dd4a98d4dff4cc97655834bb  x86: Remove a.out support

elapsed time: 730m

configs tested: 96
configs skipped: 90

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                           h3600_defconfig
riscv                            allmodconfig
powerpc                 mpc85xx_cds_defconfig
arm                       omap2plus_defconfig
sh                            titan_defconfig
parisc                generic-64bit_defconfig
mips                    maltaup_xpa_defconfig
mips                           gcw0_defconfig
sh                        apsh4ad0a_defconfig
m68k                           sun3_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                        mvme16x_defconfig
arc                           tb10x_defconfig
arm                           viper_defconfig
powerpc                       ppc64_defconfig
ia64                      gensparse_defconfig
mips                      fuloong2e_defconfig
powerpc                   motionpro_defconfig
h8300                     edosk2674_defconfig
arm                           stm32_defconfig
mips                 decstation_r4k_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20220310
arm                  randconfig-c002-20220312
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220310
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220310
riscv                randconfig-c006-20220310
mips                 randconfig-c004-20220310
i386                          randconfig-c001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
