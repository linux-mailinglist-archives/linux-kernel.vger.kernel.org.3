Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5558B467
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiHFIBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbiHFIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:00:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1CC13DE0
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659772852; x=1691308852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Zv7ihRb6MPbOwGcHXJSCwSYvqqp+/GBKhT9/Fo058Y=;
  b=KF8iyVXL8eBhNALO8eoFK8kOcKndePe5jfPbUuZ8AS+lGQjXunoEU3IN
   Bu1IbuGrDH4g2J5wxEb4GQ8XjEB0WV6Q9iw4oE4E8+RIC2diZ3EQz2MnY
   d3BZlAjT/m9G8Xd4/XRJ9IvTLsAK5S+V1oNw8IcjynCfm5ipCfL5Wi8H+
   n3EPJti7u1KF1PdguhMNMNjr9wOlcPuHaUdT67US6LvVQYToFPzU7ur7w
   hDDg50tHatorFDoQ6a4on+R1w/XlvxR8ic0jZBCPo/Wd2zm6UGdiWkmfu
   YqV9ia6hqXSufeBkq2PG61miWZK516mgJg54ozyAWmRd2HmjVhqc3Hz7N
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="352073042"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352073042"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 01:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="730232329"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2022 01:00:49 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKEjp-000KBZ-0Y;
        Sat, 06 Aug 2022 08:00:49 +0000
Date:   Sat, 6 Aug 2022 16:00:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Message-ID: <202208061533.YBqXyzHm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: e46b5970496705127f9ae494c66e0242773097e8 fs/zonefs: Use the enum req_op type for tracing request operations
date:   3 weeks ago
config: arm64-randconfig-s052-20220804 (https://download.01.org/0day-ci/archive/20220806/202208061533.YBqXyzHm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e46b5970496705127f9ae494c66e0242773097e8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e46b5970496705127f9ae494c66e0242773097e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash fs/zonefs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   fs/zonefs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, fs/zonefs/trace.h):
>> fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted blk_opf_t
>> fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted blk_opf_t
>> fs/zonefs/./trace.h:22:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> fs/zonefs/./trace.h:22:1: sparse: sparse: restricted blk_opf_t degrades to integer
   fs/zonefs/super.c: note: in included file (through arch/arm64/include/asm/smp.h, include/linux/smp.h, arch/arm64/include/asm/arch_timer.h, ...):
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
   arch/arm64/include/asm/percpu.h:127:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)

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
