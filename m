Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A02550B0A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiFSNzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiFSNzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:55:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CA658C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655646901; x=1687182901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N5l7NMyC97RfHbYVj/MJwUW/QzLVaeXo2mpCIkMbH6Q=;
  b=Vx8UXlqvKBr+3mDmA83KM6Z1Bkg/4NZGpOJ8rWXR+V/Phl+sNEWAn9Q+
   EDLEus2qkPQV+93ELsoZ0TeiEGwM6m6xiqzUM7WpzGHSpNZMGUSQ+RSm4
   Ft3EModcw8tAxT/xTTl+bDTb2ZOVsURVQGg2Cth1/eCBTrvTu5/oT1THY
   +px7CYHvvmdbLD8JWeafbfyGQGUrsRLrfOIssBohK4DcwHYB3f0V0CfpG
   EFrIsvhQpgx0FqUZvtPvDhWXv3Ej1FwXGL+yrUv8SLWvwnpHgbCmjjR6m
   v3MN8w1Dl15Z2DbydmekPXxeA/l5ga+hjTZDVA9tVwyyGoSr1IqYxN7IG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262770732"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262770732"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="689058860"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2022 06:54:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2vOF-000RGT-8A;
        Sun, 19 Jun 2022 13:54:59 +0000
Date:   Sun, 19 Jun 2022 21:54:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 15/15]
 drivers/block/paride/pd.c:487:10: warning: 12 enumeration values not handled
 in switch: 'REQ_OP_FLUSH', 'REQ_OP_DISCARD', 'REQ_OP_SECURE_ERASE'...
Message-ID: <202206192107.iLLORMOz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   031ccdd616b11c4e774e56aa7eae906188ab24cc
commit: 031ccdd616b11c4e774e56aa7eae906188ab24cc [15/15] block: Introduce the type blk_mq_opf_t
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220619/202206192107.iLLORMOz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/bvanassche/linux/commit/031ccdd616b11c4e774e56aa7eae906188ab24cc
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 031ccdd616b11c4e774e56aa7eae906188ab24cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/block/paride/pd.c:487:10: warning: 12 enumeration values not handled in switch: 'REQ_OP_FLUSH', 'REQ_OP_DISCARD', 'REQ_OP_SECURE_ERASE'... [-Wswitch]
           switch (req_op(pd_req)) {
                   ^~~~~~~~~~~~~~
   include/linux/blk-mq.h:200:21: note: expanded from macro 'req_op'
   #define req_op(req) (__force enum req_op)((req)->cmd_flags & REQ_OP_MASK)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +487 drivers/block/paride/pd.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  484  
^1da177e4c3f41 Linus Torvalds    2005-04-16  485  static enum action do_pd_io_start(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16  486  {
aebf526b53aea1 Christoph Hellwig 2017-01-31 @487  	switch (req_op(pd_req)) {
aebf526b53aea1 Christoph Hellwig 2017-01-31  488  	case REQ_OP_DRV_IN:
^1da177e4c3f41 Linus Torvalds    2005-04-16  489  		phase = pd_special;
^1da177e4c3f41 Linus Torvalds    2005-04-16  490  		return pd_special();
aebf526b53aea1 Christoph Hellwig 2017-01-31  491  	case REQ_OP_READ:
aebf526b53aea1 Christoph Hellwig 2017-01-31  492  	case REQ_OP_WRITE:
83096ebf1263b2 Tejun Heo         2009-05-07  493  		pd_block = blk_rq_pos(pd_req);
83096ebf1263b2 Tejun Heo         2009-05-07  494  		pd_count = blk_rq_cur_sectors(pd_req);
f3fa33acca9f00 Christoph Hellwig 2021-11-26  495  		if (pd_block + pd_count > get_capacity(pd_req->q->disk))
^1da177e4c3f41 Linus Torvalds    2005-04-16  496  			return Fail;
83096ebf1263b2 Tejun Heo         2009-05-07  497  		pd_run = blk_rq_sectors(pd_req);
b4f42e2831ff9b Jens Axboe        2014-04-10  498  		pd_buf = bio_data(pd_req->bio);
^1da177e4c3f41 Linus Torvalds    2005-04-16  499  		pd_retries = 0;
aebf526b53aea1 Christoph Hellwig 2017-01-31  500  		if (req_op(pd_req) == REQ_OP_READ)
^1da177e4c3f41 Linus Torvalds    2005-04-16  501  			return do_pd_read_start();
^1da177e4c3f41 Linus Torvalds    2005-04-16  502  		else
^1da177e4c3f41 Linus Torvalds    2005-04-16  503  			return do_pd_write_start();
^1da177e4c3f41 Linus Torvalds    2005-04-16  504  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  505  	return Fail;
^1da177e4c3f41 Linus Torvalds    2005-04-16  506  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  507  

:::::: The code at line 487 was first introduced by commit
:::::: aebf526b53aea164508730427597d45f3e06b376 block: fold cmd_type into the REQ_OP_ space

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Jens Axboe <axboe@fb.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
