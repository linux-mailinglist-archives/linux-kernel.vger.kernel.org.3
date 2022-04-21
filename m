Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAA509F37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383680AbiDUME2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383336AbiDUMEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:04:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A931367
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650542463; x=1682078463;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=40ZpXzHhif4b+zrDrJvZ+zMxh+KqAiiSUkdESy1uBXo=;
  b=IPg/k1ScnGeqOxdO/aLdpxlsp7IdSuAyPyCS1jfEenBo2K4JNdNsRqj9
   QBSc4DkBSU/A3v0UXY+bu6W5iADDDN3CbvVxfZUH2Sacwv9xMDm1w3gDt
   ZH5to6hxJcXPQa3QkqxOO4Pm2kvocsnxMcHhPCr35qzV5KCzjSDxXv9HA
   PuUV1tVHGCI4/fIeSIBQ73wSEQYm+01u/VKN8ChJ1V4101JHENaKN2i18
   NJlxDRrWjiDSA2yDV06kZ/lyMggumFMlSMckpx7ZMvlvQgR9c+SGy25dz
   o5qFI0EAjkPIhi2smJlpjVrDmbnwbNJfRZSvnhxqBOnqbASl7qaNeLRLH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324771620"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="324771620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 05:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="511033445"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2022 05:01:01 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhVUa-0008Md-HN;
        Thu, 21 Apr 2022 12:01:00 +0000
Date:   Thu, 21 Apr 2022 20:00:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2005/2579] net/ipv6/mcast.c:258:5: warning:
 no previous prototype for function 'ipv6_sock_mc_join_ssm'
Message-ID: <202204211908.ZazXpu8z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: c69b0b89e88734be4e9bf8aad8f3fbcbf0b05df9 [2005/2579] headers/deps: net: Split <net/ipv6_api_sock.h> header out of <net/ipv6.h>
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204211908.ZazXpu8z-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c69b0b89e88734be4e9bf8aad8f3fbcbf0b05df9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout c69b0b89e88734be4e9bf8aad8f3fbcbf0b05df9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/crypto/ arch/x86/entry/vdso/ arch/x86/events/amd/ arch/x86/kernel/ arch/x86/pci/ kernel/bpf/ kernel/trace/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ipv6/mcast.c:258:5: warning: no previous prototype for function 'ipv6_sock_mc_join_ssm' [-Wmissing-prototypes]
   int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
       ^
   net/ipv6/mcast.c:258:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
   ^
   static 
   1 warning generated.


vim +/ipv6_sock_mc_join_ssm +258 net/ipv6/mcast.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  257  
c7ea20c9da5b94 Hangbin Liu    2018-07-10 @258  int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
c7ea20c9da5b94 Hangbin Liu    2018-07-10  259  			  const struct in6_addr *addr, unsigned int mode)
c7ea20c9da5b94 Hangbin Liu    2018-07-10  260  {
c7ea20c9da5b94 Hangbin Liu    2018-07-10  261  	return __ipv6_sock_mc_join(sk, ifindex, addr, mode);
c7ea20c9da5b94 Hangbin Liu    2018-07-10  262  }
c7ea20c9da5b94 Hangbin Liu    2018-07-10  263  

:::::: The code at line 258 was first introduced by commit
:::::: c7ea20c9da5b94e400c8dcc0adb99411f2e430a6 ipv6/mcast: init as INCLUDE when join SSM INCLUDE group

:::::: TO: Hangbin Liu <liuhangbin@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
