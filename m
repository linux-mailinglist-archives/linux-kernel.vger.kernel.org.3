Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB874F719F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiDGBe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiDGBcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:32:05 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2083DAFD4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 18:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649294765; x=1680830765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fZ291ic3waNvY0BAT14yHav4HdGGi932SjJLUuRh/3c=;
  b=JkZfrbCe+rIJifgK9aXAIEOYPQQY3QdzGet4fgCdW2jVvuscOBgz/EGn
   pbnc0Q+iLsSEZK8ITTN4AqoJAtJITlEC9Zlfz/H3D4Z6DByo0zBXhJsOY
   KXp2NjyFeHlIbjgZi0ucnCmVEOoRLJKe3/sr71XzWg1x2P5MnQNxm8dbe
   p2WXr5eN/aRh9hg9pTVyOYHdHZ/rxcrX/d6oF7SUScv0tjYYqONtIhctZ
   pN/NJbbciX9My90BeACyBigRnaZb1DjUz1fmKjOCKarzx5KqlLKn/BZqD
   ofXXrlC5Wu+Y5/aJyKky0YnzK7TuNmjuD7DlvnqOS/nebnvnYqHBtsPd4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="321893628"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="321893628"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="524720932"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2022 18:26:03 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncGuQ-0004vz-QR;
        Thu, 07 Apr 2022 01:26:02 +0000
Date:   Thu, 7 Apr 2022 09:25:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 26/40]
 fs/netfs/crypto.c:208:1: warning: the frame size of 1040 bytes is larger
 than 1024 bytes
Message-ID: <202204070930.v6UQvVXJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: fc693b2e39df6567a0312f21bb9004e1d7983286 [26/40] netfs: Perform content encryption
config: powerpc-buildonly-randconfig-r004-20220406 (https://download.01.org/0day-ci/archive/20220407/202204070930.v6UQvVXJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/fc693b2e39df6567a0312f21bb9004e1d7983286
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout fc693b2e39df6567a0312f21bb9004e1d7983286
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:26,
                    from arch/powerpc/include/asm/page.h:11,
                    from arch/powerpc/include/asm/thread_info.h:13,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/netfs/crypto.c:8:
   fs/netfs/crypto.c: In function 'netfs_xarray_to_sglist':
   include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast
      20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
         |                                   ^~
   include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
      26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
         |                  ^~~~~~~~~~~
   include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
      36 |         __builtin_choose_expr(__safe_cmp(x, y), \
         |                               ^~~~~~~~~~
   include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
      45 | #define min(x, y)       __careful_cmp(x, y, <)
         |                         ^~~~~~~~~~~~~
   fs/netfs/crypto.c:76:31: note: in expansion of macro 'min'
      76 |                         seg = min(len, PAGE_SIZE - offset);
         |                               ^~~
   fs/netfs/crypto.c: In function 'netfs_encrypt':
>> fs/netfs/crypto.c:208:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     208 | }
         | ^


vim +208 fs/netfs/crypto.c

   133	
   134	/*
   135	 * Prepare a write request for writing.  We encrypt from wreq->buffer to
   136	 * wreq->buffer2.
   137	 */
   138	bool netfs_encrypt(struct netfs_io_request *wreq)
   139	{
   140		struct netfs_i_context *ctx = netfs_i_context(wreq->inode);
   141		struct scatterlist source_sg[16], dest_sg[16];
   142		unsigned int n_source, n_dest;
   143		size_t n, chunk, bsize = 1UL << ctx->crypto_bshift;
   144		loff_t pos;
   145		int ret;
   146	
   147		_enter("");
   148	
   149		trace_netfs_rreq(wreq, netfs_rreq_trace_encrypt);
   150	
   151		pos = wreq->start;
   152		n = wreq->len;
   153		_debug("ENCRYPT %llx-%llx", pos, pos + n - 1);
   154	
   155		for (; n > 0; n -= chunk, pos += chunk) {
   156			chunk = min(n, bsize);
   157	
   158			switch (wreq->buffering) {
   159			case NETFS_ENC_BUFFER_TO_BOUNCE:
   160				ret = netfs_xarray_to_sglist(&wreq->buffer, pos, chunk,
   161							     source_sg, ARRAY_SIZE(source_sg));
   162				break;
   163			case NETFS_ENC_DIRECT_TO_BOUNCE:
   164				ret = netfs_iter_to_sglist(&wreq->direct_iter, chunk,
   165							   dest_sg, ARRAY_SIZE(dest_sg));
   166				break;
   167			case NETFS_COPY_ENC_BOUNCE:
   168				ret = netfs_xarray_to_sglist(&wreq->bounce, pos, chunk,
   169							     source_sg, ARRAY_SIZE(source_sg));
   170				break;
   171			default:
   172				BUG();
   173			}
   174			if (ret < 0)
   175				goto error;
   176			n_source = ret;
   177	
   178			switch (wreq->buffering) {
   179			case NETFS_ENC_BUFFER_TO_BOUNCE:
   180			case NETFS_ENC_DIRECT_TO_BOUNCE:
   181				ret = netfs_xarray_to_sglist(&wreq->bounce, pos, chunk,
   182							     dest_sg, ARRAY_SIZE(dest_sg));
   183				break;
   184			case NETFS_COPY_ENC_BOUNCE:
   185				memcpy(dest_sg, source_sg, sizeof(dest_sg));
   186				ret = n_source;
   187				break;
   188			default:
   189				BUG();
   190			}
   191			if (ret < 0)
   192				goto error;
   193			n_dest = ret;
   194	
   195			ret = ctx->ops->encrypt_block(wreq, pos, chunk,
   196						      source_sg, n_source, dest_sg, n_dest);
   197			if (ret < 0)
   198				goto error_failed;
   199		}
   200	
   201		return true;
   202	
   203	error_failed:
   204		trace_netfs_failure(wreq, NULL, ret, netfs_fail_encryption);
   205	error:
   206		wreq->error = ret;
   207		return false;
 > 208	}

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
