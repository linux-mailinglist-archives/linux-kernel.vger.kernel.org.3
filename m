Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D9154F2C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380903AbiFQIYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380867AbiFQIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:24:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5047064D0B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655454263; x=1686990263;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=f4LHhVxhLkz4pVhOgb5P3aqEgq0f0e1kZ6XdaE+AQmI=;
  b=N9Q9BCc3N87/c+DW3ity7T86C8UEuHlDxU+SyjauV+FOhRGmX10WF10S
   kvVqWzW+5MmJ+YgcE1y11hBqY7qo5C34WhQcHBsz9yxPhTINdUzOvGP4v
   QmfTAu8dK98WNX4IGElKXfVGHS281KVy+2w729z2D3s1JUlKAS236AZgg
   T0uYEYklMHKCBwpMgV02OuqehVv0UQ5LFNTNXJjE7yzEuRV/iypoQm+kV
   PBbbV2WgAppnr0+YKfpvqxVZY49+IZ/bGGkJtTloXLeXthQfrbf4ptKZm
   bMUjDukokafH7U55uP0tzoEOojc2y0eBH3UD6Ler/3tUhPZvwYyOqSur9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278248112"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278248112"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 01:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="641945841"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2022 01:22:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o27FR-000PFV-Gh;
        Fri, 17 Jun 2022 08:22:33 +0000
Date:   Fri, 17 Jun 2022 16:21:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.06.15c] BUILD SUCCESS
 39a7b06a0b5a00fc57b117d6abebf2d8dae21517
Message-ID: <62ac3992.WhLBYsLanoljCFAq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.06.15c
branch HEAD: 39a7b06a0b5a00fc57b117d6abebf2d8dae21517  context_tracking: Use arch_atomic_read() in __ct_state for KASAN

elapsed time: 730m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
microblaze                          defconfig
powerpc                 mpc834x_itx_defconfig
sh                   rts7751r2dplus_defconfig
m68k                       m5475evb_defconfig
powerpc                     tqm8548_defconfig
sh                             sh03_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          pxa910_defconfig
sh                      rts7751r2d1_defconfig
sh                         microdev_defconfig
parisc64                         alldefconfig
ia64                        generic_defconfig
mips                           xway_defconfig
powerpc                      ppc40x_defconfig
sh                            hp6xx_defconfig
xtensa                  nommu_kc705_defconfig
mips                             allmodconfig
xtensa                  cadence_csp_defconfig
mips                  decstation_64_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                        m5407c3_defconfig
arc                           tb10x_defconfig
arm                        realview_defconfig
sh                             espt_defconfig
sh                     sh7710voipgw_defconfig
sh                   sh7724_generic_defconfig
sh                              ul2_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220617
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
mips                             allyesconfig
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
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                           sama7_defconfig
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
riscv                             allnoconfig
arm                          collie_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                       cns3420vb_defconfig
powerpc                     tqm5200_defconfig
arm                          moxart_defconfig
arm                         s5pv210_defconfig
hexagon                             defconfig
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
riscv                randconfig-r042-20220616
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
