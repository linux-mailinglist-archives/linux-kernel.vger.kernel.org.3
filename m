Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9B57D62F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiGUVj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:39:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B3D9363B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658439596; x=1689975596;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g8nWBde7r3kLMEsNvBK1kA8asirc7RYjN6NpUaTx5zU=;
  b=XPWNJSKr+rc2ds7RXggqJyb3s8QFdZTV+Av/o3klA/6VmBOJMUCNhQv0
   rd6pdY3IQ3/Y5fx7SZjI4zqkl0efeRkhT31JunFptahbFKGGod2rHGiCW
   Q0uzeA5yUX7J4ZwxO05Uabv456k7TU2/2QsxtZa0DDzXPhDm6ge9pwmgP
   awf5K4vTZaVWLJ75VEnFBS8zv/JWxnCMS8u2/1f03s6BV2QctRctNjmoU
   A7pCm9IGiu6Dt2ApD3hDG6hR/iVXplZobrPD0PEYEr0D07oM4/o3+c0ek
   iE/z8Qy1oWtpzhCbs+t6wB73lC2Q7RUcqizwsDswkWE2tf98u1NxnQIGa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266952457"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="266952457"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 14:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="626301451"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2022 14:39:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEdti-0000aS-09;
        Thu, 21 Jul 2022 21:39:54 +0000
Date:   Fri, 22 Jul 2022 05:39:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 d906fa730827456711ce29c1f2994a0ccaff49dc
Message-ID: <62d9c7a5.bySYc5wuYGbQdGoG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: d906fa730827456711ce29c1f2994a0ccaff49dc  hwmon: (k10temp): Add support for new family 17h and 19h models

elapsed time: 739m

configs tested: 115
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                               j2_defconfig
arc                          axs101_defconfig
alpha                               defconfig
mips                         cobalt_defconfig
arm                      jornada720_defconfig
arm                        spear6xx_defconfig
arm                          pxa910_defconfig
mips                        vocore2_defconfig
powerpc                         ps3_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
ia64                        generic_defconfig
xtensa                    smp_lx200_defconfig
arm                         assabet_defconfig
parisc                generic-64bit_defconfig
arm                         at91_dt_defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
arm                           sama5_defconfig
sh                   sh7770_generic_defconfig
xtensa                       common_defconfig
m68k                       bvme6000_defconfig
arm                             rpc_defconfig
arm                        shmobile_defconfig
arc                          axs103_defconfig
xtensa                              defconfig
m68k                            mac_defconfig
arm                           viper_defconfig
arm                             pxa_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                        oxnas_v6_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm                  randconfig-c002-20220721
x86_64                        randconfig-c001
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                 randconfig-a013-20220718
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220718
arc                  randconfig-r043-20220721
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                          ixp4xx_defconfig
powerpc                  mpc866_ads_defconfig
mips                      malta_kvm_defconfig
arm                                 defconfig
arm                           spitz_defconfig
powerpc                        fsp2_defconfig
powerpc                          allyesconfig
arm                             mxs_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      tct_hammer_defconfig
mips                        qi_lb60_defconfig
powerpc                     kmeter1_defconfig
x86_64                           allyesconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a001-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                          randconfig-a004
i386                 randconfig-a003-20220718
i386                 randconfig-a004-20220718
i386                 randconfig-a005-20220718
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718
hexagon              randconfig-r041-20220721
s390                 randconfig-r044-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
