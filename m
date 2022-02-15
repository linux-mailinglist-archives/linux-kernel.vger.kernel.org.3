Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254264B61D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiBODnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:43:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBODnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:43:42 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A0FC625D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644896613; x=1676432613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DPagWfmY473ULnntllerihlP9RCrg+iBTmm/T+H4pNE=;
  b=KWhlPgL4a1skSdnxMTNLO7x2S2SoJ7FfIm/z4ljPphqjYzoOR3pewgSC
   kY0DLjPvF4swsrGDWfJ54JZ/Z8VXrKGAzrkVdaZJPf45XwdKw87H8t6Ns
   /sbp58/A9tzsZ9jCenjQvCX9b/gLeCLx6l5uE9UwvaHgW/CzPOr3taExG
   FSMoTTH/xGXcj5rx/q7uelv/7CyMrjGqqPoK/Np5ypusHcTY2OdYnvFc6
   wUqy/pIPJ3ZziaiGO+JMT0i0jQsDN9xn32IDLOhj0oq7D5jEwvQ2eWCE4
   VJffrC5JQxfF4AiKSJ0txgG3DfnKAkwdU08IGIhso4FyxVQ5tr3GgCqYu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="310977500"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="310977500"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 19:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="496707623"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2022 19:43:31 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJokU-0009Eu-Ff; Tue, 15 Feb 2022 03:43:30 +0000
Date:   Tue, 15 Feb 2022 11:42:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: [ebiggers:crypto-pending 3/7] crypto/xctr.c:66:22: sparse: sparse:
 restricted __le32 degrades to integer
Message-ID: <202202151139.J5pKremk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crypto-pending
head:   67824d3cb5325de4264ad344174a7e4ea69e5303
commit: d98684f7dc5be61c6380f6c5a4d5dae44c6ddbca [3/7] crypto: hctr2 - Add HCTR2 support
config: arm-randconfig-s031-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151139.J5pKremk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=d98684f7dc5be61c6380f6c5a4d5dae44c6ddbca
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers crypto-pending
        git checkout d98684f7dc5be61c6380f6c5a4d5dae44c6ddbca
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> crypto/xctr.c:66:22: sparse: sparse: restricted __le32 degrades to integer
   crypto/xctr.c:94:22: sparse: sparse: restricted __le32 degrades to integer

vim +66 crypto/xctr.c

8330f8a6b750f6 Nathan Huckleberry 2022-02-10  48  
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  49  static int crypto_xctr_crypt_segment(struct skcipher_walk *walk,
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  50  				    struct crypto_cipher *tfm, u32 byte_ctr)
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  51  {
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  52  	void (*fn)(struct crypto_tfm *, u8 *, const u8 *) =
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  53  		   crypto_cipher_alg(tfm)->cia_encrypt;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  54  	u8 *src = walk->src.virt.addr;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  55  	u8 *dst = walk->dst.virt.addr;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  56  	unsigned int nbytes = walk->nbytes;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  57  	__le32 ctr32 = cpu_to_le32(byte_ctr / XCTR_BLOCKSIZE + 1);
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  58  
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  59  	do {
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  60  		/* create keystream */
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  61  		crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  62  		fn(crypto_cipher_tfm(tfm), dst, walk->iv);
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  63  		crypto_xor(dst, src, XCTR_BLOCKSIZE);
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  64  		crypto_xor(walk->iv, (u8 *)&ctr32, sizeof(ctr32));
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  65  
8330f8a6b750f6 Nathan Huckleberry 2022-02-10 @66  		ctr32++;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  67  
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  68  		src += XCTR_BLOCKSIZE;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  69  		dst += XCTR_BLOCKSIZE;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  70  	} while ((nbytes -= XCTR_BLOCKSIZE) >= XCTR_BLOCKSIZE);
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  71  
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  72  	return nbytes;
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  73  }
8330f8a6b750f6 Nathan Huckleberry 2022-02-10  74  

:::::: The code at line 66 was first introduced by commit
:::::: 8330f8a6b750f6b7b65987a27d4bf7d2bebde570 crypto: xctr - Add XCTR support

:::::: TO: Nathan Huckleberry <nhuck@google.com>
:::::: CC: Eric Biggers <ebiggers@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
