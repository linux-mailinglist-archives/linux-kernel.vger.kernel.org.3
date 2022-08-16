Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6EB59585D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiHPKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiHPKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:32:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B853B94E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660639733; x=1692175733;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4dzc/qx53hVX29ifX4zMyW7ez/x2P7dWTA9KkO31wJ8=;
  b=NZJWgAG8Z0zHUXotG7k7IyJ/wwjFwjxvihPEfgxGKd7mRa2FbhRzAwZg
   3RBnFplCYkdSlJhTdSXysc3b14vF6GG08ZtaVL9HUeV48/lTlJznh7iiz
   pgcmCwtIgseSGXjbit4Cl+N164G7cIfTbB7bzGq6kLnTnzxlKG7aqkkPM
   drpmd6S3XI+Yrk8k8rP3zrCT4+WdEIJTSgAXaEVjRlDLAPsK7MSuxVRof
   4PL6Fpx22VDLG2SpkH27S2mWmFDx4UlYw26GJcbtHscsbdwVmjheWfGs3
   Rf9UKbe4rr1Ianh6I/rWwjcuKrGDX+pizIkJrI4fBR48Pefbpjk3tnQ7f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292960495"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292960495"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 01:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="733219835"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2022 01:48:51 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNsFm-0001eP-2w;
        Tue, 16 Aug 2022 08:48:50 +0000
Date:   Tue, 16 Aug 2022 16:48:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam1-v6.0] BUILD SUCCESS
 0be5e5d3e8a6c733c09424bdcefb5f2846e827a5
Message-ID: <62fb59d6.pbyai36+qORIIiow%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam1-v6.0
branch HEAD: 0be5e5d3e8a6c733c09424bdcefb5f2846e827a5  scsi: megaraid_sas: Use struct_size() in code related to struct MR_PD_CFG_SEQ_NUM_SYNC

elapsed time: 717m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220815
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a001-20220815
i386                 randconfig-a005-20220815
i386                 randconfig-a004-20220815
i386                 randconfig-a006-20220815
i386                 randconfig-a003-20220815
i386                 randconfig-a002-20220815
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
i386                                defconfig
arm                      integrator_defconfig
sh                            shmin_defconfig
xtensa                              defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
x86_64               randconfig-a006-20220815
x86_64               randconfig-a003-20220815
x86_64               randconfig-a005-20220815
x86_64               randconfig-a004-20220815
x86_64               randconfig-a001-20220815
x86_64               randconfig-a002-20220815
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
mips                         bigsur_defconfig
powerpc                      chrp32_defconfig
arm                           h3600_defconfig
i386                 randconfig-c001-20220815
sh                            hp6xx_defconfig
powerpc                   currituck_defconfig
powerpc                     redwood_defconfig
powerpc                     sequoia_defconfig
ia64                      gensparse_defconfig
arm                           corgi_defconfig
sh                        sh7785lcr_defconfig
arm                      footbridge_defconfig
powerpc                     stx_gp3_defconfig
nios2                               defconfig
arm                         vf610m4_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc              randconfig-c003-20220815
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
m68k                            q40_defconfig
arm                         s3c6400_defconfig
powerpc                      makalu_defconfig
arc                            hsdk_defconfig
powerpc                    klondike_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
xtensa                         virt_defconfig
powerpc                       eiger_defconfig
arm                          iop32x_defconfig
m68k                       m5208evb_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig

clang tested configs:
hexagon              randconfig-r045-20220815
hexagon              randconfig-r041-20220815
riscv                randconfig-r042-20220815
s390                 randconfig-r044-20220815
x86_64               randconfig-a011-20220815
x86_64               randconfig-a016-20220815
x86_64               randconfig-a013-20220815
x86_64               randconfig-a015-20220815
x86_64               randconfig-a014-20220815
x86_64               randconfig-a012-20220815
i386                 randconfig-a011-20220815
i386                 randconfig-a012-20220815
i386                 randconfig-a014-20220815
i386                 randconfig-a016-20220815
i386                 randconfig-a015-20220815
i386                 randconfig-a013-20220815
arm                        multi_v5_defconfig
x86_64               randconfig-k001-20220815
powerpc                          g5_defconfig
powerpc                          allmodconfig
powerpc                 mpc836x_mds_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
