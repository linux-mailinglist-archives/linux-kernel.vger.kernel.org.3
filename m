Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E235A473DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhLNIFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:05:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:25185 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhLNIFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639469154; x=1671005154;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rjV2vJCIHQHCMOKR5klOAYcSglpVlBbDX5kT5PNhLRY=;
  b=VpdaMJ0JPOrs4DS08YA8otUYk7lvNOGIGisl2G63spANOGr0IrPsgmAq
   FybiSxdfRQ6XhzyvGiJSVJf+cMIL+JVXIzJImAj4JR+mmKCDwVkExqszL
   mpraCmCvUL5WLT0rzPD+3I1zqLINJtnhryZ2VH7sVlTmBgrs3gNEeewJq
   sRNNgnpinQf0G/UvON4miyGGocqbnhyPhC6BMI+NMUMiDpj9+5XPTQ+cr
   2xUATSq1NuMRa1kIA58WVCOXsw9MVGWBAaVmsUWcV6gNQDRr2b+LXqoMx
   WGChgj1Vg63LMXmcNvdEmgvBxLMY9FTBA8EhQd9r0h5/fb8EAriIBSdJM
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302303380"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="302303380"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 00:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="464977888"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2021 00:05:52 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx2op-00004F-C7; Tue, 14 Dec 2021 08:05:51 +0000
Date:   Tue, 14 Dec 2021 16:05:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tglx-devel:x86/fpu-kvm 1/6] arch/x86/kernel/fpu/xstate.c:1625:6:
 warning: variable 'ret' is used uninitialized whenever 'if' condition is
 false
Message-ID: <202112141631.KodrezTK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu-kvm
head:   e16d6eec3c9e60abfb29d0d77f08411d326142dd
commit: 8a4ae8c80ec211646b5824b7c89d64cf7d286625 [1/6] x86/fpu: Extend fpu_xstate_prctl() with guest permissions
config: x86_64-randconfig-r035-20211213 (https://download.01.org/0day-ci/archive/20211214/202112141631.KodrezTK-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=8a4ae8c80ec211646b5824b7c89d64cf7d286625
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel x86/fpu-kvm
        git checkout 8a4ae8c80ec211646b5824b7c89d64cf7d286625
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/fpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/fpu/xstate.c:1625:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (!guest) {
               ^~~~~~
   arch/x86/kernel/fpu/xstate.c:1637:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   arch/x86/kernel/fpu/xstate.c:1625:2: note: remove the 'if' if its condition is always true
           if (!guest) {
           ^~~~~~~~~~~~
   arch/x86/kernel/fpu/xstate.c:1611:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +1625 arch/x86/kernel/fpu/xstate.c

  1597	
  1598	static int __xstate_request_perm(u64 permitted, u64 requested, bool guest)
  1599	{
  1600		/*
  1601		 * This deliberately does not exclude !XSAVES as we still might
  1602		 * decide to optionally context switch XCR0 or talk the silicon
  1603		 * vendors into extending XFD for the pre AMX states, especially
  1604		 * AVX512.
  1605		 */
  1606		bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
  1607		struct fpu *fpu = &current->group_leader->thread.fpu;
  1608		struct fpu_state_perm *perm;
  1609		unsigned int ksize, usize;
  1610		u64 mask;
  1611		int ret;
  1612	
  1613		/* Check whether fully enabled */
  1614		if ((permitted & requested) == requested)
  1615			return 0;
  1616	
  1617		/* Calculate the resulting kernel state size */
  1618		mask = permitted | requested;
  1619		ksize = xstate_calculate_size(mask, compacted);
  1620	
  1621		/* Calculate the resulting user state size */
  1622		mask &= XFEATURE_MASK_USER_SUPPORTED;
  1623		usize = xstate_calculate_size(mask, false);
  1624	
> 1625		if (!guest) {
  1626			ret = validate_sigaltstack(usize);
  1627			if (ret)
  1628				return ret;
  1629		}
  1630	
  1631		perm = guest ? &fpu->guest_perm : &fpu->perm;
  1632		/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
  1633		WRITE_ONCE(perm->__state_perm, requested);
  1634		/* Protected by sighand lock */
  1635		perm->__state_size = ksize;
  1636		perm->__user_state_size = usize;
  1637		return ret;
  1638	}
  1639	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
