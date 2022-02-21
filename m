Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A04BE204
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354835AbiBUKb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:31:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355057AbiBUKav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:30:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908FF6A04A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645437132; x=1676973132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C7P41dHaDHZTC6Y6Q9L7XgLflEr6ye2MKtW+2lEOfUI=;
  b=FbtyvSww806OfGO7zOc6eRbBRQ9Zpi6FlxoR3LUMI6TE28E7nUi8IQ9z
   gSCM8F9LWcauAsBiOOQHFqs1kca454YyMA/wIAHQqUdGNEuV62XpBYfbZ
   m4CQLD1/mxy3RDvnRJtmg7+Q6fonEEJDRUIgqpG/Tn2G8P0dtzQZe+XDz
   OIEZ1630QhWRMoUMlHVnUjm5PVTS79+A5qIrS3kyAaY3iRFYhZUO2CFVL
   18G0uXPnXCoPI2wilkN1Ouj/gHLLyMA0AjNFIkzuNaGFceslx5IX0z2yD
   qzMWJgLER7QSHqEM65pM0krJ5jPQtDYyuQkeafD+1M0n79QRyYp2dnzL/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="231445714"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="231445714"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 01:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="638501931"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2022 01:52:11 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM5MY-0001Tq-ER; Mon, 21 Feb 2022 09:52:10 +0000
Date:   Mon, 21 Feb 2022 17:51:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 400/2574] net/ipv4/nexthop.c:3686:32:
 sparse: sparse: dereference of noderef expression
Message-ID: <202202211705.vXSB551U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   39e8a0edc8fae20758051dadf7846849edc18b88
commit: 1458e29daa7f391e80f5d3f837586c6df551c740 [400/2574] headers/uninline: Uninline multi-use function: rb_link_node() and rb_link_node_rcu()
config: x86_64-randconfig-s022-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211705.vXSB551U-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=1458e29daa7f391e80f5d3f837586c6df551c740
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 1458e29daa7f391e80f5d3f837586c6df551c740
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/vsyscall/ drivers/hwspinlock/ net/ipv4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/ipv4/nexthop.c:3686:32: sparse: sparse: dereference of noderef expression

vim +3686 net/ipv4/nexthop.c

e95f2592f633a3 Ido Schimmel 2020-11-04  3667  
56ad5ba344dea9 Ido Schimmel 2021-03-11  3668  void nexthop_bucket_set_hw_flags(struct net *net, u32 id, u16 bucket_index,
56ad5ba344dea9 Ido Schimmel 2021-03-11  3669  				 bool offload, bool trap)
56ad5ba344dea9 Ido Schimmel 2021-03-11  3670  {
56ad5ba344dea9 Ido Schimmel 2021-03-11  3671  	struct nh_res_table *res_table;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3672  	struct nh_res_bucket *bucket;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3673  	struct nexthop *nexthop;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3674  	struct nh_group *nhg;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3675  
56ad5ba344dea9 Ido Schimmel 2021-03-11  3676  	rcu_read_lock();
56ad5ba344dea9 Ido Schimmel 2021-03-11  3677  
56ad5ba344dea9 Ido Schimmel 2021-03-11  3678  	nexthop = nexthop_find_by_id(net, id);
56ad5ba344dea9 Ido Schimmel 2021-03-11  3679  	if (!nexthop || !nexthop->is_group)
56ad5ba344dea9 Ido Schimmel 2021-03-11  3680  		goto out;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3681  
56ad5ba344dea9 Ido Schimmel 2021-03-11  3682  	nhg = rcu_dereference(nexthop->nh_grp);
56ad5ba344dea9 Ido Schimmel 2021-03-11  3683  	if (!nhg->resilient)
56ad5ba344dea9 Ido Schimmel 2021-03-11  3684  		goto out;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3685  
56ad5ba344dea9 Ido Schimmel 2021-03-11 @3686  	if (bucket_index >= nhg->res_table->num_nh_buckets)
56ad5ba344dea9 Ido Schimmel 2021-03-11  3687  		goto out;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3688  
56ad5ba344dea9 Ido Schimmel 2021-03-11  3689  	res_table = rcu_dereference(nhg->res_table);
56ad5ba344dea9 Ido Schimmel 2021-03-11  3690  	bucket = &res_table->nh_buckets[bucket_index];
56ad5ba344dea9 Ido Schimmel 2021-03-11  3691  	bucket->nh_flags &= ~(RTNH_F_OFFLOAD | RTNH_F_TRAP);
56ad5ba344dea9 Ido Schimmel 2021-03-11  3692  	if (offload)
56ad5ba344dea9 Ido Schimmel 2021-03-11  3693  		bucket->nh_flags |= RTNH_F_OFFLOAD;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3694  	if (trap)
56ad5ba344dea9 Ido Schimmel 2021-03-11  3695  		bucket->nh_flags |= RTNH_F_TRAP;
56ad5ba344dea9 Ido Schimmel 2021-03-11  3696  
56ad5ba344dea9 Ido Schimmel 2021-03-11  3697  out:
56ad5ba344dea9 Ido Schimmel 2021-03-11  3698  	rcu_read_unlock();
56ad5ba344dea9 Ido Schimmel 2021-03-11  3699  }
56ad5ba344dea9 Ido Schimmel 2021-03-11  3700  EXPORT_SYMBOL(nexthop_bucket_set_hw_flags);
56ad5ba344dea9 Ido Schimmel 2021-03-11  3701  

:::::: The code at line 3686 was first introduced by commit
:::::: 56ad5ba344dea9c914331da8754f5ba7cede9941 nexthop: Allow setting "offload" and "trap" indication of nexthop buckets

:::::: TO: Ido Schimmel <idosch@nvidia.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
