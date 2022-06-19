Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D725508F7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 08:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiFSGgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiFSGgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 02:36:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D75F69
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655620608; x=1687156608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yNPXkNrQ39aVeyfK6a4n71ndujwklD+5/8trDPKy6j8=;
  b=jpLeoKHQhbVSDRc8DvM+gBsWRBAxCfq1zUGFK7efQ4WfnuZzpJj8Uqlf
   HHn7Owi0ff1IrgIZwfLhUFPJEa/sTOD6I9fw62l0sN1fScU4FThddM8n2
   4XdvZG2Q8IQHwrK79XNV9V9ICzF5qoD01bVBmnLec9QG2Q7yWbn8dgm3q
   boNCTpnZvaISMrSfuF2e4+g+AR6iIpAyzoSlIBgwlfFHUyqxG8Xk4kbQo
   PMIIKuUn5UXXXUaZfXlX4GfKoUM1Qr6i8KxOmRLr5N1/nqs7TwWkTjKkd
   NcVRe00MwS5le7/l9EBEABsseZwZWqgNFfOFkIQCskCEH1UGpSYCJVpwj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305138619"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305138619"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 23:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688964754"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2022 23:36:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2oYA-000Qvd-Pi;
        Sun, 19 Jun 2022 06:36:46 +0000
Date:   Sun, 19 Jun 2022 14:36:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta4 2/2] net/core/dev.c:3968:44: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202206191401.lhKuX4Q0-lkp@intel.com>
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

tree:   https://github.com/cilium/linux.git pr/meta4
head:   dcea837b60f0d9f8f3cdae284680659042f560d1
commit: dcea837b60f0d9f8f3cdae284680659042f560d1 [2/2] bpf: Add fd-based API to attach tc BPF programs
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220619/202206191401.lhKuX4Q0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/cilium/linux/commit/dcea837b60f0d9f8f3cdae284680659042f560d1
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta4
        git checkout dcea837b60f0d9f8f3cdae284680659042f560d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/core/ net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/core/dev.c:3323:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
   net/core/dev.c:3323:23: sparse:     expected restricted __wsum [usertype] csum
   net/core/dev.c:3323:23: sparse:     got unsigned int
   net/core/dev.c:3323:23: sparse: sparse: cast from restricted __wsum
>> net/core/dev.c:3968:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sch_entry *entry @@     got struct sch_entry [noderef] __rcu *sch_ingress @@
   net/core/dev.c:3968:44: sparse:     expected struct sch_entry *entry
   net/core/dev.c:3968:44: sparse:     got struct sch_entry [noderef] __rcu *sch_ingress
>> net/core/dev.c:4008:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sch_entry *entry @@     got struct sch_entry [noderef] __rcu *sch_egress @@
   net/core/dev.c:4008:44: sparse:     expected struct sch_entry *entry
   net/core/dev.c:4008:44: sparse:     got struct sch_entry [noderef] __rcu *sch_egress
   net/core/dev.c:3827:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
   net/core/dev.c:5199:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
--
>> net/sched/sch_ingress.c:91:66: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct mini_Qdisc [noderef] __rcu **p_miniq @@     got struct mini_Qdisc ** @@
   net/sched/sch_ingress.c:91:66: sparse:     expected struct mini_Qdisc [noderef] __rcu **p_miniq
   net/sched/sch_ingress.c:91:66: sparse:     got struct mini_Qdisc **
   net/sched/sch_ingress.c:241:74: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct mini_Qdisc [noderef] __rcu **p_miniq @@     got struct mini_Qdisc ** @@
   net/sched/sch_ingress.c:241:74: sparse:     expected struct mini_Qdisc [noderef] __rcu **p_miniq
   net/sched/sch_ingress.c:241:74: sparse:     got struct mini_Qdisc **
   net/sched/sch_ingress.c:261:73: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct mini_Qdisc [noderef] __rcu **p_miniq @@     got struct mini_Qdisc ** @@
   net/sched/sch_ingress.c:261:73: sparse:     expected struct mini_Qdisc [noderef] __rcu **p_miniq
   net/sched/sch_ingress.c:261:73: sparse:     got struct mini_Qdisc **

vim +3968 net/core/dev.c

  3955	
  3956	#ifdef CONFIG_NET_XGRESS
  3957	#ifdef CONFIG_NET_CLS_ACT
  3958	unsigned int sch_cls_ingress(const void *pskb, const struct bpf_insn *null)
  3959	{
  3960		struct sk_buff *skb = (void *)pskb;
  3961		struct mini_Qdisc *miniq;
  3962		struct tcf_result res;
  3963		int ret;
  3964	
  3965		tc_skb_cb(skb)->mru = 0;
  3966		tc_skb_cb(skb)->post_ct = false;
  3967	
> 3968		miniq = dev_sch_entry_pair(skb->dev->sch_ingress)->miniq;
  3969		if (!miniq)
  3970			return TC_ACT_UNSPEC;
  3971		mini_qdisc_bstats_cpu_update(miniq, skb);
  3972		__skb_pull(skb, skb->mac_len);
  3973		ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
  3974		__skb_push(skb, skb->mac_len);
  3975		/* Only tcf related quirks below. */
  3976		switch (ret) {
  3977		case TC_ACT_SHOT:
  3978			mini_qdisc_qstats_cpu_drop(miniq);
  3979			break;
  3980		case TC_ACT_OK:
  3981		case TC_ACT_RECLASSIFY:
  3982			skb->tc_index = TC_H_MIN(res.classid);
  3983			ret = TC_ACT_OK;
  3984			break;
  3985		case TC_ACT_STOLEN:
  3986		case TC_ACT_QUEUED:
  3987		case TC_ACT_TRAP:
  3988			ret = TC_ACT_CONSUMED;
  3989			break;
  3990		case TC_ACT_CONSUMED:
  3991			/* Bump refcount given skb is now in use elsewhere. */
  3992			skb_get(skb);
  3993			break;
  3994		}
  3995		return ret;
  3996	}
  3997	
  3998	unsigned int sch_cls_egress(const void *pskb, const struct bpf_insn *null)
  3999	{
  4000		struct sk_buff *skb = (void *)pskb;
  4001		struct mini_Qdisc *miniq;
  4002		struct tcf_result res;
  4003		int ret;
  4004	
  4005		tc_skb_cb(skb)->mru = 0;
  4006		tc_skb_cb(skb)->post_ct = false;
  4007	
> 4008		miniq = dev_sch_entry_pair(skb->dev->sch_egress)->miniq;
  4009		if (!miniq)
  4010			return TC_ACT_UNSPEC;
  4011		mini_qdisc_bstats_cpu_update(miniq, skb);
  4012		ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, false);
  4013		/* Only tcf related quirks below. */
  4014		switch (ret) {
  4015		case TC_ACT_SHOT:
  4016			mini_qdisc_qstats_cpu_drop(miniq);
  4017			break;
  4018		case TC_ACT_OK:
  4019		case TC_ACT_RECLASSIFY:
  4020			skb->tc_index = TC_H_MIN(res.classid);
  4021			ret = TC_ACT_OK;
  4022			break;
  4023		case TC_ACT_STOLEN:
  4024		case TC_ACT_QUEUED:
  4025		case TC_ACT_TRAP:
  4026			ret = TC_ACT_CONSUMED;
  4027			break;
  4028		case TC_ACT_CONSUMED:
  4029			/* Bump refcount given skb is now in use elsewhere. */
  4030			skb_get(skb);
  4031			break;
  4032		}
  4033		return ret;
  4034	}
  4035	#endif /* CONFIG_NET_CLS_ACT */
  4036	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
