Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C6E48027F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhL0Q5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:57:35 -0500
Received: from mga09.intel.com ([134.134.136.24]:10928 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhL0Q5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640624253; x=1672160253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8EBAX45FqP/nxBvXKCtxcTSHtaVWDXN9koroDwN0wBQ=;
  b=YfSBxjN7TwpeGZENX8u9LGDkX+qEx7kFiCjoNxIDtCvmo7mlkAKuUrfd
   6sj9SG/9eYXs+8txSohKI5hwBSjuMCSgmKGPXxDgb+eoIH2VRndapl0g4
   vbpnNUTLfF/nvPJzEnUm7xQxwGfC9ASm8mMn3Q/aNlfjNk47RW4IHGUTb
   SfM147Zs3XMUaRd93IMGjKcwluU6yuMuWQl8MwYipd5TYq8Wl5UmnInId
   ivjNmCGimwtBuC6gCCXo+tHogUj3Akizw0J7BZaA2LtTzAjtJUEOMTNYj
   9PbO74302hhLpSGRxtRyF6R3LsDpV/nmWiD5lfoALMr9drzvj8I31x50J
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241039925"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="241039925"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 08:57:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="618497705"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Dec 2021 08:57:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1tJR-0006bX-VR; Mon, 27 Dec 2021 16:57:29 +0000
Date:   Tue, 28 Dec 2021 00:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: nios2-linux-ld: blake2s.c:undefined reference to `blake2s_compress'
Message-ID: <202112280006.qBjwc9v6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211227-222159/Jason-A-Donenfeld/lib-crypto-blake2s-include-as-built-in/20211223-221318
head:   cf9c5e5cba1ba852d4c4482fef47ecd0842b645b
commit: 2607be0046b083ed690e8176d93f8c8f52676224 lib/crypto: blake2s: include as built-in
date:   2 hours ago
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20211228/202112280006.qBjwc9v6-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2607be0046b083ed690e8176d93f8c8f52676224
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211227-222159/Jason-A-Donenfeld/lib-crypto-blake2s-include-as-built-in/20211223-221318
        git checkout 2607be0046b083ed690e8176d93f8c8f52676224
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: lib/crypto/blake2s.o: in function `blake2s_final':
   blake2s.c:(.text+0x50): undefined reference to `blake2s_compress'
   blake2s.c:(.text+0x50): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
   nios2-linux-ld: lib/crypto/blake2s.o: in function `blake2s_update':
   blake2s.c:(.text+0x13c): undefined reference to `blake2s_compress'
   blake2s.c:(.text+0x13c): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
>> nios2-linux-ld: blake2s.c:(.text+0x16c): undefined reference to `blake2s_compress'
   blake2s.c:(.text+0x16c): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
   nios2-linux-ld: lib/crypto/blake2s.o: in function `blake2s256_hmac':
   blake2s.c:(.text+0x284): undefined reference to `blake2s_compress'
   blake2s.c:(.text+0x284): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
   nios2-linux-ld: blake2s.c:(.text+0x534): undefined reference to `blake2s_compress'
   blake2s.c:(.text+0x534): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
   nios2-linux-ld: lib/crypto/blake2s.o:blake2s.c:(.text+0x564): more undefined references to `blake2s_compress' follow
   lib/crypto/blake2s.o: in function `blake2s256_hmac':
   blake2s.c:(.text+0x564): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
   blake2s.c:(.text+0x5a8): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
   blake2s.c:(.text+0x5e0): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'
   blake2s.c:(.text+0x614): relocation truncated to fit: R_NIOS2_CALL26 against `blake2s_compress'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
