Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FDA50D5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiDXWkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiDXWkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:40:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2FB24F30
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650839826; x=1682375826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8WJhKWDH2PvK7MSGl4HZoh9ULfnszL8nW+xGSpbUJGU=;
  b=kLQQw593s2gsUgOg85FG6zxcpT1UAjbfuet90grM/VFNrkpMVqPRi0Do
   pG7kY9rvwozTl/FP0aqRaP7pA4lPrsJxppq6QzfReskkGIQkeVh99Ash1
   96Ev63hhA8C2lCjsrlg3BslN8WDZlviHRQkYAW+D5/rCHLFtvCtTDoOWO
   X649DOq7b39oc8GIM51HwvILnJgk84j4PC3u6UqWmZRPb5C+Z4zgLnF3T
   qO9UEQpHvtx9+/UrQramE3CRZi7eJ39plkJRucTjcONjRw6+s9Kv2YE3V
   APN0wtG0ECsBlc7QwTC4vDobocfwTTLodLHEuNMfRgXbr4uUC0sp5846s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="245659537"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="245659537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 15:37:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="729441890"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2022 15:37:04 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nikqm-0001qd-B7;
        Sun, 24 Apr 2022 22:37:04 +0000
Date:   Mon, 25 Apr 2022 06:36:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 396/2579] net/ipv4/nexthop.c:3686:32:
 sparse: sparse: dereference of noderef expression
Message-ID: <202204250600.UokLwrwL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 8c7e5c008072b19524ab8d9e3555cef82962c3ce [396/2579] headers/uninline: Uninline multi-use function: rb_link_node() and rb_link_node_rcu()
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220425/202204250600.UokLwrwL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=8c7e5c008072b19524ab8d9e3555cef82962c3ce
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 8c7e5c008072b19524ab8d9e3555cef82962c3ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash mm/ net/ipv4/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
