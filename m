Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C88480452
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 20:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhL0TKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 14:10:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:58920 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbhL0TKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 14:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640632235; x=1672168235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ui8N0jnQ4cmJnKqL/NKx64hV7AbgzBhGCAfh/aWWWCc=;
  b=IWh9AP9Jl6Dz4MTQ0i9lQeoEqyLUEccwiB1NNNL8wvdKLqgt0puHaA1J
   xB+wABUii+x7PaQob0fHnLxpmY62xCaFhauJhpHoG+rrJfyT6hF2bgw3i
   7ulB8k45Af4Z6NWQlyLqM/5RQW0QPsB9JD2VwJkqxbXQ/0CRix3dFQ8Rl
   nDx5MMCij2ukMckSlvjrd9KCYraWKXUNz/H8Ajb4yoVGXUIn3/oXT4xPm
   jK72QY0yEPfUeBWBjue3fpr45EA09U8QUPT1Z8i5ywbEDfGVoAACc1XQc
   we0JBfEjoIGe9lZ/Avw2qSI1H+3KZYpvSdDul29iZM02zY/ZhFJiFkz8X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="238799587"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="238799587"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 11:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="618534593"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2021 11:10:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1vOD-0006iQ-2u; Mon, 27 Dec 2021 19:10:33 +0000
Date:   Tue, 28 Dec 2021 03:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, zx2c4@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [crng-random:master 8/9] s390-linux-ld: blake2s.c:undefined
 reference to `blake2s_compress'
Message-ID: <202112280325.lfFyGqBk-lkp@intel.com>
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
config: s390-alldefconfig (https://download.01.org/0day-ci/archive/20211228/202112280325.lfFyGqBk-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=94385fa60862094ce641b628c5fd7fd8307d6c39
        git remote add crng-random git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
        git fetch --no-tags crng-random master
        git checkout 94385fa60862094ce641b628c5fd7fd8307d6c39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: lib/crypto/blake2s.o: in function `blake2s_update':
   blake2s.c:(.text+0x9c): undefined reference to `blake2s_compress'
>> s390-linux-ld: blake2s.c:(.text+0xd8): undefined reference to `blake2s_compress'
   s390-linux-ld: lib/crypto/blake2s.o: in function `blake2s_final':
   blake2s.c:(.text+0x16e): undefined reference to `blake2s_compress'
   s390-linux-ld: lib/crypto/blake2s.o: in function `blake2s256_hmac':
   blake2s.c:(.text+0x282): undefined reference to `blake2s_compress'
   s390-linux-ld: blake2s.c:(.text+0x388): undefined reference to `blake2s_compress'
   s390-linux-ld: lib/crypto/blake2s.o:blake2s.c:(.text+0x45a): more undefined references to `blake2s_compress' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
