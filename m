Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C9B4DE5E0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 05:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbiCSED1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 00:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbiCSEDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:03:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD3179419
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647662523; x=1679198523;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5eRdhNRcRyE5yLK2LJKiW8aXnJP36qulP2WK2duIVds=;
  b=kli6LI/uoY4WhJK1k+n7zeELD6bv1Wv1VSHhbo7poKDkkyfiSNJ4akCH
   5u1XvRp69pIBPtiJa73xmi5FiH2zKT26l8jh6sp1T5GMwq0EmZJjGC4Wn
   Bl+nYYc/ucAsWPaHimZ/5AfFItszYK0YkGtDHBACPKBVLUrBk2NSyyHav
   NkXkSILM01RVcoKdJAAIg16QNuTrgg+nbcKcMEW+J+p4EqXBi2+diZ5iF
   5chbfSHMSdXDbrKd3u25LXFuri6EmPQYh30XvLFX0VRgSOfEov++jHZDE
   G1C6VEwKKfyCkNIVYo2cqP8rfPvHumW1B+x4tDsj9c4xPo8dgk40JEYUU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="343707637"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343707637"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 21:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715766747"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 21:01:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVQHv-000FYf-48; Sat, 19 Mar 2022 04:01:59 +0000
Date:   Sat, 19 Mar 2022 12:01:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 2f35e67f621fffc636cb802a4f93fd168cf38274
Message-ID: <62355592.dVnwrdbybuVmRwtq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 2f35e67f621fffc636cb802a4f93fd168cf38274  kbuild: Fixup the IBT kbuild changes

elapsed time: 953m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm64                            alldefconfig
arm                            xcep_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         ap325rxa_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
m68k                          multi_defconfig
mips                         rt305x_defconfig
ia64                        generic_defconfig
arm                        keystone_defconfig
xtensa                           alldefconfig
openrisc                         alldefconfig
m68k                        m5307c3_defconfig
arc                         haps_hs_defconfig
powerpc                           allnoconfig
arm                          lpd270_defconfig
powerpc                       holly_defconfig
sparc                            alldefconfig
sh                ecovec24-romimage_defconfig
arc                                 defconfig
mips                         mpc30x_defconfig
m68k                           sun3_defconfig
sh                        edosk7705_defconfig
alpha                            alldefconfig
arm                             rpc_defconfig
sh                             espt_defconfig
sh                           se7619_defconfig
arm                        trizeps4_defconfig
sh                           se7705_defconfig
sh                          sdk7780_defconfig
powerpc                      bamboo_defconfig
arm                         lubbock_defconfig
sh                           sh2007_defconfig
arc                          axs101_defconfig
arm                             pxa_defconfig
mips                  maltasmvp_eva_defconfig
arm                        realview_defconfig
m68k                            mac_defconfig
sh                            hp6xx_defconfig
arm                  randconfig-c002-20220317
arm                  randconfig-c002-20220318
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220317
arc                  randconfig-r043-20220318
riscv                randconfig-r042-20220317
arc                  randconfig-r043-20220317
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220318
s390                 randconfig-c005-20220317
s390                 randconfig-c005-20220318
arm                  randconfig-c002-20220317
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220318
riscv                randconfig-c006-20220318
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
mips                 randconfig-c004-20220318
i386                          randconfig-c001
mips                        qi_lb60_defconfig
hexagon                          alldefconfig
powerpc                     tqm8540_defconfig
mips                           ip22_defconfig
powerpc                     mpc512x_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r041-20220318
riscv                randconfig-r042-20220318
hexagon              randconfig-r041-20220317
s390                 randconfig-r044-20220318
hexagon              randconfig-r045-20220317

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
