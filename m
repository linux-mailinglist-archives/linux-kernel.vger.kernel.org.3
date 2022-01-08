Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B843488559
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiAHSYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:24:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:58269 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232400AbiAHSYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641666245; x=1673202245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HmEPE1UHIZMfDTU149L4CivgGqF9VvzVq87J8WolXNg=;
  b=JYORhTwFgyeYgVLA+76x6dxwZjppMtC1gXHrZ2M5tnR55BAolfSxE86R
   Z9GzxyB6vMl+tBWB//mDdfzY16BWseN0yim7gW/OAd0TTJ2ySlcrZnnZH
   ppKiTmE3I4lxzB4p6gSX/9UpNg40rf9AF9MrJUGG7Mvv5yUAPa9IOI6nB
   dYuavJuOKaAUKh9+zhTtGDq2wll4ljK7xw+PbBKZIIIJoUlD6K+fLlIsm
   kOto6Er9E4capVAE7s5sAOIta+5HgVJd2CO+4TfLewZZQZbyOlcMZMV5d
   dBld/371WhCxU/ta7IB62tJe8+iaKJlpIxvNE6Zg+ourd2wFC+P5kniKl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="223730028"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="223730028"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 10:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="622262878"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2022 10:24:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6GNn-0000uF-Le; Sat, 08 Jan 2022 18:24:03 +0000
Date:   Sun, 9 Jan 2022 02:23:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 2294/2300] arch/mips/crypto/chacha-glue.c:45:34:
 error: implicit declaration of function 'round_down'
Message-ID: <202201090259.KZeo3bGb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   4e348e961395297bb17f101cc63bc133d8a348e9
commit: a35948847a1e0bf875f580f821cb871ce16d4c60 [2294/2300] headers/deps: time: Optimize <linux/time64.h> dependencies, remove <linux/time64_api.h> inclusion
config: mips-randconfig-r034-20220108 (https://download.01.org/0day-ci/archive/20220109/202201090259.KZeo3bGb-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a35948847a1e0bf875f580f821cb871ce16d4c60
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout a35948847a1e0bf875f580f821cb871ce16d4c60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/crypto/chacha-glue.c: In function 'chacha_mips_stream_xor':
>> arch/mips/crypto/chacha-glue.c:45:34: error: implicit declaration of function 'round_down' [-Werror=implicit-function-declaration]
      45 |                         nbytes = round_down(nbytes, walk.stride);
         |                                  ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/round_down +45 arch/mips/crypto/chacha-glue.c

3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  29  
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  30  static int chacha_mips_stream_xor(struct skcipher_request *req,
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  31  				  const struct chacha_ctx *ctx, const u8 *iv)
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  32  {
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  33  	struct skcipher_walk walk;
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  34  	u32 state[16];
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  35  	int err;
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  36  
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  37  	err = skcipher_walk_virt(&walk, req, false);
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  38  
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  39  	chacha_init_generic(state, ctx->key, iv);
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  40  
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  41  	while (walk.nbytes > 0) {
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  42  		unsigned int nbytes = walk.nbytes;
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  43  
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  44  		if (nbytes < walk.total)
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08 @45  			nbytes = round_down(nbytes, walk.stride);
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  46  
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  47  		chacha_crypt(state, walk.dst.virt.addr, walk.src.virt.addr,
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  48  			     nbytes, ctx->nrounds);
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  49  		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  50  	}
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  51  
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  52  	return err;
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  53  }
3a2f58f3ba4f6f Ard Biesheuvel 2019-11-08  54  

:::::: The code at line 45 was first introduced by commit
:::::: 3a2f58f3ba4f6f44e33d1a48240d5eadb882cb59 crypto: mips/chacha - wire up accelerated 32r2 code from Zinc

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
