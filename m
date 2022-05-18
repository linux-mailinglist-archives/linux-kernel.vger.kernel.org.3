Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6352B8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiERLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiERLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:34:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989B178549
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652873673; x=1684409673;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=chfxsfqqx6UW0S3OYhECYveYnJLSaTg3JUufhYxCG4s=;
  b=i1JonZ4XXb0U8bbZYvSUnNewmuqdvyZs6ciKqwKi8JlgWih7SJobYsTO
   bu8tH0gBBP8yZoM2dlboNZhSn72PCX/xbEzddukXNi5wEzaTlWRryF0HN
   d+GSrz6G7Ydg9baSGGDwtygzQmXsSfSSVg/oX2jry8Ta5OOuGzs2DlSzO
   f/SNHnQtMrHtWU7bIstdoli21mBUapM+2iBqNgDLl8AaIsZafINAy3wEX
   DuSSB9lqXs+3sqRbDMivDvebdMberux9QNBB9AHdRByKoIq38fEX0gKB5
   JQ8jtW93UmFTEk+gjVp7JhsdXJI6srpLONGhifJvEBU1rG4TTVQBeaaC0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332246407"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="332246407"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 04:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="523474206"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 May 2022 04:34:31 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrHwl-00027h-6x;
        Wed, 18 May 2022 11:34:31 +0000
Date:   Wed, 18 May 2022 19:33:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 0621210ab7693e6d50585ca689d95d57df617455
Message-ID: <6284d9a6.HWv21SWIARfnPT0l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/sev
branch HEAD: 0621210ab7693e6d50585ca689d95d57df617455  x86/sev: Remove duplicated assignment to variable info

elapsed time: 1424m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220516
m68k                        m5407c3_defconfig
m68k                             allmodconfig
m68k                       m5208evb_defconfig
sh                             sh03_defconfig
m68k                       m5249evb_defconfig
sparc                       sparc64_defconfig
s390                             allyesconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
powerpc                     pq2fads_defconfig
sh                         ecovec24_defconfig
mips                            gpr_defconfig
sh                               j2_defconfig
mips                           ci20_defconfig
openrisc                            defconfig
arm                            mps2_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                          amiga_defconfig
arm                             pxa_defconfig
arm                         cm_x300_defconfig
sh                   sh7770_generic_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
parisc64                            defconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a012-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a016-20220516
x86_64               randconfig-a015-20220516
i386                 randconfig-a011-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a014-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a016-20220516
arc                  randconfig-r043-20220516
riscv                randconfig-r042-20220516
s390                 randconfig-r044-20220516
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
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc              randconfig-c003-20220518
x86_64                        randconfig-c007
riscv                randconfig-c006-20220518
mips                 randconfig-c004-20220518
i386                          randconfig-c001
arm                  randconfig-c002-20220518
powerpc                     pseries_defconfig
powerpc                    mvme5100_defconfig
arm                     davinci_all_defconfig
x86_64               randconfig-a001-20220516
x86_64               randconfig-a006-20220516
x86_64               randconfig-a003-20220516
x86_64               randconfig-a005-20220516
x86_64               randconfig-a002-20220516
x86_64               randconfig-a004-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a003-20220516
i386                 randconfig-a005-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a006-20220516
i386                 randconfig-a002-20220516
hexagon              randconfig-r045-20220516
hexagon              randconfig-r041-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
