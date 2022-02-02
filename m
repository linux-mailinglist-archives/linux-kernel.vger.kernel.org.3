Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A04A6A93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 04:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiBBDkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 22:40:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:20128 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243770AbiBBDke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 22:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643773234; x=1675309234;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/AOZiYMRcQHDplSb2i423RjeeSpU2AuNH0+XF/KNnbQ=;
  b=nA78botkCblLR54ZXniXTX8Z9/ORUIaDL8jPD8Jtyhsyt0bBDMcEFtQS
   DTWtNxMKzPtGLDZCjw6OO7aBY9SpjfDRkRvlYQDgwnIAcoiIMtdewtj8Q
   N8Tv1ulGY+BGED9BBLrdwz140I68WnLUMLlAiO2c+vtjj396BRMNW9ykz
   fSYyXkt9De3Lzr77CqwtPuR+zZBdKCy3BNWjGQN3crXLuUltidF+g7VP4
   g2b+DZGZPUVlilzWa12qasJKz5Uo4oWcyK20H4LdDWrUIr6xecafu+Kfz
   SNUCowBFxinRIbZXDHG2pHJrTiJCTksFcuIO4DsuCBh9EZnh8jJ3itLy5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="235240177"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="235240177"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 19:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="534734360"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2022 19:40:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF6VT-000U66-AQ; Wed, 02 Feb 2022 03:40:31 +0000
Date:   Wed, 2 Feb 2022 11:39:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [ebiggers:crypto-pending 11/11] arch/arm64/crypto/aes-glue.c:479:20:
 error: use of undeclared identifier 'STRIDE'
Message-ID: <202202021149.MKVbgnkg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crypto-pending
head:   33ee40d3677bee91888ba1a6ee5a37bd6d2292fe
commit: 33ee40d3677bee91888ba1a6ee5a37bd6d2292fe [11/11] crypto: arm64/aes-neon-ctr - improve handling of single tail block
config: arm64-buildonly-randconfig-r004-20220130 (https://download.01.org/0day-ci/archive/20220202/202202021149.MKVbgnkg-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=33ee40d3677bee91888ba1a6ee5a37bd6d2292fe
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers crypto-pending
        git checkout 33ee40d3677bee91888ba1a6ee5a37bd6d2292fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/crypto/aes-glue.c:479:20: error: use of undeclared identifier 'STRIDE'
                   tail = nbytes % (STRIDE * AES_BLOCK_SIZE);
                                    ^
   1 error generated.


vim +/STRIDE +479 arch/arm64/crypto/aes-glue.c

735177ca148af5 Ard Biesheuvel     2019-08-19  451  
9d5a9509b91221 Nathan Huckleberry 2022-01-24  452  static int __maybe_unused xctr_encrypt(struct skcipher_request *req)
9d5a9509b91221 Nathan Huckleberry 2022-01-24  453  {
9d5a9509b91221 Nathan Huckleberry 2022-01-24  454  	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  455  	struct crypto_aes_ctx *ctx = crypto_skcipher_ctx(tfm);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  456  	int err, rounds = 6 + ctx->key_length / 4;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  457  	struct skcipher_walk walk;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  458  	unsigned int byte_ctr = 0;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  459  
9d5a9509b91221 Nathan Huckleberry 2022-01-24  460  	err = skcipher_walk_virt(&walk, req, false);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  461  
9d5a9509b91221 Nathan Huckleberry 2022-01-24  462  	while (walk.nbytes > 0) {
9d5a9509b91221 Nathan Huckleberry 2022-01-24  463  		const u8 *src = walk.src.virt.addr;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  464  		unsigned int nbytes = walk.nbytes;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  465  		u8 *dst = walk.dst.virt.addr;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  466  		u8 buf[AES_BLOCK_SIZE];
9d5a9509b91221 Nathan Huckleberry 2022-01-24  467  		unsigned int tail;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  468  
9d5a9509b91221 Nathan Huckleberry 2022-01-24  469  		if (unlikely(nbytes < AES_BLOCK_SIZE))
9d5a9509b91221 Nathan Huckleberry 2022-01-24  470  			src = memcpy(buf, src, nbytes);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  471  		else if (nbytes < walk.total)
9d5a9509b91221 Nathan Huckleberry 2022-01-24  472  			nbytes &= ~(AES_BLOCK_SIZE - 1);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  473  
9d5a9509b91221 Nathan Huckleberry 2022-01-24  474  		kernel_neon_begin();
9d5a9509b91221 Nathan Huckleberry 2022-01-24  475  		aes_xctr_encrypt(dst, src, ctx->key_enc, rounds, nbytes,
9d5a9509b91221 Nathan Huckleberry 2022-01-24  476  						 walk.iv, buf, byte_ctr);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  477  		kernel_neon_end();
9d5a9509b91221 Nathan Huckleberry 2022-01-24  478  
9d5a9509b91221 Nathan Huckleberry 2022-01-24 @479  		tail = nbytes % (STRIDE * AES_BLOCK_SIZE);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  480  		if (tail > 0 && tail < AES_BLOCK_SIZE)
9d5a9509b91221 Nathan Huckleberry 2022-01-24  481  			/*
9d5a9509b91221 Nathan Huckleberry 2022-01-24  482  			 * The final partial block could not be returned using
9d5a9509b91221 Nathan Huckleberry 2022-01-24  483  			 * an overlapping store, so it was passed via buf[]
9d5a9509b91221 Nathan Huckleberry 2022-01-24  484  			 * instead.
9d5a9509b91221 Nathan Huckleberry 2022-01-24  485  			 */
9d5a9509b91221 Nathan Huckleberry 2022-01-24  486  			memcpy(dst + nbytes - tail, buf, tail);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  487  		byte_ctr += nbytes;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  488  
9d5a9509b91221 Nathan Huckleberry 2022-01-24  489  		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
9d5a9509b91221 Nathan Huckleberry 2022-01-24  490  	}
9d5a9509b91221 Nathan Huckleberry 2022-01-24  491  
9d5a9509b91221 Nathan Huckleberry 2022-01-24  492  	return err;
9d5a9509b91221 Nathan Huckleberry 2022-01-24  493  }
9d5a9509b91221 Nathan Huckleberry 2022-01-24  494  

:::::: The code at line 479 was first introduced by commit
:::::: 9d5a9509b912217aa41fd8ca8c5d3c125ecc3ca2 crypto: arm64/aes-xctr: Add accelerated implementation of XCTR

:::::: TO: Nathan Huckleberry <nhuck@google.com>
:::::: CC: Eric Biggers <ebiggers@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
