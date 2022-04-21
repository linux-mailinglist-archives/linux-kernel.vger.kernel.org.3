Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4A509884
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385159AbiDUGsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385395AbiDUGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55417F1F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523493; x=1682059493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EbS87KL5VPkTKHKMhwfU53bwvY+Q0qgi2a2RTEZdUuQ=;
  b=f89lanhece3YyOiV38sIXsFkmAOT79XdCwufeVqVTg9AIsQWdTWsA39E
   +kMt3ctCX+y12sC1VfZRTqHSCn09sqKGHe+EvOdWHhRAvfOy0994FODDX
   q4AL+Imqqvm873Bv9ACeV39jYnn3TDel6Wv/l2Hmv8TE/xgEYKT6fOaGK
   NfDfzOYlJf/f4xY9yYqg19BzZ49YJJvxT8i4PVOkGlXEIn+7fuvIjV6jr
   APOaMliUjRP4OLdBDr0ysNfXZPggmZR3thjG4mxwqQHYiVFDnWGO0x0rc
   tdVLb9RQ1eX6reNTdKFKgYszYjlYBeB3Htm4UH1jwfZKiKhonfST8Uahj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289369629"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289369629"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="658392046"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-00081z-GM;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:44:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2005/2579] net/ipv6/mcast.c:258:5: warning:
 no previous prototype for 'ipv6_sock_mc_join_ssm'
Message-ID: <202204211115.AswnonHW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: c69b0b89e88734be4e9bf8aad8f3fbcbf0b05df9 [2005/2579] headers/deps: net: Split <net/ipv6_api_sock.h> header out of <net/ipv6.h>
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204211115.AswnonHW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=c69b0b89e88734be4e9bf8aad8f3fbcbf0b05df9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout c69b0b89e88734be4e9bf8aad8f3fbcbf0b05df9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/pci/ fs/crypto/ net/ipv6/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ipv6/mcast.c:258:5: warning: no previous prototype for 'ipv6_sock_mc_join_ssm' [-Wmissing-prototypes]
     258 | int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/ipv6_sock_mc_join_ssm +258 net/ipv6/mcast.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  257  
c7ea20c9da5b94e Hangbin Liu    2018-07-10 @258  int ipv6_sock_mc_join_ssm(struct sock *sk, int ifindex,
c7ea20c9da5b94e Hangbin Liu    2018-07-10  259  			  const struct in6_addr *addr, unsigned int mode)
c7ea20c9da5b94e Hangbin Liu    2018-07-10  260  {
c7ea20c9da5b94e Hangbin Liu    2018-07-10  261  	return __ipv6_sock_mc_join(sk, ifindex, addr, mode);
c7ea20c9da5b94e Hangbin Liu    2018-07-10  262  }
c7ea20c9da5b94e Hangbin Liu    2018-07-10  263  

:::::: The code at line 258 was first introduced by commit
:::::: c7ea20c9da5b94e400c8dcc0adb99411f2e430a6 ipv6/mcast: init as INCLUDE when join SSM INCLUDE group

:::::: TO: Hangbin Liu <liuhangbin@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
