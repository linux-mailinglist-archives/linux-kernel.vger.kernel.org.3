Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB974DA8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353380AbiCPCyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353374AbiCPCyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:54:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C67BF46
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647399169; x=1678935169;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=I87w4d/pF0WwWEl19XHeHlYghYLObCo6tp341ptUlBc=;
  b=QvGoJknInZ8vgLUIDPea51JynuTYRTQOfURGz5x/5H5/VMUPQlUxFQqa
   Ufc7KBSqQF32Xv6POLz2ipGXOm1a/yMMQJempSYylH7DnOCtuFcht6xkh
   NSwzUPRw9p+hPKlIk7hr0TgxdiHOCmqeUPjAmg3WZ7vQPfAnRLem7WVML
   UYE0Y1/VNdid17dmNJltZXBYh+f6qwPTE5M7/LeQQjMk75xg+dK5nBI4g
   0iVgvcGPtgzJeHH17q0h7OaKCQ4ViA5SflrdP5jxistq2TsMYEWyLMEHd
   wwkghGzZuK0SzEQhpjqo/mrOvTYQd2IO+1+GfaBtukYmna3gctIaeBSip
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281252013"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="281252013"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="540712864"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2022 19:52:38 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUJm9-000Bpc-P3; Wed, 16 Mar 2022 02:52:37 +0000
Date:   Wed, 16 Mar 2022 10:52:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 61f719d76d1baf12c3b2cfa6155dab5c8c64b633
Message-ID: <623150dc.pc0iFw5X5qrjdzL/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 61f719d76d1baf12c3b2cfa6155dab5c8c64b633  Merge branch into tip/master: 'core/core'

elapsed time: 871m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                              ul2_defconfig
powerpc64                           defconfig
mips                  decstation_64_defconfig
s390                          debug_defconfig
arm                         lubbock_defconfig
powerpc                 canyonlands_defconfig
xtensa                  cadence_csp_defconfig
arm                          exynos_defconfig
openrisc                 simple_smp_defconfig
sparc                            alldefconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a001-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a006-20220314
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
arc                  randconfig-r043-20220314
s390                 randconfig-r044-20220313
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                       cns3420vb_defconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
powerpc                       ebony_defconfig
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
arm                           sama7_defconfig
mips                     loongson2k_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc832x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a014-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a012-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a016-20220314
hexagon              randconfig-r045-20220313
hexagon              randconfig-r045-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
riscv                randconfig-r042-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
