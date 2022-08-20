Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2927F59ABD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbiHTGst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbiHTGsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:48:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D02019C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660978113; x=1692514113;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ANac5rmsWEEFgxc9oMLOxCcT6rImUprpc90XJdhlGrU=;
  b=bS9EvTlvggY5rMzkqUwZFgFwWIQt83j1f1rh3zmmYbJHaUNAMMLMshI0
   IP6EL1CKqGNjOoAbOBIsFppKtI9Sk9WZPtfjRq9ZWCS8+D2f7ldFUow9r
   rzDMmdQ8v1o4MOfjwgX4HN+IheP7SjIwjgR9oMyEmTJ1u3wn71FrQV72B
   iaMmE6jevQw2NcsOE3lvuwfEgJMoHVR7CGi/KEn9jGTNUWR4G4nWe2XEf
   bZDip7c/e5W0q75/Qr9pCdx6ICB48h6kilH7TitxMNHILZJOqL8Ct46YM
   5u0SVn1wdja5HPEAEZsPii3g9jiceTRyus0GUF5NXZ7/qLF9D1x8vkshj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="293156314"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="293156314"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 23:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="936458239"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2022 23:48:30 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPIHV-0002IB-2u;
        Sat, 20 Aug 2022 06:48:29 +0000
Date:   Sat, 20 Aug 2022 14:47:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 254abba1863ae7bfc1a698661450cb7aee300f54
Message-ID: <63008382.AnX8tm7d4X0Sxt9Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 254abba1863ae7bfc1a698661450cb7aee300f54  Merge branch into tip/master: 'x86/timers'

elapsed time: 720m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
alpha                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
m68k                             allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
i386                                defconfig
arc                              allyesconfig
x86_64                        randconfig-a015
riscv             nommu_k210_sdcard_defconfig
powerpc                           allnoconfig
riscv                randconfig-r042-20220820
s390                 randconfig-r044-20220820
arc                  randconfig-r043-20220820
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-c001
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                      rts7751r2d1_defconfig
powerpc                 mpc834x_itx_defconfig
mips                      fuloong2e_defconfig
powerpc                    klondike_defconfig
m68k                             alldefconfig
sh                           se7722_defconfig
arm                        spear6xx_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
xtensa                generic_kc705_defconfig
arm                        mini2440_defconfig
microblaze                          defconfig
powerpc                 linkstation_defconfig
arm                             ezx_defconfig
ia64                                defconfig
um                                  defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
s390                       zfcpdump_defconfig
mips                           jazz_defconfig
m68k                            mac_defconfig
powerpc                     stx_gp3_defconfig
m68k                          amiga_defconfig
arm                        oxnas_v6_defconfig
powerpc                      ppc40x_defconfig
microblaze                      mmu_defconfig
arm                         cm_x300_defconfig
xtensa                          iss_defconfig
mips                     decstation_defconfig
arm                            qcom_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
sh                         apsh4a3a_defconfig
arc                 nsimosci_hs_smp_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                          atari_defconfig
sh                          sdk7780_defconfig
sh                         ecovec24_defconfig

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                      ppc64e_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                        randconfig-k001
mips                        omega2p_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
arm                       mainstone_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                     loongson1c_defconfig
i386                             allyesconfig
powerpc                     ksi8560_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
