Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E104DDAF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiCRNyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiCRNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:54:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42AE186164
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647611562; x=1679147562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oTmQnH31LXnh+65zM2fyibjzTL1ZhhsTaOk5bBswryM=;
  b=HZZmvgLq0EL1KIqyJJp8m4fpXXLEugRsGhtjAEC0U7y9dQerjuCYWGgZ
   a2CvEXbkjQo0/WsLRBUqeaqEodkFiJBJFFcpow3A2NQj6UpXOghSREJ4L
   D8Mpwg80IZ9vUUTGRKL4cU6vap4bFo/+yICILxeZofcw7ujoyB+YnKdgM
   fDgR1F/MPX4cT2wga6yE4RMh0F7QTiW3DngXMWMrW9LGWdfQcFrtd62d5
   XqIXaoBUkempJsNhltsaRySnSnstO7hwT8AZnCO5eMwNbz0SQBHN+VUyU
   3iSxrnVuPVJJvTtli8+NM1V94k+U8+/qjMG+jgFfj6DqGFBBM0AZBrZaP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257326802"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257326802"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="715489828"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2022 06:52:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVD20-000Enp-Fc; Fri, 18 Mar 2022 13:52:40 +0000
Date:   Fri, 18 Mar 2022 21:52:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1863/2335] net/ipv6/mcast.c:257:5: warning: no
 previous prototype for function 'ipv6_sock_mc_join_ssm'
Message-ID: <202203182145.IJoJVRxO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 6444b1da8c923265175370f6a07405345c316ad9 [1863/2335] headers/deps: net: Split <net/ipv6_api_sock.h> header out of <net/ipv6.h>
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220318/202203182145.IJoJVRxO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=6444b1da8c923265175370f6a07405345c316ad9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 6444b1da8c923265175370f6a07405345c316ad9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mtrr/ arch/x86/pci/ kernel/trace/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ipv6/mcast.c:257:5: warning: no previous prototype for function 'ipv6_sock_mc_join_ssm' [-Wmissing-prototypes]
   int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
       ^
   net/ipv6/mcast.c:257:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
   ^
   static 
   1 warning generated.


vim +/ipv6_sock_mc_join_ssm +257 net/ipv6/mcast.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  256  
c7ea20c9da5b94 Hangbin Liu    2018-07-10 @257  int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
c7ea20c9da5b94 Hangbin Liu    2018-07-10  258  			  const struct in6_addr *addr, unsigned int mode)
c7ea20c9da5b94 Hangbin Liu    2018-07-10  259  {
c7ea20c9da5b94 Hangbin Liu    2018-07-10  260  	return __ipv6_sock_mc_join(sk, ifindex, addr, mode);
c7ea20c9da5b94 Hangbin Liu    2018-07-10  261  }
c7ea20c9da5b94 Hangbin Liu    2018-07-10  262  

:::::: The code at line 257 was first introduced by commit
:::::: c7ea20c9da5b94e400c8dcc0adb99411f2e430a6 ipv6/mcast: init as INCLUDE when join SSM INCLUDE group

:::::: TO: Hangbin Liu <liuhangbin@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
