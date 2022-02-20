Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492164BD2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 01:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiBTX71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 18:59:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245334AbiBTX7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 18:59:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C8517D6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645401540; x=1676937540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h9OBvVxeTFGz3g/o4EcQ8VBHngG7EV8AugMhIE98HEk=;
  b=Fi9rWWR8WOCyqe5RiXR8YnPIygp+jCbL6Fe6ByytpJ3vcSSzkn56RrrP
   Xyk3cYN2t84ad6pGihZqyBGQQ18ChuYLoCiB4Pa7Nsvvorf96NJdKobQU
   xo9w82Zyl/CzJvZfedkX9p3+8Fzk9mckCcxiaHGn+XTV5fXfM8KYC/J3h
   bm4a73zNwBT+N8arHn2ds+DQsezGscA5PcGQS32YlroRJ/0dV5g/ST6tG
   0txQMKlC79ZIjR1K1hgqeqcijG8YEgnL4fi5QAoVWldDhbpExnUIt4kkZ
   3eZyLDqgu62rrvdg3LsnxfIZj8pT3uVWeXnWPatvos9wmkb831sUxiFHO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="234950987"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="234950987"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 15:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="638367088"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2022 15:58:58 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLw6T-00012r-P1; Sun, 20 Feb 2022 23:58:57 +0000
Date:   Mon, 21 Feb 2022 07:58:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 387/2574] net/sched/sch_generic.c:410:6:
 warning: no previous prototype for function '__qdisc_run'
Message-ID: <202202210711.TSsBtE2b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: f54bcd14bfddfcc8eb987098f25589b074600c5f [387/2574] headers/uninline: Uninline single-use function: qdisc_run()
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220221/202202210711.TSsBtE2b-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f54bcd14bfddfcc8eb987098f25589b074600c5f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout f54bcd14bfddfcc8eb987098f25589b074600c5f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ arch/x86/pci/ kernel/bpf/ kernel/sched/ kernel/trace/ lib/ net/ipv6/ net/sched/

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
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
