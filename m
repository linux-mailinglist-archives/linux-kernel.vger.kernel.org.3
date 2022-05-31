Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACC538F66
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiEaLBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237843AbiEaLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:01:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21B98596
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653994870; x=1685530870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UE12GZEVRy/pdc4rAVZ9gZx8sKWZjEwZJ3yeLoXYo48=;
  b=cGVlHXuHyf65fdubCCb2R8Ef1cHPxpBPCLTsSaUEveG7i+7rzrOr7LMO
   gfbhrruvo/HrTwe4WX9TwDECMRYHfGUu1VuHpiHk76IPjE+DSy6KxeCqn
   m2+zdniWnJq7Q52Bq4IudHhWUPnR60cj8Fr+pIqh+/1xQOlv8O+f/qcwj
   0kl+RtPNZ8zPHFPJUNlvo8xWgBqZS787FqAPbIv0RJ5d37Sj7kzX2Wy5/
   Dmz4Pubz8B/PIjVqRTLR+lLs+kzecR0T3NWIoNclI4Pfgb7JXEDEDXq/J
   v1cLucm/w6YxGAHXVKZE/Kp3Z5K125eBMm4rWAWa8QyNTsC3DHcDPFoTq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="300568067"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="300568067"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 04:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="611786344"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 May 2022 04:01:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvzcZ-0002ck-81;
        Tue, 31 May 2022 11:01:07 +0000
Date:   Tue, 31 May 2022 19:00:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 3/5] net/core/skb_map.c:414:21: warning: cast to
 pointer from integer of different size
Message-ID: <202205311853.M58G3t1Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   88a2f876b0736617600bfaa2301dbfdaaa139ddd
commit: 03e158bc84030847ce9f7bf91b1221079c194f3d [3/5] bpf: introduce skb map
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220531/202205311853.M58G3t1Z-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/congwang/linux/commit/03e158bc84030847ce9f7bf91b1221079c194f3d
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout 03e158bc84030847ce9f7bf91b1221079c194f3d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   net/core/skb_map.c: In function '____bpf_flow_map_pop':
>> net/core/skb_map.c:414:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     414 |         u64 rank = *(u64 *) key;
         |                     ^
   net/core/skb_map.c: In function '____bpf_flow_map_push':
   net/core/skb_map.c:460:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     460 |         u64 rank = *(u64 *) key;
         |                     ^


vim +414 net/core/skb_map.c

   410	
   411	BPF_CALL_2(bpf_flow_map_pop, struct bpf_map *, map, u64, key)
   412	{
   413		struct bpf_skb_map *rb = bpf_skb_map(map);
 > 414		u64 rank = *(u64 *) key;
   415		struct bpf_map *target;
   416		unsigned long flags;
   417	
   418		raw_spin_lock_irqsave(&rb->lock, flags);
   419		target = map_rb_find(&rb->root, rank);
   420		if (!target) {
   421			raw_spin_unlock_irqrestore(&rb->lock, flags);
   422			return (unsigned long)NULL;
   423		}
   424		rb_erase(&bpf_skb_map(target)->node, &rb->root);
   425		raw_spin_unlock_irqrestore(&rb->lock, flags);
   426		atomic_dec(&rb->count);
   427		return (unsigned long)target;
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
