Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA8D59D0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiHWFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiHWFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:41:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE111461
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661233269; x=1692769269;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mg95FBXN0KdoAhs1PI0mE1otGnckCun7D+2/Dyv33Uo=;
  b=YaL4f0Shc6xnnhHb3z8it6aRgXcheUzj6IppJcIDEZmI8npFhV/cnCVk
   DCDbbCXFCe5p6wie8IGKfLky07QwKKYOjqPNaIiG5ojbUT3ZIkGLIR0xV
   E3D45lseW2z0tpGI4rpwOQO3uAYrHZijc1XCUzWEOcNRhoFiIbV207rUO
   e3pejWgzFaxa9Vsok610qyskU1Wu5QX+XpYHF4Icl0ail1A1z+yihQlQw
   4bS5JP87ooR9wNUsOieBJllHkze7eeKmmaOHqImrgimqHTDNcVyPiOjtp
   DtWcC5+lorwISJdFSJgqB2rL4FPnGELjiJcDReR9AYbF+ca1h4srYNTjW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355327506"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="355327506"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="854743802"
Received: from lkp-server01.sh.intel.com (HELO 5b31f6010e99) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2022 22:41:08 -0700
Received: from kbuild by 5b31f6010e99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQMex-00001u-1h;
        Tue, 23 Aug 2022 05:41:07 +0000
Date:   Tue, 23 Aug 2022 13:40:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.08.15a] BUILD SUCCESS
 8590389ffb137a406e0298e15dec0ebc08018fbf
Message-ID: <6304685f.RMPSUuvTNu/EhhAk%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.08.15a
branch HEAD: 8590389ffb137a406e0298e15dec0ebc08018fbf  doc/rcu: Update LWN article URLs and add 2019 article

elapsed time: 727m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220821
arc                  randconfig-r043-20220822
riscv                randconfig-r042-20220822
powerpc                           allnoconfig
m68k                             allmodconfig
powerpc                          allmodconfig
arc                              allyesconfig
s390                 randconfig-r044-20220822
alpha                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
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
m68k                             allyesconfig
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
x86_64               randconfig-a013-20220822
x86_64               randconfig-a014-20220822
x86_64               randconfig-a011-20220822
x86_64               randconfig-a016-20220822
x86_64               randconfig-a012-20220822
x86_64               randconfig-a015-20220822
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
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                         assabet_defconfig
powerpc                     asp8347_defconfig
powerpc                     tqm8548_defconfig
openrisc                    or1ksim_defconfig
arc                              alldefconfig
arc                                 defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220823
ia64                             allmodconfig
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
x86_64               randconfig-a002-20220822
x86_64               randconfig-a003-20220822
x86_64               randconfig-a001-20220822
x86_64               randconfig-a006-20220822
x86_64               randconfig-a005-20220822
x86_64               randconfig-a004-20220822
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
