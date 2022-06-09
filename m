Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFFA54423D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiFID40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiFID4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:56:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EFC28999
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654746977; x=1686282977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+I/oVCq3xhjdVOnCr/3XZ2G1+Q28DoV50e7XTR1XEyM=;
  b=BBkG2So/804F48SGXsM5FeV+sKDYyI+URj1aQ9QNcTLH8iBSPTaAjke8
   gnNxcKAMkYqigKxfq+sFaCJe0siR4FF5U6gGvH4g1E4ZyZ8m8WnZuuLEt
   eeCwK9fF9NwJOkGJo/Qa6/0vtgxPcq4s9ryDlD3jCI6nx1+uoXwmeG+iM
   WyrH7ttCYeMZ6slQZGVVi6FcPjj2CQtFQjG4KQZY5FvAGyo/XP9gM9ckl
   TtAzX5zF9xEW5o4OXHyIzi16ll/TWqMZdrIHxNjp7A5nhog1Wa+v6Z96h
   rbqRoXRgmLl/0R70BSbbX+SSmz5TLmE50WQJodxq86m8aQNpjCb2JxpEB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="265926820"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="265926820"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 20:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585270617"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2022 20:56:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz9HK-000FTR-K9;
        Thu, 09 Jun 2022 03:56:14 +0000
Date:   Thu, 9 Jun 2022 11:56:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Subject: net/ipv4/tcp_cong.c:238:22: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202206091138.G3gUfGes-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
commit: e188f3330a13df904d77003846eafd3edf99009d ARC: cmpxchg/xchg: rewrite as macros to make type safe
date:   10 months ago
config: arc-randconfig-s032-20220530 (https://download.01.org/0day-ci/archive/20220609/202206091138.G3gUfGes-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-26-gb3cf30ba-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e188f3330a13df904d77003846eafd3edf99009d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e188f3330a13df904d77003846eafd3edf99009d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash net/ipv4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   net/ipv4/tcp_cong.c:238:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tcp_congestion_ops const [noderef] __rcu *_val_ @@     got struct tcp_congestion_ops *[assigned] ca @@
   net/ipv4/tcp_cong.c:238:24: sparse:     expected struct tcp_congestion_ops const [noderef] __rcu *_val_
   net/ipv4/tcp_cong.c:238:24: sparse:     got struct tcp_congestion_ops *[assigned] ca
>> net/ipv4/tcp_cong.c:238:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tcp_congestion_ops const *prev @@     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] _val_ @@
   net/ipv4/tcp_cong.c:238:22: sparse:     expected struct tcp_congestion_ops const *prev
   net/ipv4/tcp_cong.c:238:22: sparse:     got struct tcp_congestion_ops const [noderef] __rcu *[assigned] _val_

vim +238 net/ipv4/tcp_cong.c

317a76f9a44b43 Stephen Hemminger 2005-06-23  219  
317a76f9a44b43 Stephen Hemminger 2005-06-23  220  /* Used by sysctl to change default congestion control */
6670e152447732 Stephen Hemminger 2017-11-14  221  int tcp_set_default_congestion_control(struct net *net, const char *name)
317a76f9a44b43 Stephen Hemminger 2005-06-23  222  {
317a76f9a44b43 Stephen Hemminger 2005-06-23  223  	struct tcp_congestion_ops *ca;
6670e152447732 Stephen Hemminger 2017-11-14  224  	const struct tcp_congestion_ops *prev;
6670e152447732 Stephen Hemminger 2017-11-14  225  	int ret;
317a76f9a44b43 Stephen Hemminger 2005-06-23  226  
6670e152447732 Stephen Hemminger 2017-11-14  227  	rcu_read_lock();
6670e152447732 Stephen Hemminger 2017-11-14  228  	ca = tcp_ca_find_autoload(net, name);
6670e152447732 Stephen Hemminger 2017-11-14  229  	if (!ca) {
6670e152447732 Stephen Hemminger 2017-11-14  230  		ret = -ENOENT;
0baf26b0fcd74b Martin KaFai Lau  2020-01-08  231  	} else if (!bpf_try_module_get(ca, ca->owner)) {
6670e152447732 Stephen Hemminger 2017-11-14  232  		ret = -EBUSY;
8d432592f30fcc Jonathon Reinhart 2021-05-01  233  	} else if (!net_eq(net, &init_net) &&
8d432592f30fcc Jonathon Reinhart 2021-05-01  234  			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
8d432592f30fcc Jonathon Reinhart 2021-05-01  235  		/* Only init netns can set default to a restricted algorithm */
8d432592f30fcc Jonathon Reinhart 2021-05-01  236  		ret = -EPERM;
6670e152447732 Stephen Hemminger 2017-11-14  237  	} else {
6670e152447732 Stephen Hemminger 2017-11-14 @238  		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
6670e152447732 Stephen Hemminger 2017-11-14  239  		if (prev)
0baf26b0fcd74b Martin KaFai Lau  2020-01-08  240  			bpf_module_put(prev, prev->owner);
317a76f9a44b43 Stephen Hemminger 2005-06-23  241  
6670e152447732 Stephen Hemminger 2017-11-14  242  		ca->flags |= TCP_CONG_NON_RESTRICTED;
317a76f9a44b43 Stephen Hemminger 2005-06-23  243  		ret = 0;
317a76f9a44b43 Stephen Hemminger 2005-06-23  244  	}
6670e152447732 Stephen Hemminger 2017-11-14  245  	rcu_read_unlock();
317a76f9a44b43 Stephen Hemminger 2005-06-23  246  
317a76f9a44b43 Stephen Hemminger 2005-06-23  247  	return ret;
317a76f9a44b43 Stephen Hemminger 2005-06-23  248  }
317a76f9a44b43 Stephen Hemminger 2005-06-23  249  

:::::: The code at line 238 was first introduced by commit
:::::: 6670e152447732ba90626f36dfc015a13fbf150e tcp: Namespace-ify sysctl_tcp_default_congestion_control

:::::: TO: Stephen Hemminger <stephen@networkplumber.org>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
