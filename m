Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E644E4BD1EF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 22:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbiBTVW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 16:22:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245090AbiBTVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 16:22:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568B81D0F1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645392115; x=1676928115;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GC+2z8Lu5NgjhX4XI6uIC3F0yiHjPZQt2eUDHq0B4p0=;
  b=bMjeTVacDLxRxP/W7lTeHgus2tsVDyPxZadGE9pBpMy1pTzpBShjqKAH
   vrYEb7PqDAJR3WdV42clSP/PKnE31o4wwYak6JRpcKb839ftoCDQkeMdn
   dAL9fMlhwy/lKjVVyhudLZ+81kIYRee0I1Umls1XRcymvk0H1M8YP145V
   H1BdZ9Bko4FesYiDN/eOOIToy6vHMWWfe6ALL2CDrTUbgsQJzydL0bqo/
   nnH65CWkS1Ttlcx1FsAyq/qbfMBoiZd+MeQ9Hc5QWmuVdM6HFCQ9F2/GU
   WEJrDcgg2XxOL8q/rz/DZbiWEmqlX8fHVo4ysUJJcOg+VPRuSXNTaezbG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="250222381"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="250222381"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 13:21:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="547088194"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2022 13:21:53 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLteS-0000oM-Ju; Sun, 20 Feb 2022 21:21:52 +0000
Date:   Mon, 21 Feb 2022 05:21:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 44cad52cc14ae10062f142ec16ede489bccf4469
Message-ID: <6212b0ce.xOhloc0Jx/t7NIq+%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 44cad52cc14ae10062f142ec16ede489bccf4469  x86/ptrace: Fix xfpregs_set()'s incorrect xmm clearing

elapsed time: 730m

configs tested: 135
configs skipped: 135

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
powerpc                     redwood_defconfig
arm                          badge4_defconfig
arm                         lpc18xx_defconfig
powerpc                     pq2fads_defconfig
mips                             allyesconfig
ia64                         bigsur_defconfig
mips                      maltasmvp_defconfig
xtensa                    smp_lx200_defconfig
xtensa                          iss_defconfig
powerpc                      ppc40x_defconfig
sh                        edosk7760_defconfig
powerpc                       ppc64_defconfig
arm                       multi_v4t_defconfig
powerpc                    klondike_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
alpha                               defconfig
powerpc                      pcm030_defconfig
mips                       bmips_be_defconfig
h8300                            alldefconfig
powerpc                    sam440ep_defconfig
powerpc                   motionpro_defconfig
sh                             espt_defconfig
powerpc                     tqm8555_defconfig
sh                           se7343_defconfig
sh                   rts7751r2dplus_defconfig
nios2                         10m50_defconfig
arm                         lubbock_defconfig
sh                         ecovec24_defconfig
mips                           xway_defconfig
mips                      loongson3_defconfig
arm64                            alldefconfig
powerpc                     rainier_defconfig
sh                        dreamcast_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        vocore2_defconfig
um                           x86_64_defconfig
sh                           se7751_defconfig
arm                            zeus_defconfig
sh                        sh7763rdp_defconfig
powerpc                      bamboo_defconfig
nds32                               defconfig
sh                          landisk_defconfig
powerpc                      ppc6xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220220
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a001
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a013
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
powerpc                    mvme5100_defconfig
powerpc                        fsp2_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     mpc5200_defconfig
powerpc                     kilauea_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
