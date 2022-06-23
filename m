Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8681C558027
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiFWQpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiFWQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:45:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794A424B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656002709; x=1687538709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M+DSX9YXT0/DkVxnkV3+BQzSY1WMMGsGyz0xOHfPud4=;
  b=CU5hz/QIh3CJMDTt4pIXJQyQLH10GcsH4wP9lIJSGtzGg64SZkY8u08o
   djp4/DF6R8BYoZgieVa92HLiTZR17OwwIjMJNW+Oiwzw/1iyzO4Ful6Oc
   9kTwUXs6y4rBUd69Z67kBR1w8zGsoZUUbVfO4QOeLoAI0vFhKr4coSdnN
   +aBgkoMhL4i7Y8k/kMn+hoZr6bwSdNqYqivarq6sUIJ1qIcYrf3NM6OYl
   yHtwZDTBgTfT7fBYih+uU+jtWNWju0uofECodqRZ/uzNg8PY1aLCicpA2
   Aj82MCljcnANZqTO5KPpuwMm42Qwb/iH5G+L/erO8hq3/qbgVrKZ5kkBd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="263807536"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="263807536"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 09:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="715895396"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2022 09:45:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Px4-00025W-FX;
        Thu, 23 Jun 2022 16:45:06 +0000
Date:   Fri, 24 Jun 2022 00:44:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 11/50]
 drivers/scsi/device_handler/scsi_dh_rdac.c:539:67: sparse: sparse: incorrect
 type in initializer (different base types)
Message-ID: <202206240039.oI3SMpN3-lkp@intel.com>
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
head:   cdae45bfee03111b49b421b4c01dcddb643f64a2
commit: 389f5e4037ed787995e6d3753e502cf1a7c5a9f5 [11/50] block: Introduce the type blk_opf_t
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220624/202206240039.oI3SMpN3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/bvanassche/linux/commit/389f5e4037ed787995e6d3753e502cf1a7c5a9f5
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 389f5e4037ed787995e6d3753e502cf1a7c5a9f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/device_handler/scsi_dh_rdac.c:539:67: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] req_flags @@     got restricted blk_opf_t @@
   drivers/scsi/device_handler/scsi_dh_rdac.c:539:67: sparse:     expected unsigned long long [usertype] req_flags
   drivers/scsi/device_handler/scsi_dh_rdac.c:539:67: sparse:     got restricted blk_opf_t
--
>> drivers/scsi/device_handler/scsi_dh_hp_sw.c:124:67: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] req_flags @@     got restricted blk_opf_t @@
   drivers/scsi/device_handler/scsi_dh_hp_sw.c:124:67: sparse:     expected unsigned long long [usertype] req_flags
   drivers/scsi/device_handler/scsi_dh_hp_sw.c:124:67: sparse:     got restricted blk_opf_t
   drivers/scsi/device_handler/scsi_dh_hp_sw.c:86:67: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] req_flags @@     got restricted blk_opf_t @@
   drivers/scsi/device_handler/scsi_dh_hp_sw.c:86:67: sparse:     expected unsigned long long [usertype] req_flags
   drivers/scsi/device_handler/scsi_dh_hp_sw.c:86:67: sparse:     got restricted blk_opf_t
--
>> drivers/scsi/device_handler/scsi_dh_emc.c:242:67: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] req_flags @@     got restricted blk_opf_t @@
   drivers/scsi/device_handler/scsi_dh_emc.c:242:67: sparse:     expected unsigned long long [usertype] req_flags
   drivers/scsi/device_handler/scsi_dh_emc.c:242:67: sparse:     got restricted blk_opf_t
--
   kernel/trace/blktrace.c:234:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted blk_opf_t [usertype] op @@     got int op @@
   kernel/trace/blktrace.c:234:38: sparse:     expected restricted blk_opf_t [usertype] op
   kernel/trace/blktrace.c:234:38: sparse:     got int op
>> kernel/trace/blktrace.c:235:17: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:236:17: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:237:17: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:238:17: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:239:17: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:240:19: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:240:43: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:242:19: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:848:70: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected int op @@     got restricted blk_opf_t enum req_op @@
   kernel/trace/blktrace.c:848:70: sparse:     expected int op
   kernel/trace/blktrace.c:848:70: sparse:     got restricted blk_opf_t enum req_op
   kernel/trace/blktrace.c:909:31: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected int op @@     got restricted blk_opf_t enum req_op @@
   kernel/trace/blktrace.c:909:31: sparse:     expected int op
   kernel/trace/blktrace.c:909:31: sparse:     got restricted blk_opf_t enum req_op
   kernel/trace/blktrace.c:909:41: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int op_flags @@     got restricted blk_opf_t [usertype] bi_opf @@
   kernel/trace/blktrace.c:909:41: sparse:     expected int op_flags
   kernel/trace/blktrace.c:909:41: sparse:     got restricted blk_opf_t [usertype] bi_opf
   kernel/trace/blktrace.c:991:61: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected int op @@     got restricted blk_opf_t enum req_op @@
   kernel/trace/blktrace.c:991:61: sparse:     expected int op
   kernel/trace/blktrace.c:991:61: sparse:     got restricted blk_opf_t enum req_op
   kernel/trace/blktrace.c:991:71: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int op_flags @@     got restricted blk_opf_t [usertype] bi_opf @@
   kernel/trace/blktrace.c:991:71: sparse:     expected int op_flags
   kernel/trace/blktrace.c:991:71: sparse:     got restricted blk_opf_t [usertype] bi_opf
   kernel/trace/blktrace.c:1028:31: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected int op @@     got restricted blk_opf_t enum req_op @@
   kernel/trace/blktrace.c:1028:31: sparse:     expected int op
   kernel/trace/blktrace.c:1028:31: sparse:     got restricted blk_opf_t enum req_op
   kernel/trace/blktrace.c:1028:41: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int op_flags @@     got restricted blk_opf_t [usertype] bi_opf @@
   kernel/trace/blktrace.c:1028:41: sparse:     expected int op_flags
   kernel/trace/blktrace.c:1028:41: sparse:     got restricted blk_opf_t [usertype] bi_opf
   kernel/trace/blktrace.c:1902:18: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1905:22: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1906:14: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1909:14: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1912:14: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1916:14: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1919:14: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1926:18: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1928:18: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1930:18: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c:1932:18: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c: note: in included file (through include/linux/blktrace_api.h):
   include/linux/blk-mq.h:207:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op @@
   include/linux/blk-mq.h:207:44: sparse:     expected unsigned int op
   include/linux/blk-mq.h:207:44: sparse:     got restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:33: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blk-mq.h:202:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_opf_t enum req_op @@     got unsigned int @@
   include/linux/blk-mq.h:202:31: sparse:     expected restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:31: sparse:     got unsigned int
   kernel/trace/blktrace.c: note: in included file:
   include/linux/blkdev.h:225:12: sparse: sparse: invalid assignment: &=
   include/linux/blkdev.h:225:12: sparse:    left side has type unsigned int
   include/linux/blkdev.h:225:12: sparse:    right side has type restricted blk_opf_t
   include/linux/blkdev.h:226:22: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blkdev.h:226:45: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c: note: in included file (through include/linux/blktrace_api.h):
   include/linux/blk-mq.h:207:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op @@
   include/linux/blk-mq.h:207:44: sparse:     expected unsigned int op
   include/linux/blk-mq.h:207:44: sparse:     got restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:33: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blk-mq.h:202:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_opf_t enum req_op @@     got unsigned int @@
   include/linux/blk-mq.h:202:31: sparse:     expected restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:31: sparse:     got unsigned int
   kernel/trace/blktrace.c: note: in included file:
   include/linux/blkdev.h:225:12: sparse: sparse: invalid assignment: &=
   include/linux/blkdev.h:225:12: sparse:    left side has type unsigned int
   include/linux/blkdev.h:225:12: sparse:    right side has type restricted blk_opf_t
   include/linux/blkdev.h:226:22: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blkdev.h:226:45: sparse: sparse: restricted blk_opf_t degrades to integer
   kernel/trace/blktrace.c: note: in included file (through include/linux/blktrace_api.h):
   include/linux/blk-mq.h:202:33: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blk-mq.h:202:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_opf_t enum req_op @@     got unsigned int @@
   include/linux/blk-mq.h:202:31: sparse:     expected restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:31: sparse:     got unsigned int
   include/linux/blk-mq.h:202:33: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blk-mq.h:202:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_opf_t enum req_op @@     got unsigned int @@
   include/linux/blk-mq.h:202:31: sparse:     expected restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:31: sparse:     got unsigned int
   include/linux/blk-mq.h:207:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op @@
   include/linux/blk-mq.h:207:44: sparse:     expected unsigned int op
   include/linux/blk-mq.h:207:44: sparse:     got restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:33: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blk-mq.h:202:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted blk_opf_t enum req_op @@     got unsigned int @@
   include/linux/blk-mq.h:202:31: sparse:     expected restricted blk_opf_t enum req_op
   include/linux/blk-mq.h:202:31: sparse:     got unsigned int
   kernel/trace/blktrace.c: note: in included file:
   include/linux/blkdev.h:225:12: sparse: sparse: invalid assignment: &=
   include/linux/blkdev.h:225:12: sparse:    left side has type unsigned int
   include/linux/blkdev.h:225:12: sparse:    right side has type restricted blk_opf_t
   include/linux/blkdev.h:226:22: sparse: sparse: restricted blk_opf_t degrades to integer
   include/linux/blkdev.h:226:45: sparse: sparse: restricted blk_opf_t degrades to integer
--
   drivers/md/dm.c:1465:46: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int opf @@     got restricted blk_opf_t @@
   drivers/md/dm.c:1465:46: sparse:     expected unsigned int opf
   drivers/md/dm.c:1465:46: sparse:     got restricted blk_opf_t
>> drivers/md/dm.c:1511:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/dm.c:1511:33: sparse:     expected unsigned int op
   drivers/md/dm.c:1511:33: sparse:     got restricted blk_opf_t enum req_op
>> drivers/md/dm.c:1513:19: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/md/dm.c:1513:40: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/md/dm.c:1513:62: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/md/dm.c:1515:22: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/md/dm.c:1516:22: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/md/dm.c:1517:22: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/md/dm.c:1625:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] submit_as_polled:1 @@     got restricted blk_opf_t @@
   drivers/md/dm.c:1625:30: sparse:     expected bool [usertype] submit_as_polled:1
   drivers/md/dm.c:1625:30: sparse:     got restricted blk_opf_t
>> drivers/md/dm.c:1720:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int bio_opf @@     got restricted blk_opf_t [usertype] bi_opf @@
   drivers/md/dm.c:1720:31: sparse:     expected unsigned int bio_opf
   drivers/md/dm.c:1720:31: sparse:     got restricted blk_opf_t [usertype] bi_opf
   drivers/md/dm.c:720:23: sparse: sparse: restricted blk_opf_t degrades to integer
   drivers/md/dm.c:729:23: sparse: sparse: restricted blk_opf_t degrades to integer
--
   drivers/md/dm-log.c:310:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected int bi_op @@     got restricted blk_opf_t @@
   drivers/md/dm-log.c:310:26: sparse:     expected int bi_op
   drivers/md/dm-log.c:310:26: sparse:     got restricted blk_opf_t
   drivers/md/dm-log.c:311:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int bi_op_flags @@     got restricted blk_opf_t [usertype] @@
   drivers/md/dm-log.c:311:32: sparse:     expected int bi_op_flags
   drivers/md/dm-log.c:311:32: sparse:     got restricted blk_opf_t [usertype]
>> drivers/md/dm-log.c:320:28: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int op @@     got restricted blk_opf_t @@
   drivers/md/dm-log.c:320:28: sparse:     expected int op
   drivers/md/dm-log.c:320:28: sparse:     got restricted blk_opf_t
   drivers/md/dm-log.c:633:27: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int op @@     got restricted blk_opf_t @@
   drivers/md/dm-log.c:633:27: sparse:     expected int op
   drivers/md/dm-log.c:633:27: sparse:     got restricted blk_opf_t
   drivers/md/dm-log.c:701:27: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int op @@     got restricted blk_opf_t @@
   drivers/md/dm-log.c:701:27: sparse:     expected int op
   drivers/md/dm-log.c:701:27: sparse:     got restricted blk_opf_t
--
   drivers/md/raid1.c:646:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:646:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:646:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:777:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:777:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:777:24: sparse:    struct md_rdev *
>> drivers/md/raid1.c:1223:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/raid1.c:1223:30: sparse:     expected int const op
   drivers/md/raid1.c:1223:30: sparse:     got restricted blk_opf_t enum req_op
   drivers/md/raid1.c:1224:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
   drivers/md/raid1.c:1224:52: sparse:     expected unsigned long const do_sync
   drivers/md/raid1.c:1224:52: sparse:     got restricted blk_opf_t
   drivers/md/raid1.c:1241:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1241:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1241:24: sparse:    struct md_rdev *
   drivers/md/raid1.c:1404:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1404:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1404:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1635:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1635:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1635:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1707:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1707:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1707:40: sparse:    struct md_rdev *
   drivers/md/raid1.c:1824:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1824:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1824:25: sparse:    struct md_rdev *
   drivers/md/raid1.c:1835:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:1835:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:1835:25: sparse:    struct md_rdev *
   drivers/md/raid1.c:2060:50: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int op @@     got restricted blk_opf_t @@
   drivers/md/raid1.c:2165:59: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int opf @@     got restricted blk_opf_t @@
   drivers/md/raid1.c:2298:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2298:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2298:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2334:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2334:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2334:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2351:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2351:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2351:32: sparse:    struct md_rdev *
   drivers/md/raid1.c:2767:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid1.c:2767:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid1.c:2767:24: sparse:    struct md_rdev *
--
   drivers/md/raid10.c:1946:37: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1946:37: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1946:37: sparse:    struct md_rdev *
   drivers/md/raid10.c:4872:63: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int opf @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:4872:63: sparse:     expected unsigned int opf
   drivers/md/raid10.c:4872:63: sparse:     got restricted blk_opf_t
   drivers/md/raid10.c:4919:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4919:33: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4919:33: sparse:    struct md_rdev *
   drivers/md/raid10.c:4922:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4922:33: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4922:33: sparse:    struct md_rdev *
   drivers/md/raid10.c:5011:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5011:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5011:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:5014:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5014:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5014:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:759:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:759:24: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:759:24: sparse:    struct md_rdev *
   drivers/md/raid10.c:762:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:762:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:762:32: sparse:    struct md_rdev *
>> drivers/md/raid10.c:1139:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/raid10.c:1139:30: sparse:     expected int const op
   drivers/md/raid10.c:1139:30: sparse:     got restricted blk_opf_t enum req_op
   drivers/md/raid10.c:1140:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:1140:52: sparse:     expected unsigned long const do_sync
   drivers/md/raid10.c:1140:52: sparse:     got restricted blk_opf_t
   drivers/md/raid10.c:1165:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1165:28: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1165:28: sparse:    struct md_rdev *
   drivers/md/raid10.c:1233:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected int const op @@     got restricted blk_opf_t enum req_op @@
   drivers/md/raid10.c:1234:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_sync @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:1235:51: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long const do_fua @@     got restricted blk_opf_t @@
>> drivers/md/raid10.c:1263:32: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted blk_opf_t enum req_op op @@     got int const op @@
   drivers/md/raid10.c:1263:44: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted blk_opf_t [usertype] op_flags @@     got unsigned long @@
   drivers/md/raid10.c:1303:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1303:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1303:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:1304:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1304:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1304:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:1434:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1434:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1434:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:1435:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1435:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1435:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:1744:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1744:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1744:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:1745:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1745:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1745:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:1913:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:1913:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:1913:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:2142:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2142:25: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2142:25: sparse:    struct md_rdev *
   drivers/md/raid10.c:2156:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2156:17: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2156:17: sparse:    struct md_rdev *
   drivers/md/raid10.c:2424:62: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int opf @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:2515:35: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int op @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:2523:43: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int op @@     got restricted blk_opf_t @@
   drivers/md/raid10.c:2716:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2716:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2716:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:2769:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2769:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2769:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:2803:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:2803:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:2803:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:3313:49: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3313:49: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3313:49: sparse:    struct md_rdev *
   drivers/md/raid10.c:3388:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3388:33: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3388:33: sparse:    struct md_rdev *
   drivers/md/raid10.c:3389:36: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3389:36: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3389:36: sparse:    struct md_rdev *
   drivers/md/raid10.c:3459:56: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3459:56: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3459:56: sparse:    struct md_rdev *
   drivers/md/raid10.c:3476:41: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3476:41: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3476:41: sparse:    struct md_rdev *
   drivers/md/raid10.c:3679:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3679:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3679:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:3709:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:3709:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:3709:32: sparse:    struct md_rdev *
   drivers/md/raid10.c:4452:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4452:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4452:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:4468:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:4468:40: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:4468:40: sparse:    struct md_rdev *
   drivers/md/raid10.c:5096:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5096:48: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5096:48: sparse:    struct md_rdev *
   drivers/md/raid10.c:5192:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5192:48: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5192:48: sparse:    struct md_rdev *
   drivers/md/raid10.c:5195:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/md/raid10.c:5195:32: sparse:    struct md_rdev [noderef] __rcu *
   drivers/md/raid10.c:5195:32: sparse:    struct md_rdev *
--
   drivers/block/zram/zram_drv.c:619:47: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int opf @@     got restricted blk_opf_t @@
   drivers/block/zram/zram_drv.c:619:47: sparse:     expected unsigned int opf
   drivers/block/zram/zram_drv.c:619:47: sparse:     got restricted blk_opf_t
   drivers/block/zram/zram_drv.c:749:39: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int opf @@     got restricted blk_opf_t @@
   drivers/block/zram/zram_drv.c:749:39: sparse:     expected unsigned int opf
   drivers/block/zram/zram_drv.c:749:39: sparse:     got restricted blk_opf_t
>> drivers/block/zram/zram_drv.c:1530:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted blk_opf_t [usertype] op @@     got unsigned int op @@
   drivers/block/zram/zram_drv.c:1530:26: sparse:     expected restricted blk_opf_t [usertype] op
   drivers/block/zram/zram_drv.c:1530:26: sparse:     got unsigned int op
   drivers/block/zram/zram_drv.c:1544:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted blk_opf_t [usertype] op @@     got unsigned int op @@
   drivers/block/zram/zram_drv.c:1544:34: sparse:     expected restricted blk_opf_t [usertype] op
   drivers/block/zram/zram_drv.c:1544:34: sparse:     got unsigned int op
>> drivers/block/zram/zram_drv.c:1584:48: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op @@
   drivers/block/zram/zram_drv.c:1584:48: sparse:     expected unsigned int op
   drivers/block/zram/zram_drv.c:1584:48: sparse:     got restricted blk_opf_t enum req_op
>> drivers/block/zram/zram_drv.c:1661:54: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op op @@
   drivers/block/zram/zram_drv.c:1661:54: sparse:     expected unsigned int op
   drivers/block/zram/zram_drv.c:1661:54: sparse:     got restricted blk_opf_t enum req_op op
   drivers/block/zram/zram_drv.c:62:12: sparse: sparse: context imbalance in 'zram_slot_trylock' - wrong count at exit
   drivers/block/zram/zram_drv.c:67:13: sparse: sparse: context imbalance in 'zram_slot_lock' - wrong count at exit
   drivers/block/zram/zram_drv.c: note: in included file (through include/linux/list_bl.h, include/linux/rculist_bl.h, include/linux/dcache.h, ...):
   include/linux/bit_spinlock.h:63:25: sparse: sparse: context imbalance in 'zram_slot_unlock' - unexpected unlock
--
>> drivers/nvdimm/btt.c:1429:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted blk_opf_t [usertype] op @@     got unsigned int op @@
   drivers/nvdimm/btt.c:1429:26: sparse:     expected restricted blk_opf_t [usertype] op
   drivers/nvdimm/btt.c:1429:26: sparse:     got unsigned int op
>> drivers/nvdimm/btt.c:1468:41: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op @@
   drivers/nvdimm/btt.c:1468:41: sparse:     expected unsigned int op
   drivers/nvdimm/btt.c:1468:41: sparse:     got restricted blk_opf_t enum req_op
>> drivers/nvdimm/btt.c:1491:62: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected unsigned int op @@     got restricted blk_opf_t enum req_op op @@
   drivers/nvdimm/btt.c:1491:62: sparse:     expected unsigned int op
   drivers/nvdimm/btt.c:1491:62: sparse:     got restricted blk_opf_t enum req_op op

vim +539 drivers/scsi/device_handler/scsi_dh_rdac.c

fbd7ab3eb53a3b8 Chandra Seetharaman 2008-05-01  526  
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  527  static void send_mode_select(struct work_struct *work)
fbd7ab3eb53a3b8 Chandra Seetharaman 2008-05-01  528  {
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  529  	struct rdac_controller *ctlr =
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  530  		container_of(work, struct rdac_controller, ms_work);
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  531  	struct scsi_device *sdev = ctlr->ms_sdev;
ee14c674e8fc572 Christoph Hellwig   2015-08-27  532  	struct rdac_dh_data *h = sdev->handler_data;
3278255741326b6 Hannes Reinecke     2016-11-03  533  	int err = SCSI_DH_OK, retry_cnt = RDAC_RETRY_COUNT;
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  534  	struct rdac_queue_data *tmp, *qdata;
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  535  	LIST_HEAD(list);
92eb506262a2a3d Stephen Kitt        2018-03-09  536  	unsigned char cdb[MAX_COMMAND_SIZE];
3278255741326b6 Hannes Reinecke     2016-11-03  537  	struct scsi_sense_hdr sshdr;
3278255741326b6 Hannes Reinecke     2016-11-03  538  	unsigned int data_size;
3278255741326b6 Hannes Reinecke     2016-11-03 @539  	u64 req_flags = REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT |
3278255741326b6 Hannes Reinecke     2016-11-03  540  		REQ_FAILFAST_DRIVER;
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  541  
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  542  	spin_lock(&ctlr->ms_lock);
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  543  	list_splice_init(&ctlr->ms_head, &list);
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  544  	ctlr->ms_queued = 0;
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  545  	ctlr->ms_sdev = NULL;
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  546  	spin_unlock(&ctlr->ms_lock);
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  547  
c85f8cb9254e60c Chandra Seetharaman 2008-11-05  548   retry:
57adf5d4cfd3198 Martin Wilck        2019-09-04  549  	memset(cdb, 0, sizeof(cdb));
57adf5d4cfd3198 Martin Wilck        2019-09-04  550  
3278255741326b6 Hannes Reinecke     2016-11-03  551  	data_size = rdac_failover_get(ctlr, &list, cdb);
fbd7ab3eb53a3b8 Chandra Seetharaman 2008-05-01  552  
dd784edcfc080fb Moger, Babu         2009-09-03  553  	RDAC_LOG(RDAC_LOG_FAILOVER, sdev, "array %s, ctlr %d, "
dd784edcfc080fb Moger, Babu         2009-09-03  554  		"%s MODE_SELECT command",
dd784edcfc080fb Moger, Babu         2009-09-03  555  		(char *) h->ctlr->array_name, h->ctlr->index,
c85f8cb9254e60c Chandra Seetharaman 2008-11-05  556  		(retry_cnt == RDAC_RETRY_COUNT) ? "queueing" : "retrying");
fbd7ab3eb53a3b8 Chandra Seetharaman 2008-05-01  557  
fcbfffe2c5cbec0 Christoph Hellwig   2017-02-23  558  	if (scsi_execute(sdev, cdb, DMA_TO_DEVICE, &h->ctlr->mode_select,
fcbfffe2c5cbec0 Christoph Hellwig   2017-02-23  559  			data_size, NULL, &sshdr, RDAC_TIMEOUT * HZ,
fcbfffe2c5cbec0 Christoph Hellwig   2017-02-23  560  			RDAC_RETRIES, req_flags, 0, NULL)) {
3278255741326b6 Hannes Reinecke     2016-11-03  561  		err = mode_select_handle_sense(sdev, &sshdr);
c85f8cb9254e60c Chandra Seetharaman 2008-11-05  562  		if (err == SCSI_DH_RETRY && retry_cnt--)
c85f8cb9254e60c Chandra Seetharaman 2008-11-05  563  			goto retry;
d2d06d4fe0f2cc2 Hannes Reinecke     2016-01-22  564  		if (err == SCSI_DH_IMM_RETRY)
d2d06d4fe0f2cc2 Hannes Reinecke     2016-01-22  565  			goto retry;
c85f8cb9254e60c Chandra Seetharaman 2008-11-05  566  	}
dd784edcfc080fb Moger, Babu         2009-09-03  567  	if (err == SCSI_DH_OK) {
fbd7ab3eb53a3b8 Chandra Seetharaman 2008-05-01  568  		h->state = RDAC_STATE_ACTIVE;
dd784edcfc080fb Moger, Babu         2009-09-03  569  		RDAC_LOG(RDAC_LOG_FAILOVER, sdev, "array %s, ctlr %d, "
dd784edcfc080fb Moger, Babu         2009-09-03  570  				"MODE_SELECT completed",
dd784edcfc080fb Moger, Babu         2009-09-03  571  				(char *) h->ctlr->array_name, h->ctlr->index);
dd784edcfc080fb Moger, Babu         2009-09-03  572  	}
ca9f0089867c9e4 Hannes Reinecke     2008-07-17  573  
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  574  	list_for_each_entry_safe(qdata, tmp, &list, entry) {
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  575  		list_del(&qdata->entry);
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  576  		if (err == SCSI_DH_OK)
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  577  			qdata->h->state = RDAC_STATE_ACTIVE;
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  578  		if (qdata->callback_fn)
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  579  			qdata->callback_fn(qdata->callback_data, err);
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  580  		kfree(qdata);
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  581  	}
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  582  	return;
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  583  }
970f3f47e7c97c0 Chandra Seetharaman 2009-10-21  584  

:::::: The code at line 539 was first introduced by commit
:::::: 3278255741326b6d66d8ca7d1cb2c57633ee43d9 scsi_dh_rdac: switch to scsi_execute_req_flags()

:::::: TO: Hannes Reinecke <hare@suse.de>
:::::: CC: Jens Axboe <axboe@fb.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
