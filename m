Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5C859D0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiHWFlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiHWFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:41:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF5E08C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661233269; x=1692769269;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=p1nIymyGi4DQmcTyI1wOnIm/805NiwBwtvLI0MuemV0=;
  b=TUxdWDFDosvoUPxPo92EzVXZRyNH3UAvhIlUKiriq8hDYsQWFZwTRSPO
   QE7xaUgRTrTrW1aJmYzKWPierJ3y5y2Cx4vMcGpmw8zrKARUcY/eyqWa+
   6xwyN4h7zqSgr4J83tlB57T7r1wrCdgz6FnIsx8Olr6CQtwO9pIkTp70I
   5TzJvo4ez8YGDGkjyMbiSO+wsCYH4nvEn3m5o5njdZmjx7h0g+zG6CWZC
   MxGbMc/7ZLsRcz6FR458TlqVEJMJJbRtEon8mv2T5BtcjWtp0bVqW5LCs
   X00E/gdSdM7GcISmLb6qIxtzvY7RuRdwKYohVS18HPl2x0C3KVfmgPQ90
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293595082"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="293595082"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="937327415"
Received: from lkp-server01.sh.intel.com (HELO 5b31f6010e99) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2022 22:41:08 -0700
Received: from kbuild by 5b31f6010e99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQMex-00001s-1b;
        Tue, 23 Aug 2022 05:41:07 +0000
Date:   Tue, 23 Aug 2022 13:40:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 d25c6948a6aad787d9fd64de6b5362c3f23cc8d0
Message-ID: <63046857.XaS+AJWjcr7dsUKQ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: d25c6948a6aad787d9fd64de6b5362c3f23cc8d0  RAS/CEC: Reduce offline page threshold for Intel systems

elapsed time: 722m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64               randconfig-a012-20220822
x86_64               randconfig-a013-20220822
x86_64               randconfig-a011-20220822
arc                  randconfig-r043-20220821
arc                  randconfig-r043-20220822
riscv                randconfig-r042-20220822
x86_64               randconfig-a016-20220822
x86_64               randconfig-a014-20220822
s390                 randconfig-r044-20220822
x86_64               randconfig-a015-20220822
m68k                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
i386                             allyesconfig
i386                                defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                 randconfig-a015-20220822
i386                 randconfig-a016-20220822
i386                 randconfig-a011-20220822
i386                 randconfig-a013-20220822
i386                 randconfig-a014-20220822
i386                 randconfig-a012-20220822
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
powerpc                    amigaone_defconfig
arc                           tb10x_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          amiga_defconfig
sparc                               defconfig
powerpc                      ppc6xx_defconfig
sh                          rsk7269_defconfig
arm                          exynos_defconfig
ia64                            zx1_defconfig
arm                        oxnas_v6_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
powerpc                        cell_defconfig
sh                                  defconfig
sh                          rsk7264_defconfig
powerpc                    sam440ep_defconfig
xtensa                  audio_kc705_defconfig
sh                               j2_defconfig
m68k                        mvme147_defconfig
xtensa                  nommu_kc705_defconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
sh                   sh7724_generic_defconfig
arm                      footbridge_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc85xx_cds_defconfig
loongarch                 loongson3_defconfig
mips                           xway_defconfig
ia64                             allmodconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         assabet_defconfig
powerpc                     asp8347_defconfig
powerpc                     tqm8548_defconfig
openrisc                    or1ksim_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220823
arc                              alldefconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
hexagon              randconfig-r041-20220822
hexagon              randconfig-r045-20220822
riscv                randconfig-r042-20220821
hexagon              randconfig-r045-20220821
hexagon              randconfig-r041-20220821
s390                 randconfig-r044-20220821
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                 randconfig-a002-20220822
i386                 randconfig-a005-20220822
i386                 randconfig-a001-20220822
i386                 randconfig-a006-20220822
i386                 randconfig-a003-20220822
i386                 randconfig-a004-20220822
x86_64                        randconfig-k001
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64               randconfig-a002-20220822
x86_64               randconfig-a005-20220822
x86_64               randconfig-a006-20220822
x86_64               randconfig-a003-20220822
x86_64               randconfig-a001-20220822
x86_64               randconfig-a004-20220822
arm                     am200epdkit_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     mpc5200_defconfig
powerpc                        fsp2_defconfig
arm                          sp7021_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    gamecube_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                     tqm5200_defconfig
arm                          pxa168_defconfig
arm                          ixp4xx_defconfig
arm                         palmz72_defconfig
mips                malta_qemu_32r6_defconfig
mips                           rs90_defconfig
arm                         s3c2410_defconfig
arm                                 defconfig
arm                   milbeaut_m10v_defconfig
arm                        neponset_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
