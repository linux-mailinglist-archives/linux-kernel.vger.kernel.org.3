Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1649BFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiAYXoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:44:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:17329 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234941AbiAYXoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643154241; x=1674690241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fSz9k08FH3ICVnzjJ3/Kj5pWt7+PnpZf9JKIfaROch8=;
  b=M1LE4gRa4dQ9Rc7JAgMVSFfbItQVPEJNwGeLl8SY9nIMgn7XiYYOWzO/
   j80UpqkE4UjdrR4d+9Vlfad9vglHJwJF6sz6dVk7lwFw0JY7VqjEAEz68
   IpEd0qwqcYDVMZLDIsS/MT8od5YPAEo4SHgVx2TzvFJFrtNlLkkruRvkh
   LuWr5T1fuDjjOHHn9BooRFB4jz4zW1P8ajVZb7rl1DU4xve9GSNt9q9Zk
   Tws+RoBjJt1E6Ib05pBcU55Zqd5C4eOuWyCula0RrVu2sRa4Z1/ttYsPU
   cN9/0gEK4rwjD89FL7asP6Q2xkSEpu9Uvxlrwz3nmSwPVRwYSPe3X61qB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332794368"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="332794368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 15:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="617790660"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2022 15:43:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCVTC-000KZC-0C; Tue, 25 Jan 2022 23:43:26 +0000
Date:   Wed, 26 Jan 2022 07:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     glider <glider@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 5156/9999] aarch64-linux-gcc: error: unrecognized command line option
 '-ftrivial-auto-var-init=pattern'
Message-ID: <202201260753.XHIT2rMz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   4ab5bac1598e3ed91a6267f6cada336467312112
commit: a7eda6eddca559c1c3a897a35692f9d49d46c9dd [5156/9999] BACKPORT: security: allow using Clang's zero initialization for stack variables
config: arm64-randconfig-r025-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260753.XHIT2rMz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a7eda6eddca559c1c3a897a35692f9d49d46c9dd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout a7eda6eddca559c1c3a897a35692f9d49d46c9dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   WARNING: Disabling clang-specific options with gcc
>> aarch64-linux-gcc: error: unrecognized command line option '-ftrivial-auto-var-init=pattern'
   make[2]: *** [./Kbuild:22: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1214: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:146: sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
