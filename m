Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED2550D15
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiFSVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFSVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 17:19:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC92B7665
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655673552; x=1687209552;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nq7ni1HxcQi3kxnNdR2UUQELe7s+75d2r+y1n8RRAbc=;
  b=eK1zMFOsF8awjE4x1TUtH4yq/UY11WAuJtdXE1wM6dvPif+9524MP3+k
   Znv2zgVWXRZHEBGLZqShmoE8QU4GwXwZhDpRpZTlp4wzAs97mGOW4EWb9
   UvN2K++CNO/CrVv7cSNAOLjc+DcAXFca+UOvIml0KGmXucvXfTbxU8i4z
   KZycrzuxVNL6zB7kjOwbCGTGaIUEYo+vdpjcOcwDVTzZRwuZ7g+EBG+Ni
   VYIg/NCw3srEzVwBTqtVPmYGfVeIFDvIYg4m328/qG2YQxlxDOx3izKlv
   g8CK4gAn8xJkF0McfKnVCR6kCDnESVDsI0fX9uuhY6/dIfO9GZ4zpqxUo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260192168"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260192168"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 14:19:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619877399"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Jun 2022 14:19:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o32K6-000RYd-Iw;
        Sun, 19 Jun 2022 21:19:10 +0000
Date:   Mon, 20 Jun 2022 05:18:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:fixes-test.2022.06.16a] BUILD SUCCESS
 19d6322655242bd70d3806420769cc4849df636c
Message-ID: <62af929a.igxUOevXCu1MXmIJ%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git fixes-test.2022.06.16a
branch HEAD: 19d6322655242bd70d3806420769cc4849df636c  srcu: Block less aggressively for expedited grace periods

elapsed time: 3896m

configs tested: 115
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                          randconfig-c001
sparc                       sparc32_defconfig
sh                            hp6xx_defconfig
ia64                        generic_defconfig
xtensa                generic_kc705_defconfig
nios2                            alldefconfig
sh                              ul2_defconfig
powerpc                         wii_defconfig
m68k                        mvme147_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                       maple_defconfig
arm                            lart_defconfig
sh                        edosk7760_defconfig
powerpc                     asp8347_defconfig
powerpc                     taishan_defconfig
m68k                       m5208evb_defconfig
sh                           se7724_defconfig
sh                          urquell_defconfig
m68k                           virt_defconfig
powerpc                      bamboo_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220617
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                               defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
powerpc                       ebony_defconfig
arm                             mxs_defconfig
arm                         shannon_defconfig
arm                           omap1_defconfig
powerpc                   microwatt_defconfig
mips                        omega2p_defconfig
powerpc                          allmodconfig
mips                        workpad_defconfig
mips                      bmips_stb_defconfig
mips                          malta_defconfig
arm                         s3c2410_defconfig
powerpc                        icon_defconfig
arm                          collie_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220617
hexagon              randconfig-r045-20220617

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
