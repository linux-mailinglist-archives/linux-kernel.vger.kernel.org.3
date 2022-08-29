Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2C5A55B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiH2Ulv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2Uls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:41:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D657E020
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661805707; x=1693341707;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mbnLPx8S7d45TZIJsNAxM+Pgbdj0xqDab9amy0XsdBA=;
  b=SkBb4tYXMa6R1uBdGb4IUx8MP9fylf8wDqegmDuG5jaS7W8aeLO3cn4O
   ZYxiOqHv41ih/vwV8RbfGI5QH9+xOfkWgx2mN7YzGTMPq73R1fS3Ruyfs
   QqHBfBLPs7xq4gJIKWg3VGyIa8VX7JUA12EY6AALnipgiSugcojMWfzzQ
   JlVjy/jx7XeT70cCGQttqCLPIhTe8fFu6sck+f+06sLmA3MNqfoB1nGBL
   ZKaYXBUmfWF35EauH4eaLe98iBDwvDrtHJULN0itzUDhi3V66S+DiFAeo
   E8F8HL3KBrnsbUoK01tr+rIS6fG+Y8Ez9DzU5R+b2/wxBMIkW9PeZfLlo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="294998185"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="294998185"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="679761232"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2022 13:41:46 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSlZp-0000FT-0V;
        Mon, 29 Aug 2022 20:41:45 +0000
Date:   Tue, 30 Aug 2022 04:41:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 f9781bb18ed828e7b83b7bac4a4ad7cd497ee7d7
Message-ID: <630d245d.KuNIkbf/PxLYFIiB%lkp@intel.com>
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
branch HEAD: f9781bb18ed828e7b83b7bac4a4ad7cd497ee7d7  x86/mce: Retrieve poison range from hardware

elapsed time: 722m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
loongarch                         allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
arc                  randconfig-r043-20220829
x86_64                               rhel-8.3
x86_64                    rhel-8.3-kselftests
i386                                defconfig
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
x86_64               randconfig-a003-20220829
x86_64               randconfig-a002-20220829
x86_64               randconfig-a001-20220829
x86_64               randconfig-a004-20220829
m68k                             allyesconfig
x86_64               randconfig-a005-20220829
i386                 randconfig-a004-20220829
csky                                defconfig
i386                 randconfig-a005-20220829
i386                             allyesconfig
i386                 randconfig-a006-20220829
x86_64               randconfig-a006-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a003-20220829
i386                 randconfig-a002-20220829
x86_64                                  kexec
sparc                               defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc                     taishan_defconfig
arm                         axm55xx_defconfig
nios2                               defconfig
ia64                             allmodconfig
microblaze                      mmu_defconfig
arm                         lpc18xx_defconfig
powerpc                  storcenter_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
riscv                               defconfig
powerpc                       eiger_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                                defconfig
i386                 randconfig-c001-20220829
loongarch                           defconfig
sh                           se7722_defconfig
xtensa                  nommu_kc705_defconfig
arm                             ezx_defconfig
arm                            mps2_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5407c3_defconfig
sh                          r7780mp_defconfig
m68k                          multi_defconfig
sh                                  defconfig
sh                          r7785rp_defconfig
sh                             shx3_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
arm64                            alldefconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                           se7343_defconfig
sh                        edosk7705_defconfig

clang tested configs:
hexagon              randconfig-r041-20220829
riscv                randconfig-r042-20220829
s390                 randconfig-r044-20220829
hexagon              randconfig-r045-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a015-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a016-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a012-20220829
i386                 randconfig-a016-20220829
i386                 randconfig-a015-20220829
arm                        mvebu_v5_defconfig
x86_64               randconfig-k001-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
