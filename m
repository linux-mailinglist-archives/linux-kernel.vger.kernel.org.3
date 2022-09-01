Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C75A952D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiIAK5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiIAK4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:56:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1031A7AB4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662029782; x=1693565782;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=hh0ffIFHrLlRK7AiUQRXNzhh91yRv5pISOTFI2E3mDM=;
  b=AmZuWamqk4IguQmC/dMW69W+D5usF3ztXieFQgqfiF8nm8KX+iDEc/E2
   v360u+wMC2gioHPPnX0a4pe+ZSn1wk5OtX/ElYfWLJTYOF/gb9fSk3oNm
   YkBUdAZxThUgdxkY7FC9hdW85eMggMoNwSgurrmQCtaqkuOFh2PJfDpX/
   AEnFyCf3lL2moYF9VKJnvnkYlclp34/aAYjMti1u3o2e1PH/gZkI+GdaT
   v4/69GmEpe2knYGKq3fBJLIh69HFCIjM9KI8fD/64sIUwe/XwSgXMW0hb
   /8hiINcATRbV5mUFAvtwzucyr2XfsfNiyufXEr0fqjgYgbXLG6W+wkq6b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321830773"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321830773"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 03:56:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="788199946"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Sep 2022 03:56:21 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oThrw-0000Bh-23;
        Thu, 01 Sep 2022 10:56:20 +0000
Date:   Thu, 01 Sep 2022 18:56:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 5515d21c6817bc27b0b13c61edf22b09b58bc647
Message-ID: <63108fc2./qWNiUSWHmCzl6bs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 5515d21c6817bc27b0b13c61edf22b09b58bc647  x86/cpu: Add CPU model numbers for Meteor Lake

elapsed time: 790m

configs tested: 65
configs skipped: 82

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                                defconfig
x86_64                        randconfig-a013
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allyesconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                      pcm030_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     rainier_defconfig
arm                      jornada720_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-c001
mips                      loongson3_defconfig
sh                          r7780mp_defconfig
parisc64                            defconfig
sh                           se7705_defconfig
sh                          lboxre2_defconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220831
hexagon              randconfig-r041-20220831
arm                        vexpress_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
