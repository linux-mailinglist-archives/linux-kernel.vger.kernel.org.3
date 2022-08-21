Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCE759B6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 01:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiHUXCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 19:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiHUXCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 19:02:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69251FCC5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 16:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661122938; x=1692658938;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mFgipm59hncFjiK65T534FRXbQUssltPnecmLAKLySI=;
  b=mJ08kyQOH0Zia7sl+uynEhcDC9xi2003JYM3kyPmval8YeAFi2j8CHiZ
   Rt4VDxl6Vj539Ivd8RV9UDgr9uzZvh/Oonf01+tS1XkmKCgZhztNfkplP
   s0vlow1VmM360GN4jau2hyEsxlNOhmYnsNr1MHsCHQquO/F9V0PoB6Ne+
   Rmkls0qxHXg/LLz7E2Lfgr+9VfEYD6QfolB9wICGOHZtyhgyFSR75rBLP
   5HzBnkDrr+WT3EsB7BrILYBO8r9BG5QDxSLRs8bEed0b8FgS/OLMaNYav
   ApEY7p99i1Z6TxLiTc5TieQOfUoYvHe/Fm5Gsegola5onOCO2hDxQkpAb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="357266611"
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="357266611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 16:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="559525198"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2022 16:02:16 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPtxP-0004cX-1v;
        Sun, 21 Aug 2022 23:02:15 +0000
Date:   Mon, 22 Aug 2022 07:02:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 fc2e426b1161761561624ebd43ce8c8d2fa058da
Message-ID: <6302b970.vFcDipENWnxAcKKr%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: fc2e426b1161761561624ebd43ce8c8d2fa058da  x86/unwind/orc: Unwind ftrace trampolines with correct ORC entry

elapsed time: 727m

configs tested: 107
configs skipped: 60

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                          randconfig-a012
x86_64                           rhel-8.3-syz
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                             allyesconfig
mips                     decstation_defconfig
arm                           imxrt_defconfig
mips                 decstation_r4k_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                       imx_v6_v7_defconfig
ia64                             alldefconfig
sh                           se7619_defconfig
arm                      integrator_defconfig
csky                                defconfig
microblaze                          defconfig
sh                        edosk7705_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
arm                        spear6xx_defconfig
parisc64                         alldefconfig
i386                          randconfig-c001
mips                           jazz_defconfig
arm                           h3600_defconfig
sh                     magicpanelr2_defconfig
alpha                               defconfig
openrisc                            defconfig
powerpc                 canyonlands_defconfig
arm                          lpd270_defconfig
arm                         lubbock_defconfig
sh                                  defconfig
parisc                generic-32bit_defconfig
arm                         axm55xx_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
sh                          rsk7269_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                         apollo_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
m68k                       m5275evb_defconfig
arm                           sama5_defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220821
powerpc                    adder875_defconfig
arm                         s3c6400_defconfig
arm                        cerfcube_defconfig
powerpc                      arches_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
parisc                              defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
riscv                    nommu_virt_defconfig
mips                malta_qemu_32r6_defconfig
arm                       cns3420vb_defconfig
hexagon              randconfig-r045-20220821
riscv                randconfig-r042-20220821
hexagon              randconfig-r041-20220821
s390                 randconfig-r044-20220821
x86_64                        randconfig-k001
arm                           spitz_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          moxart_defconfig
arm                         bcm2835_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
