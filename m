Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D074DBEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 06:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiCQFtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 01:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCQFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:48:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831FE1FF421
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647494319; x=1679030319;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7e3pe/Jd89FX8Aua1Fg+D9PE3vqDQCC1cV1PYno25kg=;
  b=Au6hSqURlFy6XN/OyZzRAIPDkGeX4/UNHIYIXWODt8J1C/87QE6ldy+Y
   KfhPT1RGKUX/kliXjfF0EwbZIxtz/Zo6TnacAkn3FZWP5OeUtrHKPYCnQ
   u4t819TY4cr2fEEBOSyEqwhcVLVM4dPKvu6uQCIxdGb/XyJF1u+UjJaeX
   EiU8A5kb9Tat2MMrFmVH75Oi5EwATDs8wGTXTDuGW9maxhPXU8r/a/xGi
   qJrZgsiYTkPnnvHDNTfv1sSSh99MG9ExuJCO1AKOLboK9qbLQCAucvXAD
   rpVl/LGEvKCu0TpkTntSq7wYvCk+MkpGw9FZre4g5dT8jq8D2u5KQcMiK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="319995875"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="319995875"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 22:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="821212455"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2022 22:18:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUiWx-000DJk-R5; Thu, 17 Mar 2022 05:18:35 +0000
Date:   Thu, 17 Mar 2022 13:18:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 d4c9df20a37d128f6acb3c6286db7e694554a51b
Message-ID: <6232c499.IwPceR+n4E18/jSg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: d4c9df20a37d128f6acb3c6286db7e694554a51b  x86/nmi: Remove the 'strange power saving mode' hint from unknown NMI handler

elapsed time: 726m

configs tested: 166
configs skipped: 82

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220314
mips                       bmips_be_defconfig
sh                         ecovec24_defconfig
arm                        oxnas_v6_defconfig
mips                           ci20_defconfig
powerpc                  storcenter_defconfig
sh                           sh2007_defconfig
alpha                            alldefconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
sh                         ap325rxa_defconfig
arm                           h3600_defconfig
arm                            lart_defconfig
powerpc                         wii_defconfig
h8300                            alldefconfig
arm                         nhk8815_defconfig
powerpc                     pq2fads_defconfig
sh                          rsk7264_defconfig
sh                             sh03_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
powerpc                     rainier_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
xtensa                           alldefconfig
sh                              ul2_defconfig
arm                           sama5_defconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
xtensa                    xip_kc705_defconfig
sh                ecovec24-romimage_defconfig
sh                          sdk7786_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                          iss_defconfig
arc                      axs103_smp_defconfig
m68k                       bvme6000_defconfig
arm                           sunxi_defconfig
arm                        trizeps4_defconfig
arm                        multi_v7_defconfig
parisc64                            defconfig
mips                           jazz_defconfig
arc                              alldefconfig
sh                   secureedge5410_defconfig
arm                         lubbock_defconfig
sh                             shx3_defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
sh                         apsh4a3a_defconfig
arm                           tegra_defconfig
mips                         cobalt_defconfig
arm                  randconfig-c002-20220317
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
arc                  randconfig-r043-20220313
arc                  randconfig-r043-20220314
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220317
riscv                randconfig-r042-20220317
s390                 randconfig-r044-20220317
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
mips                            e55_defconfig
powerpc                      pmac32_defconfig
powerpc                     kilauea_defconfig
mips                           mtx1_defconfig
mips                        maltaup_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
