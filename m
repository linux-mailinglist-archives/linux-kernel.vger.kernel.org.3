Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6254A7E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbiBCDAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:00:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:32012 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349076AbiBCDAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643857241; x=1675393241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QbvTnnL+MRgF7Ucp//VgqN8FR2m3aWIH1m8CeU1thsE=;
  b=Nf0u/w1w/bTTOegM4btugLC0sfCuKmS7tdj0DizTXXHd7ePfbpMui39P
   sOc6PHhDxcifE8h/k/d875+/yTMpJ9aa4GTfT1/mrG8Ez+/L2Yss6CwOB
   zLGfk7q15Kt+zYHZXZHNATm8fHok3n9gPHkOecdqBnfacD9raNZvmqO2a
   dkxBz40NG3lxI2sOvDiWjuml2DBWPVy7vL4TPEc/YF+fW6czzndVYduV4
   lOfd/cf85Yz2rwzWwj/vkoJv1fKSd9zPe/zttrXbexMqqTxVObHXhtHmK
   8RV9ArBu5SLc82p6x6UCPlLXgpXbQy7i7BczRN5ulZ2waL6Bx5M+T0GTJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334424833"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="334424833"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="483094058"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 19:00:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFSMQ-000VTg-SX; Thu, 03 Feb 2022 03:00:38 +0000
Date:   Thu, 3 Feb 2022 11:00:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:paulmck/linux-rcu/dev.2022.02.01a 77/103]
 kernel/rcu/srcutree.c:424:5: error: 'struct srcu_struct' has no member named
 'srcu_size_state'
Message-ID: <202202031012.PzmEcyQ4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev.2022.02.01a
head:   5721fe42e5e76b24e5a37c4fb5a4807cd4eb925d
commit: efbdb910e14b15835266c55ad4d891dde0792aed [77/103] srcu: Dynamically allocate srcu_node array
config: i386-randconfig-a004-20211220 (https://download.01.org/0day-ci/archive/20220203/202202031012.PzmEcyQ4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/efbdb910e14b15835266c55ad4d891dde0792aed
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev.2022.02.01a
        git checkout efbdb910e14b15835266c55ad4d891dde0792aed
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/paulmck/linux-rcu/dev.2022.02.01a HEAD 5721fe42e5e76b24e5a37c4fb5a4807cd4eb925d builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   kernel/rcu/srcutree.c: In function 'cleanup_srcu_struct':
>> kernel/rcu/srcutree.c:424:5: error: 'struct srcu_struct' has no member named 'srcu_size_state'
     424 |  ssp->srcu_size_state = SRCU_SIZE_SMALL;
         |     ^~
>> kernel/rcu/srcutree.c:424:25: error: 'SRCU_SIZE_SMALL' undeclared (first use in this function)
     424 |  ssp->srcu_size_state = SRCU_SIZE_SMALL;
         |                         ^~~~~~~~~~~~~~~
   kernel/rcu/srcutree.c:424:25: note: each undeclared identifier is reported only once for each function it appears in


vim +424 kernel/rcu/srcutree.c

   387	
   388	/**
   389	 * cleanup_srcu_struct - deconstruct a sleep-RCU structure
   390	 * @ssp: structure to clean up.
   391	 *
   392	 * Must invoke this after you are finished using a given srcu_struct that
   393	 * was initialized via init_srcu_struct(), else you leak memory.
   394	 */
   395	void cleanup_srcu_struct(struct srcu_struct *ssp)
   396	{
   397		int cpu;
   398	
   399		if (WARN_ON(!srcu_get_delay(ssp)))
   400			return; /* Just leak it! */
   401		if (WARN_ON(srcu_readers_active(ssp)))
   402			return; /* Just leak it! */
   403		flush_delayed_work(&ssp->work);
   404		for_each_possible_cpu(cpu) {
   405			struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
   406	
   407			del_timer_sync(&sdp->delay_work);
   408			flush_work(&sdp->work);
   409			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
   410				return; /* Forgot srcu_barrier(), so just leak it! */
   411		}
   412		if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
   413		    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
   414		    WARN_ON(srcu_readers_active(ssp))) {
   415			pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
   416				__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
   417				rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
   418			return; /* Caller forgot to stop doing call_srcu()? */
   419		}
   420		free_percpu(ssp->sda);
   421		ssp->sda = NULL;
   422		kfree(ssp->node);
   423		ssp->node = NULL;
 > 424		ssp->srcu_size_state = SRCU_SIZE_SMALL;
   425	}
   426	EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
   427	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
