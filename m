Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DBA47B496
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhLTU53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 15:57:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:61360 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhLTU5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 15:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640033845; x=1671569845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GXiEAIkvpM54nRM5gXc5wo8WacmND3thLJnZc0dy4XY=;
  b=hdUzyv+GdVz9/WNT600OfIoC9tHrPdoYjhG/Kco61WJ35KZIdpLpyXi2
   OKuM2KtzBYFG96LYHaK3iNNHlsuzgV2EC1elK2PWuMIml0sXhlIRl9ZK7
   TIebYkCa5nVB2Z4+l1uZfjz/kkrEC2H8BsigxzHHpv50DLlAXU9mQi9rZ
   VtDr/L9kpLgJBm7T8RTnMjCyCKCSC4Ffc6fryTEsm2YA7zyP2xU3p83WV
   pN5UuLuYPWrOlZ/l26+d1SF2jixgwOZccICmgyRtPvNTomn22+Pc4vBbC
   E1LY99omaZK4ub+Cn1SeItXJBK7vEyAyeOsq3Iu6lvMP3VokrhTR/Y40O
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227122100"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="227122100"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 12:57:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="467540826"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2021 12:57:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzPik-0008El-5d; Mon, 20 Dec 2021 20:57:22 +0000
Date:   Tue, 21 Dec 2021 04:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [axboe-block:nvme-passthru-wip.2 4/10] fs/io_uring.c:11271:2: error:
 call to __compiletime_assert_764 declared with 'error' attribute:
 BUILD_BUG_ON failed: offsetof(struct io_uring_cmd_sqe, user_data) !=
 sqe_offsets[1].user_data
Message-ID: <202112210447.xuPrVLM2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git nvme-passthru-wip.2
head:   edab2611e228dc05e995d3e2e4d25cb9e0989c75
commit: 278755c32b7fd62a8e82a1229c819ed2fcd85730 [4/10] io_uring: add infrastructure around io_uring_cmd_sqe
config: mips-buildonly-randconfig-r001-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210447.xuPrVLM2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 555eacf75f21cd1dfc6363d73ad187b730349543)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=278755c32b7fd62a8e82a1229c819ed2fcd85730
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block nvme-passthru-wip.2
        git checkout 278755c32b7fd62a8e82a1229c819ed2fcd85730
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/io_uring.c:11271:2: error: call to __compiletime_assert_764 declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct io_uring_cmd_sqe, user_data) != sqe_offsets[1].user_data
           BUILD_BUG_SQEC_ELEM(sqe_offsets[1].user_data,   __u64,  user_data);
           ^
   fs/io_uring.c:11268:2: note: expanded from macro 'BUILD_BUG_SQEC_ELEM'
           __BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
           ^
   fs/io_uring.c:11228:2: note: expanded from macro '__BUILD_BUG_VERIFY_ELEMENT'
           BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:323:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:316:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:13:1: note: expanded from here
   __compiletime_assert_764
   ^
>> fs/io_uring.c:11272:2: error: call to __compiletime_assert_766 declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct io_uring_cmd_sqe, personality) != sqe_offsets[1].personality
           BUILD_BUG_SQEC_ELEM(sqe_offsets[1].personality, __u16,  personality);
           ^
   fs/io_uring.c:11268:2: note: expanded from macro 'BUILD_BUG_SQEC_ELEM'
           __BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
           ^
   fs/io_uring.c:11228:2: note: expanded from macro '__BUILD_BUG_VERIFY_ELEMENT'
           BUILD_BUG_ON(offsetof(stype, ename) != eoffset); \
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:323:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:316:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:21:1: note: expanded from here
   __compiletime_assert_766
   ^
   2 errors generated.


vim +/error +11271 fs/io_uring.c

 11231	
 11232	#define BUILD_BUG_SQE_ELEM(eoffset, etype, ename) \
 11233		__BUILD_BUG_VERIFY_ELEMENT(struct io_uring_sqe, eoffset, etype, ename)
 11234		BUILD_BUG_ON(sizeof(struct io_uring_sqe) != 64);
 11235		BUILD_BUG_ON(sizeof(struct io_uring_cmd_sqe) != 64);
 11236		BUILD_BUG_SQE_ELEM(0,  __u8,   hdr.opcode);
 11237		BUILD_BUG_SQE_ELEM(1,  __u8,   hdr.flags);
 11238		BUILD_BUG_SQE_ELEM(2,  __u16,  hdr.ioprio);
 11239		BUILD_BUG_SQE_ELEM(4,  __s32,  hdr.fd);
 11240		BUILD_BUG_SQE_ELEM(8,  __u64,  off);
 11241		BUILD_BUG_SQE_ELEM(8,  __u64,  addr2);
 11242		BUILD_BUG_SQE_ELEM(16, __u64,  addr);
 11243		BUILD_BUG_SQE_ELEM(16, __u64,  splice_off_in);
 11244		BUILD_BUG_SQE_ELEM(24, __u32,  len);
 11245		BUILD_BUG_SQE_ELEM(28,     __kernel_rwf_t, rw_flags);
 11246		BUILD_BUG_SQE_ELEM(28, /* compat */   int, rw_flags);
 11247		BUILD_BUG_SQE_ELEM(28, /* compat */ __u32, rw_flags);
 11248		BUILD_BUG_SQE_ELEM(28, __u32,  fsync_flags);
 11249		BUILD_BUG_SQE_ELEM(28, /* compat */ __u16,  poll_events);
 11250		BUILD_BUG_SQE_ELEM(28, __u32,  poll32_events);
 11251		BUILD_BUG_SQE_ELEM(28, __u32,  sync_range_flags);
 11252		BUILD_BUG_SQE_ELEM(28, __u32,  msg_flags);
 11253		BUILD_BUG_SQE_ELEM(28, __u32,  timeout_flags);
 11254		BUILD_BUG_SQE_ELEM(28, __u32,  accept_flags);
 11255		BUILD_BUG_SQE_ELEM(28, __u32,  cancel_flags);
 11256		BUILD_BUG_SQE_ELEM(28, __u32,  open_flags);
 11257		BUILD_BUG_SQE_ELEM(28, __u32,  statx_flags);
 11258		BUILD_BUG_SQE_ELEM(28, __u32,  fadvise_advice);
 11259		BUILD_BUG_SQE_ELEM(28, __u32,  splice_flags);
 11260		BUILD_BUG_SQE_ELEM(32, __u64,  user_data);
 11261		BUILD_BUG_SQE_ELEM(40, __u16,  buf_index);
 11262		BUILD_BUG_SQE_ELEM(40, __u16,  buf_group);
 11263		BUILD_BUG_SQE_ELEM(42, __u16,  personality);
 11264		BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 11265		BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
 11266	
 11267		#define BUILD_BUG_SQEC_ELEM(eoffset, etype, ename) \
 11268		__BUILD_BUG_VERIFY_ELEMENT(struct io_uring_cmd_sqe, eoffset, etype, ename)
 11269		BUILD_BUG_SQEC_ELEM(8,				__u64,	user_data);
 11270		BUILD_BUG_SQEC_ELEM(18,				__u16,	personality);
 11271		BUILD_BUG_SQEC_ELEM(sqe_offsets[1].user_data,	__u64,	user_data);
 11272		BUILD_BUG_SQEC_ELEM(sqe_offsets[1].personality,	__u16,	personality);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
