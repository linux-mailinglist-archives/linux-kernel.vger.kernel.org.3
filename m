Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE85046D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 08:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiDQGgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 02:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiDQGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:36:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B642CC9B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650177209; x=1681713209;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8O8m9dZItrTx152+up2AdaWrOEKS8j8P+Zz/DNPzh7o=;
  b=Q4wr3I5TQkUcVYoLPfzX2O5erUp1fn7iztvtkXI9unlOC2+6vJ7hTcXn
   UDzC0iTZLm2c51c0TAypGlZuO7RyY6Zhj57lEnlRxeTtUAxTHXwm9OJsW
   pyWVEVcswiUWVjppO7HM//paBN6ujWvGmJA1CEzMZ/h+3CT3ijoyPs/uE
   sXfmaJQxqhZHeUo5mUcYnx6in6mAIBCHl4dXWb232IC3WwX5RDVJqJpTQ
   fVV9RFHphTswSK8Lobh2gGrEgNTm/jzBhkXDDX8oTHdHJQ8JYFDek2Jya
   R6HdnPyKr4Dj13eyXhP9q6GohQo4m6YsmcyH1MWvWXZUTuceSRSU7/A6n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="326266680"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="326266680"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 23:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="726268313"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2022 23:33:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfyTO-0003jJ-Vn;
        Sun, 17 Apr 2022 06:33:26 +0000
Date:   Sun, 17 Apr 2022 14:33:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:fastexp.2022.04.16a] BUILD SUCCESS
 209a765cb52bf942f8073d52e6277a99a2b7e3a2
Message-ID: <625bb4a2.GwSlOFz8x1m/TlfS%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git fastexp.2022.04.16a
branch HEAD: 209a765cb52bf942f8073d52e6277a99a2b7e3a2  rcu: Move expedited grace period (GP) work to RT kthread_worker

elapsed time: 720m

configs tested: 120
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                      loongson3_defconfig
sh                           se7750_defconfig
arm                       imx_v6_v7_defconfig
sh                            titan_defconfig
m68k                        m5272c3_defconfig
mips                      maltasmvp_defconfig
arm                        clps711x_defconfig
sh                          r7785rp_defconfig
m68k                        stmark2_defconfig
sh                          polaris_defconfig
mips                         tb0226_defconfig
arm                     eseries_pxa_defconfig
arm                          gemini_defconfig
sh                           se7712_defconfig
arm                           imxrt_defconfig
ia64                         bigsur_defconfig
arm                           viper_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7721_defconfig
sh                           se7724_defconfig
arm                  randconfig-c002-20220417
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220417
riscv                randconfig-r042-20220417
s390                 randconfig-r044-20220417
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220417
arm                  randconfig-c002-20220417
i386                          randconfig-c001
riscv                randconfig-c006-20220417
arm                  colibri_pxa270_defconfig
riscv                    nommu_virt_defconfig
powerpc                     mpc512x_defconfig
arm                           sama7_defconfig
powerpc                   bluestone_defconfig
powerpc                     tqm5200_defconfig
powerpc                     powernv_defconfig
mips                            e55_defconfig
powerpc                  mpc866_ads_defconfig
arm                              alldefconfig
mips                      pic32mzda_defconfig
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220417
hexagon              randconfig-r045-20220417

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
