Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45495A57B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiH2Xl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiH2Xlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:41:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A8383F26
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661816514; x=1693352514;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dkq5UtYy4xUBzFDduq4KV07qdX5OwWvQfB0gtW1Awcc=;
  b=IZ1Nw30SZvXEkLWzI3c9QvG8bS2RHqI4u1uhMRuckP7rqPRkPv43lCH1
   oBrZ8wLg4eYO3rHBZeP6zqay9zF3kdlKHnXJL+aqhAkE/+yKyhpC4d62J
   5j9h8lbtc31B9+0B4f+w//kmMLo30pJZ92ibjwu63YTicTL7xNRMsqAfW
   pRkJwkNBkhvKGu/JLLlB5L6lKhskTIoSrYZCSbsD8lChUPtAtUndJG0Of
   Cnih9uMzff0iC96hSvFrAIp2c2wtkdRd4Ec5CYN+3DquD+/nlKlL7Z58u
   G1zHzcQvYEA3veeY0H8G9ah9Lxy82qFgDclO5DsI6puY6ZYytVml0yBS5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="296303898"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="296303898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 16:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="679809161"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2022 16:41:52 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSoO8-0000Od-0Y;
        Mon, 29 Aug 2022 23:41:52 +0000
Date:   Tue, 30 Aug 2022 07:41:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 bc12b70f7d216b36bd87701349374a13e486f8eb
Message-ID: <630d4eb4.I7T0kMrX48AGjQIN%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: bc12b70f7d216b36bd87701349374a13e486f8eb  x86/earlyprintk: Clean up pciserial

elapsed time: 725m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
xtensa                           alldefconfig
sh                            migor_defconfig
sh                      rts7751r2d1_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
m68k                        m5407c3_defconfig
sh                          r7780mp_defconfig
m68k                          multi_defconfig
sh                                  defconfig
i386                             allyesconfig
i386                                defconfig
sh                          r7785rp_defconfig
sh                             shx3_defconfig
mips                       bmips_be_defconfig
arc                  randconfig-r043-20220829
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                           h5000_defconfig
arm                        keystone_defconfig
arm64                            alldefconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64               randconfig-a002-20220829
x86_64               randconfig-a005-20220829
x86_64               randconfig-a006-20220829
x86_64               randconfig-a003-20220829
x86_64               randconfig-a001-20220829
x86_64               randconfig-a004-20220829
loongarch                           defconfig
loongarch                         allnoconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-a002-20220829
i386                 randconfig-a005-20220829
i386                 randconfig-a001-20220829
i386                 randconfig-a006-20220829
i386                 randconfig-a003-20220829
i386                 randconfig-a004-20220829
arm                         axm55xx_defconfig
sh                           se7343_defconfig
sh                        edosk7705_defconfig
ia64                             allmodconfig
i386                 randconfig-c001-20220829
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
arm                         s3c6400_defconfig
powerpc                      tqm8xx_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8548_defconfig
arm                  randconfig-c002-20220829
x86_64               randconfig-c001-20220829
sh                             sh03_defconfig
powerpc                      makalu_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                        sh7763rdp_defconfig
m68k                          atari_defconfig
mips                  decstation_64_defconfig
m68k                        m5307c3_defconfig
powerpc                         wii_defconfig
powerpc                        cell_defconfig
xtensa                    xip_kc705_defconfig

clang tested configs:
i386                 randconfig-a016-20220829
i386                 randconfig-a015-20220829
i386                 randconfig-a011-20220829
i386                 randconfig-a013-20220829
i386                 randconfig-a014-20220829
i386                 randconfig-a012-20220829
hexagon              randconfig-r045-20220829
riscv                randconfig-r042-20220829
hexagon              randconfig-r041-20220829
s390                 randconfig-r044-20220829
x86_64               randconfig-a013-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a011-20220829
x86_64               randconfig-a016-20220829
x86_64               randconfig-a012-20220829
x86_64               randconfig-a015-20220829
arm                        mvebu_v5_defconfig
powerpc                     kilauea_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
