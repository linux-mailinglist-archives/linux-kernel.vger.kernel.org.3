Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8863F4B9E85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbiBQL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:28:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiBQL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:28:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61123F08C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645097278; x=1676633278;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H2XGrjT+rRqAeNBiu3e4fRodsZVvJc9mwNNndzrleFo=;
  b=THcCE3qtcuOkQbw72m3prIwKDty/nbVhYR1wL8VZX471ZG+1O0kk57bS
   e6RR0APPRnBu2oZpyWWSDy6iuMTxccOVhlRw9h80hXOCD9OIabXJ+Y5al
   ni7HLAAANN8EH4eK2WhrE12wXMxd4ZKHNj0mY1mejtqv39BG8r4xVFpaP
   s1Y1318Ax1PJapCi9N1Nz0TF2F3v5jkixVbhVKY1E8ELhTKM2/2WyMFpO
   9zy8dRiRTSuXZ9a8tN2ixxppWG9jjqNKv8074mPJVYZPhKsunp3uDQaAw
   T6/U/oyqS2i6CYK8qm+DARGXPSaX9qY6JHmR9Z5V90FeSE9ltHvOIfujZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249689027"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="249689027"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 03:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="589314268"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Feb 2022 03:27:46 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKewr-00007N-U8; Thu, 17 Feb 2022 11:27:45 +0000
Date:   Thu, 17 Feb 2022 19:27:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 08f253ec3767bcfafc5d32617a92cee57c63968e
Message-ID: <620e311e.7foValu4gZnt0Ohq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 08f253ec3767bcfafc5d32617a92cee57c63968e  x86/cpu: Clear SME feature flag when not in use

elapsed time: 733m

configs tested: 152
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                 mpc8540_ads_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc32_defconfig
mips                            gpr_defconfig
m68k                          hp300_defconfig
powerpc                      cm5200_defconfig
powerpc                      makalu_defconfig
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
powerpc64                           defconfig
mips                            ar7_defconfig
arc                           tb10x_defconfig
powerpc                     asp8347_defconfig
arm                             rpc_defconfig
arc                              alldefconfig
sh                           se7619_defconfig
nds32                            alldefconfig
mips                       bmips_be_defconfig
xtensa                          iss_defconfig
mips                           ci20_defconfig
arm                        multi_v7_defconfig
nios2                            alldefconfig
nds32                             allnoconfig
sh                  sh7785lcr_32bit_defconfig
mips                           gcw0_defconfig
sh                          sdk7786_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  maltasmvp_eva_defconfig
mips                         mpc30x_defconfig
arm                          exynos_defconfig
sh                        sh7785lcr_defconfig
arm                         nhk8815_defconfig
openrisc                  or1klitex_defconfig
mips                    maltaup_xpa_defconfig
arm                           viper_defconfig
ia64                         bigsur_defconfig
powerpc64                        alldefconfig
m68k                            q40_defconfig
h8300                            alldefconfig
s390                       zfcpdump_defconfig
mips                           jazz_defconfig
sh                            migor_defconfig
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
riscv                randconfig-c006-20220217
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220217
arm                  randconfig-c002-20220217
i386                          randconfig-c001
mips                 randconfig-c004-20220217
mips                           ip27_defconfig
mips                     loongson1c_defconfig
arm                          ixp4xx_defconfig
arm                        neponset_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      ppc44x_defconfig
powerpc                          allmodconfig
powerpc                     mpc5200_defconfig
powerpc                   microwatt_defconfig
arm                        magician_defconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig
arm                          imote2_defconfig
powerpc                 mpc836x_mds_defconfig
mips                  cavium_octeon_defconfig
mips                     cu1830-neo_defconfig
arm                       aspeed_g4_defconfig
powerpc                          allyesconfig
arm                          pcm027_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
