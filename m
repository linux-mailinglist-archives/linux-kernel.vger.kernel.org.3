Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF15A5CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiH3HPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiH3HO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:14:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C463BF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661843695; x=1693379695;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S7836uVsE3uLxvEeyT1LOqEWiiqtSIadJT7XJkXUa0c=;
  b=CVEEDz2aMS+ysfd61FHZpAGwpMQo1b6o3aTVH+CtkihH3eNI1oWwW/vw
   wpVGLYymxg+6hGqniqZ3ggbVh/WVRXQuA51+0jQ0oXgHJkvSFFm8/Rc3F
   nyK6bmA9CaazTFXMYS0xHz9UepZHxKp5ClnQrB718YWPjMBkKEh0Be+4z
   g1809uCkBi8iNSvJoIbDgnIhgl0/D3QbG+m1YMWemDVgmVq/eJ/rW31v+
   +8jNFqUYrkUG3iXOTVL9TItgTFSkzOfyi9KFnw80oHME0VIgDRQv2uyii
   5SAWKHA2IloTBcQnmANBi+cyE6+1zbH1tS+SzIampAA47YYdjTtIy44hU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282074662"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282074662"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="700887669"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2022 00:14:53 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSvSW-00001i-1g;
        Tue, 30 Aug 2022 07:14:52 +0000
Date:   Tue, 30 Aug 2022 15:13:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/6.0-rc2-kspp-misc] BUILD SUCCESS
 61b2005335d446d9169be9405696be6e7507ebd3
Message-ID: <630db8af.4sbrBdRIrMBf7eAA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/6.0-rc2-kspp-misc
branch HEAD: 61b2005335d446d9169be9405696be6e7507ebd3  drm/amdkfd: Use kvcalloc() instead of kvzalloc()

elapsed time: 729m

configs tested: 162
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-a004-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
i386                 randconfig-a002-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a006-20220829
powerpc                           allnoconfig
alpha                            allyesconfig
arc                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20220829
sh                               allmodconfig
x86_64               randconfig-a002-20220829
m68k                             allyesconfig
x86_64               randconfig-a001-20220829
m68k                             allmodconfig
arc                                 defconfig
x86_64               randconfig-a004-20220829
x86_64               randconfig-a005-20220829
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a006-20220829
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
arc                  randconfig-r043-20220829
i386                                defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
m68k                        m5307c3_defconfig
m68k                          atari_defconfig
arm                            mps2_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                             allyesconfig
x86_64               randconfig-c001-20220829
arm                         cm_x300_defconfig
sh                        sh7763rdp_defconfig
sh                          lboxre2_defconfig
mips                  decstation_64_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm                  randconfig-c002-20220829
i386                 randconfig-c001-20220829
i386                             alldefconfig
csky                              allnoconfig
powerpc                      cm5200_defconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                     stx_gp3_defconfig
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
arm                       imx_v6_v7_defconfig
powerpc                       maple_defconfig
mips                    maltaup_xpa_defconfig
arm                         at91_dt_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
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
s390                       zfcpdump_defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220830
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
arm                        shmobile_defconfig
sh                            migor_defconfig
ia64                      gensparse_defconfig
ia64                             alldefconfig
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

clang tested configs:
i386                 randconfig-a011-20220829
x86_64               randconfig-a011-20220829
i386                 randconfig-a014-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
i386                 randconfig-a013-20220829
x86_64               randconfig-a014-20220829
i386                 randconfig-a012-20220829
x86_64               randconfig-a016-20220829
i386                 randconfig-a016-20220829
hexagon              randconfig-r041-20220829
x86_64               randconfig-a015-20220829
i386                 randconfig-a015-20220829
hexagon              randconfig-r045-20220829
riscv                randconfig-r042-20220829
s390                 randconfig-r044-20220829
arm                             mxs_defconfig
powerpc                     kilauea_defconfig
arm                        mvebu_v5_defconfig
powerpc                        icon_defconfig
i386                             allyesconfig
powerpc                     powernv_defconfig
mips                     cu1000-neo_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                 mpc832x_rdb_defconfig
powerpc                  mpc885_ads_defconfig
s390                 randconfig-r044-20220830
hexagon              randconfig-r045-20220830
hexagon              randconfig-r041-20220830
riscv                randconfig-r042-20220830
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
