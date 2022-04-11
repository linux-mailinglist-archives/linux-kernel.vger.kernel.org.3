Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443824FBADC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiDKL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbiDKL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:28:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC62654E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676359; x=1681212359;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dPQlol1SDSBGKetKFe14UFchHkct6W+n6HAxv/iAXyU=;
  b=jJFCCHhOh7F0kagFZE/OJVgPjZsQul+b+jH9dn3+1CdRjarEjv1H8EXe
   Aan7MgqEC9ty0CNeriazDzXhes8UD7Zv1czjn5m7K3ly4hA4Z/kqH938F
   88lVLtzko2PBg9Mh/sJLq7xheu0RYUs/IhvRCP73XrVNnj2RWTdjMWojA
   WFSokSkPolPKmzC1eShcGxa9iZAHM0YzsIO0vMOxTGgpiZzaaFVZkyxgZ
   88+i1VzG4X8E8Vw4B5o9y6iOjoamMX8qQhcH1VdQslV4I6ucmyljLesr4
   SQ4P9xmQV7FX9XhKQFNJCC4zXfi+YD+lOjD31mRUXN9GpfwiaLVRYyGh/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242028821"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242028821"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="622794570"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2022 04:25:58 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndsBB-0001oL-D6;
        Mon, 11 Apr 2022 11:25:57 +0000
Date:   Mon, 11 Apr 2022 19:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 8afbcaf8690dac19ebf570a4e4fef9c59c75bf8e
Message-ID: <6254101b.0cMfOwssjl/0V6pB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 8afbcaf8690dac19ebf570a4e4fef9c59c75bf8e  clocksource: Replace cpumask_weight() with cpumask_empty()

elapsed time: 727m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220410
i386                          randconfig-c001
i386                 randconfig-c001-20220411
m68k                             allyesconfig
sh                          landisk_defconfig
sh                         ap325rxa_defconfig
parisc                generic-32bit_defconfig
powerpc                 canyonlands_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc8540_ads_defconfig
nios2                            alldefconfig
powerpc                     taishan_defconfig
xtensa                         virt_defconfig
arm                       omap2plus_defconfig
arc                          axs101_defconfig
arm                             pxa_defconfig
arm                        mini2440_defconfig
powerpc                    adder875_defconfig
openrisc                    or1ksim_defconfig
m68k                        m5307c3_defconfig
powerpc                      bamboo_defconfig
mips                        vocore2_defconfig
sh                          r7780mp_defconfig
sh                            migor_defconfig
sparc                               defconfig
xtensa                  audio_kc705_defconfig
powerpc                           allnoconfig
powerpc                      tqm8xx_defconfig
mips                             allmodconfig
powerpc                      makalu_defconfig
powerpc                     stx_gp3_defconfig
arc                          axs103_defconfig
arm                      jornada720_defconfig
sh                   sh7724_generic_defconfig
arm                           h3600_defconfig
arm                       multi_v4t_defconfig
arm                          pxa910_defconfig
powerpc                     tqm8541_defconfig
mips                       capcella_defconfig
nios2                               defconfig
m68k                        mvme16x_defconfig
xtensa                          iss_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5275evb_defconfig
powerpc                mpc7448_hpc2_defconfig
h8300                            allyesconfig
arm                        clps711x_defconfig
m68k                           sun3_defconfig
mips                         tb0226_defconfig
sh                        sh7785lcr_defconfig
mips                             allyesconfig
sh                            hp6xx_defconfig
arm                  randconfig-c002-20220411
arm                  randconfig-c002-20220410
x86_64               randconfig-c001-20220411
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
arc                              allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64               randconfig-a016-20220411
x86_64               randconfig-a012-20220411
x86_64               randconfig-a013-20220411
x86_64               randconfig-a014-20220411
x86_64               randconfig-a015-20220411
x86_64               randconfig-a011-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
riscv                randconfig-r042-20220411
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
arc                  randconfig-r043-20220410
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
powerpc                     mpc512x_defconfig
arm                       netwinder_defconfig
arm                      pxa255-idp_defconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
powerpc                    gamecube_defconfig
powerpc                     akebono_defconfig
mips                     loongson2k_defconfig
arm64                            allyesconfig
powerpc                     kilauea_defconfig
mips                          ath25_defconfig
powerpc                     powernv_defconfig
arm                         hackkit_defconfig
mips                       lemote2f_defconfig
mips                   sb1250_swarm_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         s3c2410_defconfig
arm                          collie_defconfig
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220410
hexagon              randconfig-r041-20220411
hexagon              randconfig-r041-20220410
hexagon              randconfig-r045-20220411
hexagon              randconfig-r045-20220410

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
