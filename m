Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF744C2891
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiBXJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiBXJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:54:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A72819B6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645696418; x=1677232418;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CYRIDdp9DfLLgliDckqKxr1/trJ76a0IiZvbqZYWbu0=;
  b=R7xoD7U5Am5Ptv8RNWYKKjxdUkIBG33x20mDrFEJFmtlePs+UrzZRFPZ
   Sph/N4Sh8HUBZDn5K9Yjh4HFS3Oenu2fMjOyd14jGdG4RlBlTuHwRJHUg
   jmIPztQr9DBVQ/6+3ruUlHIpIcMtuZtq8t2J6ONaNs+/TMk9y702vq/jX
   xf92ns4yNlmzMrhpVqY6+3Fse78ToEooUxByicrAD38kRK10/M6wF2pxy
   HBLDQfPBytnkWgCuMwiTIRdk+JYsZGR6OUCq4VAPDebuO7bplcfhGl1WS
   z3gdunSDjpi9eSK9J5Z6PNOHNYkB4Ik5ZQShYLr0Qj4RgewRNilQTGv4d
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232815979"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="232815979"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 01:53:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="684223536"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 01:53:19 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNAoI-0002yZ-I9; Thu, 24 Feb 2022 09:53:18 +0000
Date:   Thu, 24 Feb 2022 17:52:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 27/42] arch/x86/lib/error-inject.c:15:3:
 error: expected ')'
Message-ID: <202202241727.G6Jrx2wZ-lkp@intel.com>
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
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 894eca106331b66d8f1c261d40386c043da75ee2 [27/42] x86/ibt: Annotate text references
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220224/202202241727.G6Jrx2wZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=894eca106331b66d8f1c261d40386c043da75ee2
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 894eca106331b66d8f1c261d40386c043da75ee2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/lib/error-inject.c:15:3: error: expected ')'
                   ANNOTATE_NOENDBR
                   ^
   arch/x86/lib/error-inject.c:10:4: note: to match this '('
   asm(
      ^
   1 error generated.


vim +15 arch/x86/lib/error-inject.c

     9	
    10	asm(
    11		".text\n"
    12		".type just_return_func, @function\n"
    13		".globl just_return_func\n"
    14		"just_return_func:\n"
  > 15			ANNOTATE_NOENDBR
    16			ASM_RET
    17		".size just_return_func, .-just_return_func\n"
    18	);
    19	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
