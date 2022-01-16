Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC07448FFAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 00:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiAPX5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 18:57:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:38129 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbiAPX5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 18:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642377438; x=1673913438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CMrlQy5ltdYislPsS7IaQHq2vW8wpuQ9QTNnY8wEGBE=;
  b=GJXMMMYekb7R62PZVostQ8zVEPB8UolqRLLqwCyJV9HagcqCp6ham3Af
   IvqXzWXSvGusi4ABR32lXt0MrJxl4HI+AD1+S2SHWAOvuz7jy/nSkbh1v
   e9fY6DvdnDXFHE62Ipd1n5OmAqLj+Cd1xArctPXlx4O9/dry0kfcRokWN
   O+xMkTkF/6wbhIS4pTce2Sm7Ku1DI/daFq6nfbU9BII4lQVwZRUdlbwyz
   7xjt8ypzY4cEGHNupRXYu0eG+NFfx1g0lvJV960fQbEehupg6NPEl6TBu
   CFEWuvdCedz/xg6PdJJUUh4CP9PeHPRQLunH1PnE5qNDJZwYfUQ690X24
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="330873782"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="330873782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 15:57:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="577871994"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jan 2022 15:57:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9FOe-000B47-UG; Sun, 16 Jan 2022 23:57:16 +0000
Date:   Mon, 17 Jan 2022 07:56:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:master 3/5] vmlinux.o: warning: objtool:
 do_machine_check()+0x4db: call to mca_msr_reg() leaves .noinstr.text section
Message-ID: <202201170731.quqbKbo5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git master
head:   c268640c1e164a8084deae65b4d6136fff429eba
commit: 7ec51079b641eebeb984246bd42bf4bcece1d087 [3/5] Merge branch 'locking/core'
config: x86_64-randconfig-r014-20211215 (https://download.01.org/0day-ci/archive/20220117/202201170731.quqbKbo5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=7ec51079b641eebeb984246bd42bf4bcece1d087
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue master
        git checkout 7ec51079b641eebeb984246bd42bf4bcece1d087
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: mce_read_aux()+0x63: call to mca_msr_reg() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: do_machine_check()+0x4db: call to mca_msr_reg() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x52: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x59: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x52: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x52: call to on_thread_stack() leaves .noinstr.text section

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
