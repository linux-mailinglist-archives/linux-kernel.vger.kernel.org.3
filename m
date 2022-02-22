Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA54BF259
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiBVHDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:03:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiBVHDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:03:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B936E99EED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645513377; x=1677049377;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PaMOZHdkvpYmV+wvpiy8KINi8Rm4k50FcjpT5r5CQB0=;
  b=aUPT11oiJgmI0H+1thZMtWpmchBAYf5DhMV+q8hw8pr7xsS3DiZXhMuJ
   uvdKd7teroQU8CWM87sXqpFX9XOF4kxMYk6oYlXBUtPAoqLrph49cFJI/
   X6Cjql+KVKEvjrG/1Tpjn+h9OwM6qI/TT8wGCh+GDXHblamPjQLwwNaJT
   mTiy6c5Mrg1cDZRsi5plhh7WnY4Wb4EHNue28AYQmop9e7IYQXdhOGYK2
   rWXSmRfp3kpupBECooIDvaJZjqvrn1aKjfyl3kGjNVASbPqNPkWLHjCJD
   kv7pxF4SYXBchTgiI4pztRa9R19Jub7NaR6ewF1O0r6c/2aSgyj21TS6L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251811369"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251811369"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 23:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="505435106"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2022 23:02:56 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMPCJ-0002Se-Ck; Tue, 22 Feb 2022 07:02:55 +0000
Date:   Tue, 22 Feb 2022 15:02:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 7/39] llvm-objcopy: error:
 'arch/riscv/kernel/vdso/vdso.so.dbg': No such file or directory
Message-ID: <202202221532.Hh2NnPXO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   1436dce5f32d577e8cef693e09f4bb1faa0e2692
commit: b89e586f426820864b1d7838a4cabea6ae4180fb [7/39] kbuild: Fix clang build
config: riscv-randconfig-r013-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221532.Hh2NnPXO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=b89e586f426820864b1d7838a4cabea6ae4180fb
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout b89e586f426820864b1d7838a4cabea6ae4180fb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> llvm-objcopy: error: 'arch/riscv/kernel/vdso/vdso.so.dbg': No such file or directory

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
