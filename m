Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8053D655
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiFDJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiFDJ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:58:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE5237F5
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654336711; x=1685872711;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PWwSsRjGoSCzmi402BF0hUhp+FIMbSJmczyG3tzibzc=;
  b=cWzuHqoMB+lyHNFyO/1oosVynWPl0Y4+3QPmLTHiBhlvtAlD7frjod1J
   oggIO2iPGYuDMzEE+hTPLB+tDFCEDosIwflhNPZVu8un4JyYzA943JN1S
   x3EpZaEGe/ohUubcLLTEeANssYDzHdgjdnFDKc4J1GbH3zRSmTgA9Zuw9
   p01AGB3clv+JO8igJPU9wBpp080HcyvUhmtbjK5KjirprmdtvBsIyR5Hf
   DsKugTVzf/SMhtuO+UbVKSxGYdFJud3jnLuAi3HAhOnrMmmPdwN1h4r2e
   RQoJT04Z2bTQHDE0hUgWacxES7ndNQWrZ1j4OXITk8s1w61qpRDEYa570
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="301795845"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="301795845"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 02:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="708382840"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2022 02:58:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxQY8-000AcZ-QA;
        Sat, 04 Jun 2022 09:58:28 +0000
Date:   Sat, 04 Jun 2022 17:57:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 77b2c072dd466f6332189c9057bcca155e6d529c
Message-ID: <629b2c9d.0d8pqQBkQZT3jMW+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 77b2c072dd466f6332189c9057bcca155e6d529c  Merge branch 'linus' into x86/cleanups, to resolve conflict

elapsed time: 1414m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc64                           defconfig
mips                      loongson3_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                           ip32_defconfig
sh                        dreamcast_defconfig
powerpc                     mpc83xx_defconfig
s390                             allmodconfig
arm                        multi_v7_defconfig
arc                              alldefconfig
xtensa                    smp_lx200_defconfig
sh                           sh2007_defconfig
powerpc                       maple_defconfig
arm                        trizeps4_defconfig
m68k                            q40_defconfig
arm                           u8500_defconfig
sh                   rts7751r2dplus_defconfig
sh                              ul2_defconfig
arm                        keystone_defconfig
arm                        cerfcube_defconfig
xtensa                    xip_kc705_defconfig
arc                    vdk_hs38_smp_defconfig
openrisc                 simple_smp_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220603
ia64                                defconfig
ia64                             allmodconfig
riscv                             allnoconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
mips                             allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
powerpc                          allyesconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
um                             i386_defconfig
arm64                            allyesconfig
ia64                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                          randconfig-a012
arc                  randconfig-r043-20220531
riscv                randconfig-r042-20220531
s390                 randconfig-r044-20220531
x86_64                    rhel-8.3-kselftests
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc              randconfig-c003-20220603
x86_64                        randconfig-c007
riscv                randconfig-c006-20220603
i386                          randconfig-c001
s390                 randconfig-c005-20220603
mips                 randconfig-c004-20220603
arm                  randconfig-c002-20220603
mips                malta_qemu_32r6_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                         shannon_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220603
s390                 randconfig-r044-20220603
riscv                randconfig-r042-20220603
hexagon              randconfig-r041-20220603
i386                          randconfig-a011
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
