Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620DD480338
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhL0STf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:19:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:36858 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhL0STe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640629174; x=1672165174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d/eJhUm09+92HzmeMWK3AjH3oC0HS5KLgho6HA8cbaA=;
  b=BBuojz8inRiQiOuVPiw11+BUgFUZKzjvccEJo/oHpyEqspjIJn97IiLz
   yptuo1s74DKBUOJoD8isgbE7Vi4SCEpCRNCJTnHufwxrus06mFZROBpJr
   wFVNIrfqv9dGoJIBqTzFxy2O9bOC4Jx2h25Juw9nATJOQ207z4OFQ1gPN
   xQMT3qQatwmhoCJ3++OvvIDoEpDKri4orzGtTZVvHZ/fwdrYoN/02iU40
   Mlgf/Eyi0pk2Xr/kga68kF7RfgJt3hOtmVgZzwwCSo9lIhKMu6oxzGtIL
   8QaefQ4K4RPyHF9L5J+AYlU0WHF6NCIGpV5J108IJg1xpNKM5vQz6C8A5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="228085345"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="228085345"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 10:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="553874472"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2021 10:19:32 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1uaq-0006gF-70; Mon, 27 Dec 2021 18:19:32 +0000
Date:   Tue, 28 Dec 2021 02:18:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:master 8/9] mips-linux-ld: blake2s.c:undefined
 reference to `blake2s_compress'
Message-ID: <202112280222.KpoFVWEB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
head:   1e82f9dc0ff8aec645cb0bcbd003c7989db05036
commit: 94385fa60862094ce641b628c5fd7fd8307d6c39 [8/9] lib/crypto: blake2s: include as built-in
config: mips-jmr3927_defconfig (https://download.01.org/0day-ci/archive/20211228/202112280222.KpoFVWEB-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=94385fa60862094ce641b628c5fd7fd8307d6c39
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random master
        git checkout 94385fa60862094ce641b628c5fd7fd8307d6c39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips-linux-ld: lib/crypto/blake2s.o: in function `blake2s_update':
   blake2s.c:(.text+0xb0): undefined reference to `blake2s_compress'
>> mips-linux-ld: blake2s.c:(.text+0xe0): undefined reference to `blake2s_compress'
   mips-linux-ld: lib/crypto/blake2s.o: in function `blake2s_final':
   blake2s.c:(.text+0x148): undefined reference to `blake2s_compress'
   mips-linux-ld: lib/crypto/blake2s.o: in function `blake2s256_hmac':
   blake2s.c:(.text+0x2bc): undefined reference to `blake2s_compress'
   mips-linux-ld: blake2s.c:(.text+0x588): undefined reference to `blake2s_compress'
   mips-linux-ld: lib/crypto/blake2s.o:blake2s.c:(.text+0x5c0): more undefined references to `blake2s_compress' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
