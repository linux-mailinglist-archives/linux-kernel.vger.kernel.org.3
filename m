Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17419573F78
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbiGMWO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGMWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:14:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C8010FFB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657750463; x=1689286463;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LxF5dNYwv2JF3tqJP2zIWAqU9FX32I+h9OJ6Z1kjSxA=;
  b=T9DcbpG7bPrJlQJEqZ2DLErxrDkRZLwnLl1LwbRt0Rkna5hks/DMnmgT
   9qembomDuOwUsSwUj3lrkxyMAAMsTtExn9g6/0ST7RLTalB1GEFZ7BVn9
   Pb8gLjAEMPz9j86+GPvJxjm5+FGwMe9OwEJNypDlJgtLlv+tDTaP6DNJk
   fgp7fx4Z9jYJe+g8QJJ+0uHOtuTMeUfAI/u0+knNZZDGJ0M7mfsGOcLR8
   aGkDJS2XsB9bsEaMPFIx+QkO69RzOH7Qu9kN2nl9FVCUncdZKDpxPU821
   1/cWaZbgdyzZFOeOKj/9sQCRkHRvtOsHPvt+6w9Wqsle+VYRAcI5381m8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="349327538"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="349327538"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 15:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="922818692"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2022 15:14:21 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBkce-0003qH-Kd;
        Wed, 13 Jul 2022 22:14:20 +0000
Date:   Thu, 14 Jul 2022 06:14:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-06 12/17] net/core/filter.c:4450: undefined
 reference to `dev_schedule_xdp_dequeue'
Message-ID: <202207140654.OfCix8dN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-06
head:   eb15b48f1b85d5986f1c2dbaf68c3c27e93f0c0c
commit: a32ddb0c8337335ecce0a6a4f2f86297906ea5e5 [12/17] bpf: Add helper to schedule an interface for TX dequeue
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220714/202207140654.OfCix8dN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=a32ddb0c8337335ecce0a6a4f2f86297906ea5e5
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-06
        git checkout a32ddb0c8337335ecce0a6a4f2f86297906ea5e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/core/dev.o: in function `net_tx_action':
   net/core/dev.c:5038: undefined reference to `dev_run_xdp_dequeue'
   ld: net/core/filter.o: in function `bpf_schedule_iface_dequeue':
>> net/core/filter.c:4450: undefined reference to `dev_schedule_xdp_dequeue'


vim +4450 net/core/filter.c

  4433	
  4434	static int bpf_schedule_iface_dequeue(struct net *net, int ifindex, int flags)
  4435	{
  4436		struct net_device *dev;
  4437		struct bpf_prog *prog;
  4438	
  4439		if (flags)
  4440			return -EINVAL;
  4441	
  4442		dev = dev_get_by_index_rcu(net, ifindex);
  4443		if (!dev)
  4444			return -ENODEV;
  4445	
  4446		prog = rcu_dereference(dev->xdp_dequeue_prog);
  4447		if (!prog)
  4448			return -ENOENT;
  4449	
> 4450		dev_schedule_xdp_dequeue(dev);
  4451		return 0;
  4452	}
  4453	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
