Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6750C790
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiDWFVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDWFVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:21:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6FC8D6B1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650691127; x=1682227127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BBptDshfl5tudHwTRVARFAasErWWOH3IRRdaQ+/aH4s=;
  b=AemMe93s/TwCe57aizFEsNlbOb4kFgfJ2BY5r6R5keoxLWQcbbz+F/Gw
   89OzeRBpNz06WU2wcYuR2uV/EtfZdcKVbh/9cczc0kRO3R47351xicBE2
   vh9IKL7n3HuW7cWRQzGX9x9+h1c/lOOFr5uhKeLtl9b8nNOADnOuOYSYn
   ShJzo/2S+kd2D8/2tt3LcwR7l8FbPfOu4eLHM82PKCIzX1XvqIG34eUzy
   p4SMM89AQknlqkeOuPa824YAXTVxqYSxnN1ooCFzu5GH4T5kYFBs6ScqF
   7D5IWflWEiK/Na1ZDMsFDEw19+vbw80D+jobwSXScNwcfR+sJbWdBtXd5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245422863"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="245422863"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 22:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="627280594"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Apr 2022 22:18:46 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni8AP-000B2t-JB;
        Sat, 23 Apr 2022 05:18:45 +0000
Date:   Sat, 23 Apr 2022 13:17:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 42/44]
 fs/afs/write.c:265:6: warning: variable 'ret' is used uninitialized whenever
 'if' condition is true
Message-ID: <202204231313.4Udoczm1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: 0565641524458774e47a4d1fd06f80d0bd62965f [42/44] afs: [DON'T MERGE] Implement trivial content crypto for testing purposes
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220423/202204231313.4Udoczm1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0565641524458774e47a4d1fd06f80d0bd62965f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 0565641524458774e47a4d1fd06f80d0bd62965f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/afs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/afs/write.c:265:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!buf)
               ^~~~
   fs/afs/write.c:335:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/afs/write.c:265:2: note: remove the 'if' if its condition is always false
           if (!buf)
           ^~~~~~~~~
   fs/afs/write.c:247:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   fs/afs/write.c:372:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!buf)
               ^~~~
   fs/afs/write.c:442:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/afs/write.c:372:2: note: remove the 'if' if its condition is always false
           if (!buf)
           ^~~~~~~~~
   fs/afs/write.c:354:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   2 warnings generated.


vim +265 fs/afs/write.c

   230	
   231	/*
   232	 * Encrypt part of a write for fscrypt.  The caller reserved an extra
   233	 * scatterlist element before each of source_sg and dest_sg for our purposes,
   234	 * should we need them.
   235	 */
   236	int afs_encrypt_block(struct netfs_io_request *wreq, loff_t pos, size_t len,
   237			      struct scatterlist *source_sg, unsigned int n_source,
   238			      struct scatterlist *dest_sg, unsigned int n_dest)
   239	{
   240		struct crypto_sync_skcipher *ci;
   241		struct skcipher_request *req;
   242		struct crypto_skcipher *tfm;
   243		struct sha256_state *sha;
   244		void *buf = NULL;
   245		__be64 *session_key;
   246		u8 *iv, *b0;
   247		int ret;
   248	
   249		ci = crypto_alloc_sync_skcipher("cts(cbc(aes))", 0, 0);
   250		if (IS_ERR(ci)) {
   251			ret = PTR_ERR(ci);
   252			pr_err("Can't allocate cipher: %d\n", ret);
   253			goto error;
   254		}
   255		tfm = &ci->base;
   256	
   257		if (crypto_sync_skcipher_ivsize(ci) > 16 &&
   258		    crypto_sync_skcipher_blocksize(ci) > 16) {
   259			pr_err("iv wrong size: %u\n", crypto_sync_skcipher_ivsize(ci));
   260			ret = -EINVAL;
   261			goto error_ci;
   262		}
   263	
   264		buf = kzalloc(4 * 16 + sizeof(*sha), GFP_KERNEL);
 > 265		if (!buf)
   266			goto error_ci;
   267		b0 = buf;
   268		iv = buf + 32;
   269		session_key = buf + 48;
   270		session_key[0] = cpu_to_be64(pos);
   271		session_key[1] = cpu_to_le64(pos);
   272		sha = buf + 64;
   273	
   274		*(__be64 *)iv = pos;
   275	
   276		ret = crypto_sync_skcipher_setkey(ci, (u8 *)session_key, 16);
   277		if (ret < 0) {
   278			pr_err("Setkey failed: %d\n", ret);
   279			goto error_ci;
   280		}
   281	
   282		ret = -ENOMEM;
   283		req = skcipher_request_alloc(tfm, GFP_NOFS);
   284		if (!req)
   285			goto error_ci;
   286	
   287		skcipher_request_set_sync_tfm(req, ci);
   288		skcipher_request_set_callback(req, 0, NULL, NULL);
   289	
   290		/* If the length is so short that the CTS algorithm will refuse to
   291		 * handle it, prepend a predictable block on the front and discard the
   292		 * output.  Since CTS does draw data backwards, we can regenerate the
   293		 * encryption on just that block at decryption time.
   294		 */
   295		if (len < 16) {
   296			unsigned int i;
   297			u8 *p = buf + 16;
   298	
   299			kdebug("preblock %16phN", iv);
   300			sha256_init(sha);
   301			sha256_update(sha, iv, 32); /* iv and session key */
   302			sha256_final(sha, b0);
   303			kdebug("preblock %16phN", b0);
   304	
   305			netfs_dump_sg("SRC", source_sg, n_source);
   306			if (sg_copy_to_buffer(source_sg, n_source, p, len) != len) {
   307				ret = -EIO;
   308				goto error_req;
   309			}
   310	
   311			for (i = 0; i < len; i++)
   312				p[i] += b0[i];
   313	
   314			if (sg_copy_from_buffer(dest_sg, n_dest, p, len) != len) {
   315				ret = -EIO;
   316				goto error_req;
   317			}
   318			netfs_dump_sg("DST", dest_sg, n_dest);
   319			ret = 0;
   320		} else {
   321			netfs_dump_sg("SRC", source_sg, n_source);
   322			skcipher_request_set_crypt(req, source_sg, dest_sg, len, iv);
   323			ret = crypto_skcipher_encrypt(req);
   324			if (ret < 0)
   325				pr_err("Encrypt failed: %d\n", ret);
   326			netfs_dump_sg("DST", dest_sg, n_dest);
   327		}
   328	
   329	error_req:
   330		skcipher_request_free(req);
   331	error_ci:
   332		kfree(buf);
   333		crypto_free_sync_skcipher(ci);
   334	error:
   335		return ret;
   336	}
   337	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
