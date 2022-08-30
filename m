Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC345A5F92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiH3Jg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiH3JgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:36:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AC8EA172
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661852044; x=1693388044;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZvVIkfptZOksDHoD5BQ0BvgCrKxH5FewlQmDfWFAIwY=;
  b=W7vvRqUjoGxPkUbLLflIq7VviN3VbYUujZbAp/v/o3ntKjUtR6VNbZXk
   fJ/B2hVJEzx0CjUQJu8Z4m9Zivf/UfPnJ/cPCt5icVM1LYydNO7Iry94E
   +x8j9xE28stLEud6pqDmkdAR7cvdaZaEKKdt7heBURhcjfmIjFRoWHM6v
   TfYO+6TzrhvZIqxiN5BZ+Uv0VebnGz1MrEKnKFwhKszZIhqRPYd3q8wMx
   99ir/lLWLAOXXc/or06a+J8iQgMVCLgv/EA64ZrlDC6M7O7iM/xQBY458
   WYjvZqvmqPo93G4gP/pFzQ3m1DNVU1wPe3ZlL+ve+hlciwRspkecWSHcl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="274879163"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="274879163"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641303152"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2022 02:34:01 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSxdA-00008g-1V;
        Tue, 30 Aug 2022 09:34:00 +0000
Date:   Tue, 30 Aug 2022 17:33:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.0-rc2-fam0-non-uapi] BUILD SUCCESS
 50ad7b6697a546e4c55e1ae7a6778fde61def1aa
Message-ID: <630dd957.SVyvitW5FsG3LFfM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.0-rc2-fam0-non-uapi
branch HEAD: 50ad7b6697a546e4c55e1ae7a6778fde61def1aa  can: etas_es58x: Replace zero-length array with DECLARE_FLEX_ARRAY() helper

elapsed time: 721m

configs tested: 151
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
arc                  randconfig-r043-20220829
x86_64               randconfig-a003-20220829
x86_64               randconfig-a002-20220829
x86_64               randconfig-a001-20220829
alpha                            allyesconfig
x86_64               randconfig-a005-20220829
arc                              allyesconfig
x86_64               randconfig-a006-20220829
um                           x86_64_defconfig
um                             i386_defconfig
sh                               allmodconfig
x86_64               randconfig-a004-20220829
m68k                             allmodconfig
mips                             allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
powerpc                          allmodconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                 randconfig-a001-20220829
i386                                defconfig
x86_64                           rhel-8.3-kvm
i386                 randconfig-a003-20220829
i386                 randconfig-a002-20220829
i386                 randconfig-a004-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
x86_64                              defconfig
x86_64                               rhel-8.3
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
x86_64                           allyesconfig
xtensa                           alldefconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                  randconfig-c002-20220829
i386                 randconfig-c001-20220829
x86_64               randconfig-c001-20220829
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                         s3c6400_defconfig
powerpc                      tqm8xx_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8548_defconfig
ia64                             allmodconfig
sh                             sh03_defconfig
powerpc                      makalu_defconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220830
mips                 randconfig-c004-20220830
loongarch                           defconfig
loongarch                         allnoconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                       imx_v6_v7_defconfig
powerpc                       maple_defconfig
mips                    maltaup_xpa_defconfig
arm                         at91_dt_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220830
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                          pxa910_defconfig
powerpc                      pasemi_defconfig
mips                  maltasmvp_eva_defconfig
arm64                               defconfig
ia64                             allyesconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
s390                       zfcpdump_defconfig
arm                            mps2_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
xtensa                generic_kc705_defconfig
m68k                            mac_defconfig
arm                        oxnas_v6_defconfig
m68k                             alldefconfig
sh                           se7780_defconfig
loongarch                 loongson3_defconfig
sh                         ecovec24_defconfig
arm                      integrator_defconfig
powerpc                     asp8347_defconfig

clang tested configs:
hexagon              randconfig-r041-20220829
hexagon              randconfig-r045-20220829
riscv                randconfig-r042-20220829
s390                 randconfig-r044-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
i386                 randconfig-a013-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a016-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a016-20220829
i386                 randconfig-a015-20220829
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                             allyesconfig
powerpc                     powernv_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20220830
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-k001
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220830
riscv                randconfig-c006-20220830
powerpc              randconfig-c003-20220830
mips                 randconfig-c004-20220830
arm                  randconfig-c002-20220830

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
