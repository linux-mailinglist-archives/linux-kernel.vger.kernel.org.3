Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4615181F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiECKFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiECKFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:05:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B9E38BD6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651572097; x=1683108097;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=UOVvEhMCzOfQwujPsMh77Vh4k+bMOG/dOx2XBGFH+Q0=;
  b=aV+ZUWWi+Lap9XlaRcB8y/97t/vqarP8YN9cLLlgfZ04KGmJ8D8va9rQ
   vfrbylEBwKO7JGvSglozR3H+TlsMLai77+IlkXhon4Ry6kTw9m1e6cQSv
   8EfjLa0hoNLciBSz4dO1rr7qWxhWCXJwN+eNaRAXTD2Bzff9sxduVGGA4
   CVtSyYJx3HXhfWTMcDEGw78/Vw51gZYq4ShSvrHM0ppOjd0poEb6A+CPN
   Tz27+YSPwXfUsrSdjGK0tG8Fk3KHm6bcDPIT/jREmQnroWRKfDwxxE4mu
   d35g194Gspirl0sVQ7SmbVofiibH+DdGrDSJjYH6xbe4xYdGxqCT3DAqU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267598594"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267598594"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 03:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="810608541"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 May 2022 03:01:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlpLa-000AMN-VM;
        Tue, 03 May 2022 10:01:34 +0000
Date:   Tue, 03 May 2022 18:00:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 2147c438fde135d6c145a96e373d9348e7076f7f
Message-ID: <6270fd5a.gZamI7q6ZtQ2vGFn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/cpu
branch HEAD: 2147c438fde135d6c145a96e373d9348e7076f7f  x86/speculation: Add missing prototype for unpriv_ebpf_notify()

elapsed time: 7212m

configs tested: 283
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           imxrt_defconfig
powerpc                    sam440ep_defconfig
arc                         haps_hs_defconfig
xtensa                          iss_defconfig
mips                         tb0226_defconfig
powerpc                      cm5200_defconfig
powerpc                       holly_defconfig
xtensa                           allyesconfig
powerpc                         ps3_defconfig
arc                     haps_hs_smp_defconfig
arc                            hsdk_defconfig
arm                         vf610m4_defconfig
arm                            zeus_defconfig
mips                  decstation_64_defconfig
s390                       zfcpdump_defconfig
arm                        realview_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
sparc64                          alldefconfig
sh                        sh7763rdp_defconfig
mips                           ci20_defconfig
arm                         lubbock_defconfig
m68k                                defconfig
sh                          sdk7780_defconfig
powerpc                     tqm8555_defconfig
parisc                              defconfig
sh                         microdev_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     tqm8541_defconfig
riscv                            allmodconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
powerpc                 linkstation_defconfig
sh                     sh7710voipgw_defconfig
sh                        edosk7705_defconfig
mips                           ip32_defconfig
arm                          lpd270_defconfig
riscv                            allyesconfig
mips                        vocore2_defconfig
mips                          rb532_defconfig
powerpc                      ppc6xx_defconfig
arm                      jornada720_defconfig
sh                           se7619_defconfig
mips                  maltasmvp_eva_defconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
sh                          r7780mp_defconfig
parisc                generic-32bit_defconfig
sh                     magicpanelr2_defconfig
nios2                               defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
sparc                            alldefconfig
powerpc                      ep88xc_defconfig
arc                          axs103_defconfig
powerpc                    klondike_defconfig
m68k                       m5208evb_defconfig
arc                              alldefconfig
sparc                       sparc64_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                       common_defconfig
powerpc                    amigaone_defconfig
microblaze                      mmu_defconfig
sh                          polaris_defconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                        apsh4ad0a_defconfig
m68k                       m5275evb_defconfig
mips                            gpr_defconfig
arm                            lart_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
parisc                generic-64bit_defconfig
sh                          lboxre2_defconfig
arm                          pxa910_defconfig
i386                             alldefconfig
x86_64                              defconfig
mips                         db1xxx_defconfig
powerpc                        cell_defconfig
powerpc                     taishan_defconfig
xtensa                  cadence_csp_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
powerpc                   motionpro_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
arm                            qcom_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
s390                          debug_defconfig
sh                      rts7751r2d1_defconfig
sh                   sh7724_generic_defconfig
mips                     loongson1b_defconfig
m68k                        m5307c3_defconfig
powerpc                    adder875_defconfig
mips                            ar7_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
arm                        cerfcube_defconfig
m68k                          multi_defconfig
mips                     decstation_defconfig
powerpc                         wii_defconfig
s390                             allyesconfig
ia64                             alldefconfig
mips                         cobalt_defconfig
arm                         nhk8815_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       maple_defconfig
mips                      maltasmvp_defconfig
sh                             sh03_defconfig
sh                             espt_defconfig
openrisc                            defconfig
sh                          urquell_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
powerpc                   currituck_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
sh                           sh2007_defconfig
powerpc                     mpc83xx_defconfig
arm                      integrator_defconfig
sh                          landisk_defconfig
i386                                defconfig
powerpc                     asp8347_defconfig
mips                       bmips_be_defconfig
sh                           se7206_defconfig
sh                   rts7751r2dplus_defconfig
parisc64                            defconfig
m68k                             allmodconfig
arm                        oxnas_v6_defconfig
sh                           se7705_defconfig
m68k                         amcore_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220501
arm                  randconfig-c002-20220429
x86_64               randconfig-c001-20220502
i386                 randconfig-c001-20220502
arm                  randconfig-c002-20220502
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                               defconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a006-20220502
x86_64               randconfig-a001-20220502
x86_64               randconfig-a003-20220502
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220428
arc                  randconfig-r043-20220501
s390                 randconfig-r044-20220501
riscv                randconfig-r042-20220501
arc                  randconfig-r043-20220429
s390                 randconfig-r044-20220429
riscv                randconfig-r042-20220429
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           allyesconfig

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220501
riscv                randconfig-c006-20220501
mips                 randconfig-c004-20220501
arm                  randconfig-c002-20220501
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
riscv                randconfig-c006-20220429
mips                 randconfig-c004-20220429
arm                  randconfig-c002-20220429
powerpc              randconfig-c003-20220429
arm                       spear13xx_defconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
arm                         socfpga_defconfig
arm                        vexpress_defconfig
arm                         palmz72_defconfig
arm                       cns3420vb_defconfig
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
powerpc                  mpc866_ads_defconfig
mips                          rm200_defconfig
arm                          moxart_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1830-neo_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc44x_defconfig
arm                         s3c2410_defconfig
arm64                            allyesconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           mtx1_defconfig
powerpc                      walnut_defconfig
arm                              alldefconfig
mips                            e55_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      obs600_defconfig
powerpc                    socrates_defconfig
arm                         bcm2835_defconfig
arm                            dove_defconfig
arm                           spitz_defconfig
powerpc                        icon_defconfig
arm                       aspeed_g4_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
arm                          ixp4xx_defconfig
riscv                          rv32_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
mips                          ath25_defconfig
powerpc                     skiroot_defconfig
mips                      bmips_stb_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      pmac32_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a015-20220502
x86_64               randconfig-a012-20220502
x86_64               randconfig-a016-20220502
x86_64               randconfig-a014-20220502
x86_64               randconfig-a013-20220502
x86_64               randconfig-a011-20220502
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428
hexagon              randconfig-r041-20220428
s390                 randconfig-r044-20220428

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
