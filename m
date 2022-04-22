Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CBE50ADF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443511AbiDVCrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443516AbiDVCr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:47:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0BE4CD46
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650595477; x=1682131477;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GJiwExnw2IafD02a1HNsPSHGWBmXbRwNr9H/jzVEfLY=;
  b=RebRQsbdl2crTuA/k6xiTMu/G0gGrukUbV8r9wHHqslS+1J0W02Vecwv
   p5hpQqxPKTNmuFifXemfGXkqRRc3DglgnC4xioBj9XOuHt9rCHkRANa5A
   9VylaaPno3jsFK34l2uCaOviU8GIJ8h6hYQ6W2pIz9wpZ4zZgbUrSWULl
   cSKP27rDbnI4C1k/vT23lURghqtPWOeJx/VHVts7c/P/zO0J6Q/qfmoIf
   C9gETEzpRK44I5m/JEcfuhDQK5HPArMQxJgbgKjjXI4mwcNh9mqZ6tHcM
   47zQnUisIasYPbGSq7YHPiFSTyGnAcbHKYQRx1KcDSKUxLTjq3td16J96
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262147704"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="262147704"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 19:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="805790258"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2022 19:44:36 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhjHf-00098U-EN;
        Fri, 22 Apr 2022 02:44:35 +0000
Date:   Fri, 22 Apr 2022 10:43:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 9617f2f48310f2f341a9a0ebbc2dcfe1e88031a2
Message-ID: <62621657.PWCXywsBgvhd8blt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 9617f2f48310f2f341a9a0ebbc2dcfe1e88031a2  virt: sevguest: Rename the sevguest dir and files to sev-guest

elapsed time: 887m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                     asp8347_defconfig
sh                           se7712_defconfig
powerpc                     ep8248e_defconfig
sh                   sh7724_generic_defconfig
powerpc                       ppc64_defconfig
sh                          rsk7269_defconfig
mips                     loongson1b_defconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
arm                        keystone_defconfig
powerpc                  storcenter_defconfig
mips                        bcm47xx_defconfig
sh                          polaris_defconfig
arm                        spear6xx_defconfig
mips                            ar7_defconfig
powerpc                     pq2fads_defconfig
arm                           stm32_defconfig
xtensa                    smp_lx200_defconfig
mips                           xway_defconfig
xtensa                          iss_defconfig
microblaze                          defconfig
powerpc                      arches_defconfig
xtensa                  cadence_csp_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220421
ia64                             allmodconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220421
s390                 randconfig-r044-20220421
riscv                randconfig-r042-20220421
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
riscv                randconfig-c006-20220421
mips                 randconfig-c004-20220421
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220421
powerpc              randconfig-c003-20220421
powerpc                      ppc64e_defconfig
mips                           rs90_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8560_defconfig
arm                              alldefconfig
hexagon                          alldefconfig
arm                     davinci_all_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
