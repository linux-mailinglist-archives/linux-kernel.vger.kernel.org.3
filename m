Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2F4B3E69
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiBMXe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:34:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiBMXeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:34:25 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6E517D1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644795258; x=1676331258;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GB3oTFQzCkmlpfsb39ob2C2mRdaPDzejqeGO3cu32lY=;
  b=EadAbg9sjpCd+CGogz2agotzW/fJgXgIKqdAUGrB4+d2yqTmcTCWk46V
   g2KvLmz7q4WvZFPcwX9yulytipfLKDwEvIhnkLnm9iJ+qpvwHbil8TkGl
   VrbGE5xnaiGfc3JrR9wcUSyeif5Yv+fdm5ITRVn+MbT9TzspnyWzbVKS5
   fy6oifvUFiTjkiRqaS1YCyn9zzrpbanzd1j6bk7GgeKtbZHTwkVqiHvuo
   iQkY5l6pPe22VE7YERTkA7mnWzndOMJ96BtqfJfmqxaoKfnKSyltZXTYa
   uvAubejYQZAJnokeReHVHCLpb0cxksfBsBj9VswOQS0h3ie7Ku9ZmQFH8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="310719411"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="310719411"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 15:34:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="702799807"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2022 15:34:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJONk-0007zl-GK; Sun, 13 Feb 2022 23:34:16 +0000
Date:   Mon, 14 Feb 2022 07:33:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 b008893b08dcc8c30d756db05c229a1491bcb992
Message-ID: <62099543.jzmynpDCyL2SXEIZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: b008893b08dcc8c30d756db05c229a1491bcb992  x86/ptrace: Always inline v8086_mode() for instrumentation

elapsed time: 720m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                          rsk7264_defconfig
arm                           h3600_defconfig
openrisc                            defconfig
m68k                        mvme147_defconfig
sh                            hp6xx_defconfig
powerpc64                        alldefconfig
sh                          sdk7786_defconfig
xtensa                    smp_lx200_defconfig
sh                   sh7770_generic_defconfig
arm                           corgi_defconfig
mips                     decstation_defconfig
sh                ecovec24-romimage_defconfig
sh                              ul2_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
sh                        edosk7705_defconfig
nds32                             allnoconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5275evb_defconfig
powerpc                      chrp32_defconfig
h8300                            alldefconfig
powerpc                     rainier_defconfig
powerpc                       ppc64_defconfig
s390                                defconfig
parisc                              defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
powerpc                    amigaone_defconfig
alpha                            alldefconfig
ia64                        generic_defconfig
arm                          pxa910_defconfig
sh                           se7722_defconfig
nios2                            alldefconfig
mips                         db1xxx_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
arc                  randconfig-r043-20220213
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20220213
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220213
arm                  randconfig-c002-20220213
i386                          randconfig-c001
mips                 randconfig-c004-20220213
powerpc                 mpc836x_rdk_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
hexagon                             defconfig
powerpc                  mpc866_ads_defconfig
arm                     am200epdkit_defconfig
powerpc                      pmac32_defconfig
arm                     davinci_all_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          pcm027_defconfig
arm                              alldefconfig
mips                         tb0287_defconfig
powerpc                     tqm8540_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r045-20220213
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r041-20220213
riscv                randconfig-r042-20220213
s390                 randconfig-r044-20220213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
