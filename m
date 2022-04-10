Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9724FADC4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiDJMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiDJMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:17:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582C4C40E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649592910; x=1681128910;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=R77cuSTiyJPt6vWz2tJy04oolBZ3kRtK4ONPcd5GBSE=;
  b=KpVs/LyeuLuk7ZwbapogmWzDUdbCcYfRKc0zi5mdZjfNfVMLwEtK8FHH
   ZaJGiwrOVZYwoM//KOsPiQanUTyQWn32VF4MCd1p291xC962MX9w3ewG4
   OgDjVfhp/zNEiM0XS/IT6sQz07rXFrwKiEknNhON4myqzuhBKhWFKKb7s
   wc83HTryFgUGBX0WnNo2oarCsY/2+AVNI93ydcJwL1A7erP6fRAHFCnw8
   SULFUEV0MXe0itEVfknW2thpF30Z9cZmTYa1tnShsvZleoEPDb4ekl2b0
   s0a3HXrkwqoxoFlWSGtkXckjulvC7dhhktBmJgBBlmTZ2Yi2OimV12m9Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="324879315"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="324879315"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 05:15:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="525616748"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2022 05:15:09 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndWTE-0000sZ-CV;
        Sun, 10 Apr 2022 12:15:08 +0000
Date:   Sun, 10 Apr 2022 20:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 63ef1a8a07ef64f802af1adadae3b05ba824c534
Message-ID: <6252ca3d.L3gvNNdoHDvwljfV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 63ef1a8a07ef64f802af1adadae3b05ba824c534  Merge tag 'irqchip-fixes-5.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 723m

configs tested: 96
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
xtensa                  audio_kc705_defconfig
ia64                         bigsur_defconfig
sh                           sh2007_defconfig
mips                        vocore2_defconfig
powerpc                 mpc834x_mds_defconfig
arc                     nsimosci_hs_defconfig
s390                                defconfig
powerpc                   motionpro_defconfig
arm                          badge4_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 canyonlands_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220410
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
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
powerpc              randconfig-c003-20220410
arm                  randconfig-c002-20220410
i386                          randconfig-c001
riscv                randconfig-c006-20220410
mips                 randconfig-c004-20220410
hexagon                          alldefconfig
powerpc                    mvme5100_defconfig
arm                       aspeed_g4_defconfig
powerpc                      ppc64e_defconfig
powerpc                     skiroot_defconfig
powerpc                     mpc512x_defconfig
mips                     cu1000-neo_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220410
hexagon              randconfig-r041-20220410
hexagon              randconfig-r045-20220410

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
