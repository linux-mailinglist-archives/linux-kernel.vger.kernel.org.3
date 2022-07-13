Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5357354D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiGMLZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbiGMLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:24:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82E71014AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657711497; x=1689247497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xA6De5du1h40WQGQhyOrLijvhmThcZKzStWUuRAh97k=;
  b=DbLYpd8p6MCD5wdNKHtkJzkuXMmsPEnrQOjxhvp6v3YCoInjaFikYvWg
   5XZuXPEaQsWNa7QJ8Jzz7VbXPdHOF2NEHuUw80uAPJk99ivXW6zl11pDH
   ZXS+UQFhIlI/VH3ZAqUkzKk0p2HtU4MpUbnxnrafoKqkEU3zLqXc8ifqT
   U2VK5AGd++ZnYSsZiUty7bitm5OFZB/76P81jD55k0QwxKRQNJQM6zENL
   E7QDnjuG5abPbcPRWYJ+0rksT+W0fK/+QzvdcQJgvI4+oV70+AAOBa8hV
   u6JvFqMRMFiCtR973qQfrxP1+t6wPnZSKvvQouB9ERyEGiPYZT5DTr0Qg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="371497259"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="371497259"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 04:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="737841061"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2022 04:24:56 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBaUB-0003Pl-PZ;
        Wed, 13 Jul 2022 11:24:55 +0000
Date:   Wed, 13 Jul 2022 19:24:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta5 4/4] kernel/bpf/net.c:52:28: warning: variable
 'peer' is uninitialized when used here
Message-ID: <202207131933.oKjzatHd-lkp@intel.com>
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

tree:   https://github.com/cilium/linux.git pr/meta5
head:   3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
commit: 3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5 [4/4] bpf: Add fd-based API to attach tc BPF programs
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220713/202207131933.oKjzatHd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e60b4fb2b777118c0ff664a6347851df14fcf75b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/cilium/linux/commit/3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta5
        git checkout 3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/net.c:52:28: warning: variable 'peer' is uninitialized when used here [-Wuninitialized]
                                   dev_sch_entry_prio_set(peer, prio, nprog);
                                                          ^~~~
   kernel/bpf/net.c:33:32: note: initialize the variable 'peer' to silence this warning
           struct sch_entry *entry, *peer;
                                         ^
                                          = NULL
   1 warning generated.


vim +/peer +52 kernel/bpf/net.c

    28	
    29	static int __sch_prog_attach(struct net_device *dev, bool ingress, u32 limit,
    30				     struct bpf_prog *nprog, u32 prio, u32 flags)
    31	{
    32		struct bpf_prog_array_item *item, *tmp;
    33		struct sch_entry *entry, *peer;
    34		struct bpf_prog *oprog;
    35		bool created;
    36		int i, j;
    37	
    38		entry = dev_sch_entry_fetch(dev, ingress, &created);
    39		if (!entry)
    40			return -ENOMEM;
    41		for (i = 0; i < limit; i++) {
    42			item = &entry->items[i];
    43			oprog = item->prog;
    44			if (!oprog)
    45				break;
    46			if (item->bpf_priority == prio) {
    47				if (flags & BPF_F_REPLACE) {
    48					/* Pairs with READ_ONCE() in sch_run_progs(). */
    49					WRITE_ONCE(item->prog, nprog);
    50					if (sch_prog_refcounted(oprog))
    51						bpf_prog_put(oprog);
  > 52					dev_sch_entry_prio_set(peer, prio, nprog);
    53					return prio;
    54				}
    55				return -EBUSY;
    56			}
    57		}
    58		if (dev_sch_entry_total(entry) >= limit)
    59			return -ENOSPC;
    60		prio = dev_sch_entry_prio_new(entry, prio, nprog);
    61		if (prio < 0) {
    62			if (created)
    63				dev_sch_entry_free(entry);
    64			return -ENOMEM;
    65		}
    66		peer = dev_sch_entry_peer(entry);
    67		dev_sch_entry_clear(peer);
    68		for (i = 0, j = 0; i < limit; i++, j++) {
    69			item = &entry->items[i];
    70			tmp = &peer->items[j];
    71			oprog = item->prog;
    72			if (!oprog) {
    73				if (i == j) {
    74					tmp->prog = nprog;
    75					tmp->bpf_priority = prio;
    76				}
    77				break;
    78			} else if (item->bpf_priority < prio) {
    79				tmp->prog = oprog;
    80				tmp->bpf_priority = item->bpf_priority;
    81			} else if (item->bpf_priority > prio) {
    82				if (i == j) {
    83					tmp->prog = nprog;
    84					tmp->bpf_priority = prio;
    85					tmp = &peer->items[++j];
    86				}
    87				tmp->prog = oprog;
    88				tmp->bpf_priority = item->bpf_priority;
    89			}
    90		}
    91		dev_sch_entry_update(dev, peer, ingress);
    92		if (ingress)
    93			net_inc_ingress_queue();
    94		else
    95			net_inc_egress_queue();
    96		return prio;
    97	}
    98	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
