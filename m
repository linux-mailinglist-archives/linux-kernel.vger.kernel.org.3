Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB684BEEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiBVAdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:33:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiBVAdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:33:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D912A97
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645489968; x=1677025968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w/719drwIG98CBNKxkg6YGoi7mX8RV+BZWzDPPPcIUI=;
  b=DgedmOzSa3Aj7a6rpYl5nmWKStJqKqtgvm+jk1dDrxPwt/qVANyfeYWA
   4JgzAl/3A9/oWfNUERkJ5cjk/bAdPkQFxpahLFeVbJ8NSAa6CwHa02FIW
   Mp7DHOx0ZP2U7/2IcYy9YE+f56UpcAm0uCq5aZ6loBqPuOMdsnP+Kg5SN
   yPc7/Vq1aF4GXbRBvkak6XwEnpMVXwvCvS7P7kbJNMa0T826/QdrdgLD2
   Mc8m02BjNeSJ2f3boZmj/Mlk/aqYxfeUezrlvfmPHLFZqvriZ0Bc337HL
   KnspcKp02H+M6II7kGzG9gtXu5svCQ8tHgQKycUP3MszcGPEku1VyYA6h
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="338016854"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="338016854"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 16:32:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="573244362"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2022 16:32:47 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMJ6k-00029I-D1; Tue, 22 Feb 2022 00:32:46 +0000
Date:   Tue, 22 Feb 2022 08:32:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 24/39] arch/x86/lib/error-inject.c:14:3:
 error: expected ')'
Message-ID: <202202220805.Eoasnrld-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   1436dce5f32d577e8cef693e09f4bb1faa0e2692
commit: 691967145f3060050b5628f6863de26cc77ef17e [24/39] x86/ibt: Annotate text references
config: i386-randconfig-a012-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220805.Eoasnrld-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=691967145f3060050b5628f6863de26cc77ef17e
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 691967145f3060050b5628f6863de26cc77ef17e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/lib/error-inject.c:14:3: error: expected ')'
                   ANNOTATE_NOENDBR
                   ^
   arch/x86/lib/error-inject.c:9:4: note: to match this '('
   asm(
      ^
   1 error generated.
--
>> arch/x86/kernel/alternative.c:716:2: error: expected ')'
           ANNOTATE_NOENDBR
           ^
   arch/x86/kernel/alternative.c:712:5: note: to match this '('
   asm (
       ^
   arch/x86/kernel/alternative.c:761:16: error: expected string literal in 'asm'
           asm volatile (ANNOTATE_NOENDBR
                         ^
   2 errors generated.


vim +14 arch/x86/lib/error-inject.c

     8	
     9	asm(
    10		".text\n"
    11		".type just_return_func, @function\n"
    12		".globl just_return_func\n"
    13		"just_return_func:\n"
  > 14			ANNOTATE_NOENDBR
    15			ASM_RET
    16		".size just_return_func, .-just_return_func\n"
    17	);
    18	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
