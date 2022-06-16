Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D7754E259
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377239AbiFPNrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376688AbiFPNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:47:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1916381B2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655387223; x=1686923223;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=IXK0ykvIxP0+klEILUEvEVK/D68IabMlJhtsf1HZv44=;
  b=MiEMFi+6H8iSAQoYtf3r974j0deWboMs89Yv2hh/b8HfhyN7tOWkPVgk
   6Vuixg9I66sBqCzbeZ2kkg+Ow5U6A1967OY3bwZC47aexvPNjcHoCGpdx
   KSRdlpUnwdvczdfT1RczHQFhO5yxrlu/GTcRD824ujcX5vMLMtgYUsAWA
   R36m9eLQcNzMmkpAx9p+FQ0nUTaeBBdYCFD7/vZicMPaMqbtRgdZcZGur
   p8CMuYgFI0K8UBn/gPsxP5284rw67/Sw+Fnn1hGYuFslEV24gBJZP9MoM
   ZKqxkhRavDVGPQ8Y3qHXiGuH0TOwZDc462St//msG60/8ufQ3dDpLHnnh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="365604038"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="365604038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="653164897"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2022 06:47:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1pps-000OQD-OM;
        Thu, 16 Jun 2022 13:47:00 +0000
Date:   Thu, 16 Jun 2022 21:46:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 e607cc3860162967a0c7391ad030bd6e7a8e270b
Message-ID: <62ab3427.60OBb6l9BR+u1A3e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e607cc3860162967a0c7391ad030bd6e7a8e270b  context_tracking: Interrupts always disabled for ct_idle_exit()

elapsed time: 1054m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                         bigsur_defconfig
m68k                        mvme147_defconfig
sh                         ap325rxa_defconfig
sh                      rts7751r2d1_defconfig
arm                        keystone_defconfig
sh                                  defconfig
m68k                       m5475evb_defconfig
s390                          debug_defconfig
arm                         at91_dt_defconfig
sh                   secureedge5410_defconfig
um                                  defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      cm5200_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
m68k                        m5307c3_defconfig
arc                              allyesconfig
sh                          landisk_defconfig
sh                             shx3_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8548_defconfig
m68k                       m5249evb_defconfig
powerpc                      makalu_defconfig
m68k                       m5275evb_defconfig
arm                            xcep_defconfig
arm                         nhk8815_defconfig
xtensa                         virt_defconfig
arm                        clps711x_defconfig
arm                           sunxi_defconfig
mips                       capcella_defconfig
nios2                         10m50_defconfig
microblaze                      mmu_defconfig
arc                         haps_hs_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
mips                             allmodconfig
sparc                               defconfig
m68k                          hp300_defconfig
m68k                        stmark2_defconfig
powerpc                         wii_defconfig
arm                        trizeps4_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
arm                      integrator_defconfig
s390                                defconfig
powerpc                     pq2fads_defconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
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
mips                          ath25_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8540_defconfig
powerpc                       ebony_defconfig
powerpc                   microwatt_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    socrates_defconfig
x86_64                        randconfig-k001
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
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
