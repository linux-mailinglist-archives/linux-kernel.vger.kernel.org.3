Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3084F1402
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376553AbiDDLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiDDLtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:49:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59803D1EF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649072834; x=1680608834;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eFJ4rhPclLPd5glv4epq+OWh9osXIpM8HhnGfD2DM4E=;
  b=QoyGAHRgi/I1Au0S1YWxzGVAri/gpsqqmXjm2YSprbqlGdF2AhPsvsRG
   ecbXw3rn5nbtf5DuJVmazSYUqKdTiSmttGNELFSzpzYmFLHSexpUa7bC+
   e5RLJ0+FOnI0slG4ULPQP97ZYK/8BgqryW1fZCDN4GQs3AGuHN9NJUldk
   qGbxnV96Xkd5YGHPdHUEANGyvLOPxifDrqTeeHdIc3G/2xCCbRqfGJJME
   sp7boLd3p9lrqROehEe6ku2fureA2y6nDTUuU/+dGzQsqnRvqDcndm/jC
   oTgVJRptyUM0+5UGqSeejuwOFequqnKmC9j/p7If6EecibUnxFeRfjAdG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="285443801"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="285443801"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 04:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="721618454"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Apr 2022 04:47:13 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbLAu-000216-9P;
        Mon, 04 Apr 2022 11:47:12 +0000
Date:   Mon, 04 Apr 2022 19:46:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.03b] BUILD SUCCESS
 4e459bba45570d8f4aec2a9f18fca30e1d9472fc
Message-ID: <624ada9f.2+4KbN5gUU9tHCdy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.03b
branch HEAD: 4e459bba45570d8f4aec2a9f18fca30e1d9472fc  fixup! rcu: Make UP-vacuous normal grace period advance sequence

elapsed time: 723m

configs tested: 168
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
i386                 randconfig-c001-20220404
arm                          gemini_defconfig
mips                        vocore2_defconfig
parisc64                         alldefconfig
sh                 kfr2r09-romimage_defconfig
powerpc                           allnoconfig
sh                          rsk7269_defconfig
sh                          rsk7264_defconfig
arm                           sama5_defconfig
powerpc                    klondike_defconfig
sh                        edosk7705_defconfig
m68k                          hp300_defconfig
sh                           se7722_defconfig
arm                           h3600_defconfig
h8300                               defconfig
sh                  sh7785lcr_32bit_defconfig
mips                            ar7_defconfig
mips                  maltasmvp_eva_defconfig
arm                          simpad_defconfig
arm                           stm32_defconfig
parisc                           alldefconfig
alpha                               defconfig
sh                             sh03_defconfig
powerpc                     taishan_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
sh                     sh7710voipgw_defconfig
arm                        oxnas_v6_defconfig
powerpc                        cell_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc834x_itx_defconfig
arc                              alldefconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc6xx_defconfig
sh                          r7785rp_defconfig
sh                            migor_defconfig
xtensa                generic_kc705_defconfig
arm                        spear6xx_defconfig
parisc                generic-64bit_defconfig
x86_64                              defconfig
sh                         ecovec24_defconfig
sh                   sh7770_generic_defconfig
arm                         cm_x300_defconfig
arm                        clps711x_defconfig
arc                          axs101_defconfig
arm                        mvebu_v7_defconfig
mips                         rt305x_defconfig
mips                    maltaup_xpa_defconfig
arm                          pxa910_defconfig
sh                          rsk7201_defconfig
m68k                        mvme147_defconfig
sh                      rts7751r2d1_defconfig
sh                   secureedge5410_defconfig
sh                               j2_defconfig
x86_64               randconfig-c001-20220404
arm                  randconfig-c002-20220404
arm                  randconfig-c002-20220403
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220404
x86_64               randconfig-a011-20220404
x86_64               randconfig-a014-20220404
x86_64               randconfig-a016-20220404
x86_64               randconfig-a012-20220404
x86_64               randconfig-a013-20220404
i386                 randconfig-a013-20220404
i386                 randconfig-a011-20220404
i386                 randconfig-a014-20220404
i386                 randconfig-a012-20220404
i386                 randconfig-a015-20220404
i386                 randconfig-a016-20220404
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220404
s390                 randconfig-r044-20220404
riscv                randconfig-r042-20220404
arc                  randconfig-r043-20220403
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                               defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220403
arm                  randconfig-c002-20220403
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220403
i386                          randconfig-c001
s390                 randconfig-c005-20220403
riscv                randconfig-c006-20220403
powerpc                      obs600_defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
arm                         socfpga_defconfig
arm                           sama7_defconfig
mips                        workpad_defconfig
arm                          pcm027_defconfig
riscv                             allnoconfig
powerpc                  mpc866_ads_defconfig
powerpc                   bluestone_defconfig
arm                          imote2_defconfig
mips                     loongson1c_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
x86_64               randconfig-a006-20220404
x86_64               randconfig-a002-20220404
x86_64               randconfig-a001-20220404
x86_64               randconfig-a005-20220404
x86_64               randconfig-a003-20220404
x86_64               randconfig-a004-20220404
i386                 randconfig-a006-20220404
i386                 randconfig-a002-20220404
i386                 randconfig-a001-20220404
i386                 randconfig-a004-20220404
i386                 randconfig-a003-20220404
i386                 randconfig-a005-20220404
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20220403
riscv                randconfig-r042-20220403
hexagon              randconfig-r041-20220403
hexagon              randconfig-r045-20220404
hexagon              randconfig-r041-20220404
s390                 randconfig-r044-20220403

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
