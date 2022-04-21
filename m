Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7385097D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385085AbiDUGpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385057AbiDUGoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:44:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB75813FA1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523312; x=1682059312;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j8r4lW+miO7Wmw0PZa28Www49vm3FMDOfjP6ZPaNyQY=;
  b=ihAMY3OAfiBzIpY77lC4PZqHuyh/9OrcowEhRhBgya6KIKnOitydizRf
   a5w8mIIpe3LXnr+9M1VgNiqYThax+Ke0/3MNXmD3JgNUWBmqi8Xs79DW1
   z6u89fMeEx9Xs4bGsl3ucgqKQt0cGS0rvn/dRd3v+3EUGVLIxK3z0QjoF
   1en6GACHy2k9Qy2twwJbtXrUXzjypmLDa9Qxt7RZ9QiZUl6MbiliErsS2
   37IFhC/Eryf9upaRKMyZTr5c8CsnQ5oAY232CCWuYceDeDXIu9pfxXVXU
   uzWb0GXzDlE1jTrCj0p+tHyoSQA6rVkJIEHShehiRoHe+w6+fF+Orms3C
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264021868"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264021868"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="670046916"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 23:41:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQVi-0007z7-5q;
        Thu, 21 Apr 2022 06:41:50 +0000
Date:   Thu, 21 Apr 2022 14:41:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.04.18a 22/22]
 kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared; did
 you mean 'rcu_nocb_setup'?
Message-ID: <202204210054.ZtsFVPYs-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.04.18a
head:   d6932dca19b1a7cbccad9d4acede8229e61cf97a
commit: d6932dca19b1a7cbccad9d4acede8229e61cf97a [22/22] rcu/nocb: Add an option to offload all CPUs on boot
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220421/202204210054.ZtsFVPYs-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d6932dca19b1a7cbccad9d4acede8229e61cf97a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.04.18a
        git checkout d6932dca19b1a7cbccad9d4acede8229e61cf97a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:5031:
   kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
>> kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared (first use in this function); did you mean 'rcu_nocb_setup'?
    1162 |         if (!rcu_nocb_is_setup) {
         |              ^~~~~~~~~~~~~~~~~
         |              rcu_nocb_setup
   kernel/rcu/tree_nocb.h:1162:14: note: each undeclared identifier is reported only once for each function it appears in


vim +1162 kernel/rcu/tree_nocb.h

  1153	
  1154	void __init rcu_init_nohz(void)
  1155	{
  1156		int cpu;
  1157		bool need_rcu_nocb_mask = false;
  1158		bool offload_all = false;
  1159		struct rcu_data *rdp;
  1160	
  1161	#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> 1162		if (!rcu_nocb_is_setup) {
  1163			need_rcu_nocb_mask = true;
  1164			offload_all = true;
  1165		}
  1166	#endif
  1167	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
