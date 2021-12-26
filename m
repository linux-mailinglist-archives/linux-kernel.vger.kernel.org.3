Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0B47F5BC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLZH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 02:57:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:32913 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhLZH5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 02:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640505457; x=1672041457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G2QR44OvvvFXF1Egz2eX0d/S/iplswknw/OhXz/Wu6o=;
  b=da8fDy5wStu2XZp8crAxFLCtLfbAJI9gbnfRvWghBIGthekB8ym3Vf2g
   BxOKE39IkqdXqnbtc9RdKWMKjggHxow4bapMmpxTUqhDdezjj8Te7mKfS
   S9i4+O1xxIEjViLcaGDM2gwhuZyIccYUMsq0rGWRDBvgl8GtPsp+Ws4RR
   1pl6+J3pmDbutAESKzT/3Da7jXbPzD4UqkS+ObEdQOlkpAxuLrXPCYbvy
   7UXC+lLhRNie9EH9hIrqyCs67dnqeu+LD7mDTHYGImtLJSq2XgL1jhz9V
   /mk1ELl3uXjppITlORU9zgkAeO0pBQIJXY4HXBiLdZcktrvskOpW8o5g1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="327417225"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="327417225"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 23:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="509533587"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Dec 2021 23:57:35 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1OPP-0005D0-1s; Sun, 26 Dec 2021 07:57:35 +0000
Date:   Sun, 26 Dec 2021 15:57:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-5 1/1] kernel/signal.c:2994
 __arm64_sys_restart_syscall() warn: inconsistent indenting
Message-ID: <202112261406.ElfEMkZR-lkp@intel.com>
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
config: arm64-randconfig-m031-20211225 (https://download.01.org/0day-ci/archive/20211226/202112261406.ElfEMkZR-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/signal.c:2994 __arm64_sys_restart_syscall() warn: inconsistent indenting

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
