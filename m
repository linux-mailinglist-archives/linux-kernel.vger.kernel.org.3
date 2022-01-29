Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A09C4A2D9F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 11:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbiA2KZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 05:25:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:22056 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbiA2KZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 05:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643451957; x=1674987957;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sXnnCGn/3jPRr3t/1zs7nws/AN/8Xwhv4EBUtRGrj6Y=;
  b=VmMmyFw4pOIwPr+yFBu3rswbHTtXN40VUqv9TnvGAMASu2KNA8ZkIwBo
   L1VT72mIR0zVfg9wVJM0NL6o+Kh9GnSIr1kyMWKS+AB9E07khUSzzJN7f
   BMWWDa+WpE+ZOIRWPmDHDjDhuSRqeTr6k6qTwxgN7y84NbivWBDPmvNw2
   cO9Z1IWTEhUsmLUcQCLMGoj0SIwHBg7L27ZroEjYiiSFVD9pXRDkzPp75
   70z2SM1IYesGY1t52AXMCRVZqzCDPH87s5ff3Ts5HyDt/KW5x3GAhS83z
   6PPg7o5l0VXOHWBv1Dv64rZSiapC58zqwFIXCaQAfjEhjHsYbNcZ6WS8e
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247481937"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="247481937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 02:25:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="629388306"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2022 02:25:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDkva-000P48-Gv; Sat, 29 Jan 2022 10:25:54 +0000
Date:   Sat, 29 Jan 2022 18:25:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: net/ipv4/tcp_cong.c:238:22: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202201291808.JSpyvEVe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   169387e2aa291a4e3cb856053730fe99d6cec06f
commit: e188f3330a13df904d77003846eafd3edf99009d ARC: cmpxchg/xchg: rewrite as macros to make type safe
date:   5 months ago
config: arc-randconfig-s031-20220129 (https://download.01.org/0day-ci/archive/20220129/202201291808.JSpyvEVe-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e188f3330a13df904d77003846eafd3edf99009d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e188f3330a13df904d77003846eafd3edf99009d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash net/ipv4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/ipv4/tcp_cong.c:238:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tcp_congestion_ops const [noderef] __rcu *_val_ @@     got struct tcp_congestion_ops *[assigned] ca @@
   net/ipv4/tcp_cong.c:238:24: sparse:     expected struct tcp_congestion_ops const [noderef] __rcu *_val_
   net/ipv4/tcp_cong.c:238:24: sparse:     got struct tcp_congestion_ops *[assigned] ca
>> net/ipv4/tcp_cong.c:238:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tcp_congestion_ops const *prev @@     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] _val_ @@
   net/ipv4/tcp_cong.c:238:22: sparse:     expected struct tcp_congestion_ops const *prev
   net/ipv4/tcp_cong.c:238:22: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] _val_

vim +238 net/ipv4/tcp_cong.c

317a76f9a44b43 Stephen Hemminger 2005-06-23  219  
317a76f9a44b43 Stephen Hemminger 2005-06-23  220  /* Used by sysctl to change default congestion control */
6670e152447732 Stephen Hemminger 2017-11-14  221  int tcp_set_default_congestion_control(struct net *net, const char *name)
317a76f9a44b43 Stephen Hemminger 2005-06-23  222  {
317a76f9a44b43 Stephen Hemminger 2005-06-23  223  	struct tcp_congestion_ops *ca;
6670e152447732 Stephen Hemminger 2017-11-14  224  	const struct tcp_congestion_ops *prev;
6670e152447732 Stephen Hemminger 2017-11-14  225  	int ret;
317a76f9a44b43 Stephen Hemminger 2005-06-23  226  
6670e152447732 Stephen Hemminger 2017-11-14  227  	rcu_read_lock();
6670e152447732 Stephen Hemminger 2017-11-14  228  	ca = tcp_ca_find_autoload(net, name);
6670e152447732 Stephen Hemminger 2017-11-14  229  	if (!ca) {
6670e152447732 Stephen Hemminger 2017-11-14  230  		ret = -ENOENT;
0baf26b0fcd74b Martin KaFai Lau  2020-01-08  231  	} else if (!bpf_try_module_get(ca, ca->owner)) {
6670e152447732 Stephen Hemminger 2017-11-14  232  		ret = -EBUSY;
8d432592f30fcc Jonathon Reinhart 2021-05-01  233  	} else if (!net_eq(net, &init_net) &&
8d432592f30fcc Jonathon Reinhart 2021-05-01  234  			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
8d432592f30fcc Jonathon Reinhart 2021-05-01  235  		/* Only init netns can set default to a restricted algorithm */
8d432592f30fcc Jonathon Reinhart 2021-05-01  236  		ret = -EPERM;
6670e152447732 Stephen Hemminger 2017-11-14  237  	} else {
6670e152447732 Stephen Hemminger 2017-11-14 @238  		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
6670e152447732 Stephen Hemminger 2017-11-14  239  		if (prev)
0baf26b0fcd74b Martin KaFai Lau  2020-01-08  240  			bpf_module_put(prev, prev->owner);
317a76f9a44b43 Stephen Hemminger 2005-06-23  241  
6670e152447732 Stephen Hemminger 2017-11-14  242  		ca->flags |= TCP_CONG_NON_RESTRICTED;
317a76f9a44b43 Stephen Hemminger 2005-06-23  243  		ret = 0;
317a76f9a44b43 Stephen Hemminger 2005-06-23  244  	}
6670e152447732 Stephen Hemminger 2017-11-14  245  	rcu_read_unlock();
317a76f9a44b43 Stephen Hemminger 2005-06-23  246  
317a76f9a44b43 Stephen Hemminger 2005-06-23  247  	return ret;
317a76f9a44b43 Stephen Hemminger 2005-06-23  248  }
317a76f9a44b43 Stephen Hemminger 2005-06-23  249  

:::::: The code at line 238 was first introduced by commit
:::::: 6670e152447732ba90626f36dfc015a13fbf150e tcp: Namespace-ify sysctl_tcp_default_congestion_control

:::::: TO: Stephen Hemminger <stephen@networkplumber.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
