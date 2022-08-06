Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6910058B3F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 07:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239527AbiHFFvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 01:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiHFFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 01:51:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9EEE13
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 22:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659765108; x=1691301108;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+wvkLSEiVJ+P6g4llMQGtOn/AZ9S7xgW7B7Hpo3Uc7c=;
  b=T+kdmkpbFfnytKmW8lVgznjjkvHqwBAa1kde7Nz421bEhVndifXagh8/
   yCIjWcAk/CdbvV5L3q9nKuGiP8hP5X77nvrDkXZWGz/uXeJLnxMxWZMWD
   hdhV0FJR/HnLbMbOheXEMSIberbvy8OzZjZJLDKfJPZOuYsgl2I4ktzaL
   17x+2/As/IYH2RkXzn56XJQaalLmR8Ew9QpeQ2wtPDS6tzCniGC3cbN2J
   jZ55GpcEqKv1lqjQVUchLBwcBehFHz1EqOX3kP2OGnjsCr6pxtg6a8aI/
   B5WA9dz+kB3y0axmFIRHpfj6kXpbJlhQTPLUPbmrGqprsGt5If/RmtyzK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277267686"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="277267686"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 22:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="579747043"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 22:51:46 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKCiw-000K5j-02;
        Sat, 06 Aug 2022 05:51:46 +0000
Date:   Sat, 6 Aug 2022 13:50:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: drivers/block/null_blk/./trace.h:33:1: sparse: sparse: cast to
 restricted blk_opf_t
Message-ID: <202208061324.VHI5boIp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: 342a72a334073f163da924b69c3d3fb4685eb33a block: Introduce the type blk_opf_t
date:   3 weeks ago
config: arm64-randconfig-s052-20220804 (https://download.01.org/0day-ci/archive/20220806/202208061324.VHI5boIp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=342a72a334073f163da924b69c3d3fb4685eb33a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 342a72a334073f163da924b69c3d3fb4685eb33a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/block/ fs/zonefs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/block/null_blk/zoned.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, drivers/block/null_blk/trace.h):
>> drivers/block/null_blk/./trace.h:33:1: sparse: sparse: cast to restricted blk_opf_t
>> drivers/block/null_blk/./trace.h:33:1: sparse: sparse: cast to restricted blk_opf_t
>> drivers/block/null_blk/./trace.h:33:1: sparse: sparse: restricted blk_opf_t degrades to integer
>> drivers/block/null_blk/./trace.h:33:1: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/block/null_blk/zoned.c: note: in included file (through drivers/block/null_blk/null_blk.h):
   include/linux/blk-mq.h:203:33: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blk-mq.h:203:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_opf_t enum req_op @@     got unsigned int @@
   include/linux/blk-mq.h:203:31: sparse:     expected restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:203:31: sparse:     got unsigned int
   include/linux/blk-mq.h:203:33: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blk-mq.h:203:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_opf_t enum req_op @@     got unsigned int @@
   include/linux/blk-mq.h:203:31: sparse:     expected restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:203:31: sparse:     got unsigned int
   drivers/block/null_blk/zoned.c:56:32: sparse: sparse: context imbalance in 'null_report_zones' - unexpected unlock
   drivers/block/null_blk/zoned.c:56:32: sparse: sparse: context imbalance in 'null_zone_write' - unexpected unlock
   drivers/block/null_blk/zoned.c:498:29: sparse: sparse: context imbalance in 'null_open_zone' - different lock contexts for basic block
   drivers/block/null_blk/zoned.c:513:29: sparse: sparse: context imbalance in 'null_close_zone' - different lock contexts for basic block
   drivers/block/null_blk/zoned.c:558:29: sparse: sparse: context imbalance in 'null_finish_zone' - different lock contexts for basic block
   drivers/block/null_blk/zoned.c:574:37: sparse: sparse: context imbalance in 'null_reset_zone' - different lock contexts for basic block
   drivers/block/null_blk/zoned.c:56:32: sparse: sparse: context imbalance in 'null_zone_mgmt' - unexpected unlock
   drivers/block/null_blk/zoned.c:56:32: sparse: sparse: context imbalance in 'null_process_zoned_cmd' - unexpected unlock

vim +33 drivers/block/null_blk/./trace.h

c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  32  
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25 @33  TRACE_EVENT(nullb_zone_op,
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  34  	    TP_PROTO(struct nullb_cmd *cmd, unsigned int zone_no,
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  35  		     unsigned int zone_cond),
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  36  	    TP_ARGS(cmd, zone_no, zone_cond),
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  37  	    TP_STRUCT__entry(
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  38  		__array(char, disk, DISK_NAME_LEN)
ff07a02e9e8e648 drivers/block/null_blk/trace.h Bart Van Assche    2022-07-14  39  		__field(enum req_op, op)
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  40  		__field(unsigned int, zone_no)
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  41  		__field(unsigned int, zone_cond)
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  42  	    ),
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  43  	    TP_fast_assign(
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  44  		__entry->op = req_op(cmd->rq);
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  45  		__entry->zone_no = zone_no;
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  46  		__entry->zone_cond = zone_cond;
f3fa33acca9f005 drivers/block/null_blk/trace.h Christoph Hellwig  2021-11-26  47  		__assign_disk_name(__entry->disk, cmd->rq->q->disk);
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  48  	    ),
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  49  	    TP_printk("%s req=%-15s zone_no=%u zone_cond=%-10s",
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  50  		      __print_disk_name(__entry->disk),
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  51  		      blk_op_str(__entry->op),
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  52  		      __entry->zone_no,
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  53  		      blk_zone_cond_str(__entry->zone_cond))
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  54  );
c51d04199826824 drivers/block/null_blk_trace.h Chaitanya Kulkarni 2020-03-25  55  

:::::: The code at line 33 was first introduced by commit
:::::: c51d04199826824944ed563748c9542eea27c2d7 null_blk: add tracepoint helpers for zoned mode

:::::: TO: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
