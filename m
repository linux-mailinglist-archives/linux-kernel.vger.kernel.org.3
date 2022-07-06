Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72456958D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGFW4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGFW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:56:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AAD2A26C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657148191; x=1688684191;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8DbT4bhyfITTbHgUKYW3/W8iRxM6tM3UJzh/P4G68Xw=;
  b=MV1Is78xz1SRFR6FH4iYPU419LyZJ4h0cgTcIa/+YEchWpolsPZj8RYx
   Nkz9CayNXDH7ECsygf7FGsM7r0qZ+CS8DCLY91/RM9feeggsd8G1sXX89
   WloSrOpziUyuas3e2DtY0gcHJFxMzSS3/fy054Zip1KoxKdaLhvzwckIz
   KNjXswtvxAeJYUK36ykWo//pKue/j+qA4mp7udE7bES/h1UB+ZfaHkbSp
   zVk9U4ebYgP0ngYHj3XjNDxovH58i1OiBZZx8PIw5gWT9sPKfScrhdGBn
   3DG/FLBBly01MJJZ1BknVcPA0YJicZQ+P0l9ILOQz02tjGy5Sii2dKZH0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="309440414"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="309440414"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 15:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="568267283"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 15:56:29 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9Dwb-000LBM-0E;
        Wed, 06 Jul 2022 22:56:29 +0000
Date:   Thu, 07 Jul 2022 06:55:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b57feed2cc2622ae14b2fa62f19e973e5e0a60cf
Message-ID: <62c612e7.ktr2SH5IpU+2Q81N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: b57feed2cc2622ae14b2fa62f19e973e5e0a60cf  x86/compressed/64: Add identity mappings for setup_data entries

elapsed time: 721m

configs tested: 96
configs skipped: 73

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                          rsk7269_defconfig
arm                          iop32x_defconfig
sh                         ecovec24_defconfig
powerpc                    amigaone_defconfig
openrisc                  or1klitex_defconfig
xtensa                         virt_defconfig
mips                         mpc30x_defconfig
arc                        nsimosci_defconfig
arm                          exynos_defconfig
powerpc                      cm5200_defconfig
arm                          simpad_defconfig
xtensa                           allyesconfig
sh                           se7721_defconfig
mips                           ip32_defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
s390                          debug_defconfig
um                             i386_defconfig
riscv                            allyesconfig
powerpc                    adder875_defconfig
arm                          lpd270_defconfig
xtensa                generic_kc705_defconfig
nios2                         3c120_defconfig
powerpc                      pasemi_defconfig
arm                           viper_defconfig
arm                      jornada720_defconfig
arm                        mini2440_defconfig
arm                             rpc_defconfig
sh                           se7705_defconfig
sparc64                             defconfig
um                               alldefconfig
mips                       capcella_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                      maltaaprp_defconfig
powerpc                      walnut_defconfig
arm                            dove_defconfig
mips                malta_qemu_32r6_defconfig
arm                       spear13xx_defconfig
mips                           ip27_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220706
hexagon              randconfig-r045-20220706
hexagon              randconfig-r041-20220706
s390                 randconfig-r044-20220706

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
