Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A49598839
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbiHRQBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbiHRQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:01:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD47B14F3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660838470; x=1692374470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tA8V1drYYYK0xzACszrVpyl5sQ8ISuTmC0FGyjDHVfk=;
  b=d+NdoDfYiTsdWQD4tcGNoH+DCvh+luW1MUQ9l4J8M0aQHIU1S338QMMP
   9wbL9GmrcuF+egN5iSxZ0r/L2Y8y4xhL1NoFvdgdkzbfzPvYXBROXhMRh
   Hh5zKnS/l++EEwFsRKW2pKsjA6z8Wyv1czSCNAPAiw6DPGoaQs6oJZOpn
   3ZNi/1HUKv+EA+/e8EpmS1Re2+CU7YDHRwr1Oz4CH8NJSoBFUUlJggVSW
   CSh1/56HgK/l6VY4b88Vc4Gt/5Mm4/XxmsR4b+K/5Glkiy/a+u7V0Gw7w
   lvjPMaIYGe6P/Jbi/UegsVPmES9+8ldf7E2RZBlVMRs2XL1sATD8RTjMJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="293588368"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="293588368"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 09:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558581369"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 09:00:53 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOhwy-0000Df-2E;
        Thu, 18 Aug 2022 16:00:52 +0000
Date:   Fri, 19 Aug 2022 00:00:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [ammarfaizi2-block:tglx/devel/depthtracking 33/59]
 arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_caller+0x0:
 unreachable instruction
Message-ID: <202208182339.nUcZuZWV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/depthtracking
head:   7e7135a8ff18016dde7361f13b02c3d1f63edfdb
commit: 301b621edaa301dc3936a386920008a689ddd988 [33/59] objtool: Fix find_{symbol,func}_containing()
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220818/202208182339.nUcZuZWV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/301b621edaa301dc3936a386920008a689ddd988
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/depthtracking
        git checkout 301b621edaa301dc3936a386920008a689ddd988
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_caller+0x0: unreachable instruction


objdump-func vmlinux.o ftrace_caller:
0000 0000000000062370 <ftrace_caller>:
0000    62370:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
0007    62377:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
000c    6237c:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
0011    62381:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
0016    62386:	48 89 74 24 68       	mov    %rsi,0x68(%rsp)
001b    6238b:	48 89 7c 24 70       	mov    %rdi,0x70(%rsp)
0020    62390:	4c 89 44 24 48       	mov    %r8,0x48(%rsp)
0025    62395:	4c 89 4c 24 40       	mov    %r9,0x40(%rsp)
002a    6239a:	48 c7 44 24 78 00 00 00 00 	movq   $0x0,0x78(%rsp)
0033    623a3:	48 89 ea             	mov    %rbp,%rdx
0036    623a6:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
003b    623ab:	48 8b b4 24 b0 00 00 00 	mov    0xb0(%rsp),%rsi
0043    623b3:	48 8b bc 24 a8 00 00 00 	mov    0xa8(%rsp),%rdi
004b    623bb:	48 89 bc 24 80 00 00 00 	mov    %rdi,0x80(%rsp)
0053    623c3:	48 83 ef 05          	sub    $0x5,%rdi
0057    623c7:	48 8d 8c 24 b0 00 00 00 	lea    0xb0(%rsp),%rcx
005f    623cf:	48 89 8c 24 98 00 00 00 	mov    %rcx,0x98(%rsp)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
