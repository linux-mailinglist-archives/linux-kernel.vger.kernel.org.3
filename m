Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB550C8EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbiDWKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiDWKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:04:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E1165EDD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650708077; x=1682244077;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JoPlsE2ABpO9h5Sw7SvTCPwR/5jbxfCoNRpstzd3JpY=;
  b=VOVIvXiOBli6n1d3jhAQx3dza8BOFItAcIsuLYr4Kp7G8f+gsPmOdhMa
   82M2D89nbCkgBOtlywfSj8QEGbzrEmMAPuiSBFHLrOrfxO5Sor+NZTYsb
   6yYSK1RO1zbN2aUutHQV3FhyP09Nb6gVjEj+VpgFI1ZcaOynaQ3wW6qQ+
   n1jtS2pn66nas/IMHPQ6cFps47Hs07S1Ywdp45ohnWHt7Vzxo+C0Ajuna
   jmZG2aUeM6XWHkTvE7rT2wAGRepNPin68FSRjHGaEUpgdell0zVLB8mZc
   36wCmUBzEo8Zqbc8txDBo1kd237hGZeJea962twoA2D0Ko1NQ0s0pOnlh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351324982"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="351324982"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 03:01:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="728890233"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 03:01:15 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niCZn-00008x-0b;
        Sat, 23 Apr 2022 10:01:15 +0000
Date:   Sat, 23 Apr 2022 18:01:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 42/44]
 fs/afs/write.c:271:24: sparse: sparse: incorrect type in assignment
 (different base types)
Message-ID: <202204231701.vIC3BFdf-lkp@intel.com>
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
config: alpha-randconfig-s031-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231701.vIC3BFdf-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/0565641524458774e47a4d1fd06f80d0bd62965f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 0565641524458774e47a4d1fd06f80d0bd62965f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash fs/afs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/afs/write.c:271:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] @@     got restricted __le64 [usertype] @@
   fs/afs/write.c:271:24: sparse:     expected restricted __be64 [usertype]
   fs/afs/write.c:271:24: sparse:     got restricted __le64 [usertype]
>> fs/afs/write.c:274:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] @@     got long long [usertype] pos @@
   fs/afs/write.c:274:23: sparse:     expected restricted __be64 [usertype]
   fs/afs/write.c:274:23: sparse:     got long long [usertype] pos
   fs/afs/write.c:378:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] @@     got restricted __le64 [usertype] @@
   fs/afs/write.c:378:24: sparse:     expected restricted __be64 [usertype]
   fs/afs/write.c:378:24: sparse:     got restricted __le64 [usertype]
   fs/afs/write.c:381:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] @@     got long long [usertype] pos @@
   fs/afs/write.c:381:23: sparse:     expected restricted __be64 [usertype]
   fs/afs/write.c:381:23: sparse:     got long long [usertype] pos

vim +271 fs/afs/write.c

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
   265		if (!buf)
   266			goto error_ci;
   267		b0 = buf;
   268		iv = buf + 32;
   269		session_key = buf + 48;
   270		session_key[0] = cpu_to_be64(pos);
 > 271		session_key[1] = cpu_to_le64(pos);
   272		sha = buf + 64;
   273	
 > 274		*(__be64 *)iv = pos;
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
