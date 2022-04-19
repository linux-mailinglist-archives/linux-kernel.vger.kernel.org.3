Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FAC506284
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbiDSDTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiDSDS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:18:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780C383
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650338178; x=1681874178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZB1uB9q2BZuLsMWlbDJYQao7f1VQ48TkORVyBSZ/9+A=;
  b=MH7MmtToYGI48O7VGYe1dOv/ye7ZV7CNOs9+I0vUsCAm7n884LdH6A4t
   TMaItwhJS7W2CyBxKGatSNGLJNGN0mV4oNgbXvqMJTOS2v/DEgQRjqnSF
   FLayxPq8laokEvrPrcveTF9iYiVq5PMiNYQ6mdA/ziElOzE+r0ZPjkFt6
   Sm7hZMitIXUcd3sHYfPkPrWCdTi+FVZFPcYvIC5L+r69F22bDhEzY1xv9
   Yf9JlO34RPrrIsTNluxfb/xi7uYmPIR9RE9gU8/pK2jcE9/xMRS5ZOcpw
   mSm17Ft2TLnLR2aRTRNJyrPN5vytr7q6vcqUIUboY3qOGEPuYH/VsjAGM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262522939"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="262522939"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="592619440"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2022 20:16:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngeLf-0005GA-EL;
        Tue, 19 Apr 2022 03:16:15 +0000
Date:   Tue, 19 Apr 2022 11:15:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.04.16a 24/24]
 kernel/rcu/tree_nocb.h:1162:14: error: 'rcu_nocb_is_setup' undeclared; did
 you mean 'rcu_nocb_setup'?
Message-ID: <202204191137.9uki6akh-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.04.16a
head:   21b595e4233e6885bdea2819c206a470cc207ea5
commit: 21b595e4233e6885bdea2819c206a470cc207ea5 [24/24] rcu/nocb: Add an option to offload all CPUs on boot
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220419/202204191137.9uki6akh-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/21b595e4233e6885bdea2819c206a470cc207ea5
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.04.16a
        git checkout 21b595e4233e6885bdea2819c206a470cc207ea5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

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
