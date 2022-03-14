Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE20F4D78E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiCNASA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 20:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiCNAR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:17:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AFCE5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647217007; x=1678753007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WSe+c+6P2a21motfagDGkpUQ39t36USC4TWbIOevwHE=;
  b=Jr10ue9plCVgxjrQfghew2+LdlXKq9gLgdPuMpNuF1tR6bSbM6rNRsVZ
   ndO66nhQStcHa5QZMJKcoLVpxnorGbcO53+TSaO1dR8x0Cy32lCkOyw0N
   /aYkZxYrKExgWRbYaeoypn0t23YZ1rzKkm3kdH8bVhaqP8pgi4eWCAq/M
   VrN4sjkolDyIzvt3EtmZug3IA48L62TfwDP561bDxRB0DTM17G5j9Bsap
   HTKyBVgUfXzaU3HV94IVy9yCoeS6MIoVbH6Aij/zSuv4bzn2sThLz6rQp
   y2VHaWLkbdcDsHxb3s0k2nhrMZJGDkRbo2WmgI7AHhB9hTHXPkIAy8Ft6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236511843"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="236511843"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 17:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="579929084"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2022 17:16:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTYOC-0009Pf-PD; Mon, 14 Mar 2022 00:16:44 +0000
Date:   Mon, 14 Mar 2022 08:16:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: [toke:xdp-queueing-03 2/9] net/packet/af_packet.c:1448: undefined
 reference to `__umoddi3'
Message-ID: <202203140800.8pr81INh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-03
head:   3e7f25d58b1bfd5ad623678bf9e11f27c98a8094
commit: 1cc16c4489cbf066b09942ea224e6dc9ac6a46ac [2/9] bpf: Use 64-bit return value for bpf_prog_run
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220314/202203140800.8pr81INh-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=1cc16c4489cbf066b09942ea224e6dc9ac6a46ac
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-03
        git checkout 1cc16c4489cbf066b09942ea224e6dc9ac6a46ac
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/packet/af_packet.o: in function `fanout_demux_bpf':
>> net/packet/af_packet.c:1448: undefined reference to `__umoddi3'


vim +1448 net/packet/af_packet.c

2d36097d26b599 Neil Horman        2014-01-22  1437  
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1438  static unsigned int fanout_demux_bpf(struct packet_fanout *f,
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1439  				     struct sk_buff *skb,
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1440  				     unsigned int num)
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1441  {
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1442  	struct bpf_prog *prog;
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1443  	unsigned int ret = 0;
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1444  
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1445  	rcu_read_lock();
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1446  	prog = rcu_dereference(f->bpf_prog);
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1447  	if (prog)
ff936a04e5f28b Alexei Starovoitov 2015-10-07 @1448  		ret = bpf_prog_run_clear_cb(prog, skb) % num;
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1449  	rcu_read_unlock();
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1450  
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1451  	return ret;
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1452  }
47dceb8ecdc1c3 Willem de Bruijn   2015-08-14  1453  

:::::: The code at line 1448 was first introduced by commit
:::::: ff936a04e5f28b7e0455be0e7fa91334f89e4b44 bpf: fix cb access in socket filter programs

:::::: TO: Alexei Starovoitov <ast@plumgrid.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
