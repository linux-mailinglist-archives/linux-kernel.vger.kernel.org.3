Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0201E5ABC06
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiICB1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICB1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:27:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C75EEF0C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662168457; x=1693704457;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aKDTzIydv1VX0AFqsd26Zi+tHOpIoK888fl9HUc+lR4=;
  b=KBr0SQMV7msq4ZcyjRUF7UcGOe73RzA8vNOKXFRF6rc+RF4DCNwlP4IX
   S/UcxnyhyIyNoRZaDvFb7l6PlQkh/Q4mwsrTRcs+e7NiQWWKHYrZQt89d
   F9Y0v5oje8YYfFJ8cNvju2WAUspTfD7CPLIdO6OeYsZ4UCTmEKsCDwr3U
   lwMkDg0YomAcCbLrUFtlfmj0ttx06Xg5pQgrYE1h1jWRhaLgxpvGGaIb7
   wOjJYeD5TXviya3y9VsgA8KA59qpFTy2AH9P3inJzi+H7ri+KcGh3vjZJ
   Sy3pXd4smTnA0wHEX54JI2NNYjzhzUQoAergx68oV51P6D5EeZTpS8IX0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296902433"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="296902433"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 18:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="590277298"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2022 18:27:35 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUHwc-0000qE-2u;
        Sat, 03 Sep 2022 01:27:34 +0000
Date:   Sat, 03 Sep 2022 09:27:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 7fce8d6eccbc31a561d07c79f359ad09f0424347
Message-ID: <6312ad68.vFrlrTMoz5knQBWG%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 7fce8d6eccbc31a561d07c79f359ad09f0424347  x86/microcode: Print previous version of microcode after reload

elapsed time: 1146m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220901
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                        randconfig-a006
i386                          randconfig-a014
powerpc                           allnoconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
i386                          randconfig-a012
arc                              allyesconfig
alpha                            allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                           allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                          randconfig-a005
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
mips                             allyesconfig
i386                                defconfig
i386                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220901
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220901
x86_64                        randconfig-a003
i386                          randconfig-a013
x86_64                        randconfig-a005
riscv                randconfig-r042-20220901
i386                          randconfig-a011
s390                 randconfig-r044-20220901
i386                          randconfig-a015
x86_64                        randconfig-a012
i386                          randconfig-a002
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
