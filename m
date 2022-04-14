Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A885019A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiDNRKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344180AbiDNRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:08:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096121BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649955368; x=1681491368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BewBPeek1Gi+1NgMiUqk9ZJ0zScM1pv+m92TWIcZW58=;
  b=RLpgLq0hmAeR/+Bm4TswE5C/JJqeyg/UfxN42TMBXk7GJ4opBpUBd3ao
   FdmQVTA5lWWLN2wfImEyH7J2jW2cbGMhGSMmj8MuHwtpivjZNNprqy0kp
   +H9FolPK2bqSxri/LhG7x7BOv8WjrfPq8P77iaWMX9ym6dkcXrze2y9gk
   AwN3PXXG801mMBWtDtvBpMIVGhNx/i45YBcUJn4Acp66j/eESI8MJh+5A
   m9GU+hkTQvZEcVLt6Vdqs6E7/Qx66WtiURjkbzDbU12RZCUBpzDTdOeri
   PFCGVvkUZLjvDqLzqs1/VVYsmvmWWH81YVbK66zLZGp8pFJqX9jHNJ2O5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262730828"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262730828"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:56:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="526985402"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2022 09:56:06 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nf2lK-00019M-7T;
        Thu, 14 Apr 2022 16:56:06 +0000
Date:   Fri, 15 Apr 2022 00:55:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: fs/io_uring.c:7501:39: sparse: sparse: marked inline, but without a
 definition
Message-ID: <202204150040.wXruLrfu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a19944809fe9942e6a96292490717904d0690c21
commit: 5106dd6e74ab6c94daac1c357094f11e6934b36f io_uring: propagate issue_flags state down to file assignment
date:   7 days ago
config: arm-randconfig-s031-20220414 (https://download.01.org/0day-ci/archive/20220415/202204150040.wXruLrfu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5106dd6e74ab6c94daac1c357094f11e6934b36f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5106dd6e74ab6c94daac1c357094f11e6934b36f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/io_uring.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/io_uring.h):
   include/trace/events/io_uring.h:488:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] op_flags @@     got restricted __kernel_rwf_t const [usertype] rw_flags @@
   include/trace/events/io_uring.h:488:1: sparse:     expected unsigned int [usertype] op_flags
   include/trace/events/io_uring.h:488:1: sparse:     got restricted __kernel_rwf_t const [usertype] rw_flags
   fs/io_uring.c: note: in included file (through include/trace/perf.h, include/trace/define_trace.h, include/trace/events/io_uring.h):
   include/trace/events/io_uring.h:488:1: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] op_flags @@     got restricted __kernel_rwf_t const [usertype] rw_flags @@
   include/trace/events/io_uring.h:488:1: sparse:     expected unsigned int [usertype] op_flags
   include/trace/events/io_uring.h:488:1: sparse:     got restricted __kernel_rwf_t const [usertype] rw_flags
   fs/io_uring.c:3210:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __kernel_rwf_t @@
   fs/io_uring.c:3210:23: sparse:     expected unsigned int [usertype] flags
   fs/io_uring.c:3210:23: sparse:     got restricted __kernel_rwf_t
   fs/io_uring.c:3429:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __user * @@     got struct io_buffer *[assigned] kbuf @@
   fs/io_uring.c:3429:24: sparse:     expected void [noderef] __user *
   fs/io_uring.c:3429:24: sparse:     got struct io_buffer *[assigned] kbuf
   fs/io_uring.c:3816:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __kernel_rwf_t [usertype] flags @@     got unsigned int [usertype] flags @@
   fs/io_uring.c:3816:48: sparse:     expected restricted __kernel_rwf_t [usertype] flags
   fs/io_uring.c:3816:48: sparse:     got unsigned int [usertype] flags
   fs/io_uring.c:5141:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/io_uring.c:5141:14: sparse:     expected struct file *file
   fs/io_uring.c:5141:14: sparse:     got struct file [noderef] __rcu *
   fs/io_uring.c:6009:68: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] _key @@     got unsigned int [usertype] cflags @@
   fs/io_uring.c:6009:68: sparse:     expected restricted __poll_t [usertype] _key
   fs/io_uring.c:6009:68: sparse:     got unsigned int [usertype] cflags
   fs/io_uring.c:6011:47: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6015:52: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6016:71: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6016:65: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:6016:65: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6016:65: sparse:     got unsigned int
   fs/io_uring.c:6016:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
   fs/io_uring.c:6016:52: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6016:52: sparse:     got unsigned short
   fs/io_uring.c:6020:71: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6020:71: sparse:     expected signed int [usertype] res
   fs/io_uring.c:6020:71: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6051:66: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6051:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
   fs/io_uring.c:6051:55: sparse:     expected restricted __poll_t [usertype] val
   fs/io_uring.c:6051:55: sparse:     got unsigned int
   fs/io_uring.c:6132:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6132:45: sparse:     expected int events
   fs/io_uring.c:6132:45: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6167:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
   fs/io_uring.c:6167:40: sparse:     expected int mask
   fs/io_uring.c:6167:40: sparse:     got restricted __poll_t [usertype] mask
   fs/io_uring.c:6167:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6167:50: sparse:     expected int events
   fs/io_uring.c:6167:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6258:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6258:24: sparse:     expected int
   fs/io_uring.c:6258:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6275:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6275:40: sparse:     expected int mask
   fs/io_uring.c:6275:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6275:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6275:50: sparse:     expected int events
   fs/io_uring.c:6275:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6286:47: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6286:47: sparse:     expected int events
   fs/io_uring.c:6286:47: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6311:25: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6311:48: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned int @@
   fs/io_uring.c:6311:48: sparse:     expected restricted __poll_t [usertype] mask
   fs/io_uring.c:6311:48: sparse:     got unsigned int
   fs/io_uring.c:6320:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6320:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6320:22: sparse:    right side has type int
   fs/io_uring.c:6325:30: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6325:30: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6325:30: sparse:    right side has type int
   fs/io_uring.c:6327:22: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6327:22: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6327:22: sparse:    right side has type int
   fs/io_uring.c:6353:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
   fs/io_uring.c:6353:33: sparse:     expected int mask
   fs/io_uring.c:6353:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
   fs/io_uring.c:6353:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6353:50: sparse:     expected int events
   fs/io_uring.c:6353:50: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6435:24: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6435:24: sparse:    left side has type unsigned int
   fs/io_uring.c:6435:24: sparse:    right side has type restricted __poll_t
   fs/io_uring.c:6436:65: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6436:29: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6436:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
   fs/io_uring.c:6436:38: sparse:     expected restricted __poll_t
   fs/io_uring.c:6436:38: sparse:     got unsigned int
   fs/io_uring.c:6488:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cflags @@     got restricted __poll_t [usertype] events @@
   fs/io_uring.c:6488:21: sparse:     expected unsigned int [usertype] cflags
   fs/io_uring.c:6488:21: sparse:     got restricted __poll_t [usertype] events
   fs/io_uring.c:6526:43: sparse: sparse: invalid assignment: &=
   fs/io_uring.c:6526:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6526:43: sparse:    right side has type int
   fs/io_uring.c:6527:62: sparse: sparse: restricted __poll_t degrades to integer
   fs/io_uring.c:6527:43: sparse: sparse: invalid assignment: |=
   fs/io_uring.c:6527:43: sparse:    left side has type restricted __poll_t
   fs/io_uring.c:6527:43: sparse:    right side has type unsigned int
   fs/io_uring.c:2463:17: sparse: sparse: context imbalance in 'handle_prev_tw_list' - different lock contexts for basic block
>> fs/io_uring.c:7501:39: sparse: sparse: marked inline, but without a definition
>> fs/io_uring.c:7501:39: sparse: sparse: marked inline, but without a definition

vim +7501 fs/io_uring.c

  7500	
> 7501	static struct file *io_file_get_normal(struct io_kiocb *req, int fd)
  7502	{
  7503		struct file *file = fget(fd);
  7504	
  7505		trace_io_uring_file_get(req->ctx, req, req->user_data, fd);
  7506	
  7507		/* we don't allow fixed io_uring files */
  7508		if (file && unlikely(file->f_op == &io_uring_fops))
  7509			io_req_track_inflight(req);
  7510		return file;
  7511	}
  7512	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
