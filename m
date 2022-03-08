Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0299C4D1733
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346798AbiCHMZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiCHMZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:25:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB77846657
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646742262; x=1678278262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o7mZVD4tgSeSny4WNiaMLexskX6VuCs8mc74h2Cc5qk=;
  b=cSPvMYkRR7Xa5Chtu3CkPAa6a9kaIk1Bn+8VPnwCrNvISCxIbu/hAwGk
   CB1AZklDYUYm6dWAESAS3XR0jXjvaoksfv/+X/Yc8orW3qcN8XVqS8eq4
   oav4h82II0URVNykEmq1mQ5N2UiPjnsFqSInBCpmjHB9QEsFFSigrcri+
   /2rCInrpagDEJzUzm9NKhoScedUBRPEBNKBd6Do5g9uBi58vfG2iq1SFY
   lgXtEbEZkRw7Z4TdVU1XqmK+1/YjRzHasUdqfEZh8IBv8kdzs2FyFgBfj
   Smm8znyyRkZumZICHkApepMfjXV6UhxTFsYNTChtdEZAr2RGkdS8dxYTY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254861119"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254861119"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="537550401"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2022 04:24:21 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRYt2-0001Mp-Mt; Tue, 08 Mar 2022 12:24:20 +0000
Date:   Tue, 8 Mar 2022 20:23:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <cong.wang@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:net-next 3/6] net/core/skmsg.c:1159:17: error: 'desc'
 undeclared
Message-ID: <202203082002.YjBSPpOd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git net-next
head:   22f7ed3aeaffba31c10ca78b26baf372f54e347b
commit: 2781a9702395d5b43d15c9becfd2901eaa501dd4 [3/6] tcp: introduce ->read_sock()
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220308/202203082002.YjBSPpOd-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/2781a9702395d5b43d15c9becfd2901eaa501dd4
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang net-next
        git checkout 2781a9702395d5b43d15c9becfd2901eaa501dd4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the congwang/net-next HEAD 22f7ed3aeaffba31c10ca78b26baf372f54e347b builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   net/core/skmsg.c: In function 'sk_psock_verdict_recv':
>> net/core/skmsg.c:1159:17: error: 'desc' undeclared (first use in this function)
    1159 |                 desc->error = -ENOMEM;
         |                 ^~~~
   net/core/skmsg.c:1159:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/desc +1159 net/core/skmsg.c

887596095ec2a9e Cong Wang      2021-02-23  1148  
2781a9702395d5b Cong Wang      2022-03-07  1149  static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
ef5659280eb13e8 John Fastabend 2020-10-10  1150  {
ef5659280eb13e8 John Fastabend 2020-10-10  1151  	struct sk_psock *psock;
ef5659280eb13e8 John Fastabend 2020-10-10  1152  	struct bpf_prog *prog;
ef5659280eb13e8 John Fastabend 2020-10-10  1153  	int ret = __SK_DROP;
2781a9702395d5b Cong Wang      2022-03-07  1154  	int len = skb->len;
ef5659280eb13e8 John Fastabend 2020-10-10  1155  
ef5659280eb13e8 John Fastabend 2020-10-10  1156  	/* clone here so sk_eat_skb() in tcp_read_sock does not drop our data */
ef5659280eb13e8 John Fastabend 2020-10-10  1157  	skb = skb_clone(skb, GFP_ATOMIC);
ef5659280eb13e8 John Fastabend 2020-10-10  1158  	if (!skb) {
ef5659280eb13e8 John Fastabend 2020-10-10 @1159  		desc->error = -ENOMEM;
ef5659280eb13e8 John Fastabend 2020-10-10  1160  		return 0;
ef5659280eb13e8 John Fastabend 2020-10-10  1161  	}
ef5659280eb13e8 John Fastabend 2020-10-10  1162  
ef5659280eb13e8 John Fastabend 2020-10-10  1163  	rcu_read_lock();
ef5659280eb13e8 John Fastabend 2020-10-10  1164  	psock = sk_psock(sk);
ef5659280eb13e8 John Fastabend 2020-10-10  1165  	if (unlikely(!psock)) {
ef5659280eb13e8 John Fastabend 2020-10-10  1166  		len = 0;
781dd0431eb549f Cong Wang      2021-06-14  1167  		sock_drop(sk, skb);
ef5659280eb13e8 John Fastabend 2020-10-10  1168  		goto out;
ef5659280eb13e8 John Fastabend 2020-10-10  1169  	}
ae8b8332fbb512f Cong Wang      2021-02-23  1170  	prog = READ_ONCE(psock->progs.stream_verdict);
a7ba4558e69a3c2 Cong Wang      2021-03-30  1171  	if (!prog)
a7ba4558e69a3c2 Cong Wang      2021-03-30  1172  		prog = READ_ONCE(psock->progs.skb_verdict);
ef5659280eb13e8 John Fastabend 2020-10-10  1173  	if (likely(prog)) {
144748eb0c44509 John Fastabend 2021-04-01  1174  		skb->sk = sk;
e3526bb92a2084c Cong Wang      2021-02-23  1175  		skb_dst_drop(skb);
e3526bb92a2084c Cong Wang      2021-02-23  1176  		skb_bpf_redirect_clear(skb);
533342322276b06 Cong Wang      2021-02-23  1177  		ret = bpf_prog_run_pin_on_cpu(prog, skb);
e3526bb92a2084c Cong Wang      2021-02-23  1178  		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
144748eb0c44509 John Fastabend 2021-04-01  1179  		skb->sk = NULL;
ef5659280eb13e8 John Fastabend 2020-10-10  1180  	}
1581a6c1c3291a8 Cong Wang      2021-06-14  1181  	if (sk_psock_verdict_apply(psock, skb, ret) < 0)
1581a6c1c3291a8 Cong Wang      2021-06-14  1182  		len = 0;
ef5659280eb13e8 John Fastabend 2020-10-10  1183  out:
ef5659280eb13e8 John Fastabend 2020-10-10  1184  	rcu_read_unlock();
ef5659280eb13e8 John Fastabend 2020-10-10  1185  	return len;
ef5659280eb13e8 John Fastabend 2020-10-10  1186  }
ef5659280eb13e8 John Fastabend 2020-10-10  1187  

:::::: The code at line 1159 was first introduced by commit
:::::: ef5659280eb13e8ac31c296f58cfdfa1684ac06b bpf, sockmap: Allow skipping sk_skb parser program

:::::: TO: John Fastabend <john.fastabend@gmail.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
