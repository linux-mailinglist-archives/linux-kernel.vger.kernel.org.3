Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD147C90E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhLUWGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:06:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:19672 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhLUWGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640124381; x=1671660381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9/xCQDK04Dy0eWk9dGR3EHbGClijoe2BwdDRmdLI/h4=;
  b=hkrLjohv92T7b7x3Z7y7XD9T6aVOs0SchbZ/AyZonEd75Rz+wTwjQjwk
   bTJckex4jG6y9pJk/643SJgj/6Lg5qNQsGecARS7hxkil3vmDbd5512q4
   7SZzho10BE+xh7bd7veEB8mhtCMMxvwvQ1qs8sFqjpf3Jb2jTSnKPnMuz
   nGDZyJVC7Mx6lXDn2UtC4FYiH7gQ+wg2C3E3yjkkZFpAgYC5T5iYSp1tc
   6mhH1uvxM/BJuf6XCJfnRHjjUflp6oIDRpvpfCy/CT1Ekq2FgKT6y7NzA
   ZbPXl0zMd3PwH8jQAYWrlm/KcHUK9kS9ubq376YT3QsBuDesFZ0mEDTc/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="227350996"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="227350996"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 14:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="684808313"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 14:06:18 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mznH0-0009aX-83; Tue, 21 Dec 2021 22:06:18 +0000
Date:   Wed, 22 Dec 2021 06:05:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: [axboe-block:nvme-passthru-wip.2 15/23] ld.lld: error: duplicate
 symbol: io_uring_cmd_import_fixed
Message-ID: <202112220501.udx7B2Uz-lkp@intel.com>
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
config: hexagon-randconfig-r045-20211220 (https://download.01.org/0day-ci/archive/20211222/202112220501.udx7B2Uz-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6c2bf01270a8a52b7986d5c49eaa7ad1c7083ec5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=bc18161c9b80cf2d647710257f9716ee6c66fee4
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block nvme-passthru-wip.2
        git checkout bc18161c9b80cf2d647710257f9716ee6c66fee4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: io_uring_cmd_import_fixed
   >>> defined at fork.c
   >>> fork.o:(io_uring_cmd_import_fixed) in archive kernel/built-in.a
   >>> defined at exit.c
   >>> exit.o:(.text+0x0) in archive kernel/built-in.a
--
>> ld.lld: error: duplicate symbol: io_uring_cmd_import_fixed
   >>> defined at fork.c
   >>> fork.o:(io_uring_cmd_import_fixed) in archive kernel/built-in.a
   >>> defined at exec.c
   >>> exec.o:(.text+0x0) in archive fs/built-in.a
--
>> ld.lld: error: duplicate symbol: io_uring_cmd_import_fixed
   >>> defined at fork.c
   >>> fork.o:(io_uring_cmd_import_fixed) in archive kernel/built-in.a
   >>> defined at fops.c
   >>> fops.o:(.text+0x0) in archive block/built-in.a
--
   In file included from kernel/fork.c:97:
>> include/linux/io_uring.h:58:5: warning: no previous prototype for function 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
   int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
       ^
   include/linux/io_uring.h:58:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
   ^
   static 
   kernel/fork.c:161:13: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void __weak arch_release_task_struct(struct task_struct *tsk)
               ^
   kernel/fork.c:161:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
   kernel/fork.c:763:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:763:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
   kernel/fork.c:858:12: warning: no previous prototype for function 'arch_dup_task_struct' [-Wmissing-prototypes]
   int __weak arch_dup_task_struct(struct task_struct *dst,
              ^
   kernel/fork.c:858:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_dup_task_struct(struct task_struct *dst,
   ^
   static 
   4 warnings generated.
--
   In file included from kernel/exit.c:65:
>> include/linux/io_uring.h:58:5: warning: no previous prototype for function 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
   int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
       ^
   include/linux/io_uring.h:58:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
   ^
   static 
   1 warning generated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
