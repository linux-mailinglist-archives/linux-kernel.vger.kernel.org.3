Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B55097EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385210AbiDUGqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385186AbiDUGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:45:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31615815
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523372; x=1682059372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JLUdpq0pV/heYP4uOV4w54641+589iXuima7EB5LNrs=;
  b=epU10phMOHxfEek7w1AZGoiiGQFqO3GPP0fo/Dk3soZR9J1DCS9IOdjw
   W6YiCTO3lganR8MygDn8rOZfi0UuH41aiLDHyQ0XVEaEfHelJ7ViwFXO2
   ITqvw57byThbupJvgx1IvucExvc9S4L9h4ZfrbiU20UYz4/F36lUWLMQH
   5QYlNszUSAlEuwrCuiBryT7MjS13PcSqrJkfIWiLfSuuoVQNkPKb7/HdA
   //e2XXxhSt++J4Wlc9FfktqMNhcrHXMJui/wq7UXQzxPfjtOoszjF0hkg
   KhxQcUBOsMGMkZ2jQnYoL7Vbao+rWcVQ245I/69P/twO7ofGwsV1R8AZd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324700358"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="324700358"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="658391479"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2022 23:42:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQWg-0007zk-Eo;
        Thu, 21 Apr 2022 06:42:50 +0000
Date:   Thu, 21 Apr 2022 14:42:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 383/2579] net/sched/sch_generic.c:410:6:
 warning: no previous prototype for '__qdisc_run'
Message-ID: <202204210355.qsD90mF8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 251150fba8c4c2b9cd65237c81874f49421476a5 [383/2579] headers/uninline: Uninline single-use function: qdisc_run()
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204210355.qsD90mF8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=251150fba8c4c2b9cd65237c81874f49421476a5
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 251150fba8c4c2b9cd65237c81874f49421476a5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/pci/ fs/crypto/ kernel/bpf/ lib/ net/ipv6/ net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sched/sch_generic.c:410:6: warning: no previous prototype for '__qdisc_run' [-Wmissing-prototypes]
     410 | void __qdisc_run(struct Qdisc *q)
         |      ^~~~~~~~~~~


vim +/__qdisc_run +410 net/sched/sch_generic.c

bbd8a0d3a3b65d3 Krishna Kumar          2009-08-06  409  
37437bb2e1ae8af David S. Miller        2008-07-16 @410  void __qdisc_run(struct Qdisc *q)
48d83325b61043e Herbert Xu             2006-06-19  411  {
3d48b53fb2ae371 Matthias Tafelmeier    2016-12-29  412  	int quota = dev_tx_weight;
b8358d70ce1066d Jesper Dangaard Brouer 2014-10-09  413  	int packets;
2ba2506ca7ca62c Herbert Xu             2008-03-28  414  
b8358d70ce1066d Jesper Dangaard Brouer 2014-10-09  415  	while (qdisc_restart(q, &packets)) {
b8358d70ce1066d Jesper Dangaard Brouer 2014-10-09  416  		quota -= packets;
b60fa1c5d01a10e Eric Dumazet           2019-10-01  417  		if (quota <= 0) {
c4fef01ba4793a8 Yunsheng Lin           2021-06-22  418  			if (q->flags & TCQ_F_NOLOCK)
c4fef01ba4793a8 Yunsheng Lin           2021-06-22  419  				set_bit(__QDISC_STATE_MISSED, &q->state);
c4fef01ba4793a8 Yunsheng Lin           2021-06-22  420  			else
37437bb2e1ae8af David S. Miller        2008-07-16  421  				__netif_schedule(q);
c4fef01ba4793a8 Yunsheng Lin           2021-06-22  422  
d90df3ad07a20cd Herbert Xu             2007-05-10  423  			break;
2ba2506ca7ca62c Herbert Xu             2008-03-28  424  		}
2ba2506ca7ca62c Herbert Xu             2008-03-28  425  	}
48d83325b61043e Herbert Xu             2006-06-19  426  }
48d83325b61043e Herbert Xu             2006-06-19  427  

:::::: The code at line 410 was first introduced by commit
:::::: 37437bb2e1ae8af470dfcd5b4ff454110894ccaf pkt_sched: Schedule qdiscs instead of netdev_queue.

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
