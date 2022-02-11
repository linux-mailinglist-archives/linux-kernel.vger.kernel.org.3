Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946844B300D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbiBKWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:05:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiBKWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:05:14 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16370C72
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644617112; x=1676153112;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WNMdlhJHH0sjtabvDXstOjZlPxdvaJHen4RjdZVO5pQ=;
  b=c5tU8G3BRxW4RWXeRp6li7MY6MZzbegZQng06T1nmmCxQMK0ommr6teI
   F35rJcLKKqCJrOqPWeX6eIzNCokxPgikDqPGnefM7zTD6LKjeVXgZ2Xvw
   JPanLzNUMbybF5WJvkYjNpeKiADMC2HcQRLgFaGCgcyrzaqvBYqgve67E
   ih1dGnfd7gAKAaKk7Ke1zDYx8IaomHsSLoturYS9T5rpxW7aMCOQPOgEj
   Ix2pfmlDCAP5I0OGGEGHHPcouxUgpzZWo5UwAtzyEliDMqgIPJCgR9FNt
   M7MalMFk3tK+eLa3jg9CwfTEm6elSn4Rob2l9YPCZj/Ap55hDR/HBushZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="237222417"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="237222417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 14:05:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="623343093"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Feb 2022 14:05:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIe2P-0005FA-8z; Fri, 11 Feb 2022 22:05:09 +0000
Date:   Sat, 12 Feb 2022 06:04:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: [tnguy-net-queue:dev-queue 21/44] net/netfilter/xt_socket.c:224:17:
 error: implicit declaration of function 'nf_defrag_ipv6_disable'; did you
 mean 'nf_defrag_ipv4_disable'?
Message-ID: <202202120545.c2k6AbiS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
head:   d35ad64359ca21540d9bf84b4bb072ca21b2f4ac
commit: 75063c9294fb239bbe64eb72141b6871fe526d29 [21/44] netfilter: xt_socket: fix a typo in socket_mt_destroy()
config: sparc-randconfig-s031-20220211 (https://download.01.org/0day-ci/archive/20220212/202202120545.c2k6AbiS-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/commit/?id=75063c9294fb239bbe64eb72141b6871fe526d29
        git remote add tnguy-net-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git
        git fetch --no-tags tnguy-net-queue dev-queue
        git checkout 75063c9294fb239bbe64eb72141b6871fe526d29
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/netfilter/xt_socket.c: In function 'socket_mt_destroy':
>> net/netfilter/xt_socket.c:224:17: error: implicit declaration of function 'nf_defrag_ipv6_disable'; did you mean 'nf_defrag_ipv4_disable'? [-Werror=implicit-function-declaration]
     224 |                 nf_defrag_ipv6_disable(par->net);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 nf_defrag_ipv4_disable
   cc1: some warnings being treated as errors


vim +224 net/netfilter/xt_socket.c

   218	
   219	static void socket_mt_destroy(const struct xt_mtdtor_param *par)
   220	{
   221		if (par->family == NFPROTO_IPV4)
   222			nf_defrag_ipv4_disable(par->net);
   223		else if (par->family == NFPROTO_IPV6)
 > 224			nf_defrag_ipv6_disable(par->net);
   225	}
   226	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
