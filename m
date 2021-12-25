Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE747F3D6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhLYQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:29:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:11068 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhLYQ3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640449782; x=1671985782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8zcxy2gafScdkxV8HxBW7DzD3ZKWqwyjLH83mcuftug=;
  b=YVuUvVozIAMH3F5iPkgJn30Fb++BrkXyql2p4pDzzSIS7SRCDmE7USOn
   ZGzbGHKZStHzQxZUIuUt6KRUq4Far/LbYy/x8bHkZArLZc7/ExRmlPRpM
   537aautQkIG8dL0RvB7bMZfUnqVbzChZkFCbrlY+EyaL2ig24uvexyQDT
   UZe4f2wcVExTnHUaP3sfviZB4xg9NnhcCdAFdHtIekKmYPvSBOLMZV+ca
   NX4jpUBAbi/8h50CH4U5I3zfQB99RFd6Ri7XcQO4NNTb5cVIFnTYREI2k
   phL+xIWeOcRSNUtgk91RDZXqdtK3sEfLNvbno+S7An0yPA2Tw5bD+GL+J
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="301815520"
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="301815520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 08:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,235,1635231600"; 
   d="scan'208";a="469316247"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 25 Dec 2021 08:29:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n19vQ-0004Ql-Tf; Sat, 25 Dec 2021 16:29:40 +0000
Date:   Sun, 26 Dec 2021 00:28:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-5 1/1] kernel/signal.c:2994
 sys_restart_syscall() warn: inconsistent indenting
Message-ID: <202112260013.QoIueYEH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-5
head:   31c51d49e3f587cdcdf22b313b5bbce80b31405f
commit: 31c51d49e3f587cdcdf22b313b5bbce80b31405f [1/1] add testing vDSO support (v5)
config: ia64-randconfig-m031-20211225 (https://download.01.org/0day-ci/archive/20211226/202112260013.QoIueYEH-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/signal.c:2994 sys_restart_syscall() warn: inconsistent indenting

vim +2994 kernel/signal.c

  2983	
  2984	/*
  2985	 * System call entry points.
  2986	 */
  2987	
  2988	/**
  2989	 *  sys_restart_syscall - restart a system call
  2990	 */
  2991	SYSCALL_DEFINE0(restart_syscall)
  2992	{
  2993		struct restart_block *restart = &current->restart_block;
> 2994	printk("************** RESTART SYSCALL gestartet\n");
  2995		return restart->fn(restart);
  2996	}
  2997	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
