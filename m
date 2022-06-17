Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09254F443
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380813AbiFQJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiFQJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:28:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD9862CF1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655458131; x=1686994131;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ZgMetKx+YLnThO+dTo98kWNrDs507igXhK+g21MkmsA=;
  b=UizPpfR/srgAO1O2KRHt4AUIl3GOSaknK3o+DLPcmfUnIm6hd2uHoKCZ
   QgzfYhg+pUEvHH6MUqi9suhm4jzsogfF0EH29KDran5nzgf9aD1VKNY1f
   NctcLbvwDt24GLPRZXFsZReAhskEKSjz68SkM1NIY0Q7/mxTMZM+Vu6Dt
   +dNNeM7n4nAb1wSyDsXF9ufreXkJk+Unj+aeJkbiJNTgPWWDiZpv4EHaT
   QKnabhWOl8rDlyJp9C4OJp9yhz2hhYFAmVHQSBIEICzIEBj+3+9E3nvoq
   wIgmW9M1aiozszb2uKZmCU23KrXX2O0KiDvx0jITmRGmDDWL9mpcdUoY7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365815314"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365815314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675420912"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2022 02:28:37 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o28HM-000PJZ-LB;
        Fri, 17 Jun 2022 09:28:36 +0000
Date:   Fri, 17 Jun 2022 17:28:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu-tasks-test.2022.06.16a] BUILD SUCCESS
 c7c3062b83aed82c8f89842ca74cb7fe3dc45d51
Message-ID: <62ac492e.ygGrt+7CQSCAWqrX%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu-tasks-test.2022.06.16a
branch HEAD: c7c3062b83aed82c8f89842ca74cb7fe3dc45d51  rcu-tasks: Use delayed_work to delay rcu_tasks_verify_self_tests()

elapsed time: 747m

configs tested: 124
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
m68k                             allyesconfig
parisc64                            defconfig
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
arm                           u8500_defconfig
powerpc                      arches_defconfig
arc                         haps_hs_defconfig
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
arc                  randconfig-r043-20220616
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
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
hexagon              randconfig-r041-20220616
hexagon              randconfig-r045-20220616
s390                 randconfig-r044-20220616
riscv                randconfig-r042-20220616

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
