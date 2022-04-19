Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19585063CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348516AbiDSFRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348498AbiDSFRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:17:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309B1220D7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650345271; x=1681881271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KiQRtbiFly6KlRBAyC/iKTzyu+xMK4SVggkiG2lAtAw=;
  b=ZLqzYKADQoXBI3aLwbCXPJOBPPbKeEYc7D92iISI7U7so2b3P7KVHy+k
   PxMd5Ays+etNpzib5NsFtVOeY4YsEXz+HgAyl1Wv7XASVAX5efFxf54aA
   BGL0WUO+x1Uz2nXvtOf8NNJzSVLwUCeS0jDIrDJzZGrCxafaCda2YEt4S
   +MM6vrAyLh3qdiW7W4uMLvxmpzKPT09vZqKatMpV204mCm5OFRl7ab8QA
   1PZs6wTT0PRfSP+P/uwgCQtB43qLfN6WJfFLVfFZTjTa9v9TunLyKQ5R8
   rcvapHuLUg+9+t+kNiLmg/AqPA1keVti/gXodzE3VLn77IySrWwtXMyip
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263436009"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263436009"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="561584168"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2022 22:14:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nggC2-0005No-HS;
        Tue, 19 Apr 2022 05:14:26 +0000
Date:   Tue, 19 Apr 2022 13:13:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [stable:linux-5.4.y 1969/9999]
 drivers/crypto/inside-secure/safexcel_cipher.c:303:12: warning: stack frame
 size (1040) exceeds limit (1024) in 'safexcel_aead_setkey'
Message-ID: <202204191329.0DXlsBnh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arvind,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
head:   e7f5213d755bc34f366d36f08825c0b446117d96
commit: c2c5dc84ac51da90cadcb12554c69bdd5ac7aeeb [1969/9999] compiler.h: fix barrier_data() on clang
config: mips-randconfig-r021-20220417 (https://download.01.org/0day-ci/archive/20220419/202204191329.0DXlsBnh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=c2c5dc84ac51da90cadcb12554c69bdd5ac7aeeb
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.4.y
        git checkout c2c5dc84ac51da90cadcb12554c69bdd5ac7aeeb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/crypto/inside-secure/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/crypto/inside-secure/safexcel_cipher.c:303:12: warning: stack frame size (1040) exceeds limit (1024) in 'safexcel_aead_setkey' [-Wframe-larger-than]
   static int safexcel_aead_setkey(struct crypto_aead *ctfm, const u8 *key,
              ^
   1 warning generated.


vim +/safexcel_aead_setkey +303 drivers/crypto/inside-secure/safexcel_cipher.c

1b44c5a60c137e Antoine Tenart     2017-05-24  302  
77cdd4efe57134 Pascal van Leeuwen 2019-07-05 @303  static int safexcel_aead_setkey(struct crypto_aead *ctfm, const u8 *key,
f6beaea304872b Antoine Tenart     2018-05-14  304  				unsigned int len)
f6beaea304872b Antoine Tenart     2018-05-14  305  {
f6beaea304872b Antoine Tenart     2018-05-14  306  	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
f6beaea304872b Antoine Tenart     2018-05-14  307  	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
f6beaea304872b Antoine Tenart     2018-05-14  308  	struct safexcel_ahash_export_state istate, ostate;
f6beaea304872b Antoine Tenart     2018-05-14  309  	struct safexcel_crypto_priv *priv = ctx->priv;
f6beaea304872b Antoine Tenart     2018-05-14  310  	struct crypto_authenc_keys keys;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  311  	struct crypto_aes_ctx aes;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  312  	int err = -EINVAL;
f6beaea304872b Antoine Tenart     2018-05-14  313  
f6beaea304872b Antoine Tenart     2018-05-14  314  	if (crypto_authenc_extractkeys(&keys, key, len) != 0)
f6beaea304872b Antoine Tenart     2018-05-14  315  		goto badkey;
f6beaea304872b Antoine Tenart     2018-05-14  316  
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  317  	if (ctx->mode == CONTEXT_CONTROL_CRYPTO_MODE_CTR_LOAD) {
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  318  		/* Minimum keysize is minimum AES key size + nonce size */
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  319  		if (keys.enckeylen < (AES_MIN_KEY_SIZE +
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  320  				      CTR_RFC3686_NONCE_SIZE))
f6beaea304872b Antoine Tenart     2018-05-14  321  			goto badkey;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  322  		/* last 4 bytes of key are the nonce! */
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  323  		ctx->nonce = *(u32 *)(keys.enckey + keys.enckeylen -
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  324  				      CTR_RFC3686_NONCE_SIZE);
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  325  		/* exclude the nonce here */
f26882a3475eb7 Pascal van Leeuwen 2019-07-30  326  		keys.enckeylen -= CONTEXT_CONTROL_CRYPTO_MODE_CTR_LOAD;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  327  	}
f6beaea304872b Antoine Tenart     2018-05-14  328  
f6beaea304872b Antoine Tenart     2018-05-14  329  	/* Encryption key */
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  330  	switch (ctx->alg) {
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  331  	case SAFEXCEL_3DES:
21f5a15e0f26c7 Ard Biesheuvel     2019-08-15  332  		err = verify_aead_des3_key(ctfm, keys.enckey, keys.enckeylen);
77cdd4efe57134 Pascal van Leeuwen 2019-07-05  333  		if (unlikely(err))
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  334  			goto badkey_expflags;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  335  		break;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  336  	case SAFEXCEL_AES:
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  337  		err = aes_expandkey(&aes, keys.enckey, keys.enckeylen);
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  338  		if (unlikely(err))
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  339  			goto badkey;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  340  		break;
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  341  	default:
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  342  		dev_err(priv->dev, "aead: unsupported cipher algorithm\n");
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  343  		goto badkey;
77cdd4efe57134 Pascal van Leeuwen 2019-07-05  344  	}
77cdd4efe57134 Pascal van Leeuwen 2019-07-05  345  
53c83e915ce8b2 Antoine Tenart     2018-06-28  346  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma &&
f6beaea304872b Antoine Tenart     2018-05-14  347  	    memcmp(ctx->key, keys.enckey, keys.enckeylen))
f6beaea304872b Antoine Tenart     2018-05-14  348  		ctx->base.needs_inv = true;
f6beaea304872b Antoine Tenart     2018-05-14  349  
f6beaea304872b Antoine Tenart     2018-05-14  350  	/* Auth key */
a7dea8c0ff9f25 Ofer Heifetz       2018-06-28  351  	switch (ctx->hash_alg) {
01ba061d0fd769 Antoine Tenart     2018-05-14  352  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA1:
01ba061d0fd769 Antoine Tenart     2018-05-14  353  		if (safexcel_hmac_setkey("safexcel-sha1", keys.authkey,
01ba061d0fd769 Antoine Tenart     2018-05-14  354  					 keys.authkeylen, &istate, &ostate))
01ba061d0fd769 Antoine Tenart     2018-05-14  355  			goto badkey;
01ba061d0fd769 Antoine Tenart     2018-05-14  356  		break;
678b2878ac396f Antoine Tenart     2018-05-14  357  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA224:
678b2878ac396f Antoine Tenart     2018-05-14  358  		if (safexcel_hmac_setkey("safexcel-sha224", keys.authkey,
678b2878ac396f Antoine Tenart     2018-05-14  359  					 keys.authkeylen, &istate, &ostate))
678b2878ac396f Antoine Tenart     2018-05-14  360  			goto badkey;
678b2878ac396f Antoine Tenart     2018-05-14  361  		break;
678b2878ac396f Antoine Tenart     2018-05-14  362  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA256:
f6beaea304872b Antoine Tenart     2018-05-14  363  		if (safexcel_hmac_setkey("safexcel-sha256", keys.authkey,
f6beaea304872b Antoine Tenart     2018-05-14  364  					 keys.authkeylen, &istate, &ostate))
f6beaea304872b Antoine Tenart     2018-05-14  365  			goto badkey;
678b2878ac396f Antoine Tenart     2018-05-14  366  		break;
ea23cb533ce419 Antoine Tenart     2018-05-29  367  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA384:
ea23cb533ce419 Antoine Tenart     2018-05-29  368  		if (safexcel_hmac_setkey("safexcel-sha384", keys.authkey,
ea23cb533ce419 Antoine Tenart     2018-05-29  369  					 keys.authkeylen, &istate, &ostate))
ea23cb533ce419 Antoine Tenart     2018-05-29  370  			goto badkey;
ea23cb533ce419 Antoine Tenart     2018-05-29  371  		break;
87eee125e7490c Antoine Tenart     2018-05-29  372  	case CONTEXT_CONTROL_CRYPTO_ALG_SHA512:
87eee125e7490c Antoine Tenart     2018-05-29  373  		if (safexcel_hmac_setkey("safexcel-sha512", keys.authkey,
87eee125e7490c Antoine Tenart     2018-05-29  374  					 keys.authkeylen, &istate, &ostate))
87eee125e7490c Antoine Tenart     2018-05-29  375  			goto badkey;
87eee125e7490c Antoine Tenart     2018-05-29  376  		break;
678b2878ac396f Antoine Tenart     2018-05-14  377  	default:
678b2878ac396f Antoine Tenart     2018-05-14  378  		dev_err(priv->dev, "aead: unsupported hash algorithm\n");
678b2878ac396f Antoine Tenart     2018-05-14  379  		goto badkey;
678b2878ac396f Antoine Tenart     2018-05-14  380  	}
f6beaea304872b Antoine Tenart     2018-05-14  381  
f6beaea304872b Antoine Tenart     2018-05-14  382  	crypto_aead_set_flags(ctfm, crypto_aead_get_flags(ctfm) &
f6beaea304872b Antoine Tenart     2018-05-14  383  				    CRYPTO_TFM_RES_MASK);
f6beaea304872b Antoine Tenart     2018-05-14  384  
53c83e915ce8b2 Antoine Tenart     2018-06-28  385  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma &&
f6beaea304872b Antoine Tenart     2018-05-14  386  	    (memcmp(ctx->ipad, istate.state, ctx->state_sz) ||
f6beaea304872b Antoine Tenart     2018-05-14  387  	     memcmp(ctx->opad, ostate.state, ctx->state_sz)))
f6beaea304872b Antoine Tenart     2018-05-14  388  		ctx->base.needs_inv = true;
f6beaea304872b Antoine Tenart     2018-05-14  389  
f6beaea304872b Antoine Tenart     2018-05-14  390  	/* Now copy the keys into the context */
f6beaea304872b Antoine Tenart     2018-05-14  391  	memcpy(ctx->key, keys.enckey, keys.enckeylen);
f6beaea304872b Antoine Tenart     2018-05-14  392  	ctx->key_len = keys.enckeylen;
f6beaea304872b Antoine Tenart     2018-05-14  393  
f6beaea304872b Antoine Tenart     2018-05-14  394  	memcpy(ctx->ipad, &istate.state, ctx->state_sz);
f6beaea304872b Antoine Tenart     2018-05-14  395  	memcpy(ctx->opad, &ostate.state, ctx->state_sz);
f6beaea304872b Antoine Tenart     2018-05-14  396  
f6beaea304872b Antoine Tenart     2018-05-14  397  	memzero_explicit(&keys, sizeof(keys));
f6beaea304872b Antoine Tenart     2018-05-14  398  	return 0;
f6beaea304872b Antoine Tenart     2018-05-14  399  
f6beaea304872b Antoine Tenart     2018-05-14  400  badkey:
f6beaea304872b Antoine Tenart     2018-05-14  401  	crypto_aead_set_flags(ctfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  402  badkey_expflags:
f6beaea304872b Antoine Tenart     2018-05-14  403  	memzero_explicit(&keys, sizeof(keys));
0e17e3621a28a6 Pascal van Leeuwen 2019-07-05  404  	return err;
f6beaea304872b Antoine Tenart     2018-05-14  405  }
f6beaea304872b Antoine Tenart     2018-05-14  406  

:::::: The code at line 303 was first introduced by commit
:::::: 77cdd4efe571345e9c116e65f64a616969e0bc35 crypto: inside-secure - add support for authenc(hmac(sha1),cbc(des3_ede))

:::::: TO: Pascal van Leeuwen <pascalvanl@gmail.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
