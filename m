Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B772447C934
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbhLUW1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:27:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:30135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhLUW1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640125642; x=1671661642;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OCoz9JuOsNdr+vSGj+llFZf1/IPEarrp1WZdEUevh+A=;
  b=deCvRMIKV9S23n+lBCaFXMMoSVO19SAihESEM3Gs+W58u7FVgoRMkeze
   wG/n9cFUCxItjaPyRAWoS85BmIqcY7tqfDz5EP5K+TAm71RZBVpo4y4YG
   664c8V4BIJ8/MXmSgXTZlqob8iYq2xWJx0z+GE7fpkh5eIgieuXgUwLqk
   A1YAeC0kyZPx3ZYdDHoXYoyqABBzjqnL/msvDDTB68lOTJFf1VXuOY9qE
   +6s4syasArt3aYFZlrPlAcf5ci8J40x065dpYdZlWIpz6f/8uUvjnZsVd
   +pAKyHJWFwGnY0qIo76HtdoF2aamhgjpHFQRTC3Ditb0Z6UC7WHVsLrTX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240309469"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="240309469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 14:27:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="508250684"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2021 14:27:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mznbK-0009bp-Sl; Tue, 21 Dec 2021 22:27:18 +0000
Date:   Wed, 22 Dec 2021 06:26:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [axboe-block:nvme-passthru-wip.2 15/23] include/linux/io_uring.h:60:
 multiple definition of `io_uring_cmd_import_fixed';
 kernel/fork.o:include/linux/io_uring.h:60: first defined here
Message-ID: <202112220658.XCmoVSe5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git nvme-passthru-wip.2
head:   7567defdb3c6a81e4114a03ddf3d6c158df81a76
commit: bc18161c9b80cf2d647710257f9716ee6c66fee4 [15/23] io_uring: add flag and helper for fixed-buffer uring-cmd
config: x86_64-randconfig-a002-20211220 (https://download.01.org/0day-ci/archive/20211222/202112220658.XCmoVSe5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=bc18161c9b80cf2d647710257f9716ee6c66fee4
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block nvme-passthru-wip.2
        git checkout bc18161c9b80cf2d647710257f9716ee6c66fee4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from fs/exec.c:66:
>> include/linux/io_uring.h:58:5: warning: no previous prototype for 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
      58 | int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   ld: kernel/exit.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: fs/exec.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: block/fops.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/host/core.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/host/ioctl.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/host/trace.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/host/zns.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/host/fault_inject.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/host/fabrics.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/host/fc.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: drivers/nvme/target/fcloop.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: net/socket.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: net/ipv4/tcp.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: net/ipv4/raw.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: net/ipv4/udp.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
   ld: net/unix/scm.o: in function `io_uring_cmd_import_fixed':
>> include/linux/io_uring.h:60: multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:include/linux/io_uring.h:60: first defined here
--
   In file included from kernel/exit.c:65:
>> include/linux/io_uring.h:58:5: warning: no previous prototype for 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
      58 | int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/exit.c:1817:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
    1817 | __weak void abort(void)
         |             ^~~~~


vim +60 include/linux/io_uring.h

    34	
    35	static inline void io_uring_files_cancel(void)
    36	{
    37		if (current->io_uring)
    38			__io_uring_cancel(false);
    39	}
    40	static inline void io_uring_task_cancel(void)
    41	{
    42		if (current->io_uring)
    43			__io_uring_cancel(true);
    44	}
    45	static inline void io_uring_free(struct task_struct *tsk)
    46	{
    47		if (tsk->io_uring)
    48			__io_uring_free(tsk);
    49	}
    50	#else
    51	static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret)
    52	{
    53	}
    54	static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
    55				void (*driver_cb)(struct io_uring_cmd *))
    56	{
    57	}
  > 58	int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
    59			int rw, struct iov_iter *iter, void *ioucmd)
  > 60	{
    61		return -1;
    62	}
    63	static inline struct sock *io_uring_get_socket(struct file *file)
    64	{
    65		return NULL;
    66	}
    67	static inline void io_uring_task_cancel(void)
    68	{
    69	}
    70	static inline void io_uring_files_cancel(void)
    71	{
    72	}
    73	static inline void io_uring_free(struct task_struct *tsk)
    74	{
    75	}
    76	#endif
    77	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
