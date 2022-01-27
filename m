Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6F49EC7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbiA0UaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:30:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:32839 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbiA0UaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643315418; x=1674851418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2VPTiOkEchTu2v390pzQVhsxxfW11PH55/4gHOPpmN4=;
  b=apBwMnJ8a3DieqCSTFZpTRpqr4lV1SzqzTdG+jUGXDTj/DrMVjzgxEnd
   fDKIDUi4ka37IAzXaIYcLMf6zOQHmdwGMWajOnimLSedaGIMFpPLsSO+L
   Y8MTw816qLwU4pQzfz4O/NRAKdBRmRdxzFHb37qdMfHAD3usmIZ3fpyw1
   V44tNjBMvp6CiKFbS284e5VmqwcQRRm/HBdkb0fGKjpYOKUpdESbxkeRM
   GGdKanAw9bu+d2N9ciZybpwsV63Q7Xw9rCH4pYGlYuwJ+Di1Cpzmowh4G
   b0dZaZ2TuLdgp0n0R/t07AXymR0KQdOWndeF6py83DlRCURGO22SAJ4+U
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234334704"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234334704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 12:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="696796048"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2022 12:30:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDBPM-000N13-2q; Thu, 27 Jan 2022 20:30:16 +0000
Date:   Fri, 28 Jan 2022 04:30:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:arm32-ftrace-fixes 46/50] arch/arm/kernel/ftrace.c:239:39:
 error: 'struct stackframe' has no member named 'lr_addr'
Message-ID: <202201280425.w2sPQp19-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git arm32-ftrace-fixes
head:   db81a4be9a228c6d728b5e10ada88553cc72a001
commit: 94e8ea79256baf12b39634037ff5336c1930308e [46/50] ARM: ftrace: enable the graph tracer with the EABI unwinder
config: arm-buildonly-randconfig-r006-20220124 (https://download.01.org/0day-ci/archive/20220128/202201280425.w2sPQp19-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=94e8ea79256baf12b39634037ff5336c1930308e
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb arm32-ftrace-fixes
        git checkout 94e8ea79256baf12b39634037ff5336c1930308e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/kernel/ftrace.c:216:6: warning: no previous prototype for 'prepare_ftrace_return' [-Wmissing-prototypes]
     216 | void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/ftrace.c: In function 'prepare_ftrace_return':
>> arch/arm/kernel/ftrace.c:239:39: error: 'struct stackframe' has no member named 'lr_addr'
     239 |                         parent = frame.lr_addr;
         |                                       ^


vim +239 arch/arm/kernel/ftrace.c

   213	
   214	#ifdef CONFIG_FUNCTION_GRAPH_TRACER
   215	asmlinkage
   216	void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
   217				   unsigned long frame_pointer,
   218				   unsigned long stack_pointer)
   219	{
   220		unsigned long return_hooker = (unsigned long) &return_to_handler;
   221		unsigned long old;
   222	
   223		if (unlikely(atomic_read(&current->tracing_graph_pause)))
   224			return;
   225	
   226		if (IS_ENABLED(CONFIG_UNWINDER_FRAME_POINTER)) {
   227			/* FP points one word below parent's top of stack */
   228			frame_pointer += 4;
   229		} else {
   230			struct stackframe frame = {
   231				.fp = frame_pointer,
   232				.sp = stack_pointer,
   233				.lr = self_addr,
   234				.pc = self_addr,
   235			};
   236			if (unwind_frame(&frame) < 0)
   237				return;
   238			if (frame.lr != self_addr)
 > 239				parent = frame.lr_addr;
   240			frame_pointer = frame.sp;
   241		}
   242	
   243		old = *parent;
   244		*parent = return_hooker;
   245	
   246		if (function_graph_enter(old, self_addr, frame_pointer, NULL))
   247			*parent = old;
   248	}
   249	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
