Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF324B9521
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiBQAtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:49:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBQAtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:49:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C470193B2E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645058936; x=1676594936;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IpBblMyLNb6CfVkfTURhf/bmurf8+DNQ4AfzBwDyidI=;
  b=KJ6BSNCrlJBPU0lksSc+mYw/OYZvnINLNcaMS+O/QNVSGu/ka0RHY2A/
   rWC1LXBYx5SUofx2rrfS8yTlw0hyHvB5p0C1j+uUf649w6CagMZZ5PK/5
   vrp8zgKdi4RSV8NPqJmfoQoOnBYpBitYcP+LPcTcMtWnQBbV3il9KSrsF
   /PPHELD0v6WwOuOOrDdIVxJbYYt1ciYxUw44WNr7I5HHE6y5ayaho3YLX
   THVZ5tw+Ksy4u9ys9AuAKvn/fUVRgwG2iZuGvHEOFCEw5/OpRfTOU2d7o
   WqwKm84ioqJBY203l1lbqz+EgvpYEUTsHSH0s8CU3OtaeJAU+AbofS0ZQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="230720481"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="230720481"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 16:48:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="588877625"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Feb 2022 16:48:54 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKUyc-000BGd-A0; Thu, 17 Feb 2022 00:48:54 +0000
Date:   Thu, 17 Feb 2022 08:48:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:rcu/dev 2/5] kernel/rcu/tree_nocb.h:1157:7:
 warning: variable 'need_rcu_nocb_mask' set but not used
Message-ID: <202202170811.xZp85edb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git rcu/dev
head:   be4d4c3ba8c4ceeba9dc9df4de5451c7261161f3
commit: bdfa2dd80919bc4636fcf606cd21b606d361fd16 [2/5] rcu/nocb: Move rcu_nocb_is_setup to rcu_state
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220217/202202170811.xZp85edb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=bdfa2dd80919bc4636fcf606cd21b606d361fd16
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks rcu/dev
        git checkout bdfa2dd80919bc4636fcf606cd21b606d361fd16
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:4858:
   kernel/rcu/tree_nocb.h: In function 'rcu_init_nohz':
>> kernel/rcu/tree_nocb.h:1157:7: warning: variable 'need_rcu_nocb_mask' set but not used [-Wunused-but-set-variable]
    1157 |  bool need_rcu_nocb_mask = false;
         |       ^~~~~~~~~~~~~~~~~~


vim +/need_rcu_nocb_mask +1157 kernel/rcu/tree_nocb.h

dfcb27540213e8 Frederic Weisbecker 2021-05-19  1153  
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1154  void __init rcu_init_nohz(void)
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1155  {
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1156  	int cpu;
dfcb27540213e8 Frederic Weisbecker 2021-05-19 @1157  	bool need_rcu_nocb_mask = false;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1158  	struct rcu_data *rdp;
dfcb27540213e8 Frederic Weisbecker 2021-05-19  1159  

:::::: The code at line 1157 was first introduced by commit
:::::: dfcb27540213e8061ecffacd4bd8ed54a310a7b0 rcu/nocb: Start moving nocb code to its own plugin file

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Paul E. McKenney <paulmck@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
