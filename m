Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4803571081
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiGLC47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLC45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:56:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951512AC48
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657594616; x=1689130616;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dbyqtmB+g/WyPhKOda+JWmVl6uu1kpQIyC0ZzFSvCkU=;
  b=Sw3fFj+zt430GJL84C+3wwJ/uZqK+g2hfRkciIfs3obB99/wCV24fmXM
   7HXtvUND535XhozPmARYRhgTlc6pzxeqvCWv3z79Mnam5jPC59z/1ylFI
   l0XJZQyx1+1KVxn1F6HHgZQ7rlNqI3VDHKgB0j8HdOpWLWIBiawszsP4n
   qQSlhoxtbql41HNHlOISUW3zFgwuHaequNCfHKVi9jSsNlwMHy83HrYlL
   oWdz6td4d4FI2vamXXTb290vAlu/xdayAF8qvRNyg3e0RFM6EjnHKKx9g
   PrGrstMwGFWAYs8IK8Bhum+9s6ZbxQVNEXNrFNY9NTP4Vjhamk6fKypvf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284849398"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284849398"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 19:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="545257438"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2022 19:56:53 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB64y-0001aX-TQ;
        Tue, 12 Jul 2022 02:56:52 +0000
Date:   Tue, 12 Jul 2022 10:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202207121022.rUEEcxGj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5a29232d870d9e63fe5ff30b081be6ea7cc2465d
commit: 4ebbd075bcde7884e078d4360510b989f559bfec KVM: PPC: Book3S HV P9: Use host timer accounting to avoid decrementer read
date:   8 months ago
config: powerpc-randconfig-s031-20220712 (https://download.01.org/0day-ci/archive/20220712/202207121022.rUEEcxGj-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ebbd075bcde7884e078d4360510b989f559bfec
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4ebbd075bcde7884e078d4360510b989f559bfec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/ arch/powerpc/platforms/powermac/

If you fix the issue, kindly add following tag where applicable
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
   arch/powerpc/kernel/time.c:557:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:557:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:557:24: sparse:     got unsigned long long *

vim +846 arch/powerpc/kernel/time.c

4a4cfe3836916e Tony Breeds            2007-09-22  842  
d831d0b83f2058 Tony Breeds            2007-09-21  843  static int decrementer_set_next_event(unsigned long evt,
d831d0b83f2058 Tony Breeds            2007-09-21  844  				      struct clock_event_device *dev)
d831d0b83f2058 Tony Breeds            2007-09-21  845  {
6601ec1c2ba929 Christophe Leroy       2020-09-29 @846  	__this_cpu_write(decrementers_next_tb, get_tb() + evt);
d831d0b83f2058 Tony Breeds            2007-09-21  847  	set_dec(evt);
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  848  
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  849  	/* We may have raced with new irq work */
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  850  	if (test_irq_work_pending())
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  851  		set_dec(1);
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  852  
d831d0b83f2058 Tony Breeds            2007-09-21  853  	return 0;
d831d0b83f2058 Tony Breeds            2007-09-21  854  }
d831d0b83f2058 Tony Breeds            2007-09-21  855  

:::::: The code at line 846 was first introduced by commit
:::::: 6601ec1c2ba929430f5585ce7f9d9960b0e0a01d powerpc: Remove get_tb_or_rtc()

:::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
