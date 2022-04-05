Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281C4F5076
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841965AbiDFB0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385435AbiDEPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:15:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0533A1AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649165492; x=1680701492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BVyUMAMp/1gi+XuYF2KWBsy3RtdVLgZsq6bNlEQfsuY=;
  b=iJlmLCL0Xvd37ZGQQX0VbxVwMs5eB2Ol2N/C01n1oY8TNPN1sPcMygWr
   vB+xY7SJmL+ku1LpWkEAby/mxpXeVEO4HNibK/F95z7uqzzLS17zrKTpr
   oTnPtBbqJYLg6jjt6EPVcXaT/2ye17tGJCz9GD//qYQGXWZc5UkhOx3ED
   o/MZxIiT49T79fH3kOXVsa83A2VYQPfyrUHVpCCCoAbZXz+qqoUp12TMb
   rreCuOd7uGyoblkn1Jr1eCf0H61c/3cuJy8c+WQcRhQkEQUC++o36mWh8
   B4AE0XXiyEqfKkEICo3XLU2J0rqbyIUL6KfCQw2dRCUmBvfPlk0AhfVeK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323921459"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="323921459"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="620358854"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2022 06:31:30 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbjHN-0003KM-Js;
        Tue, 05 Apr 2022 13:31:29 +0000
Date:   Tue, 5 Apr 2022 21:31:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 39/40]
 fs/afs/write.c:347:6: warning: variable 'ret' is used uninitialized whenever
 'if' condition is true
Message-ID: <202204052142.PgHNENti-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: e3f5aec34955d83f706c49c395274da333dd726d [39/40] afs: [DON'T MERGE] Implement trivial content crypto for testing purposes
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220405/202204052142.PgHNENti-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e3f5aec34955d83f706c49c395274da333dd726d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout e3f5aec34955d83f706c49c395274da333dd726d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/afs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/afs/write.c:347:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!buf)
               ^~~~
   fs/afs/write.c:417:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/afs/write.c:347:2: note: remove the 'if' if its condition is always false
           if (!buf)
           ^~~~~~~~~
   fs/afs/write.c:329:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   fs/afs/write.c:454:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!buf)
               ^~~~
   fs/afs/write.c:524:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   fs/afs/write.c:454:2: note: remove the 'if' if its condition is always false
           if (!buf)
           ^~~~~~~~~
   fs/afs/write.c:436:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   2 warnings generated.


vim +347 fs/afs/write.c

   312	
   313	/*
   314	 * Encrypt part of a write for fscrypt.  The caller reserved an extra
   315	 * scatterlist element before each of source_sg and dest_sg for our purposes,
   316	 * should we need them.
   317	 */
   318	int afs_encrypt_block(struct netfs_io_request *wreq, loff_t pos, size_t len,
   319			      struct scatterlist *source_sg, unsigned int n_source,
   320			      struct scatterlist *dest_sg, unsigned int n_dest)
   321	{
   322		struct crypto_sync_skcipher *ci;
   323		struct skcipher_request *req;
   324		struct crypto_skcipher *tfm;
   325		struct sha256_state *sha;
   326		void *buf = NULL;
   327		__be64 *session_key;
   328		u8 *iv, *b0;
   329		int ret;
   330	
   331		ci = crypto_alloc_sync_skcipher("cts(cbc(aes))", 0, 0);
   332		if (IS_ERR(ci)) {
   333			ret = PTR_ERR(ci);
   334			pr_err("Can't allocate cipher: %d\n", ret);
   335			goto error;
   336		}
   337		tfm = &ci->base;
   338	
   339		if (crypto_sync_skcipher_ivsize(ci) > 16 &&
   340		    crypto_sync_skcipher_blocksize(ci) > 16) {
   341			pr_err("iv wrong size: %u\n", crypto_sync_skcipher_ivsize(ci));
   342			ret = -EINVAL;
   343			goto error_ci;
   344		}
   345	
   346		buf = kzalloc(4 * 16 + sizeof(*sha), GFP_KERNEL);
 > 347		if (!buf)
   348			goto error_ci;
   349		b0 = buf;
   350		iv = buf + 32;
   351		session_key = buf + 48;
   352		session_key[0] = cpu_to_be64(pos);
   353		session_key[1] = cpu_to_le64(pos);
   354		sha = buf + 64;
   355	
   356		*(__be64 *)iv = pos;
   357	
   358		ret = crypto_sync_skcipher_setkey(ci, (u8 *)session_key, 16);
   359		if (ret < 0) {
   360			pr_err("Setkey failed: %d\n", ret);
   361			goto error_ci;
   362		}
   363	
   364		ret = -ENOMEM;
   365		req = skcipher_request_alloc(tfm, GFP_NOFS);
   366		if (!req)
   367			goto error_ci;
   368	
   369		skcipher_request_set_sync_tfm(req, ci);
   370		skcipher_request_set_callback(req, 0, NULL, NULL);
   371	
   372		/* If the length is so short that the CTS algorithm will refuse to
   373		 * handle it, prepend a predictable block on the front and discard the
   374		 * output.  Since CTS does draw data backwards, we can regenerate the
   375		 * encryption on just that block at decryption time.
   376		 */
   377		if (len < 16) {
   378			unsigned int i;
   379			u8 *p = buf + 16;
   380	
   381			kdebug("preblock %16phN", iv);
   382			sha256_init(sha);
   383			sha256_update(sha, iv, 32); /* iv and session key */
   384			sha256_final(sha, b0);
   385			kdebug("preblock %16phN", b0);
   386	
   387			netfs_dump_sg("SRC", source_sg, n_source);
   388			if (sg_copy_to_buffer(source_sg, n_source, p, len) != len) {
   389				ret = -EIO;
   390				goto error_req;
   391			}
   392	
   393			for (i = 0; i < len; i++)
   394				p[i] += b0[i];
   395	
   396			if (sg_copy_from_buffer(dest_sg, n_dest, p, len) != len) {
   397				ret = -EIO;
   398				goto error_req;
   399			}
   400			netfs_dump_sg("DST", source_sg, n_source);
   401			ret = 0;
   402		} else {
   403			netfs_dump_sg("SRC", source_sg, n_source);
   404			netfs_dump_sg("DST", dest_sg, n_dest);
   405			skcipher_request_set_crypt(req, source_sg, dest_sg, len, iv);
   406			ret = crypto_skcipher_encrypt(req);
   407			if (ret < 0)
   408				pr_err("Encrypt failed: %d\n", ret);
   409		}
   410	
   411	error_req:
   412		skcipher_request_free(req);
   413	error_ci:
   414		kfree(buf);
   415		crypto_free_sync_skcipher(ci);
   416	error:
   417		return ret;
   418	}
   419	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
