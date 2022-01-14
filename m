Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2648E3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiANFma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:42:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:53323 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234904AbiANFm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642138949; x=1673674949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mJtBJjwOHIIsvktCwetmxq/lvqD04SKb80xBhc5EN0k=;
  b=lLWPUyKxan3UPrYvt/+jBVE89aHj9S++WJsZGpxKM/nkgps1J14i6/j1
   rrsY1XMDLktdAlQZG3wyu6AJRsY9QtyxmXCMEJdLrH1Go06uCFY58KSHl
   Xh3jz93Kwkuqmgcvd2Di84L7znM24zqWyxSV2F/G3QWKmxGejyFBx5RNI
   szVOhRJhYsG4cuSGbZeMwYia0w/cSGJSyGH1q5+aCF3UnM1VRthvwI97A
   JNx2amhNLXd+cJMX31JrZ9CjXRNGanCCJyneKFHLC+n1eKTnz9ljw38KX
   t5gv7Ip0KFoYgwSoQCqiWZU3DtBvqCnD2ImkjOAxWBxb8RgaUTfGav7g8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307530880"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="307530880"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 21:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="692079917"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 21:42:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8FM2-00089r-Mb; Fri, 14 Jan 2022 05:42:26 +0000
Date:   Fri, 14 Jan 2022 13:41:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:5.16-vdso-6 1/3] kernel/signal.c:2994
 __do_sys_restart_syscall() warn: inconsistent indenting
Message-ID: <202201141304.Om7XuSMy-lkp@intel.com>
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
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220114/202201141304.Om7XuSMy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
kernel/signal.c:2994 __do_sys_restart_syscall() warn: inconsistent indenting

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
