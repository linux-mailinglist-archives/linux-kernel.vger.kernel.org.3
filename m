Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8207D48F993
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 22:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiAOVlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 16:41:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:59005 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbiAOVlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 16:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642282904; x=1673818904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m27YbEw93OL5ImIEXLaTawUYKfHA+spmhvbsQC94p6s=;
  b=H7pNrgZKHJlBjjPMGOE9fbYkut/+b8V2g9HLI+KcnNFuQ9GQ6cCWzN45
   sINoY0hh6bmANquDVe6uTj8EjXpnKBZs9pJkWhr8VJGaSuJ7tvvDXZUbw
   L67TfSFia5etkm1vk2GqCkXmmfEgS6Wl/tFL6ZjrrVWJXOwMWeH5htmDu
   B2cPwlRsulgzVvGva/CjntuP7AxXJDCv//u4kosCOyBjCR+VglhoRyObT
   VNDIP71i8RZI8VIB9AP7d90K8GU2wqPSBXT8hP7mXbIbjLAVurtHeEKRy
   kKz2lhXzIF8foHtAC/Wv8+qXqSKv7gieK9ZoUAgOEGfpNEaOm0cEp9Dn0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="243265669"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="243265669"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 13:41:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="474028457"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2022 13:41:43 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8qnu-000AJ6-N0; Sat, 15 Jan 2022 21:41:42 +0000
Date:   Sun, 16 Jan 2022 05:41:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-6 1/3] kernel/signal.c:2994
 sys_restart_syscall() warn: inconsistent indenting
Message-ID: <202201160406.ydB4aO5N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git 5.16-vdso-6
head:   b7e375e2ced653c4615242d90232d4a0238dcac1
commit: 31c51d49e3f587cdcdf22b313b5bbce80b31405f [1/3] add testing vDSO support (v5)
config: arm-randconfig-m031-20220113 (https://download.01.org/0day-ci/archive/20220116/202201160406.ydB4aO5N-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

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
