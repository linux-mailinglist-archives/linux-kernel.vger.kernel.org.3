Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34985577075
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiGPRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:43:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDFA1C108
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657993411; x=1689529411;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1KVXMHQMW6RKfp8RUFLESXDiTcg/Sa7+X74MV9ssqV4=;
  b=SGLQZ1Z4FaqHngC+8Lw6/+xBAuHYvnsVLIcrmQ2asM3JZow6KdA0ZY23
   X6qrh7Fzrg8XJNSrzPL6259KX3/hNjlJ8YbWjtwGewR9QtEO1smn++kq3
   IdzRwCuADDLHjvFAS56a7P2XAK5kH8g4vwKmEKU3cl/gWzigNYCzY5LLB
   plqwVOdWmkmglC8WF/Kou5tPr6oawQ/9ufBXpd11ms1IAtw6WVK7Z32T4
   Zj3kaAGIckwLk5o6/2XV6WGMmvOs020xL5RGT3mmJLsjW4gyaZz6UIKgU
   UJqjShOqTG0Zxzl1+ZZAnLrn/BYYFx7TWCzDjyYoiKg0BpszCCGIkRg7Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="269016686"
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="269016686"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 10:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="842851551"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2022 10:43:28 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oClp9-0001tu-V7;
        Sat, 16 Jul 2022 17:43:27 +0000
Date:   Sun, 17 Jul 2022 01:42:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 96/112]
 fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted blk_opf_t
Message-ID: <202207170156.khJQtN9O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-next
head:   b1fc9e8ad3d2d294d15e87d57af00890cd23cfc4
commit: e46b5970496705127f9ae494c66e0242773097e8 [96/112] fs/zonefs: Use the enum req_op type for tracing request operations
config: mips-randconfig-s033-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170156.khJQtN9O-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/e46b5970496705127f9ae494c66e0242773097e8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout e46b5970496705127f9ae494c66e0242773097e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash fs/zonefs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/zonefs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, fs/zonefs/trace.h):
>> fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted blk_opf_t
>> fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted blk_opf_t
>> fs/zonefs/./trace.h:22:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> fs/zonefs/./trace.h:22:1: sparse: sparse: restricted blk_opf_t degrades to integer

vim +22 fs/zonefs/./trace.h

62ab1aadcccd03 Johannes Thumshirn 2021-01-27  21  
62ab1aadcccd03 Johannes Thumshirn 2021-01-27 @22  TRACE_EVENT(zonefs_zone_mgmt,
ff07a02e9e8e64 Bart Van Assche    2022-07-14  23  	    TP_PROTO(struct inode *inode, enum req_op op),
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  24  	    TP_ARGS(inode, op),
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  25  	    TP_STRUCT__entry(
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  26  			     __field(dev_t, dev)
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  27  			     __field(ino_t, ino)
e46b5970496705 Bart Van Assche    2022-07-14  28  			     __field(enum req_op, op)
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  29  			     __field(sector_t, sector)
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  30  			     __field(sector_t, nr_sectors)
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  31  	    ),
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  32  	    TP_fast_assign(
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  33  			   __entry->dev = inode->i_sb->s_dev;
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  34  			   __entry->ino = inode->i_ino;
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  35  			   __entry->op = op;
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  36  			   __entry->sector = ZONEFS_I(inode)->i_zsector;
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  37  			   __entry->nr_sectors =
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  38  				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  39  	    ),
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  40  	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  41  		      show_dev(__entry->dev), (unsigned long)__entry->ino,
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  42  		      blk_op_str(__entry->op), __entry->sector,
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  43  		      __entry->nr_sectors
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  44  	    )
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  45  );
62ab1aadcccd03 Johannes Thumshirn 2021-01-27  46  

:::::: The code at line 22 was first introduced by commit
:::::: 62ab1aadcccd037a7ced4ed99b4d46d2b4190183 zonefs: add tracepoints for file operations

:::::: TO: Johannes Thumshirn <johannes.thumshirn@wdc.com>
:::::: CC: Damien Le Moal <damien.lemoal@wdc.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
