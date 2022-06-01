Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7A53B0A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiFAXFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 19:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiFAXFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 19:05:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F2C1EB438
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 16:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654124730; x=1685660730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aP5D7RA5fqyqj3fA9KuCw8hZvODqiAI4gHt2yOIN2uM=;
  b=j15WNLV+SA73Lj9ug8BI/1MvgiqUooUWM+s2uhmjtEUYo+KyTec/rsy8
   6j1+TJbUSDi5X9T2aMO0UhoCz1qw+9VU7SvByetY2+0vOtNckBirC7nuf
   +dLYtDj3VnL4+RHwTNjaZFOlvVklK+fZLYMCoqCARjhB7rbqP0cco3Gpd
   qynH07mKErUKe89FQJgqdbKRkZ6Ep/XTs7i76/KoiY2t6dmjJBVil1UbN
   So1rFb+7b8Ea6XjTKDjkIDaNPhX4EvDNEmmgvfMcs3vThLWsLkx7EsJqI
   aEckjjxDScA2/CKmsylx9sP4h2oX0KXKqsrEYNrLVvv48RAF9PvPZiJzx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275833866"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="275833866"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 16:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="707289965"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jun 2022 16:05:28 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwXP5-0004VW-LM;
        Wed, 01 Jun 2022 23:05:27 +0000
Date:   Thu, 2 Jun 2022 07:05:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 39/59]
 fs/netfs/crypto.c:208:1: warning: the frame size of 1056 bytes is larger
 than 1024 bytes
Message-ID: <202206020658.yKznmUUi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   22ecc2fcdab4616e624408911ec1d54644e82030
commit: b5b1a16a9c1a2ff8c62ef0c952b5672b3c78800c [39/59] netfs: Perform content encryption
config: arm-randconfig-r001-20220531 (https://download.01.org/0day-ci/archive/20220602/202206020658.yKznmUUi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b5b1a16a9c1a2ff8c62ef0c952b5672b3c78800c
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout b5b1a16a9c1a2ff8c62ef0c952b5672b3c78800c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/netfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/netfs/crypto.c: In function 'netfs_encrypt':
>> fs/netfs/crypto.c:208:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
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
