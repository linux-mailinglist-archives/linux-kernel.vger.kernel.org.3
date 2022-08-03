Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057E95885B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiHCCTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiHCCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:19:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7534454AC4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659493186; x=1691029186;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XvWc6/IhE9bacJZzGsb8jS7BDC9vN0R4MZJc4qnjiyg=;
  b=boHxPm9fA/kCXGdnFnEdhF6tqqLdaxyxWLwOzeHmHCJqus6okQOL6E8J
   KOG1NBJTxGIlF9dL5tlKKm14od9xWmpopUn8qJvzBxxNunwGe5ZVk11CJ
   +Cadz+EcnlaNTGlKUaBKLtHUE3qvnykHMKO+VgQEHa1XfQNKuw1zZnb5u
   YTQRdWXjIGaP9gr3yVwHoU7lSFbhSj+WwlK0NWnnmAZHjfCAcH0uB73p2
   QXN5SqFZ+vZTM4J54qc+jHPze3w0nqJAkVgbevK6gQvHNVodTD2C280Zp
   4iItyRBz6aY71g212owmgq+d8JLrlWFaf9MwONf7ww1oHgTSPf26WdC4c
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290337738"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="290337738"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 19:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="635510327"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2022 19:19:43 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ3z4-000Ggy-2J;
        Wed, 03 Aug 2022 02:19:42 +0000
Date:   Wed, 3 Aug 2022 10:19:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/drivers 116/128]
 drivers/md/dm.c:1019:32: error: no member named 'bio_split' in 'struct
 request_queue'
Message-ID: <202208031056.CwBNWtsS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/drivers
head:   4a60e6e655b81b817569ee42f481de06506848b3
commit: faf18cbbdb8631b48bf103f9e06e944f80e3b6bf [116/128] block: move ->bio_split to the gendisk
config: hexagon-randconfig-r041-20220801 (https://download.01.org/0day-ci/archive/20220803/202208031056.CwBNWtsS-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/faf18cbbdb8631b48bf103f9e06e944f80e3b6bf
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/drivers
        git checkout faf18cbbdb8631b48bf103f9e06e944f80e3b6bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/md/dm.c:1019:32: error: no member named 'bio_split' in 'struct request_queue'
                   dm_io_rewind(io, &md->queue->bio_split);
                                     ~~~~~~~~~  ^
   1 error generated.


vim +1019 drivers/md/dm.c

e27363472f9bc9 Mike Snitzer 2022-03-09  1002  
8b211aaccb915b Ming Lei     2022-06-24  1003  static void dm_wq_requeue_work(struct work_struct *work)
8b211aaccb915b Ming Lei     2022-06-24  1004  {
8b211aaccb915b Ming Lei     2022-06-24  1005  	struct mapped_device *md = container_of(work, struct mapped_device,
8b211aaccb915b Ming Lei     2022-06-24  1006  						requeue_work);
8b211aaccb915b Ming Lei     2022-06-24  1007  	unsigned long flags;
8b211aaccb915b Ming Lei     2022-06-24  1008  	struct dm_io *io;
8b211aaccb915b Ming Lei     2022-06-24  1009  
8b211aaccb915b Ming Lei     2022-06-24  1010  	/* reuse deferred lock to simplify dm_handle_requeue */
8b211aaccb915b Ming Lei     2022-06-24  1011  	spin_lock_irqsave(&md->deferred_lock, flags);
8b211aaccb915b Ming Lei     2022-06-24  1012  	io = md->requeue_list;
8b211aaccb915b Ming Lei     2022-06-24  1013  	md->requeue_list = NULL;
8b211aaccb915b Ming Lei     2022-06-24  1014  	spin_unlock_irqrestore(&md->deferred_lock, flags);
8b211aaccb915b Ming Lei     2022-06-24  1015  
8b211aaccb915b Ming Lei     2022-06-24  1016  	while (io) {
8b211aaccb915b Ming Lei     2022-06-24  1017  		struct dm_io *next = io->next;
8b211aaccb915b Ming Lei     2022-06-24  1018  
8b211aaccb915b Ming Lei     2022-06-24 @1019  		dm_io_rewind(io, &md->queue->bio_split);
8b211aaccb915b Ming Lei     2022-06-24  1020  
8b211aaccb915b Ming Lei     2022-06-24  1021  		io->next = NULL;
8b211aaccb915b Ming Lei     2022-06-24  1022  		__dm_io_complete(io, false);
8b211aaccb915b Ming Lei     2022-06-24  1023  		io = next;
8b211aaccb915b Ming Lei     2022-06-24  1024  	}
8b211aaccb915b Ming Lei     2022-06-24  1025  }
8b211aaccb915b Ming Lei     2022-06-24  1026  

:::::: The code at line 1019 was first introduced by commit
:::::: 8b211aaccb915bbf4f4a68f1910c4de701df393b dm: add two stage requeue mechanism

:::::: TO: Ming Lei <ming.lei@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
