Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C35585137
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiG2N7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiG2N7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:59:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44671BE1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659103144; x=1690639144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5qeRI+9v5UM1YAqh/yjo5+eFBXskJllWwXnQbUJLNhk=;
  b=eTUl5DvQwLqJ5c3k5Vt5d1ANt8CWrFj+ngzPqgRgknmszNqjT3KhxOnl
   ugf3VnYm67nfJ7FdMOWnFbuWjjsikW9eR6PlSZJZ0jMYfN3ocpY6TysNG
   Wkq3p7eILuELBzKgPgOsTL9DE8SNgffbW7vKT7KmYnuD6VSIxg8q1zYUY
   DjD6GWjLzps9Dscy6bIBMmMy4lmG/kwJg76uicSXVnw1tdqVplzFuO8Rs
   i8uyUB70xPbBMrtDL7JPhX91Q3HRmCgYICNMnsG/qQeWO80J8j8po+YRM
   2q9FO3XI5T9fMgQaQGLSi32hxL+xEoYLUR333kOU1LWRC4/87t0v28SLe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289968505"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="289968505"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 06:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="669276667"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2022 06:59:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHQW5-000Bgj-2V;
        Fri, 29 Jul 2022 13:59:01 +0000
Date:   Fri, 29 Jul 2022 21:58:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta5 4/9] net/sched/sch_ingress.c:115: undefined
 reference to `sch_prog_detach_kern'
Message-ID: <202207292142.eB49WXRc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/cilium/linux.git pr/meta5
head:   2482948e66ab1775a04a65b0d4df3737a6bf320a
commit: 990a182aa567835d95822244d8d2be56def37c3e [4/9] bpf: Add initial fd-based API to attach tc BPF programs
config: parisc-buildonly-randconfig-r001-20220728 (https://download.01.org/0day-ci/archive/20220729/202207292142.eB49WXRc-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/cilium/linux/commit/990a182aa567835d95822244d8d2be56def37c3e
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta5
        git checkout 990a182aa567835d95822244d8d2be56def37c3e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: net/sched/sch_ingress.o: in function `ingress_destroy':
>> net/sched/sch_ingress.c:115: undefined reference to `sch_prog_detach_kern'
   hppa-linux-ld: net/sched/sch_ingress.o: in function `clsact_destroy':
   net/sched/sch_ingress.c:282: undefined reference to `sch_prog_detach_kern'
>> hppa-linux-ld: net/sched/sch_ingress.c:283: undefined reference to `sch_prog_detach_kern'
   hppa-linux-ld: net/sched/sch_ingress.o: in function `clsact_init':
>> net/sched/sch_ingress.c:245: undefined reference to `sch_prog_attach_kern'
>> hppa-linux-ld: net/sched/sch_ingress.c:265: undefined reference to `sch_prog_attach_kern'
   hppa-linux-ld: net/sched/sch_ingress.o: in function `ingress_init':
   net/sched/sch_ingress.c:95: undefined reference to `sch_prog_attach_kern'


vim +115 net/sched/sch_ingress.c

   108	
   109	static void ingress_destroy(struct Qdisc *sch)
   110	{
   111		struct ingress_sched_data *q = qdisc_priv(sch);
   112		struct net_device *dev = qdisc_dev(sch);
   113	
   114		tcf_block_put_ext(q->block, sch, &q->block_info);
 > 115		sch_prog_detach_kern(dev, true);
   116		net_dec_ingress_queue();
   117	}
   118	
   119	static int ingress_dump(struct Qdisc *sch, struct sk_buff *skb)
   120	{
   121		struct nlattr *nest;
   122	
   123		nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
   124		if (nest == NULL)
   125			goto nla_put_failure;
   126	
   127		return nla_nest_end(skb, nest);
   128	
   129	nla_put_failure:
   130		nla_nest_cancel(skb, nest);
   131		return -1;
   132	}
   133	
   134	static const struct Qdisc_class_ops ingress_class_ops = {
   135		.flags		=	QDISC_CLASS_OPS_DOIT_UNLOCKED,
   136		.leaf		=	ingress_leaf,
   137		.find		=	ingress_find,
   138		.walk		=	ingress_walk,
   139		.tcf_block	=	ingress_tcf_block,
   140		.bind_tcf	=	ingress_bind_filter,
   141		.unbind_tcf	=	ingress_unbind_filter,
   142	};
   143	
   144	static struct Qdisc_ops ingress_qdisc_ops __read_mostly = {
   145		.cl_ops			=	&ingress_class_ops,
   146		.id			=	"ingress",
   147		.priv_size		=	sizeof(struct ingress_sched_data),
   148		.static_flags		=	TCQ_F_CPUSTATS,
   149		.init			=	ingress_init,
   150		.destroy		=	ingress_destroy,
   151		.dump			=	ingress_dump,
   152		.ingress_block_set	=	ingress_ingress_block_set,
   153		.ingress_block_get	=	ingress_ingress_block_get,
   154		.owner			=	THIS_MODULE,
   155	};
   156	
   157	struct clsact_sched_data {
   158		struct tcf_block *ingress_block;
   159		struct tcf_block *egress_block;
   160		struct tcf_block_ext_info ingress_block_info;
   161		struct tcf_block_ext_info egress_block_info;
   162		struct mini_Qdisc_pair miniqp_ingress;
   163		struct mini_Qdisc_pair miniqp_egress;
   164	};
   165	
   166	static unsigned long clsact_find(struct Qdisc *sch, u32 classid)
   167	{
   168		switch (TC_H_MIN(classid)) {
   169		case TC_H_MIN(TC_H_MIN_INGRESS):
   170		case TC_H_MIN(TC_H_MIN_EGRESS):
   171			return TC_H_MIN(classid);
   172		default:
   173			return 0;
   174		}
   175	}
   176	
   177	static unsigned long clsact_bind_filter(struct Qdisc *sch,
   178						unsigned long parent, u32 classid)
   179	{
   180		return clsact_find(sch, classid);
   181	}
   182	
   183	static struct tcf_block *clsact_tcf_block(struct Qdisc *sch, unsigned long cl,
   184						  struct netlink_ext_ack *extack)
   185	{
   186		struct clsact_sched_data *q = qdisc_priv(sch);
   187	
   188		switch (cl) {
   189		case TC_H_MIN(TC_H_MIN_INGRESS):
   190			return q->ingress_block;
   191		case TC_H_MIN(TC_H_MIN_EGRESS):
   192			return q->egress_block;
   193		default:
   194			return NULL;
   195		}
   196	}
   197	
   198	static void clsact_ingress_block_set(struct Qdisc *sch, u32 block_index)
   199	{
   200		struct clsact_sched_data *q = qdisc_priv(sch);
   201	
   202		q->ingress_block_info.block_index = block_index;
   203	}
   204	
   205	static void clsact_egress_block_set(struct Qdisc *sch, u32 block_index)
   206	{
   207		struct clsact_sched_data *q = qdisc_priv(sch);
   208	
   209		q->egress_block_info.block_index = block_index;
   210	}
   211	
   212	static u32 clsact_ingress_block_get(struct Qdisc *sch)
   213	{
   214		struct clsact_sched_data *q = qdisc_priv(sch);
   215	
   216		return q->ingress_block_info.block_index;
   217	}
   218	
   219	static u32 clsact_egress_block_get(struct Qdisc *sch)
   220	{
   221		struct clsact_sched_data *q = qdisc_priv(sch);
   222	
   223		return q->egress_block_info.block_index;
   224	}
   225	
   226	static int clsact_init(struct Qdisc *sch, struct nlattr *opt,
   227			       struct netlink_ext_ack *extack)
   228	{
   229		struct clsact_sched_data *q = qdisc_priv(sch);
   230		struct net_device *dev = qdisc_dev(sch);
   231		struct sch_entry *entry;
   232		bool created;
   233		int err;
   234	
   235		net_inc_ingress_queue();
   236		net_inc_egress_queue();
   237	
   238		entry = dev_sch_entry_fetch(dev, true, &created);
   239		if (!entry)
   240			return -ENOMEM;
   241	
   242		mini_qdisc_pair_init(&q->miniqp_ingress, sch, &dev_sch_entry_pair(entry)->miniq);
   243		if (created)
   244			dev_sch_entry_update(dev, entry, true);
 > 245		sch_prog_attach_kern(dev, true);
   246	
   247		q->ingress_block_info.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS;
   248		q->ingress_block_info.chain_head_change = clsact_chain_head_change;
   249		q->ingress_block_info.chain_head_change_priv = &q->miniqp_ingress;
   250	
   251		err = tcf_block_get_ext(&q->ingress_block, sch, &q->ingress_block_info,
   252					extack);
   253		if (err)
   254			return err;
   255	
   256		mini_qdisc_pair_block_init(&q->miniqp_ingress, q->ingress_block);
   257	
   258		entry = dev_sch_entry_fetch(dev, false, &created);
   259		if (!entry)
   260			return -ENOMEM;
   261	
   262		mini_qdisc_pair_init(&q->miniqp_egress, sch, &dev_sch_entry_pair(entry)->miniq);
   263		if (created)
   264			dev_sch_entry_update(dev, entry, false);
 > 265		sch_prog_attach_kern(dev, false);
   266	
   267		q->egress_block_info.binder_type = FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS;
   268		q->egress_block_info.chain_head_change = clsact_chain_head_change;
   269		q->egress_block_info.chain_head_change_priv = &q->miniqp_egress;
   270	
   271		return tcf_block_get_ext(&q->egress_block, sch, &q->egress_block_info, extack);
   272	}
   273	
   274	static void clsact_destroy(struct Qdisc *sch)
   275	{
   276		struct clsact_sched_data *q = qdisc_priv(sch);
   277		struct net_device *dev = qdisc_dev(sch);
   278	
   279		tcf_block_put_ext(q->egress_block, sch, &q->egress_block_info);
   280		tcf_block_put_ext(q->ingress_block, sch, &q->ingress_block_info);
   281	
   282		sch_prog_detach_kern(dev, true);
 > 283		sch_prog_detach_kern(dev, false);
   284	
   285		net_dec_ingress_queue();
   286		net_dec_egress_queue();
   287	}
   288	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
