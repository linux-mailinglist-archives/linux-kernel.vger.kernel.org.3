Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3F4826D6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 08:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiAAHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 02:32:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:41247 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbiAAHcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 02:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641022353; x=1672558353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7vk+brI+MP72nhmlqrJ8pE9GK7vP8Xk9GSzHHEZeYJU=;
  b=k8xUh+uhJzrJ936+sGwOrQSnXlCJ0eabRHBDzB9+1R21ifjeHeYqZSTD
   byY/1HXwvM5m+ExV5eJ3CTVK1T2l5OGkXlYPqCYO7bBUlH7aJpODSoQ3k
   /rBc1Owlw14lz/abdw9eTF3H+PO97XZsCv6AfwrEzkcAo6ai9YySapDxz
   RC4/nsruke5xkpM2Kcb1ihd1XZtdH8ALVtyWi65ZXkyiMTN+iWMgKOnYl
   XaUDOL+fgE0QcPP2O3rWJyftbKs9WD+ZrUURGIY8QaL/3lATRWuAIP1Y7
   axgCiArZO47OYmVCsp/sBzQz1H4cta10Iy1JKP2LF3uSc0g2AWhkaQXdG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="239420906"
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="239420906"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 23:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,253,1635231600"; 
   d="scan'208";a="619806461"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2021 23:32:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3YsR-000CBk-7v; Sat, 01 Jan 2022 07:32:31 +0000
Date:   Sat, 1 Jan 2022 15:31:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kelly Rossmoyer <krossmo@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alistair Delva <adelva@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android11-kiwi-5.4
 2423/9999] kernel/power/wakeup_reason.c:199:6: sparse: sparse: symbol
 '__log_abort_or_abnormal_wake' was not declared. Should it be static?
Message-ID: <202201011526.iW3K3uKk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android11-kiwi-5.4
head:   04f660d6724f5df1b07f8cf9e1c55f70fb43d1d2
commit: 189ced91cd7b0e440b0be876406fd36313a11c3f [2423/9999] ANDROID: power: wakeup_reason: wake reason enhancements
config: x86_64-randconfig-s022-20211118 (https://download.01.org/0day-ci/archive/20220101/202201011526.iW3K3uKk-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/189ced91cd7b0e440b0be876406fd36313a11c3f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android11-kiwi-5.4
        git checkout 189ced91cd7b0e440b0be876406fd36313a11c3f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/power/wakeup_reason.c:199:6: sparse: sparse: symbol '__log_abort_or_abnormal_wake' was not declared. Should it be static?
   kernel/power/wakeup_reason.c:378:12: sparse: sparse: symbol 'wakeup_reason_init' was not declared. Should it be static?

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
