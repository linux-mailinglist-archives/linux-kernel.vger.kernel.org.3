Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1044881C1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 07:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiAHF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 00:57:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:60232 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbiAHF5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 00:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641621461; x=1673157461;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lNvr8jIgepuRJoPzPtge/mB0j3ubsvTEUNrtNXk8cy4=;
  b=MogwWcLGnae2xeY4wxumwjaL5JMt/eIdUY1QP7bPonNO14TlAnufHGb4
   IksKUxIrpXUxxpZtMycadnkcsE9MkqUkGsm4Al1W224+FtXvOjKHcTVFp
   l79P5G9k/zcEpJ99oHzvtSdPyPTgHqYHhn0UwG+xaTBUO0Ch+P26FoBp/
   BW4aim/wLOTgNKrP8DBbgzqDUwjF7LmGAigAZ/pX8cv7GwB2BnD4YASQL
   BcuzMBOAyh+fDkx7qJ0OwFmlOUq1qshYEHgYOcHJNO+pjMj4oQ8FasvC4
   ooWVGkt4S6ZJbAveo+c++RZfzuZmfRx4C++wAruELzcvTdz98BFvGpvRX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="230328763"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="230328763"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 21:57:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="622155751"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 21:57:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n64jS-0000J7-EO; Sat, 08 Jan 2022 05:57:38 +0000
Date:   Sat, 8 Jan 2022 13:56:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kelly Rossmoyer <krossmo@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android11-kiwi-5.4
 2422/9999] kernel/power/wakeup_reason.c:199:6: warning: no previous
 prototype for function '__log_abort_or_abnormal_wake'
Message-ID: <202201081335.QloPko7J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kelly,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android11-kiwi-5.4
head:   7d1d5848183bd1d9086d0572f9af431d3ded407f
commit: 189ced91cd7b0e440b0be876406fd36313a11c3f [2422/9999] ANDROID: power: wakeup_reason: wake reason enhancements
config: x86_64-randconfig-a014-20220107 (https://download.01.org/0day-ci/archive/20220108/202201081335.QloPko7J-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f3a344d2125fa37e59bae1b0874442c650a19607)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/189ced91cd7b0e440b0be876406fd36313a11c3f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android11-kiwi-5.4
        git checkout 189ced91cd7b0e440b0be876406fd36313a11c3f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/power/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/power/wakeup_reason.c:199:6: warning: no previous prototype for function '__log_abort_or_abnormal_wake' [-Wmissing-prototypes]
   void __log_abort_or_abnormal_wake(bool abort, const char *fmt, va_list args)
        ^
   kernel/power/wakeup_reason.c:199:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __log_abort_or_abnormal_wake(bool abort, const char *fmt, va_list args)
   ^
   static 
   kernel/power/wakeup_reason.c:378:12: warning: no previous prototype for function 'wakeup_reason_init' [-Wmissing-prototypes]
   int __init wakeup_reason_init(void)
              ^
   kernel/power/wakeup_reason.c:378:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init wakeup_reason_init(void)
   ^
   static 
   2 warnings generated.


vim +/__log_abort_or_abnormal_wake +199 kernel/power/wakeup_reason.c

   198	
 > 199	void __log_abort_or_abnormal_wake(bool abort, const char *fmt, va_list args)
   200	{
   201		unsigned long flags;
   202	
   203		spin_lock_irqsave(&wakeup_reason_lock, flags);
   204	
   205		/* Suspend abort or abnormal wake reason has already been logged. */
   206		if (suspend_abort || abnormal_wake) {
   207			spin_unlock_irqrestore(&wakeup_reason_lock, flags);
   208			return;
   209		}
   210	
   211		suspend_abort = abort;
   212		abnormal_wake = !abort;
   213		vsnprintf(non_irq_wake_reason, MAX_SUSPEND_ABORT_LEN, fmt, args);
   214	
   215		spin_unlock_irqrestore(&wakeup_reason_lock, flags);
   216	}
   217	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
