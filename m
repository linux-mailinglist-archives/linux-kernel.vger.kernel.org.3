Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027084BEE97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiBVAHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:07:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiBVAHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:07:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F2624BCD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645488408; x=1677024408;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3HzVFK3mQ2/v5mgP5sKWL4kGEevLaeiZ5dHoBhT/ZeQ=;
  b=fzVaAUr5OgViQZubqqOqAa0PwSkwnalGqU5hw17CU5vN+V4O8tBPBkLo
   aLyfiEbQdJvxy0RIAUsOr3d+/GM31phGAU8FE/R9S6G03+6lJpANkZkqP
   NkeGDaKJuHcQKQ72yriS2UshIdydrBIhBnJzYChyTGgPyPAaGy+1lqS+W
   H1uQA/N0uh7NxMzhqLZ3RIE9QJLiWRLKuHI0WbAbzMk+Se3UAu53C8yYp
   hJGjPLhOAmgT5es9bvWZc3nBTsj0gl6Eknfd+KxqJcW5j61rSuAjVeVdW
   vxX/x9A0byRFxP6rV0xVB0jfGmoOxfLBiCLcD9SNViVwgq/a1rquFSN1a
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276177948"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="276177948"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 16:06:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="683325984"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2022 16:06:46 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMIhZ-00027b-Pl; Tue, 22 Feb 2022 00:06:45 +0000
Date:   Tue, 22 Feb 2022 08:06:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 d2206fcabdfaff3958ab67cc5b8f63257e57b889
Message-ID: <621428e8.61hFhTa3x2ASrX2L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: d2206fcabdfaff3958ab67cc5b8f63257e57b889  Merge tag 'irq-api-2022-02-21' into irq/core

elapsed time: 729m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220221
powerpc                      chrp32_defconfig
sh                         ap325rxa_defconfig
sh                   secureedge5410_defconfig
mips                         mpc30x_defconfig
sh                          kfr2r09_defconfig
powerpc                         wii_defconfig
sh                   rts7751r2dplus_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                        mvme147_defconfig
powerpc                       ppc64_defconfig
alpha                            alldefconfig
sh                           se7724_defconfig
powerpc                      mgcoge_defconfig
arc                 nsimosci_hs_smp_defconfig
riscv                               defconfig
mips                 decstation_r4k_defconfig
sh                           se7780_defconfig
sh                     magicpanelr2_defconfig
mips                             allyesconfig
arm                      jornada720_defconfig
sh                               allmodconfig
powerpc                  storcenter_defconfig
mips                         tb0226_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
sh                           se7721_defconfig
m68k                        m5407c3_defconfig
s390                             allyesconfig
arm                          pxa3xx_defconfig
powerpc                        warp_defconfig
sh                           sh2007_defconfig
arm                        clps711x_defconfig
arm                            pleb_defconfig
powerpc                       holly_defconfig
sh                   sh7770_generic_defconfig
xtensa                  cadence_csp_defconfig
powerpc                    amigaone_defconfig
powerpc                     redwood_defconfig
mips                         db1xxx_defconfig
sh                ecovec24-romimage_defconfig
powerpc                         ps3_defconfig
mips                        jmr3927_defconfig
sparc64                             defconfig
sh                        sh7757lcr_defconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
powerpc                        cell_defconfig
powerpc                  iss476-smp_defconfig
s390                                defconfig
arc                          axs101_defconfig
h8300                     edosk2674_defconfig
powerpc                 linkstation_defconfig
powerpc                     sequoia_defconfig
arm                  randconfig-c002-20220221
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220221
x86_64               randconfig-a001-20220221
x86_64               randconfig-a003-20220221
x86_64               randconfig-a006-20220221
x86_64               randconfig-a004-20220221
x86_64               randconfig-a005-20220221
i386                 randconfig-a002-20220221
i386                 randconfig-a001-20220221
i386                 randconfig-a005-20220221
i386                 randconfig-a003-20220221
i386                 randconfig-a006-20220221
i386                 randconfig-a004-20220221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220221
x86_64               randconfig-c007-20220221
arm                  randconfig-c002-20220221
mips                 randconfig-c004-20220221
i386                 randconfig-c001-20220221
riscv                randconfig-c006-20220221
arm                          moxart_defconfig
x86_64               randconfig-a011-20220221
x86_64               randconfig-a015-20220221
x86_64               randconfig-a014-20220221
x86_64               randconfig-a016-20220221
x86_64               randconfig-a013-20220221
x86_64               randconfig-a012-20220221
i386                 randconfig-a016-20220221
i386                 randconfig-a012-20220221
i386                 randconfig-a015-20220221
i386                 randconfig-a011-20220221
i386                 randconfig-a014-20220221
i386                 randconfig-a013-20220221
hexagon              randconfig-r045-20220221
hexagon              randconfig-r041-20220221
riscv                randconfig-r042-20220221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
