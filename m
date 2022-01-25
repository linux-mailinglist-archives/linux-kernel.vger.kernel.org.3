Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51B349B165
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiAYKLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:11:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:37261 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238837AbiAYKCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643104964; x=1674640964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4VKGIB8DQpC+F+Cykxy5ATSZQvYmTLXbDBDQQx0vGuE=;
  b=O01pn0kIScb2CQF8/UUH4nLFIXyCQSO1nuGV7IOMzMF9oDphGFlcWWHG
   ejxAu2KGR3GJQP5of3LlAXdgubPG5XCA0Nr+KXi6sODtASSnsGJgcMF+Y
   KK6S+7B7Mxomyq18REItbMYZEwGgSs6ZsovFYUDQH1yeC6+B/BSRqkx4x
   m4PFQqzmtYoDbt0tuj8Mc4ltiObMSPQLh7tJT04vgoYDcZBF5mXugPxvY
   ZOirGAdiG5HP/gswfomupQSKc/WzDrGFMA5bCbxn2KEOZjmtRyiHy++UB
   yhlqiXOIZIL4awmLdv+g0eISLBAddvo9Pl4kCywEV1eVj8gjNYio6F5ik
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="243867803"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="243867803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 02:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="494945228"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2022 02:02:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCIep-000Jhq-BU; Tue, 25 Jan 2022 10:02:35 +0000
Date:   Tue, 25 Jan 2022 18:02:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202201251708.BOnUdbSj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 4ebbd075bcde7884e078d4360510b989f559bfec KVM: PPC: Book3S HV P9: Use host timer accounting to avoid decrementer read
date:   9 weeks ago
config: powerpc64-randconfig-s031-20220125 (https://download.01.org/0day-ci/archive/20220125/202201251708.BOnUdbSj-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ebbd075bcde7884e078d4360510b989f559bfec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4ebbd075bcde7884e078d4360510b989f559bfec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/powerpc/kernel/time.c:90:5: sparse: sparse: symbol 'decrementer_max' was not declared. Should it be static?
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:626:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:626:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:626:24: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:557:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:557:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:557:24: sparse:     got unsigned long long *

vim +846 arch/powerpc/kernel/time.c

4a4cfe3836916e1 Tony Breeds            2007-09-22  842  
d831d0b83f20588 Tony Breeds            2007-09-21  843  static int decrementer_set_next_event(unsigned long evt,
d831d0b83f20588 Tony Breeds            2007-09-21  844  				      struct clock_event_device *dev)
d831d0b83f20588 Tony Breeds            2007-09-21  845  {
6601ec1c2ba9294 Christophe Leroy       2020-09-29 @846  	__this_cpu_write(decrementers_next_tb, get_tb() + evt);
d831d0b83f20588 Tony Breeds            2007-09-21  847  	set_dec(evt);
0215f7d8c53fb19 Benjamin Herrenschmidt 2014-01-14  848  
0215f7d8c53fb19 Benjamin Herrenschmidt 2014-01-14  849  	/* We may have raced with new irq work */
0215f7d8c53fb19 Benjamin Herrenschmidt 2014-01-14  850  	if (test_irq_work_pending())
0215f7d8c53fb19 Benjamin Herrenschmidt 2014-01-14  851  		set_dec(1);
0215f7d8c53fb19 Benjamin Herrenschmidt 2014-01-14  852  
d831d0b83f20588 Tony Breeds            2007-09-21  853  	return 0;
d831d0b83f20588 Tony Breeds            2007-09-21  854  }
d831d0b83f20588 Tony Breeds            2007-09-21  855  

:::::: The code at line 846 was first introduced by commit
:::::: 6601ec1c2ba929430f5585ce7f9d9960b0e0a01d powerpc: Remove get_tb_or_rtc()

:::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
