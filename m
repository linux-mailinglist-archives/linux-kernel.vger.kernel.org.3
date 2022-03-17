Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9E4DC5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiCQMSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiCQMSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:18:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B087E1E1106
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647519441; x=1679055441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hK8boUgXbx+/ko92grSQiQLOAam5hASxF0qf73e9Erw=;
  b=VX9qz5sjN06j5BwiU8H6AE5btEQpfJyYj8IB/gpn5IOaBh8GeaaHHKRl
   wd2czRxXXpe9IPR/EfAeC7qglPraiqmdwsxJx6eid4SyWM8ZMIt0W5Al5
   KcDhrfcZlSfybAilKUeGHTWZTctIlFljc96KNi7GYrOtgYe9zMktMWyJ9
   LJixnFtRntURgBsRD2xQw8YlsuVluZwz4tnDptdyxsr4jZTMOZ6YbX+8f
   qgpDO4Z1tTNvreT9O3yIVOuZLIeM5BkOkAqD+TyTS+KnxyxNAoZz5EbKR
   7Trh7U9p1sLXPTOrV7WH9BiuMqZ3sdIw1tyA1+arus2RT7AK7VubQd/yz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256579035"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256579035"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 05:17:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="581274915"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2022 05:17:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUp49-000DfC-RF; Thu, 17 Mar 2022 12:17:17 +0000
Date:   Thu, 17 Mar 2022 20:16:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 387/2335] net/sched/sch_generic.c:410:6: warning:
 no previous prototype for function '__qdisc_run'
Message-ID: <202203172048.n3XEqR9I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 1f7534c4ddd683aee3bb596dcaa839359aa7813d [387/2335] headers/uninline: Uninline single-use function: qdisc_run()
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220317/202203172048.n3XEqR9I-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=1f7534c4ddd683aee3bb596dcaa839359aa7813d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 1f7534c4ddd683aee3bb596dcaa839359aa7813d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/entry/vsyscall/ arch/x86/kernel/cpu/mtrr/ arch/x86/pci/ kernel/bpf/ kernel/trace/ lib/ net/ipv6/ net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sched/sch_generic.c:410:6: warning: no previous prototype for function '__qdisc_run' [-Wmissing-prototypes]
   void __qdisc_run(struct Qdisc *q)
        ^
   net/sched/sch_generic.c:410:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __qdisc_run(struct Qdisc *q)
   ^
   static 
   1 warning generated.


vim +/__qdisc_run +410 net/sched/sch_generic.c

bbd8a0d3a3b65d Krishna Kumar          2009-08-06  409  
37437bb2e1ae8a David S. Miller        2008-07-16 @410  void __qdisc_run(struct Qdisc *q)
48d83325b61043 Herbert Xu             2006-06-19  411  {
3d48b53fb2ae37 Matthias Tafelmeier    2016-12-29  412  	int quota = dev_tx_weight;
b8358d70ce1066 Jesper Dangaard Brouer 2014-10-09  413  	int packets;
2ba2506ca7ca62 Herbert Xu             2008-03-28  414  
b8358d70ce1066 Jesper Dangaard Brouer 2014-10-09  415  	while (qdisc_restart(q, &packets)) {
b8358d70ce1066 Jesper Dangaard Brouer 2014-10-09  416  		quota -= packets;
b60fa1c5d01a10 Eric Dumazet           2019-10-01  417  		if (quota <= 0) {
c4fef01ba4793a Yunsheng Lin           2021-06-22  418  			if (q->flags & TCQ_F_NOLOCK)
c4fef01ba4793a Yunsheng Lin           2021-06-22  419  				set_bit(__QDISC_STATE_MISSED, &q->state);
c4fef01ba4793a Yunsheng Lin           2021-06-22  420  			else
37437bb2e1ae8a David S. Miller        2008-07-16  421  				__netif_schedule(q);
c4fef01ba4793a Yunsheng Lin           2021-06-22  422  
d90df3ad07a20c Herbert Xu             2007-05-10  423  			break;
2ba2506ca7ca62 Herbert Xu             2008-03-28  424  		}
2ba2506ca7ca62 Herbert Xu             2008-03-28  425  	}
48d83325b61043 Herbert Xu             2006-06-19  426  }
48d83325b61043 Herbert Xu             2006-06-19  427  

:::::: The code at line 410 was first introduced by commit
:::::: 37437bb2e1ae8af470dfcd5b4ff454110894ccaf pkt_sched: Schedule qdiscs instead of netdev_queue.

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
