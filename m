Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47105334E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiEYBqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbiEYBqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:46:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C1F58
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653443189; x=1684979189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H6qkIbR47T+0X3Xh/6ENrE9zkSWdICP8hBFS5++43AM=;
  b=A6UFmJJ3nB12DR7MhOD1FOtRv1EJOSsWpIpELyM5OWYHY/cf7MZIlsmx
   xHJxtP6+ViMSaqyKklaBfXlQ1jM6T0IsuzzKSfJ1p6HZYh4P1cdt60eLl
   QzIqFcMD4E99nsd0lelktMYCjEQL4VGFa/sorvXJInsctpheRvm5/jRVI
   +/0vUMOPZMAKZpIIXawLuJr9eLwRKAFAkbrQHxNKk+o9Im6YT05ZORYmG
   0hMKAzS22zS5UQimyG53T7YfF45VaECGd7PGtNQ+QlZYB5wFEwu/ZwR1a
   Sx6YLHZmY+c1CfTlOhM7RcuYGENUSUZ7gYLSGCx9TmRrYMg0UP/DwVY2A
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255753800"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="255753800"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 18:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601596084"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 May 2022 18:46:28 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntg6V-0002cS-Bg;
        Wed, 25 May 2022 01:46:27 +0000
Date:   Wed, 25 May 2022 09:45:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring 8/34]
 io_uring/io_uring.c:6533:12: error: redefinition of 'io_shutdown'
Message-ID: <202205250907.Sf2qeeWV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring
head:   efc30c3b043b70c4a299df9f10a948b60ef721e3
commit: 4ad7740c8e760244c249fff910d82f4fcf214bda [8/34] io_uring: move to separate directory
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220525/202205250907.Sf2qeeWV-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4ad7740c8e760244c249fff910d82f4fcf214bda
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring
        git checkout 4ad7740c8e760244c249fff910d82f4fcf214bda
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:2937:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2937 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   io_uring/io_uring.c: At top level:
>> io_uring/io_uring.c:6533:12: error: redefinition of 'io_shutdown'
    6533 | static int io_##op(struct io_kiocb *req, unsigned int issue_flags)      \
         |            ^~~
   io_uring/io_uring.c:6560:1: note: in expansion of macro 'IO_NETOP_FN'
    6560 | IO_NETOP_FN(shutdown);
         | ^~~~~~~~~~~
   io_uring/io_uring.c:6533:12: note: previous definition of 'io_shutdown' with type 'int(struct io_kiocb *, unsigned int)'
    6533 | static int io_##op(struct io_kiocb *req, unsigned int issue_flags)      \
         |            ^~~
   io_uring/io_uring.c:6539:1: note: in expansion of macro 'IO_NETOP_FN'
    6539 | IO_NETOP_FN(op)                                                         \
         | ^~~~~~~~~~~
   io_uring/io_uring.c:6557:1: note: in expansion of macro 'IO_NETOP_PREP'
    6557 | IO_NETOP_PREP(shutdown);
         | ^~~~~~~~~~~~~
   io_uring/io_uring.c:6533:12: warning: 'io_shutdown' defined but not used [-Wunused-function]
    6533 | static int io_##op(struct io_kiocb *req, unsigned int issue_flags)      \
         |            ^~~
   io_uring/io_uring.c:6539:1: note: in expansion of macro 'IO_NETOP_FN'
    6539 | IO_NETOP_FN(op)                                                         \
         | ^~~~~~~~~~~
   io_uring/io_uring.c:6557:1: note: in expansion of macro 'IO_NETOP_PREP'
    6557 | IO_NETOP_PREP(shutdown);
         | ^~~~~~~~~~~~~


vim +/io_shutdown +6533 io_uring/io_uring.c

f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6490  
889fca73287b0a fs/io_uring.c Pavel Begunkov 2021-02-10  6491  static int io_connect(struct io_kiocb *req, unsigned int issue_flags)
f8e85cf255ad57 fs/io_uring.c Jens Axboe     2019-11-23  6492  {
e8c2bc1fb6c949 fs/io_uring.c Jens Axboe     2020-08-15  6493  	struct io_async_connect __io, *io;
f8e85cf255ad57 fs/io_uring.c Jens Axboe     2019-11-23  6494  	unsigned file_flags;
3fbb51c18f5c15 fs/io_uring.c Jens Axboe     2019-12-20  6495  	int ret;
45d189c6062922 fs/io_uring.c Pavel Begunkov 2021-02-10  6496  	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
f8e85cf255ad57 fs/io_uring.c Jens Axboe     2019-11-23  6497  
d886e185a128a4 fs/io_uring.c Pavel Begunkov 2021-10-04  6498  	if (req_has_async_data(req)) {
e8c2bc1fb6c949 fs/io_uring.c Jens Axboe     2020-08-15  6499  		io = req->async_data;
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6500  	} else {
3529d8c2b353e6 fs/io_uring.c Jens Axboe     2019-12-19  6501  		ret = move_addr_to_kernel(req->connect.addr,
3529d8c2b353e6 fs/io_uring.c Jens Axboe     2019-12-19  6502  						req->connect.addr_len,
e8c2bc1fb6c949 fs/io_uring.c Jens Axboe     2020-08-15  6503  						&__io.address);
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6504  		if (ret)
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6505  			goto out;
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6506  		io = &__io;
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6507  	}
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6508  
3fbb51c18f5c15 fs/io_uring.c Jens Axboe     2019-12-20  6509  	file_flags = force_nonblock ? O_NONBLOCK : 0;
3fbb51c18f5c15 fs/io_uring.c Jens Axboe     2019-12-20  6510  
e8c2bc1fb6c949 fs/io_uring.c Jens Axboe     2020-08-15  6511  	ret = __sys_connect_file(req->file, &io->address,
3fbb51c18f5c15 fs/io_uring.c Jens Axboe     2019-12-20  6512  					req->connect.addr_len, file_flags);
87f80d623c6c93 fs/io_uring.c Jens Axboe     2019-12-03  6513  	if ((ret == -EAGAIN || ret == -EINPROGRESS) && force_nonblock) {
d886e185a128a4 fs/io_uring.c Pavel Begunkov 2021-10-04  6514  		if (req_has_async_data(req))
b7bb4f7da0a1a9 fs/io_uring.c Jens Axboe     2019-12-15  6515  			return -EAGAIN;
e8c2bc1fb6c949 fs/io_uring.c Jens Axboe     2020-08-15  6516  		if (io_alloc_async_data(req)) {
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6517  			ret = -ENOMEM;
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6518  			goto out;
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6519  		}
e8c2bc1fb6c949 fs/io_uring.c Jens Axboe     2020-08-15  6520  		memcpy(req->async_data, &__io, sizeof(__io));
f8e85cf255ad57 fs/io_uring.c Jens Axboe     2019-11-23  6521  		return -EAGAIN;
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6522  	}
f8e85cf255ad57 fs/io_uring.c Jens Axboe     2019-11-23  6523  	if (ret == -ERESTARTSYS)
f8e85cf255ad57 fs/io_uring.c Jens Axboe     2019-11-23  6524  		ret = -EINTR;
f499a021ea8c9f fs/io_uring.c Jens Axboe     2019-12-02  6525  out:
4e88d6e7793f2f fs/io_uring.c Jens Axboe     2019-12-07  6526  	if (ret < 0)
93d2bcd2cbfed2 fs/io_uring.c Pavel Begunkov 2021-05-16  6527  		req_set_fail(req);
889fca73287b0a fs/io_uring.c Pavel Begunkov 2021-02-10  6528  	__io_req_complete(req, issue_flags, ret, 0);
f8e85cf255ad57 fs/io_uring.c Jens Axboe     2019-11-23  6529  	return 0;
469956e853ccdb fs/io_uring.c YueHaibing     2020-03-04  6530  }
469956e853ccdb fs/io_uring.c YueHaibing     2020-03-04  6531  #else /* !CONFIG_NET */
99a10081647168 fs/io_uring.c Jens Axboe     2021-02-19  6532  #define IO_NETOP_FN(op)							\
99a10081647168 fs/io_uring.c Jens Axboe     2021-02-19 @6533  static int io_##op(struct io_kiocb *req, unsigned int issue_flags)	\
99a10081647168 fs/io_uring.c Jens Axboe     2021-02-19  6534  {									\
99a10081647168 fs/io_uring.c Jens Axboe     2021-02-19  6535  	return -EOPNOTSUPP;						\
99a10081647168 fs/io_uring.c Jens Axboe     2021-02-19  6536  }
99a10081647168 fs/io_uring.c Jens Axboe     2021-02-19  6537  

:::::: The code at line 6533 was first introduced by commit
:::::: 99a10081647168022745859bb2f1c28b2f70dc83 io_uring: make the !CONFIG_NET helpers a bit more robust

:::::: TO: Jens Axboe <axboe@kernel.dk>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
