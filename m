Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322275062DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348139AbiDSDkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346972AbiDSDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:40:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74765A3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650339443; x=1681875443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n6YrESoq96z5iX+5zZF1IyGyg7F2BPI4Bi6Ga8iHLSU=;
  b=jxZZtv1BaIGj1qBAM0dDLexqCP0B7yawTkAYTpjZqO+mVLq4RKvy7wvd
   YHNnhDPeT50hNCbN8dlrmjsssaq5vDaM1a18IVeC5uVSJuXhXymvQDqYH
   mq5MHC+dROeaPcmIVQrjPMcNu7hP7Q/+yMINGFJB42l02840X3xCChsY5
   NIyJyn8pliAUCjNxaDZDqxRcS1EvL0cSXcQp5QnzKykEup5FvAkDi2eiI
   GMs9AcWD+ZmJs3lgfPBYMtwRcmiX2FDFZuAA8XU77LddWzjSg3Sernmfc
   EzbL9Gz20VQyX24WBbPozuhuz1HkB6ig6bj+418jttlWGmtKFmBz1pkYt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326565448"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="326565448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:37:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="529867443"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 20:37:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngeg4-0005Ia-OO;
        Tue, 19 Apr 2022 03:37:20 +0000
Date:   Tue, 19 Apr 2022 11:36:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2140/2356]
 drivers/net/bonding/bond_alb.c:1299:6: warning: incompatible integer to
 pointer conversion assigning to 'struct icmp6hdr *' from 'int'
Message-ID: <202204191122.amoOMw5g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 3ca2f09b7faf17b5e78cb699d3315e5accbe0216 [2140/2356] headers/deps: net: Optimize <net/ndisc.h> dependencies, remove <net/ndisc_api.h> inclusion
config: i386-randconfig-a016-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191122.amoOMw5g-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3ca2f09b7faf17b5e78cb699d3315e5accbe0216
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 3ca2f09b7faf17b5e78cb699d3315e5accbe0216
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/ drivers/misc/ drivers/net/bonding/ drivers/net/ethernet/marvell/prestera/ drivers/net/ethernet/microchip/lan966x/ drivers/net/netdevsim/ drivers/net/phy/ drivers/power/supply/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/bonding/bond_alb.c:1299:8: error: implicit declaration of function 'icmp6_hdr' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           hdr = icmp6_hdr(skb);
                 ^
>> drivers/net/bonding/bond_alb.c:1299:6: warning: incompatible integer to pointer conversion assigning to 'struct icmp6hdr *' from 'int' [-Wint-conversion]
           hdr = icmp6_hdr(skb);
               ^ ~~~~~~~~~~~~~~
   drivers/net/bonding/bond_alb.c:1300:28: error: use of undeclared identifier 'NDISC_NEIGHBOUR_ADVERTISEMENT'
           return hdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT ||
                                     ^
   drivers/net/bonding/bond_alb.c:1301:22: error: use of undeclared identifier 'NDISC_NEIGHBOUR_SOLICITATION'
                   hdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION;
                                      ^
   1 warning and 3 errors generated.


vim +1299 drivers/net/bonding/bond_alb.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  1282  
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1283  /* determine if the packet is NA or NS */
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1284  static bool alb_determine_nd(struct sk_buff *skb, struct bonding *bond)
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1285  {
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1286  	struct ipv6hdr *ip6hdr;
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1287  	struct icmp6hdr *hdr;
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1288  
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1289  	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr)))
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1290  		return true;
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1291  
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1292  	ip6hdr = ipv6_hdr(skb);
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1293  	if (ip6hdr->nexthdr != IPPROTO_ICMPV6)
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1294  		return false;
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1295  
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1296  	if (!pskb_network_may_pull(skb, sizeof(*ip6hdr) + sizeof(*hdr)))
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1297  		return true;
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1298  
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28 @1299  	hdr = icmp6_hdr(skb);
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1300  	return hdr->icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT ||
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1301  		hdr->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION;
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1302  }
0da8aa00bfcfeb3 Sun Shouxin    2022-01-28  1303  

:::::: The code at line 1299 was first introduced by commit
:::::: 0da8aa00bfcfeb3f4e6537dd8e2001e0727ba549 net: bonding: Add support for IPV6 ns/na to balance-alb/balance-tlb mode

:::::: TO: Sun Shouxin <sunshouxin@chinatelecom.cn>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
