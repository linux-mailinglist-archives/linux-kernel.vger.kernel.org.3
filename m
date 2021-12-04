Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4748C4685C7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhLDOvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:51:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:17640 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232056AbhLDOvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:51:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="224374579"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="224374579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 06:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="514105856"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Dec 2021 06:47:52 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtWKO-000J75-1w; Sat, 04 Dec 2021 14:47:52 +0000
Date:   Sat, 4 Dec 2021 22:47:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rt-devel:linux-5.16.y-rt-rebase 47/121] kernel/softirq.c:1031:27:
 sparse: sparse: symbol 'timer_threads' was not declared. Should it be
 static?
Message-ID: <202112042254.23J0OaOO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.16.y-rt-rebase
head:   5722735c04a5dcbb1fefed204371b299529466fc
commit: 87b7f9e13d14278fe0f616d236a7139bfa9326ad [47/121] softirq: Use a dedicated thread for timer wakeups.
config: x86_64-randconfig-s022-20211203 (https://download.01.org/0day-ci/archive/20211204/202112042254.23J0OaOO-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=87b7f9e13d14278fe0f616d236a7139bfa9326ad
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.16.y-rt-rebase
        git checkout 87b7f9e13d14278fe0f616d236a7139bfa9326ad
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/softirq.c:1031:27: sparse: sparse: symbol 'timer_threads' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
