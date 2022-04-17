Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325E1504852
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiDQQec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiDQQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:34:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD52FFF3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650213114; x=1681749114;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DdWWPK6mlWPFFVGaMfAYxaPL+qS2fwy+U6YIfEvLa3A=;
  b=YkJ3XDqrizgVb36Lmnskov9PRb7h0qIPXk5b0/rpsSNgTtrbKADVjkct
   aWFlfgY3LBCuHdj+EDMhihoZI3O6Ac/mYGFBwXnu2uXZLKrb7OSw0L7dR
   ZoY0jje+19mwN1VMvm/+PFbvnHCFe19dBYws6WTtZNzTiawKJnE6Wm6Qc
   TM+VwzMFzkzYVJdsjagoe8pqzPiD6pSM/WuHTWg4pyB0SjB0hy3KrThDn
   AZuYQn+XW5CszUonmHcMXSWgyQpgaNEot8JYN/vzF9z32OjT4hbgT1Pgc
   oB3kHUlcrX/yZRYmTSvB7hMcMrd8hbju0pkiODJh1vuP6bSfjsmfcmTq4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="263573586"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="263573586"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 09:31:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="613353121"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2022 09:31:53 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ng7oW-00042L-HZ;
        Sun, 17 Apr 2022 16:31:52 +0000
Date:   Mon, 18 Apr 2022 00:31:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 8d16616d155b7b09fccc4cbad5420e3c7c8b0ac5
Message-ID: <625c40d1.EFi79+F9+XIxwl0l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 8d16616d155b7b09fccc4cbad5420e3c7c8b0ac5  rcutorture: Test polled expedited grace-period primitives

elapsed time: 1316m

configs tested: 142
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
mips                  decstation_64_defconfig
arm                            qcom_defconfig
sh                        dreamcast_defconfig
sh                   sh7724_generic_defconfig
um                           x86_64_defconfig
sh                   rts7751r2dplus_defconfig
arc                          axs103_defconfig
h8300                    h8300h-sim_defconfig
mips                      maltasmvp_defconfig
powerpc                     rainier_defconfig
powerpc                         wii_defconfig
csky                                defconfig
openrisc                            defconfig
sh                          rsk7269_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
arm                        clps711x_defconfig
sh                          r7785rp_defconfig
m68k                        stmark2_defconfig
sh                          polaris_defconfig
mips                         tb0226_defconfig
sh                           se7206_defconfig
mips                     loongson1b_defconfig
arc                           tb10x_defconfig
powerpc                        warp_defconfig
sh                   sh7770_generic_defconfig
arm                           imxrt_defconfig
ia64                         bigsur_defconfig
arm                           viper_defconfig
powerpc                  storcenter_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          landisk_defconfig
sh                           se7724_defconfig
sh                           se7721_defconfig
powerpc                 mpc8540_ads_defconfig
arm                  randconfig-c002-20220417
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220417
riscv                randconfig-r042-20220417
s390                 randconfig-r044-20220417
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                  randconfig-c002-20220417
x86_64                        randconfig-c007
mips                 randconfig-c004-20220417
powerpc              randconfig-c003-20220417
i386                          randconfig-c001
riscv                randconfig-c006-20220417
s390                 randconfig-c005-20220417
arm                       mainstone_defconfig
mips                        bcm63xx_defconfig
mips                       lemote2f_defconfig
powerpc                     kmeter1_defconfig
mips                      malta_kvm_defconfig
arm                         mv78xx0_defconfig
mips                      pic32mzda_defconfig
mips                          ath79_defconfig
arm                           omap1_defconfig
mips                   sb1250_swarm_defconfig
powerpc                   bluestone_defconfig
arm                         socfpga_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                              alldefconfig
mips                        qi_lb60_defconfig
arm                  colibri_pxa300_defconfig
arm                        vexpress_defconfig
powerpc                          allyesconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220417
hexagon              randconfig-r045-20220417
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
