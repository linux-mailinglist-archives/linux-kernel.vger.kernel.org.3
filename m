Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3515993B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbiHSDnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHSDnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:43:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618902DA90
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660880615; x=1692416615;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VcK/uEhddtPpiXx32oXs6WPjvn4EoVih8zuVyhlR2nU=;
  b=kF8DjYsPvLbjvaG4AHu6+jiuSBH1zjFwCBj+yAF1pOT/NG7u+dPPmt/f
   V2ycE7GO0iUooZ4Taibwmy54NbGOZBHWZGVZWUmj444zcTFfC2VY4w6Y3
   7CP/+A/VmWpct76i7EYNxCXETaq6bcRxbJh9aj8t7SjOuJQyKNnRPD3MV
   2xZm3XKi0qGjmRreL4kwwYfUj/XmOokeK+IVqvx97WJg6T4CPXemv54m/
   BoAnA6O/4reBLBThB4luki4Qc3KKOdEjzEjyGYzVy9tUZtr4gJjXyZGUI
   vVcr259AtIWLSw6aOjh0Lc2oJKjf96BG1fsQZg/wJPK5B8OU94jo8jgKO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="291684737"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="291684737"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 20:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="584491704"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 20:43:33 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOsuy-00011X-36;
        Fri, 19 Aug 2022 03:43:32 +0000
Date:   Fri, 19 Aug 2022 11:43:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 57646d6769f13f9484ffc6869c493e25a6568073
Message-ID: <62ff06d1.HwBlkQ4JLbGGxsz6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 57646d6769f13f9484ffc6869c493e25a6568073  Merge tag 'irqchip-fixes-6.0-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 722m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                  randconfig-r043-20220818
um                             i386_defconfig
um                           x86_64_defconfig
riscv                randconfig-r042-20220818
x86_64                              defconfig
i386                          randconfig-a001
arc                              allyesconfig
s390                 randconfig-r044-20220818
x86_64                           allyesconfig
i386                          randconfig-a003
x86_64                               rhel-8.3
i386                                defconfig
x86_64                        randconfig-a002
i386                          randconfig-a005
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
arm                                 defconfig
i386                          randconfig-a014
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                          allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
sh                               allmodconfig
arm                              allyesconfig
x86_64                        randconfig-a004
i386                          randconfig-a012
arm64                            allyesconfig
i386                          randconfig-a016
i386                             allyesconfig
powerpc                         wii_defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                      cm5200_defconfig
mips                            gpr_defconfig
sh                   rts7751r2dplus_defconfig
sh                                  defconfig
sh                               alldefconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
loongarch                           defconfig
loongarch                         allnoconfig
sparc                             allnoconfig
m68k                         amcore_defconfig
xtensa                              defconfig
ia64                                defconfig
arm                           sama5_defconfig
um                                  defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
sparc                       sparc64_defconfig
m68k                        m5307c3_defconfig
i386                          randconfig-c001
m68k                           sun3_defconfig
sh                           sh2007_defconfig
arm                          gemini_defconfig
sh                          landisk_defconfig
sh                        apsh4ad0a_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                          rsk7201_defconfig
arm                           sunxi_defconfig
arc                 nsimosci_hs_smp_defconfig
loongarch                        alldefconfig
m68k                                defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
arm                        clps711x_defconfig
arm                      footbridge_defconfig
arm                            qcom_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
arm64                               defconfig
m68k                          hp300_defconfig
openrisc                       virt_defconfig
arm                          pxa910_defconfig
arm                        realview_defconfig
arm                        keystone_defconfig
arm                             ezx_defconfig
xtensa                  audio_kc705_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20220818
hexagon              randconfig-r045-20220818
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
x86_64                        randconfig-a005
i386                          randconfig-a006
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a003
i386                          randconfig-a011
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
mips                          ath25_defconfig
powerpc                          allmodconfig
mips                        omega2p_defconfig
arm                             mxs_defconfig
x86_64                        randconfig-k001
riscv                randconfig-r042-20220819
s390                 randconfig-r044-20220819
hexagon              randconfig-r045-20220819
hexagon              randconfig-r041-20220819
arm                         s5pv210_defconfig
arm                         shannon_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
