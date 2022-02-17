Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6A4BA054
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiBQMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:48:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiBQMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:48:05 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D84666A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645102071; x=1676638071;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0Vg57cUMJ6X76ccyPWTy1iYdTqFuumem4WREVWNg9Rc=;
  b=VfpflLsbT2rv+Uq/TORUvlDuvGilRcyMm5tRVE+44iDFWWIigg5ipke/
   qWEs3/JU0W3fyW2Xh31GCrElxwvYTZmqnjRiAVoxKsmfrpFTeoHfz4vM9
   VDl681nZ9kNoU+MNdh6lg4YKAwrbBSrxYHjnbfyjpv4U79i0152TleLxl
   3eT703zcPP/F6Av0yMoQpfaC7azQH609NMpfUIaL1bYc14E5Q/FihVet0
   jzsw/HvaoYqtKRVXUouOKWs7T39R+a0YUrnW66oFoNMmZLfVqTXwBu/rJ
   Gephcfx2w+4g1y6EHBEBX43gHN8E9zWm8zHjbY9ixOarv9XtpBXm0nsN0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311608519"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="311608519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 04:47:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="681944771"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2022 04:47:49 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKgCL-0000CU-2N; Thu, 17 Feb 2022 12:47:49 +0000
Date:   Thu, 17 Feb 2022 20:46:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-fam0] BUILD SUCCESS
 fbe9ccfe809d21228d27ed766690907dc8be6fe1
Message-ID: <620e43b6.5f49UXjTHxhQdhWg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-fam0
branch HEAD: fbe9ccfe809d21228d27ed766690907dc8be6fe1  treewide: Replace zero-length arrays with flexible-array members

elapsed time: 812m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc32_defconfig
mips                            gpr_defconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
powerpc                    amigaone_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                  iss476-smp_defconfig
xtensa                  audio_kc705_defconfig
arm                           h5000_defconfig
xtensa                       common_defconfig
powerpc                     stx_gp3_defconfig
ia64                             alldefconfig
powerpc                     asp8347_defconfig
arm                             rpc_defconfig
arc                              alldefconfig
sh                           se7619_defconfig
nds32                            alldefconfig
mips                       bmips_be_defconfig
xtensa                          iss_defconfig
mips                           ci20_defconfig
arm                        multi_v7_defconfig
mips                           gcw0_defconfig
openrisc                  or1klitex_defconfig
mips                    maltaup_xpa_defconfig
arc                           tb10x_defconfig
arm                           viper_defconfig
arc                          axs101_defconfig
sh                            shmin_defconfig
ia64                         bigsur_defconfig
powerpc64                        alldefconfig
s390                       zfcpdump_defconfig
mips                           jazz_defconfig
sh                            migor_defconfig
powerpc                 canyonlands_defconfig
m68k                        stmark2_defconfig
sh                 kfr2r09-romimage_defconfig
sh                   sh7724_generic_defconfig
sh                           se7712_defconfig
arm                  randconfig-c002-20220217
arm                  randconfig-c002-20220216
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
parisc64                            defconfig
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
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
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
x86_64                                  kexec

clang tested configs:
mips                           ip27_defconfig
mips                     loongson1c_defconfig
arm                          ixp4xx_defconfig
arm                        neponset_defconfig
mips                          malta_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
mips                      pic32mzda_defconfig
arm                       cns3420vb_defconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig
arm                          imote2_defconfig
powerpc                 mpc836x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
