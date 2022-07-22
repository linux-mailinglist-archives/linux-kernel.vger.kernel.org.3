Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6457E248
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiGVNZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:25:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEED17E27
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658496349; x=1690032349;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CQGUvO2K9TI8BbBLpol11ijJKaA1jgD/XoHq2bke1Mc=;
  b=A6koaUMznbJIIykfpqXNaOWDbyCyNKNqn2JgtE+BP7EbaVq3hsuDOzRr
   X1dB+jAp7jc/yt11EFBmPre6J0atCVRanEMzSJk2gtFCG3jgs7ljPhSUz
   vq+yuxmQwmxSdvboXBGn/HftXgQBUfU5eRQZJS99uEZdU5E7o4HjfQ7Mw
   NyWMg7lhmzm7wJlzpVljhIvDW3ceZn6Pt/MyCkbqnU3fgpFigiW/NEs2B
   dlxWhgOe2NCzG97XR+okPRZQsmit07xSHhF121ycL/MVQZtXMrAQbaRqS
   ew3ysIYkYv/uLqwxW5oDb15II2jCTbAqwFqsKfa+fx8fPy8h/3xut2ENi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287315075"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="287315075"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 06:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="626560640"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2022 06:25:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEsf4-0001TI-1l;
        Fri, 22 Jul 2022 13:25:46 +0000
Date:   Fri, 22 Jul 2022 21:25:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.07.19b] BUILD SUCCESS
 77cc4d2a1adf35feb0520e13065a7d875ecd5033
Message-ID: <62daa530.basR/n+ZYNuKMXLx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.07.19b
branch HEAD: 77cc4d2a1adf35feb0520e13065a7d875ecd5033  squash! rcu: Switch polled grace-period APIs to ->gp_seq_polled

elapsed time: 889m

configs tested: 39
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           alldefconfig
parisc64                            defconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20220721
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
mips                           mtx1_defconfig
mips                      pic32mzda_defconfig
powerpc                 mpc836x_mds_defconfig
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220721
hexagon              randconfig-r045-20220721
riscv                randconfig-r042-20220721
s390                 randconfig-r044-20220721

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
