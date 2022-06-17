Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BED54F285
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380793AbiFQIJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380252AbiFQIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:09:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D267D3C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655453375; x=1686989375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PsP8oGZ7IObPmLt6SEBKeNlWvyg0hlgFC/ZMOLRRyB0=;
  b=U9b1LcF6U3WFz0+sXtacsGIe07udWaNvT3OZQLGYP6POCFYVffR1Ofr5
   bLezUP4jTZh7EVBZ4M3zCddiUKcYTBBN1FLVZitOzD506yqP6nL/oAG5e
   2fwNGyTh9wnohAAO17AnqYkwtLyIds+1inZM3tbaNE/hNKlHXigrDqehi
   j7+YBmTlHkKWp7t+BpJSkhNypBPh01n1GwSEv0kYSs4LmjmYdikTZDvny
   EbCZaBgbSZL2u0jkn5iIBLHu6wIjSJqdY6QUfKvC4estbfB7kbg6zNHil
   A01VsRqWptS7xcq7QcLrvtCEdaTy+EdcLgoGrHS8PV+vnwwcuuu5IbUuz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262468426"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262468426"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 01:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="613476524"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2022 01:09:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o272r-000PEj-4S;
        Fri, 17 Jun 2022 08:09:33 +0000
Date:   Fri, 17 Jun 2022 16:09:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 15/15] block/blk-wbt.c:677:11: error:
 call to __compiletime_assert_332 declared with 'error' attribute:
 BUILD_BUG_ON failed: !__same_type(op, blk_mq_opf_t) && !__same_type(op, enum
 req_op)
Message-ID: <202206171642.Dj2zJ4rt-lkp@intel.com>
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
config: hexagon-randconfig-r045-20220617 (https://download.01.org/0day-ci/archive/20220617/202206171642.Dj2zJ4rt-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/031ccdd616b11c4e774e56aa7eae906188ab24cc
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 031ccdd616b11c4e774e56aa7eae906188ab24cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> block/blk-wbt.c:677:11: error: call to __compiletime_assert_332 declared with 'error' attribute: BUILD_BUG_ON failed: !__same_type(op, blk_mq_opf_t) && !__same_type(op, enum req_op)
           else if (op_is_write(op))
                    ^
   include/linux/blk_types.h:487:3: note: expanded from macro 'op_is_write'
                   BUILD_BUG_ON(!__same_type(op, blk_mq_opf_t) &&  \
                   ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:89:1: note: expanded from here
   __compiletime_assert_332
   ^
   1 error generated.


vim +/error +677 block/blk-wbt.c

80e091d10e8bf7 Jens Axboe 2016-11-28  670  
99c749a4c4f4ea Jens Axboe 2017-04-21  671  static int wbt_data_dir(const struct request *rq)
99c749a4c4f4ea Jens Axboe 2017-04-21  672  {
5235553d821433 Jens Axboe 2018-02-05  673  	const int op = req_op(rq);
5235553d821433 Jens Axboe 2018-02-05  674  
5235553d821433 Jens Axboe 2018-02-05  675  	if (op == REQ_OP_READ)
5235553d821433 Jens Axboe 2018-02-05  676  		return READ;
825843b0adb7c9 Jens Axboe 2018-05-03 @677  	else if (op_is_write(op))
5235553d821433 Jens Axboe 2018-02-05  678  		return WRITE;
5235553d821433 Jens Axboe 2018-02-05  679  
5235553d821433 Jens Axboe 2018-02-05  680  	/* don't account */
5235553d821433 Jens Axboe 2018-02-05  681  	return -1;
99c749a4c4f4ea Jens Axboe 2017-04-21  682  }
99c749a4c4f4ea Jens Axboe 2017-04-21  683  

:::::: The code at line 677 was first introduced by commit
:::::: 825843b0adb7c95e8cbab35e6fee64980e29ade8 blk-wbt: account any writing command as a write

:::::: TO: Jens Axboe <axboe@kernel.dk>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
