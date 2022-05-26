Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56467534D86
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiEZKr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiEZKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:47:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96FCC8BF4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653562043; x=1685098043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JayfP7bGY4GB3mKUqfSZGN0c7PEfGDDPQO6IO3FGCBs=;
  b=EjawhkQfD1qNfGsBpK86w0HYMi83kF+YmuIWmeYyZUS/5/sWd5nwvin0
   YJoZFbINXMV3fuCyl8agx1HT9ivr0kk0w2X8YPs2NZ3qbGWM9cz52Y0E/
   oYky6iIAYhahLVf9j+F+S8+IFYRjCfuI5JZAQ0BvjkIfVuV3PxY7V48lf
   YtD2/qxnNpqnrZHjZVMaa072c167UsbEZ+fAyfh/Oy+bUs2GsZeeJiERA
   qBro/TWf37mpJaHZdjV7gtbvL+aERvMlulVAghZOwD3thm186pmk9oFFc
   8X+iFAn+DfeoOKA4ado9vOJ/1bUe7HExuc2BoD5v7rfxnYQ1nL3itPoRh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="253989623"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="253989623"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 03:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="549509006"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2022 03:46:58 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuB17-0003nI-K5;
        Thu, 26 May 2022 10:46:57 +0000
Date:   Thu, 26 May 2022 18:46:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 3/4] net/sched/sch_bpf.c:120:19: sparse: sparse:
 incompatible types in comparison expression (different address spaces):
Message-ID: <202205261859.oX2Ndm8n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   59219ec0c11347c742ce9c432a733036eb4ed9c9
commit: 1d25d83ca077206d9665b3491b722068de876a73 [3/4] net_sched: introduce eBPF based Qdisc
config: powerpc-randconfig-s032-20220524 (https://download.01.org/0day-ci/archive/20220526/202205261859.oX2Ndm8n-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/congwang/linux/commit/1d25d83ca077206d9665b3491b722068de876a73
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout 1d25d83ca077206d9665b3491b722068de876a73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash net/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/sched/sch_bpf.c:120:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> net/sched/sch_bpf.c:120:19: sparse:    struct bpf_prog [noderef] __rcu *
>> net/sched/sch_bpf.c:120:19: sparse:    struct bpf_prog *
   net/sched/sch_bpf.c:166:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/sched/sch_bpf.c:166:19: sparse:    struct bpf_prog [noderef] __rcu *
   net/sched/sch_bpf.c:166:19: sparse:    struct bpf_prog *

vim +120 net/sched/sch_bpf.c

   109	
   110	static int sch_bpf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
   111				   struct sk_buff **to_free)
   112	{
   113		struct sch_bpf_qdisc *q = qdisc_priv(sch);
   114		unsigned int len = qdisc_pkt_len(skb);
   115		struct sch_bpf_ctx ctx = {};
   116		struct sch_bpf_class *cl;
   117		int res = NET_XMIT_SUCCESS;
   118		struct bpf_prog *enqueue;
   119	
 > 120		enqueue = rcu_dereference(q->enqueue_prog.prog);
   121		bpf_compute_data_pointers(skb);
   122		ctx.skb = (struct __sk_buff *)skb;
   123		ctx.classid = sch->handle;
   124		res = bpf_prog_run(enqueue, &ctx);
   125		switch (res) {
   126		case SCH_BPF_DROP:
   127			__qdisc_drop(skb, to_free);
   128			return NET_XMIT_DROP;
   129		case SCH_BPF_QUEUED:
   130			return NET_XMIT_SUCCESS;
   131		}
   132	
   133		cl = sch_bpf_find(sch, ctx.classid);
   134		if (!cl || !cl->qdisc) {
   135			if (res & __NET_XMIT_BYPASS)
   136				qdisc_qstats_drop(sch);
   137			__qdisc_drop(skb, to_free);
   138			return res;
   139		}
   140	
   141		res = qdisc_enqueue(skb, cl->qdisc, to_free);
   142		if (res != NET_XMIT_SUCCESS) {
   143			if (net_xmit_drop_count(res)) {
   144				qdisc_qstats_drop(sch);
   145				cl->drops++;
   146			}
   147			return res;
   148		}
   149	
   150		sch->qstats.backlog += len;
   151		sch->q.qlen++;
   152		return res;
   153	}
   154	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
