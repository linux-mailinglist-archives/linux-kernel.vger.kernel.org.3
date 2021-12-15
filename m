Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50456474F47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbhLOAbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:31:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:14830 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhLOAbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639528299; x=1671064299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vw5g02XxGnh/wWb+FVeeAh5fTIFo1dqda7KD+NsOnxA=;
  b=n3xEZK7kjIyknetuKb7z0o9zo4wHfZ7n/SWYKpdy/d07X5UMlXrH73Mx
   8H8hwicdbW9cSrMT3/qV6rLr7LErBdb+LV0gCE1bZYXxDAmJzZAqgvxWg
   ZOxcnCjnBUksuwtg2f9zB6hcmlM4s45mdRIPockjWgauL/2kVWKMuZczt
   KdkurtrqhdcdWcHQmZZ1KrMjD+bRRe1AhtY72lO0Hah4JbMlDAr0j7Ogw
   8n8ycEhl5f73n181XCKRABkGJDccuDkY66H6qjayR3nPOV/1z2utM99XH
   uAGo8VxT3u5aTbYwZ+mP+XF+H6lMTE4ZbrVgcZAQVOqI9P2AzWvSpMh4H
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225971503"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="225971503"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 16:31:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="661682623"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2021 16:31:36 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxICm-0000zN-6h; Wed, 15 Dec 2021 00:31:36 +0000
Date:   Wed, 15 Dec 2021 08:31:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [ardb:arm-entry-literals 24/38] ld.lld: error: undefined symbol:
 generic_handle_arch_irq
Message-ID: <202112150836.cvaUk2Wq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm-entry-literals
head:   bed1490d5af6f3411b5b8ca816c8b6ddb9206528
commit: 54f481a2308efab49d2b14c3f8263b34fdb1c65e [24/38] ARM: remove old-style irq entry
config: arm-randconfig-r003-20211214 (https://download.01.org/0day-ci/archive/20211215/202112150836.cvaUk2Wq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=54f481a2308efab49d2b14c3f8263b34fdb1c65e
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm-entry-literals
        git checkout 54f481a2308efab49d2b14c3f8263b34fdb1c65e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
>> ld.lld: error: undefined symbol: generic_handle_arch_irq
   >>> referenced by kernel/entry-armv.o:(__irq_svc) in archive arch/arm/built-in.a
   >>> referenced by kernel/entry-armv.o:(__irq_usr) in archive arch/arm/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
