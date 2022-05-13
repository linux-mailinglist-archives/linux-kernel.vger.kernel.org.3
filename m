Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C9C5263CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbiEMOSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiEMOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:18:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832BA126C1C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C969B82DA6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 14:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C929FC34100;
        Fri, 13 May 2022 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652451515;
        bh=bPee+Q4p/Adpv/jCFE9NBmqXW9Io963RGq+Y1h7pM3M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nVdYSwGAqGR4lwv42+wVWds4EUJm8Cs6rwPUItZWOEY+1YvUwyAtYtYRSXlttZSjY
         Ftrk3WPoTSetkPlpzHTx15jM6NNQpiChubGccktKD4uPkg4Byl2u06f7JoQBW5TPVe
         YxY6CG7CnAF/xfsxzXHVAOnzgawK6zsS+yhKWbfdRY6PlQeYjMoCQxA0mK9oSCMNjY
         5egDr87xOigJzHmx+9h7BdwrLL3ypBxV4bhX3Bg1kQX7eAHsiFojfCc8kLYKncLhxG
         2ClVQZHbDoQPG18rZ2fPSlswmgvW1mmXmhQ5Oo62HxQCAmmWTsVsWnddMVvkRm80Og
         2c4KRprKP1GeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6DF395C0342; Fri, 13 May 2022 07:18:35 -0700 (PDT)
Date:   Fri, 13 May 2022 07:18:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org
Subject: Re: [paulmck-rcu:context-tracking.2022.05.03a] BUILD REGRESSION
 9527c561aed6424e77fd2a8827c37f1103c89177
Message-ID: <20220513141835.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <627e565c.pdEDbqVrzEta7Scf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627e565c.pdEDbqVrzEta7Scf%lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 09:00:12PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git context-tracking.2022.05.03a
> branch HEAD: 9527c561aed6424e77fd2a8827c37f1103c89177  rcu/context_tracking: Merge dynticks counter and context tracking states
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/llvm/202205060346.y3d1cOFv-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> kernel/context_tracking.c:360:4: error: call to undeclared function 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> kernel/context_tracking.c:91:4: error: call to undeclared function 'rcu_irq_work_resched'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

Adding Frederic on CC.

(These are in any case experimental commits.)

							Thanx, Paul

> Error/Warning ids grouped by kconfigs:
> 
> clang_recent_errors
> |-- arm-randconfig-r013-20220505
> |   `-- kernel-context_tracking.c:error:call-to-undeclared-function-rcu_irq_work_resched-ISO-C99-and-later-do-not-support-implicit-function-declarations
> |-- riscv-randconfig-c006-20220505
> |   `-- kernel-context_tracking.c:error:call-to-undeclared-function-rcu_irq_work_resched-ISO-C99-and-later-do-not-support-implicit-function-declarations
> `-- x86_64-randconfig-a001
>     `-- kernel-context_tracking.c:error:call-to-undeclared-function-rcu_irq_work_resched-ISO-C99-and-later-do-not-support-implicit-function-declarations
> 
> elapsed time: 14089m
> 
> configs tested: 211
> configs skipped: 3
> 
> gcc tested configs:
> arm64                               defconfig
> arm64                            allyesconfig
> arm                              allmodconfig
> arm                                 defconfig
> arm                              allyesconfig
> i386                          randconfig-c001
> m68k                       m5475evb_defconfig
> arm                           corgi_defconfig
> powerpc                     ep8248e_defconfig
> nios2                            allyesconfig
> arm                      footbridge_defconfig
> powerpc                      ppc6xx_defconfig
> powerpc                     pq2fads_defconfig
> mips                         cobalt_defconfig
> powerpc                 canyonlands_defconfig
> m68k                        m5272c3_defconfig
> mips                         bigsur_defconfig
> arm                            pleb_defconfig
> powerpc                   currituck_defconfig
> openrisc                 simple_smp_defconfig
> arc                        nsimosci_defconfig
> m68k                        mvme147_defconfig
> powerpc                     tqm8555_defconfig
> sh                               allmodconfig
> ia64                         bigsur_defconfig
> powerpc                     asp8347_defconfig
> arm                      integrator_defconfig
> microblaze                          defconfig
> arm                         lpc18xx_defconfig
> parisc64                            defconfig
> powerpc                    klondike_defconfig
> sh                         ap325rxa_defconfig
> sparc64                             defconfig
> arm                           sunxi_defconfig
> powerpc                       maple_defconfig
> m68k                       m5249evb_defconfig
> mips                           ip32_defconfig
> i386                                defconfig
> sh                 kfr2r09-romimage_defconfig
> powerpc                      cm5200_defconfig
> arm                         nhk8815_defconfig
> i386                             alldefconfig
> mips                  maltasmvp_eva_defconfig
> sh                         microdev_defconfig
> arc                          axs101_defconfig
> nios2                         3c120_defconfig
> arm                         vf610m4_defconfig
> m68k                        stmark2_defconfig
> powerpc                      pcm030_defconfig
> powerpc                        cell_defconfig
> arc                     haps_hs_smp_defconfig
> sh                          rsk7269_defconfig
> xtensa                    xip_kc705_defconfig
> sh                        apsh4ad0a_defconfig
> powerpc                     sequoia_defconfig
> powerpc                     mpc83xx_defconfig
> mips                         rt305x_defconfig
> m68k                         apollo_defconfig
> mips                           jazz_defconfig
> m68k                             alldefconfig
> parisc                generic-32bit_defconfig
> xtensa                  audio_kc705_defconfig
> m68k                            q40_defconfig
> arc                 nsimosci_hs_smp_defconfig
> powerpc                 mpc85xx_cds_defconfig
> arm                            xcep_defconfig
> arm                        oxnas_v6_defconfig
> arm64                            alldefconfig
> powerpc                 linkstation_defconfig
> m68k                            mac_defconfig
> arm                            lart_defconfig
> powerpc                      ppc40x_defconfig
> powerpc                      arches_defconfig
> riscv             nommu_k210_sdcard_defconfig
> sh                                  defconfig
> powerpc                mpc7448_hpc2_defconfig
> arm                         at91_dt_defconfig
> sh                   secureedge5410_defconfig
> um                                  defconfig
> xtensa                    smp_lx200_defconfig
> um                             i386_defconfig
> sh                          polaris_defconfig
> arm                        mini2440_defconfig
> m68k                             allyesconfig
> microblaze                      mmu_defconfig
> arc                            hsdk_defconfig
> sh                             sh03_defconfig
> powerpc64                           defconfig
> sh                               j2_defconfig
> x86_64                        randconfig-c001
> arm                  randconfig-c002-20220501
> arm                  randconfig-c002-20220505
> arm                  randconfig-c002-20220506
> ia64                                defconfig
> ia64                             allmodconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> nios2                               defconfig
> arc                              allyesconfig
> csky                                defconfig
> alpha                               defconfig
> alpha                            allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> xtensa                           allyesconfig
> s390                                defconfig
> s390                             allmodconfig
> parisc                              defconfig
> parisc                           allyesconfig
> s390                             allyesconfig
> sparc                               defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> x86_64                        randconfig-a006
> x86_64                        randconfig-a004
> x86_64                        randconfig-a002
> i386                 randconfig-a004-20220502
> i386                 randconfig-a006-20220502
> i386                 randconfig-a002-20220502
> i386                 randconfig-a003-20220502
> i386                 randconfig-a001-20220502
> i386                          randconfig-a001
> i386                          randconfig-a003
> i386                          randconfig-a005
> i386                 randconfig-a005-20220502
> x86_64                        randconfig-a011
> x86_64                        randconfig-a013
> x86_64                        randconfig-a015
> i386                          randconfig-a014
> i386                          randconfig-a012
> i386                          randconfig-a016
> riscv                randconfig-r042-20220501
> arc                  randconfig-r043-20220502
> arc                  randconfig-r043-20220501
> s390                 randconfig-r044-20220501
> arc                  randconfig-r043-20220505
> s390                 randconfig-r044-20220505
> riscv                randconfig-r042-20220505
> riscv                               defconfig
> riscv                    nommu_virt_defconfig
> riscv                          rv32_defconfig
> riscv                    nommu_k210_defconfig
> riscv                             allnoconfig
> riscv                            allmodconfig
> riscv                            allyesconfig
> x86_64                    rhel-8.3-kselftests
> um                           x86_64_defconfig
> x86_64                          rhel-8.3-func
> x86_64                           rhel-8.3-syz
> x86_64                                  kexec
> x86_64                              defconfig
> x86_64                         rhel-8.3-kunit
> x86_64                               rhel-8.3
> x86_64                           allyesconfig
> 
> clang tested configs:
> x86_64                        randconfig-c007
> i386                          randconfig-c001
> powerpc              randconfig-c003-20220501
> riscv                randconfig-c006-20220501
> mips                 randconfig-c004-20220501
> arm                  randconfig-c002-20220501
> powerpc              randconfig-c003-20220505
> riscv                randconfig-c006-20220505
> arm                  randconfig-c002-20220505
> powerpc                      katmai_defconfig
> powerpc                          g5_defconfig
> arm                          ep93xx_defconfig
> mips                      maltaaprp_defconfig
> arm                           sama7_defconfig
> hexagon                          alldefconfig
> arm                         s3c2410_defconfig
> mips                        workpad_defconfig
> mips                           rs90_defconfig
> arm                       mainstone_defconfig
> powerpc                 mpc832x_rdb_defconfig
> arm                         s5pv210_defconfig
> mips                malta_qemu_32r6_defconfig
> i386                          randconfig-a002
> i386                          randconfig-a004
> i386                          randconfig-a006
> x86_64               randconfig-a011-20220502
> x86_64               randconfig-a012-20220502
> x86_64               randconfig-a013-20220502
> x86_64               randconfig-a016-20220502
> x86_64               randconfig-a014-20220502
> x86_64               randconfig-a015-20220502
> x86_64                        randconfig-a012
> x86_64                        randconfig-a014
> x86_64                        randconfig-a016
> i386                          randconfig-a013
> i386                          randconfig-a011
> i386                          randconfig-a015
> i386                 randconfig-a011-20220502
> i386                 randconfig-a013-20220502
> i386                 randconfig-a016-20220502
> i386                 randconfig-a015-20220502
> i386                 randconfig-a014-20220502
> i386                 randconfig-a012-20220502
> x86_64                        randconfig-a005
> x86_64                        randconfig-a003
> x86_64                        randconfig-a001
> hexagon              randconfig-r045-20220502
> hexagon              randconfig-r045-20220501
> hexagon              randconfig-r041-20220501
> s390                 randconfig-r044-20220502
> riscv                randconfig-r042-20220502
> hexagon              randconfig-r041-20220502
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
