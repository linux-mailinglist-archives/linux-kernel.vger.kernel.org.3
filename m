Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8785652F574
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353120AbiETWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351380AbiETWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:02:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A33C63BC4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653084139; x=1684620139;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fDO399fN0ewf0Z1JZuBxe8gbifRJtV22p9T9/k8Xzuk=;
  b=aI82ehXrqT5KsYFAmLQv8ujLiw5Uxfo/d1AxAUOeR0EOSTPnwTSkZ+5c
   Qo+PSy78PMIF9Q6Ghmcpi9cjmEd2xyO7LJSPPGruqegS58b9yGUzyuqgA
   z3/bBStXTka5vq4Ank1uxJH18H7kleTGS/NsPpgwqTV+KlOggC1YlTTIO
   dtEwreymfGR6AIsj2LiAJ78l4o+UoZxx22np/WRCgCRmk/Mx54ZRsI98J
   3hT9VuB4lg2T+45VdI8AFa4nwh1GNRTELgI1eD+LE82r2TeRPed4iqNrG
   4grKNMA99+9m3D9SVdl5OmAKNxY+ixX4SGPBAmV7eODXtTfDMu66K7b7T
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="335803221"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="335803221"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 15:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="628377259"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 May 2022 15:02:17 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsAhM-0005Y2-Oe;
        Fri, 20 May 2022 22:02:16 +0000
Date:   Sat, 21 May 2022 06:01:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 9c55d99e099bd7aa6b91fce8718505c35d5dfc65
Message-ID: <62880fbd.grSairmKb4l+dX9b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 9c55d99e099bd7aa6b91fce8718505c35d5dfc65  x86/microcode: Add explicit CPU vendor dependency

elapsed time: 728m

configs tested: 149
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                               j2_defconfig
ia64                        generic_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
h8300                    h8300h-sim_defconfig
h8300                            allyesconfig
powerpc                     asp8347_defconfig
arm                          badge4_defconfig
sh                        sh7763rdp_defconfig
sh                         microdev_defconfig
riscv                            allyesconfig
arm                      jornada720_defconfig
um                                  defconfig
powerpc                        cell_defconfig
sh                                  defconfig
powerpc                    klondike_defconfig
powerpc64                           defconfig
powerpc                        warp_defconfig
mips                       capcella_defconfig
powerpc                 linkstation_defconfig
xtensa                  audio_kc705_defconfig
arm                           h3600_defconfig
parisc                generic-64bit_defconfig
sh                           se7619_defconfig
alpha                               defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
ia64                         bigsur_defconfig
sh                          landisk_defconfig
alpha                            allyesconfig
m68k                       m5208evb_defconfig
mips                             allyesconfig
mips                  decstation_64_defconfig
m68k                       bvme6000_defconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
m68k                          hp300_defconfig
mips                         mpc30x_defconfig
m68k                            q40_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           viper_defconfig
arm                             pxa_defconfig
m68k                        mvme147_defconfig
powerpc                     rainier_defconfig
powerpc                      mgcoge_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
sh                          sdk7786_defconfig
m68k                          sun3x_defconfig
sh                        sh7757lcr_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220519
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220519
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220519
x86_64                        randconfig-c007
riscv                randconfig-c006-20220519
mips                 randconfig-c004-20220519
i386                          randconfig-c001
arm                  randconfig-c002-20220519
s390                 randconfig-c005-20220519
powerpc                          g5_defconfig
hexagon                             defconfig
mips                     loongson2k_defconfig
arm                         s5pv210_defconfig
powerpc                   bluestone_defconfig
powerpc                      katmai_defconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
arm                         palmz72_defconfig
mips                            e55_defconfig
arm                        mvebu_v5_defconfig
arm                              alldefconfig
powerpc                  mpc885_ads_defconfig
powerpc                    gamecube_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220519
hexagon              randconfig-r041-20220519
s390                 randconfig-r044-20220519
riscv                randconfig-r042-20220519

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
