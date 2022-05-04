Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D636251B2BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbiEDXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380389AbiEDXDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:03:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502255206
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651704847; x=1683240847;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AvzdZAViZbcFt+gCFFUnTX7OmoPclkBZz4ni9KPzED4=;
  b=ELC6m2UGPoiOaNiD0t+DWbqztmvWdGD74HCM4MqM7848/mBFZpUM7fuL
   4cFA3Sm439If9A/eRGdG67GjZOtksYopiNniONxyrzDZmTIsbQpFRL8Wn
   ZDm+Cvvot8OKqSOMRc5Tpgi958xErJNSkZ3RsEda5fSUw1D93LKFiIsrz
   0587wJMEhsX0XOA2Lh1pr2x7HFkk1TExJanYWEVcSZPWQhRoq52ae1tft
   SIWfkHUOK7F7bK2GJeJe8+WrAyhevMcpw6BtKdR65RErwgYMAQGmps+vq
   LcRdrl/jnlcL3Ut1i48/zwIxF7uZkTjTsyIe/XTZKlpxO2RwYszT5OGyP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247830265"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="247830265"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="708675488"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 15:52:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmNqx-000Brz-81;
        Wed, 04 May 2022 22:52:15 +0000
Date:   Thu, 05 May 2022 06:51:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/splitlock] BUILD SUCCESS
 0180a1e823d7c41d9a1c19f38e6069b38fe60c87
Message-ID: <62730363.GLGLFU3Eqtjf0nNk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/splitlock
branch HEAD: 0180a1e823d7c41d9a1c19f38e6069b38fe60c87  x86/split_lock: Enable the split lock feature on Raptor Lake

elapsed time: 750m

configs tested: 135
configs skipped: 92

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                       m5249evb_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
arc                           tb10x_defconfig
ia64                        generic_defconfig
mips                       bmips_be_defconfig
h8300                     edosk2674_defconfig
powerpc                    amigaone_defconfig
arm                           corgi_defconfig
powerpc                      pcm030_defconfig
powerpc                        cell_defconfig
arc                     haps_hs_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
xtensa                  audio_kc705_defconfig
m68k                            q40_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            xcep_defconfig
arm                        oxnas_v6_defconfig
microblaze                          defconfig
xtensa                    smp_lx200_defconfig
um                             i386_defconfig
arm                        mini2440_defconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
arc                            hsdk_defconfig
mips                        bcm47xx_defconfig
m68k                        stmark2_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220502
i386                 randconfig-a002-20220502
i386                 randconfig-a001-20220502
i386                 randconfig-a004-20220502
i386                 randconfig-a005-20220502
i386                 randconfig-a006-20220502
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
powerpc                    socrates_defconfig
mips                     cu1830-neo_defconfig
powerpc                      katmai_defconfig
arm                           sama7_defconfig
hexagon                          alldefconfig
arm                         s3c2410_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a011-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a015-20220502
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                 randconfig-a011-20220502
i386                 randconfig-a013-20220502
i386                 randconfig-a016-20220502
i386                 randconfig-a015-20220502
i386                 randconfig-a014-20220502
i386                 randconfig-a012-20220502
hexagon              randconfig-r045-20220502
hexagon              randconfig-r045-20220501
riscv                randconfig-r042-20220502
hexagon              randconfig-r041-20220502
hexagon              randconfig-r041-20220501

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
