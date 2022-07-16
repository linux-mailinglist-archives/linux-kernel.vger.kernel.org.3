Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0C1577237
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiGPXLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPXLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:11:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EE3AA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658013060; x=1689549060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YDE6zXtadoR6QeqpOQSfLcZmPiO1mqH4+LBOJCJUl2U=;
  b=OG6YbgMrOmTfG/nz9q1gLEgSHAraRgHoIRaZe/7quuV+9mzoiRfHXnjk
   LPWbnEx7yFcf80bVY2R4WEiSkxwgYZGfaS/r7pwfJ830kPE2ZUoqW7lmz
   XU52NI80NTfrYRRQbiqbwCNEwET/m05DULmInDh4H2u7Mn4lAajxZlfle
   jLgQyFKfwVE9Fvrgno4tgh6OYUxD4jujG9/p0Vwyoddm1HhQbZ3iecN4H
   zf1KuRkNhGdosM5KXejwvjukgFsz/aJtlpBGZoP+aPsVBYYlrgdaKpZR5
   D6DzhgZI4kICq6rHRVuQhz4MttfI4ovoJY7kohadHFqc9/IHO5vKef8+n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="349975434"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="349975434"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 16:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="923907647"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2022 16:10:58 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCqw5-0002Hm-Sn;
        Sat, 16 Jul 2022 23:10:57 +0000
Date:   Sun, 17 Jul 2022 07:10:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/for-next 38/112]
 drivers/block/null_blk/./trace.h:33:1: sparse: sparse: cast to restricted
 blk_opf_t
Message-ID: <202207170714.TFHAZreF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-next
head:   b1fc9e8ad3d2d294d15e87d57af00890cd23cfc4
commit: 342a72a334073f163da924b69c3d3fb4685eb33a [38/112] block: Introduce the type blk_opf_t
config: csky-randconfig-s053-20220715 (https://download.01.org/0day-ci/archive/20220717/202207170714.TFHAZreF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/342a72a334073f163da924b69c3d3fb4685eb33a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-next
        git checkout 342a72a334073f163da924b69c3d3fb4685eb33a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/block/ fs/

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
