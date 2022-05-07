Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A451E795
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385297AbiEGN4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384419AbiEGN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:56:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA547390
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651931567; x=1683467567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hcW3bxB9BNwR2j6I9hqm7xruIxTlHtcZ5M6fanEvKkA=;
  b=gpsXSpn9urDCNB9xCYO6yVsX+7T77fTkbNi4sUIqkwn1glzhJVumdp++
   ccJithWu99FHSaQufrjhq5lmUfKUolNNre8oLS1eDIxkvYonCxkeAJihk
   qmhPiLcIXjPZLjSEdJpYtVV0sTGvqd7DIiEsX0RMR4zXhTZ/U8BwORzL1
   lrivWy5NqkjWB0HGoZkUEBH8SrXNd9dRSVHO0PbqgsxwCbVAeO3cM3/f+
   WW1MfSVcRM6vq1WknMbW8nfCq+7s4pY+i19uAAA4DfgIDBLa5RX6OUBpw
   QtHTgD36xyOdx+PDdmqWPt14BfFjlWuFVMde4B4pYVT0m7T7eLSX791g1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="268851678"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="268851678"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 06:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="695608332"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 May 2022 06:52:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnKrU-000Ecp-7q;
        Sat, 07 May 2022 13:52:44 +0000
Date:   Sat, 7 May 2022 21:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap-cocci 15/15] kernel/sched/topology.c:2002:45: error:
 too many arguments to function call, expected single argument 'srcp', have 2
 arguments
Message-ID: <202205072127.9RxAaefa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-cocci
head:   3175a64928a804328d3f9a87af8bfda683539bee
commit: 3175a64928a804328d3f9a87af8bfda683539bee [15/15] sched/topology: replace cpumask_weight() with cpumask_weight_eq where appropriate
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220507/202205072127.9RxAaefa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af4cf1c6b8ed0d8102fc5e69acdc2fcbbcdaa9a7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/3175a64928a804328d3f9a87af8bfda683539bee
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-cocci
        git checkout 3175a64928a804328d3f9a87af8bfda683539bee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:89:
>> kernel/sched/topology.c:2002:45: error: too many arguments to function call, expected single argument 'srcp', have 2 arguments
           if (!cpumask_weight(cpumask_of_node(node), 1))
                ~~~~~~~~~~~~~~                        ^
   include/linux/cpumask.h:573:28: note: 'cpumask_weight' declared here
   static inline unsigned int cpumask_weight(const struct cpumask *srcp)
                              ^
   1 error generated.


vim +/srcp +2002 kernel/sched/topology.c

  1989	
  1990	/*
  1991	 * Call with hotplug lock held
  1992	 */
  1993	void sched_update_numa(int cpu, bool online)
  1994	{
  1995		int node;
  1996	
  1997		node = cpu_to_node(cpu);
  1998		/*
  1999		 * Scheduler NUMA topology is updated when the first CPU of a
  2000		 * node is onlined or the last CPU of a node is offlined.
  2001		 */
> 2002		if (!cpumask_weight(cpumask_of_node(node), 1))
  2003			return;
  2004	
  2005		sched_reset_numa();
  2006		sched_init_numa(online ? NUMA_NO_NODE : node);
  2007	}
  2008	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
