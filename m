Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0AD4BD114
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbiBTTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:45:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiBTTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:45:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7129A30F46
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645386290; x=1676922290;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tsUBFC9uX4YJggheomTNY31SBGo0Q0lQwSvlPgeaSdg=;
  b=oFzxNX3PTx6V5Blj0mreId/4bERXnWGAnBq3gfgfvIRLTdhR2DAUI2Xd
   Dxj5OES7mx3SDySyRg4UlyPs2Oa+ciWuJkIErpgQfNGBIh2ov4Jk8zLxB
   zvKnm4m/alevsuQ3zeOgPS5kfT+xN5VR7cS1HbxYIFMSghhBfssqd6V+U
   FLDjDs9GL0P/sHRsd3Lb7dLkao/PZUv9GdKxE72PoGJesUpQFrYeRGwLm
   q0K4Mv2rrRKEcJuAoxAQ/83dKg9u3qi/lKjg2LyT9WYNLc6hWgL7t6syN
   39jPVfHu1VOwI/J6cs3/ClWZ+51l+UWp2amgBNIEwkP5g5v3JgPTgs1YA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="250217036"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="250217036"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 11:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="775795850"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Feb 2022 11:44:48 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLs8W-0000fe-8u; Sun, 20 Feb 2022 19:44:48 +0000
Date:   Mon, 21 Feb 2022 03:44:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 1b40a3d2152f568a7fc22535b135525cf7185c81
Message-ID: <62129a0d.5yAbzhYbMdCqH/nn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 1b40a3d2152f568a7fc22535b135525cf7185c81  docs: Add documentation for rude and trace RCU flavors

elapsed time: 4243m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
mips                 randconfig-c004-20220220
i386                          randconfig-c001
nios2                               defconfig
sh                          landisk_defconfig
xtensa                    smp_lx200_defconfig
alpha                            alldefconfig
arm                         lpc18xx_defconfig
powerpc                     pq2fads_defconfig
mips                             allyesconfig
ia64                         bigsur_defconfig
mips                      maltasmvp_defconfig
powerpc                       maple_defconfig
arc                                 defconfig
sh                         microdev_defconfig
mips                  decstation_64_defconfig
parisc                generic-32bit_defconfig
m68k                            mac_defconfig
powerpc                        cell_defconfig
openrisc                            defconfig
sh                          r7785rp_defconfig
arm                        realview_defconfig
alpha                               defconfig
arm                         assabet_defconfig
xtensa                         virt_defconfig
xtensa                    xip_kc705_defconfig
mips                         db1xxx_defconfig
arm                             rpc_defconfig
powerpc                       eiger_defconfig
sh                        edosk7760_defconfig
powerpc                       ppc64_defconfig
arc                          axs101_defconfig
arc                        vdk_hs38_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
h8300                               defconfig
microblaze                      mmu_defconfig
powerpc                      mgcoge_defconfig
arm                         lubbock_defconfig
sh                     sh7710voipgw_defconfig
mips                         cobalt_defconfig
powerpc                    sam440ep_defconfig
powerpc                   motionpro_defconfig
sh                             espt_defconfig
powerpc                     tqm8555_defconfig
sh                           se7343_defconfig
sh                   rts7751r2dplus_defconfig
powerpc64                        alldefconfig
nios2                         10m50_defconfig
sh                         ecovec24_defconfig
powerpc                     tqm8541_defconfig
sh                   sh7724_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                        dreamcast_defconfig
sh                           sh2007_defconfig
arm64                            alldefconfig
powerpc                     rainier_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        vocore2_defconfig
arm                        shmobile_defconfig
sparc                       sparc64_defconfig
arm                            zeus_defconfig
um                               alldefconfig
m68k                          multi_defconfig
powerpc                     asp8347_defconfig
sh                        sh7763rdp_defconfig
powerpc                      pasemi_defconfig
arm                           h5000_defconfig
arm                  randconfig-c002-20220220
arm                  randconfig-c002-20220217
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
powerpc              randconfig-c003-20220220
x86_64                        randconfig-c007
arm                  randconfig-c002-20220220
mips                 randconfig-c004-20220220
i386                          randconfig-c001
riscv                randconfig-c006-20220220
arm                          collie_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
mips                        bcm63xx_defconfig
powerpc                     kmeter1_defconfig
powerpc                     mpc5200_defconfig
powerpc                     kilauea_defconfig
arm                      tct_hammer_defconfig
riscv                            alldefconfig
arm                            dove_defconfig
powerpc                      pmac32_defconfig
powerpc                     tqm5200_defconfig
arm                        magician_defconfig
mips                        workpad_defconfig
powerpc                   bluestone_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220220
hexagon              randconfig-r041-20220220
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
