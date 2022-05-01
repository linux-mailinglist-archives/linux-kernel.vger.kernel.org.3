Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC055167F3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 23:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354915AbiEAVD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354821AbiEAVDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 17:03:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7E1839E
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651438798; x=1682974798;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sTXUHZGRdaQGIilzruUCfrQPVIuxTfDw0+VGOd61v3Q=;
  b=NgixMk5OdnLill6mz+BjcqXECVDyPSiNjSyUp/AadWgSaFQuGBNB2Y2j
   pkaPfGDP2hjEqurqoEgwVWeKt7HHS2O047lTePCI3b9QT4hdwPdDX8QQ8
   IQd+mo5CqK6w8gjXSUv3lTJurlo+USIx15PRC0iXTats6iApT2XrQ2ADj
   uDTTr4h6vHOGhOOyFVPFRDeitrHDZhQm5msp8lqgpDaSEMYlh8+O9qda+
   enk3pj4gX9EkCN5VyqgEGOqG02vMlCE4xMNmoV15SdU6VbSKUX/iQqUoU
   4KDsvzOl0GAGUqGDNe9Usi6lIyRiaxs18tOLmbWQ3Kk7zw8XtWjydNhj+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247614176"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="247614176"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 13:59:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="688945535"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2022 13:59:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlGfb-00093R-SB;
        Sun, 01 May 2022 20:59:55 +0000
Date:   Mon, 02 May 2022 04:59:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7e0815b3e09986d2fe651199363e135b9358132a
Message-ID: <626ef4a9./No71nRMp7N+KVqk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 7e0815b3e09986d2fe651199363e135b9358132a  x86/pci/xen: Disable PCI/MSI[-X] masking for XEN_HVM guests

elapsed time: 744m

configs tested: 123
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                         s3c6400_defconfig
parisc                generic-64bit_defconfig
alpha                               defconfig
mips                    maltaup_xpa_defconfig
sh                        sh7763rdp_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
arm                          pxa3xx_defconfig
arc                        nsimosci_defconfig
arm                          exynos_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          sdk7780_defconfig
powerpc64                        alldefconfig
arm                           sama5_defconfig
m68k                        m5307c3_defconfig
sparc                               defconfig
sparc64                             defconfig
h8300                            alldefconfig
m68k                          atari_defconfig
arm                            zeus_defconfig
arm                            mps2_defconfig
xtensa                         virt_defconfig
powerpc                    amigaone_defconfig
sh                               allmodconfig
sh                        sh7785lcr_defconfig
m68k                         amcore_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5475evb_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220501
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                                defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a011
x86_64                        randconfig-a013
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
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
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
mips                        omega2p_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      ppc64e_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8272_ads_defconfig
mips                           mtx1_defconfig
powerpc                     ksi8560_defconfig
arm                          ep93xx_defconfig
arm                         s3c2410_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      pmac32_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
