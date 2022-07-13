Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50D573EED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiGMVYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiGMVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:24:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D417042
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657747453; x=1689283453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZjNuLmEBIpyPWeqBgSLkZ8uIlUIyFUsBrdtkJqNV6vo=;
  b=LMDaZraAPJsxOlutyfqLoS0Ue3E2PDkLEf2qINyO8wFk4TjxvyBVLP0a
   n3YMZ2vtOIzWspncP8AgdV3aGM3UyMkubTGRcP1znDt+IdaaSwYlClrhE
   adL61mmTNNMmWY4UyDbmiTTzGQVFswspY8/Vzvf2B3EdIu/Q9inPzSImL
   F7u1f8/AcfNNTr+wPfhiq/OuB2i1oOhLQZ+d+IIE8OxAjoynevoy8xNmH
   7lIIiWLduJHP3XCdpYQMtFMmlZsKtSWe7KH+zsczqswbP+JfNrmNISdNC
   lODVFv3Dse++iqeW4kTd0oAudCmU/xBj+DIOMpTb/1OgDYAbevB1fJPex
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282902551"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282902551"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 14:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="623134087"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2022 14:24:11 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBjq6-0003nm-N6;
        Wed, 13 Jul 2022 21:24:10 +0000
Date:   Thu, 14 Jul 2022 05:23:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-06 11/17] net/core/dev.c:5038: undefined
 reference to `dev_run_xdp_dequeue'
Message-ID: <202207140528.8qEWv6Hl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-06
head:   eb15b48f1b85d5986f1c2dbaf68c3c27e93f0c0c
commit: 0fb9291256bd9a2e0b9a58ce6755891bcdf21938 [11/17] dev: Add XDP dequeue hook
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220714/202207140528.8qEWv6Hl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=0fb9291256bd9a2e0b9a58ce6755891bcdf21938
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-06
        git checkout 0fb9291256bd9a2e0b9a58ce6755891bcdf21938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/core/dev.o: in function `net_tx_action':
>> net/core/dev.c:5038: undefined reference to `dev_run_xdp_dequeue'


vim +5038 net/core/dev.c

  5025	
  5026	static __latent_entropy void net_tx_action(struct softirq_action *h)
  5027	{
  5028		struct softnet_data *sd = this_cpu_ptr(&softnet_data);
  5029	
  5030		if (sd->xdp_dequeue) {
  5031			struct xdp_dequeue *deq;
  5032	
  5033			local_irq_disable();
  5034			deq = sd->xdp_dequeue;
  5035			sd->xdp_dequeue = NULL;
  5036			local_irq_enable();
  5037	
> 5038			dev_run_xdp_dequeue(deq);
  5039		}
  5040	
  5041		if (sd->completion_queue) {
  5042			struct sk_buff *clist;
  5043	
  5044			local_irq_disable();
  5045			clist = sd->completion_queue;
  5046			sd->completion_queue = NULL;
  5047			local_irq_enable();
  5048	
  5049			while (clist) {
  5050				struct sk_buff *skb = clist;
  5051	
  5052				clist = clist->next;
  5053	
  5054				WARN_ON(refcount_read(&skb->users));
  5055				if (likely(get_kfree_skb_cb(skb)->reason == SKB_REASON_CONSUMED))
  5056					trace_consume_skb(skb);
  5057				else
  5058					trace_kfree_skb(skb, net_tx_action,
  5059							SKB_DROP_REASON_NOT_SPECIFIED);
  5060	
  5061				if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
  5062					__kfree_skb(skb);
  5063				else
  5064					__kfree_skb_defer(skb);
  5065			}
  5066		}
  5067	
  5068		if (sd->output_queue) {
  5069			struct Qdisc *head;
  5070	
  5071			local_irq_disable();
  5072			head = sd->output_queue;
  5073			sd->output_queue = NULL;
  5074			sd->output_queue_tailp = &sd->output_queue;
  5075			local_irq_enable();
  5076	
  5077			rcu_read_lock();
  5078	
  5079			while (head) {
  5080				struct Qdisc *q = head;
  5081				spinlock_t *root_lock = NULL;
  5082	
  5083				head = head->next_sched;
  5084	
  5085				/* We need to make sure head->next_sched is read
  5086				 * before clearing __QDISC_STATE_SCHED
  5087				 */
  5088				smp_mb__before_atomic();
  5089	
  5090				if (!(q->flags & TCQ_F_NOLOCK)) {
  5091					root_lock = qdisc_lock(q);
  5092					spin_lock(root_lock);
  5093				} else if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED,
  5094							     &q->state))) {
  5095					/* There is a synchronize_net() between
  5096					 * STATE_DEACTIVATED flag being set and
  5097					 * qdisc_reset()/some_qdisc_is_busy() in
  5098					 * dev_deactivate(), so we can safely bail out
  5099					 * early here to avoid data race between
  5100					 * qdisc_deactivate() and some_qdisc_is_busy()
  5101					 * for lockless qdisc.
  5102					 */
  5103					clear_bit(__QDISC_STATE_SCHED, &q->state);
  5104					continue;
  5105				}
  5106	
  5107				clear_bit(__QDISC_STATE_SCHED, &q->state);
  5108				qdisc_run(q);
  5109				if (root_lock)
  5110					spin_unlock(root_lock);
  5111			}
  5112	
  5113			rcu_read_unlock();
  5114		}
  5115	
  5116		xfrm_dev_backlog(sd);
  5117	}
  5118	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
