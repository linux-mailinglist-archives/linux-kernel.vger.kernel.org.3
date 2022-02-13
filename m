Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB34B3B74
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 14:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiBMNEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 08:04:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiBMNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 08:04:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34815B88C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 05:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644757438; x=1676293438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4WJZJbknenGkTG+kkIeFvel9trpEu70jNlVS7CRk4ik=;
  b=ZweB1FJTBrR8D0WsfWALCqY/vbJBh3wlUMnNbQaptf9JS1SZBYK8Lwhf
   Wcm+SZpRNnl2QdJIXucIrUC8O1Mfk593SQPcpfFkwbrATgX69lx4Ob1ZG
   Vq+u2BiUYkPCdk8ONB50IleOWgCRGZLaqpri8X9tqvxHV4SepnqZc4bVj
   TJlUUtA6aJyL6mdXEEEZ/A+OObUKrObDKL5TCIqUICIE0rKhR5tYqXBI2
   VXE2SNzsSDhSN31ahgslqUK9tUe61OfPGYsngaqfbq+PpMyavRs3JhBAz
   6yG6nahu5pqQ4/KWKB5hJ2M521MsYcFAhy25B3rEh4c/6zO7yDDUR/AQy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="247540791"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="247540791"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 05:03:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="702627576"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2022 05:03:55 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJEXj-0007WS-7t; Sun, 13 Feb 2022 13:03:55 +0000
Date:   Sun, 13 Feb 2022 21:03:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     chongjiapeng <jiapeng.chong@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: kernel/trace/ftrace.c:7157:20: error: unused function
 'ftrace_startup_enable'
Message-ID: <202202132037.4aN017dU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: 172f7ba9772cae12f099fc563352e905dc9a1921 ftrace: Make ftrace_profile_pages_init static
date:   4 months ago
config: arm-randconfig-r001-20220213 (https://download.01.org/0day-ci/archive/20220213/202202132037.4aN017dU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 478c237e21b2c3a83e46f26fcbeb3876682f9b14)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=172f7ba9772cae12f099fc563352e905dc9a1921
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 172f7ba9772cae12f099fc563352e905dc9a1921
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/ftrace.c:7157:20: error: unused function 'ftrace_startup_enable' [-Werror,-Wunused-function]
   static inline void ftrace_startup_enable(int command) { }
                      ^
   1 error generated.


vim +/ftrace_startup_enable +7157 kernel/trace/ftrace.c

0b6e4d56bf7186 Frederic Weisbecker      2008-10-28  7155  
8434dc9340cd2e Steven Rostedt (Red Hat  2015-01-20  7156) static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
df4fc31558dd2a Steven Rostedt           2008-11-26 @7157  static inline void ftrace_startup_enable(int command) { }
e1effa0144a1dd Steven Rostedt (Red Hat  2014-08-05  7158) static inline void ftrace_startup_all(int command) { }
8a56d7761d2d04 Steven Rostedt (Red Hat  2013-11-25  7159) 

:::::: The code at line 7157 was first introduced by commit
:::::: df4fc31558dd2a3a30292ddb3a64c2a5befcec73 ftrace: add function tracing to single thread

:::::: TO: Steven Rostedt <srostedt@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
