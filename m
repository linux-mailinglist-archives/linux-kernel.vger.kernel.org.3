Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211734D8F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbiCNWCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbiCNWCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:02:17 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEF3BF8A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647295263; x=1678831263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cr/5Qscc6tCMGd1LGE5qTuUNoSf9cjTqugXe7qS30tc=;
  b=Q5rokjYgpr9MgDlO/DElb9Qx/uDgIwlIPPwPqZV7CHTs+yr7AeBnLJ54
   dXHXf5PG1gFXFMXJsMU1NhTJ5L0hnNmA/+1y1F8l8PPi66+nEXkDIOI8g
   7nAe6FR0TnVy+VKS7A0mTnEYM2hCUQS1our/a9JU50H2TdcVQ0he6xMyp
   SRKpQ7l7/cE/o6JPJWaCXwh8miGgUNbnTMjyflisoWVGQf8QA+n4qJr4J
   xkjRReEldFxrDVklIYKBL12Fw1lvcFfuDQYpqmozHbsljh0Z/ddqRfn7Q
   F01SAPdRWrSFxWWytT/Bvh1quS+5KdbcRZuq0HVWa46+ajI8jl7bc3Ffp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="316876221"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="316876221"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 15:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="645985522"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2022 15:01:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTskO-000AGt-7A; Mon, 14 Mar 2022 22:01:00 +0000
Date:   Tue, 15 Mar 2022 06:00:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: /tmp/ccIWiggX.s:22: Error: invalid literal constant: pool needs to
 be closer
Message-ID: <202203150516.KTorSVVU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09688c0166e76ce2fb85e86b9d99be8b0084cdf9
commit: 7e9bf33b812471ee57a03ec7f9b544ca437cc706 ARM: kprobes: Make a frame pointer on __kretprobe_trampoline
date:   5 months ago
config: arm-randconfig-r002-20220313 (https://download.01.org/0day-ci/archive/20220315/202203150516.KTorSVVU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e9bf33b812471ee57a03ec7f9b544ca437cc706
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7e9bf33b812471ee57a03ec7f9b544ca437cc706
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/probes/kprobes/core.c:236:16: warning: no previous prototype for 'kprobe_handler' [-Wmissing-prototypes]
     236 | void __kprobes kprobe_handler(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~
   arch/arm/probes/kprobes/core.c: In function 'arch_init_kprobes':
   arch/arm/probes/kprobes/core.c:465:12: warning: old-style function definition [-Wold-style-definition]
     465 | int __init arch_init_kprobes()
         |            ^~~~~~~~~~~~~~~~~
   /tmp/ccIWiggX.s: Assembler messages:
>> /tmp/ccIWiggX.s:22: Error: invalid literal constant: pool needs to be closer

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
