Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B038F473D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 07:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhLNGnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 01:43:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:27637 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhLNGnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 01:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639464192; x=1671000192;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zihrvfTZOHS81x6JjSCk9tbag0HqJyS22FPf4JWEsK8=;
  b=AS48lQxxVQEOKtAM+7Z+8cWXIYLpfXpz1f5pFeesJyvxap3hPkz1KuQX
   u9AcDQ8g48bmdXq1NqlvHzY24lAStHVN3SCMhyjaFeynenguzpX8zv4Pw
   CA4Tlwv+4F6Gt9aMArUat1cWeswDABZ3PH7yu1naunutu3i9rE+LFSyCM
   ibNYnNmLV/hCG7Rhbtq+ZQftBUsSzuKsrylnh0GX8IieF3AgSLm/H1SBx
   zrzVhP2QXe1mPm1FOdpBZSVkbZ7v4U0IO1Rh2rEfeexctYqWhLWP+rqgO
   fog6rBEfkpOCLUfC7RRysvsXdLCgg9waCKyfITlrVdStBdIG9rHTrtE/1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="299690681"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="299690681"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 22:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="463681529"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2021 22:43:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx1Wo-0007WK-A8; Tue, 14 Dec 2021 06:43:10 +0000
Date:   Tue, 14 Dec 2021 14:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ebiederm-user-namespace:signal-for-v5.17 10/12]
 kernel/kthread.c:299: warning: expecting prototype for kthread_complete_and
 exit(). Prototype was for kthread_complete_and_exit() instead
Message-ID: <202112141422.Cykr6YUS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.17
head:   6b1248798eb6f6d5285db214299996ecc5dc1e6b
commit: cead18552660702a4a46f58e65188fe5f36e9dfe [10/12] exit: Rename complete_and_exit to kthread_complete_and_exit
config: i386-randconfig-a001-20211213 (https://download.01.org/0day-ci/archive/20211214/202112141422.Cykr6YUS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/commit/?id=cead18552660702a4a46f58e65188fe5f36e9dfe
        git remote add ebiederm-user-namespace https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
        git fetch --no-tags ebiederm-user-namespace signal-for-v5.17
        git checkout cead18552660702a4a46f58e65188fe5f36e9dfe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/kthread.c:299: warning: expecting prototype for kthread_complete_and exit(). Prototype was for kthread_complete_and_exit() instead


vim +299 kernel/kthread.c

   285	
   286	/**
   287	 * kthread_complete_and exit - Exit the current kthread.
   288	 * @comp: Completion to complete
   289	 * @code: The integer value to return to kthread_stop().
   290	 *
   291	 * If present complete @comp and the reuturn code to kthread_stop().
   292	 *
   293	 * A kernel thread whose module may be removed after the completion of
   294	 * @comp can use this function exit safely.
   295	 *
   296	 * Does not return.
   297	 */
   298	void __noreturn kthread_complete_and_exit(struct completion *comp, long code)
 > 299	{
   300		if (comp)
   301			complete(comp);
   302	
   303		kthread_exit(code);
   304	}
   305	EXPORT_SYMBOL(kthread_complete_and_exit);
   306	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
