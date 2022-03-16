Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFD4DB863
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357782AbiCPTIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiCPTId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:08:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A76E4DD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647457638; x=1678993638;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PNCuHPKbDUrwTpGcS6LTcplnq9YGjqBNouIT3gSyC/o=;
  b=EjuFWolI8YZWimqibL8/RQLfLiISZaBU8d0YHtnHtPf10mbkn7A286mT
   zRDBxnN+J0/rMtzViXFITm/VbRhw4StieoFpcpLfaXPpeFFvTC6GH2Q8L
   iCTtTAsC9Im8G1t2gBGt5ht/MnB+IQ9qP43BUI9rqhldDWeISAFilb5GY
   Ixqw899wKuO3/LN3YN6gjwT2det7Ae6Tm6aE1BvV83Azqi02Smu8n79Um
   5tPybudfsvKMugh97/Nv+qnJ4WIt4z+VvXcgLlA2Cu4pLkQiF1JSVkw8F
   5BbaA6Sp8ThM0iw4QOW2DPT7ldbJuwMKbJeC80JYJMUVh7EGl2VccmZuD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256880128"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256880128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 12:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="541057836"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2022 12:07:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUYzM-000CmK-DO; Wed, 16 Mar 2022 19:07:16 +0000
Date:   Thu, 17 Mar 2022 03:06:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 387/2335] net/sched/sch_generic.c:410:6: warning:
 no previous prototype for '__qdisc_run'
Message-ID: <202203170235.orakWDQu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 1f7534c4ddd683aee3bb596dcaa839359aa7813d [387/2335] headers/uninline: Uninline single-use function: qdisc_run()
config: i386-randconfig-a001-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170235.orakWDQu-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=1f7534c4ddd683aee3bb596dcaa839359aa7813d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 1f7534c4ddd683aee3bb596dcaa839359aa7813d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/entry/vdso/ arch/x86/pci/ kernel/ lib/ net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sched/sch_generic.c:410:6: warning: no previous prototype for '__qdisc_run' [-Wmissing-prototypes]
     410 | void __qdisc_run(struct Qdisc *q)
         |      ^~~~~~~~~~~


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
