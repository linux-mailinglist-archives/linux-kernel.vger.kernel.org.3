Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C902D51E78D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385248AbiEGN4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354840AbiEGN4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:56:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D00A46B27
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651931567; x=1683467567;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AtwuAdbRGYliEZvMJZsmN9JyjkfGJYzyNcZLH4MV4A0=;
  b=IzKkPWWSCUruFho5sFILpgret27mXrniMgRw8l8FRQSJkM2bBkmxP/HX
   0+92/qM2KZ/aTpHSwylnaniP8xp9JSdLigtfpYq/r90ElnEh+TjniXFVw
   JxuqtpwPWV+4pd0qxa2nqKlnwN//pXZQS4QONxaWAxxcmGMtQaqv3Mky6
   TapyzMLHPJ9rd8ut4PT9WfyFQSIvPH5AeFxrCb/gX2bl59il20zxA8UhO
   KEqAC9vba4QEBtFYuHDYE/X8sql7tGVhWsBQtgryGA02UUwKDmPPPdzCx
   Kq/deieW6/famu2xhc+dNNlfpWJO4cUJkd9wbazEcL6alrGCLMVv7/R1I
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="268336242"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="268336242"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 06:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="569486347"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 May 2022 06:52:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnKrV-000Ed6-28;
        Sat, 07 May 2022 13:52:45 +0000
Date:   Sat, 7 May 2022 21:51:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-cocci 15/15] kernel/sched/topology.c:2002:14: error:
 too many arguments to function 'cpumask_weight'
Message-ID: <202205072103.8QX1JxvR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-cocci
head:   3175a64928a804328d3f9a87af8bfda683539bee
commit: 3175a64928a804328d3f9a87af8bfda683539bee [15/15] sched/topology: replace cpumask_weight() with cpumask_weight_eq where appropriate
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220507/202205072103.8QX1JxvR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/3175a64928a804328d3f9a87af8bfda683539bee
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-cocci
        git checkout 3175a64928a804328d3f9a87af8bfda683539bee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:89:
   kernel/sched/topology.c: In function 'sched_update_numa':
>> kernel/sched/topology.c:2002:14: error: too many arguments to function 'cpumask_weight'
    2002 |         if (!cpumask_weight(cpumask_of_node(node), 1))
         |              ^~~~~~~~~~~~~~
   In file included from include/linux/smp.h:13,
                    from include/linux/sched/clock.h:5,
                    from kernel/sched/build_utility.c:12:
   include/linux/cpumask.h:573:28: note: declared here
     573 | static inline unsigned int cpumask_weight(const struct cpumask *srcp)
         |                            ^~~~~~~~~~~~~~


vim +/cpumask_weight +2002 kernel/sched/topology.c

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
