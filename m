Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B321A494080
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiASTMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:12:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:63578 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236679AbiASTMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642619554; x=1674155554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a7kJT8WZQ6q10SnbggD7Ch7bg5HxbpRC2T1+XzhMwz4=;
  b=HHQos8U4yHshUsoSHQ2w6GSHCLdOXCt0C1UJWLIQiOCT6tEuKyjbovaR
   Nbn52kizGtEYr/H7uEtPNf8pAZaMRXjjYiLqFXiTYYgEVbv1AWTzIXWP3
   H02qnOsqv0+Bo0i7exzeixAMapVHnfd6DrfOqwG8hhhEHIHklFdLXEI6s
   7h4MV0Dx+rJar234Wr6Z9GIelzMTFkQKgmgDJxh/caGMGMgOqnOkpWm/H
   yEHfF0rQxPls59y8aTxuyLm4zD1jfSFdjk+U+fpGgKazP9RAHT0J9/MPK
   vFyWh1Dpvjn1C9mFj2cIsVlFkPlCTDpYUTIu50P3x1/Ef5oCwUws+OvCH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245119140"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="245119140"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 10:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="518286091"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2022 10:39:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAFru-000Dh1-TV; Wed, 19 Jan 2022 18:39:38 +0000
Date:   Thu, 20 Jan 2022 02:38:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [ardb:for-kernelci 10/36] ld.lld: error: undefined symbol:
 generic_handle_arch_irq
Message-ID: <202201200205.1qfWfUJ7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   d2dc6a5332403ee74fe236e13ee12eb472028523
commit: b101e912429f59169f78d933ba2b7e546b3af4c0 [10/36] ARM: remove old-style irq entry
config: arm-randconfig-r023-20220117 (https://download.01.org/0day-ci/archive/20220120/202201200205.1qfWfUJ7-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f7b7138a62648f4019c55e4671682af1f851f295)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=b101e912429f59169f78d933ba2b7e546b3af4c0
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout b101e912429f59169f78d933ba2b7e546b3af4c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: generic_handle_arch_irq
   >>> referenced by kernel/entry-armv.o:(__irq_svc) in archive arch/arm/built-in.a
   >>> referenced by kernel/entry-armv.o:(__irq_usr) in archive arch/arm/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
