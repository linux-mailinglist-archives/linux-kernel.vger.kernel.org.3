Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEFB4A552E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiBACPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:15:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:62483 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbiBACPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643681711; x=1675217711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=74gUUhP+ox21nViXtqKt9guNjZ1spLIfXUftJf7SJZg=;
  b=EGMaeMP3SnCR9v8uABBVMYxQCbCtzDHQFaGA8MFeYobRcLMRnJ3jPmtK
   W9s3EIsPVogxAz2OkUS+MzoIP8QO+1zWMvUCHAD1jlChsCokJ+YxRQcu+
   gyaLZ11+4iC62soxpZ1KVWi8rJyKM7DzLDeHGUYiAr90tpruJ6VZkuxH9
   mKv8yQ+c+8HQrvBvK6RPpAkWwjM2oAZMCKtNJ6FjMNcZvM368qktJ9gJk
   vgCUTJMzyOux2U7eT5kE0J8+Vu0GxSBeWSqadzHWQxOfn+hPSP6jMCRlI
   RP9ICpnudFTZKnQGYTeelUdG8cfDM9Ud4JFZWmBrDTXJo7sWkvwXoyoWn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="272082509"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="272082509"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 18:15:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="630240580"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2022 18:15:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEihF-000SbQ-UW; Tue, 01 Feb 2022 02:15:05 +0000
Date:   Tue, 1 Feb 2022 10:14:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [trondmy-nfs-2.6:testing 10/19] fs/nfs/nfs4state.c:2572:13: error:
 implicit declaration of function 'memalloc_nofs_save'
Message-ID: <202202011021.MbDOMg4H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git testing
head:   ad0a7ba45fd8af0dceeadddd78d85a85df429f5b
commit: 2f9032d5005af9b1581630763b61e3acd5dbaea4 [10/19] NFSv4: Protect the state recovery thread against direct reclaim
config: x86_64-randconfig-a013-20220131 (https://download.01.org/0day-ci/archive/20220201/202202011021.MbDOMg4H-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add trondmy-nfs-2.6 git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
        git fetch --no-tags trondmy-nfs-2.6 testing
        git checkout 2f9032d5005af9b1581630763b61e3acd5dbaea4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/nfs/nfs4state.c:2572:13: error: implicit declaration of function 'memalloc_nofs_save' [-Werror,-Wimplicit-function-declaration]
           memflags = memalloc_nofs_save();
                      ^
>> fs/nfs/nfs4state.c:2668:3: error: implicit declaration of function 'memalloc_nofs_restore' [-Werror,-Wimplicit-function-declaration]
                   memalloc_nofs_restore(memflags);
                   ^
   fs/nfs/nfs4state.c:2668:3: note: did you mean 'memalloc_nofs_save'?
   fs/nfs/nfs4state.c:2572:13: note: 'memalloc_nofs_save' declared here
           memflags = memalloc_nofs_save();
                      ^
   fs/nfs/nfs4state.c:2699:2: error: implicit declaration of function 'memalloc_nofs_restore' [-Werror,-Wimplicit-function-declaration]
           memalloc_nofs_restore(memflags);
           ^
   3 errors generated.


vim +/memalloc_nofs_save +2572 fs/nfs/nfs4state.c

  2560	
  2561	static void nfs4_state_manager(struct nfs_client *clp)
  2562	{
  2563		unsigned int memflags;
  2564		int status = 0;
  2565		const char *section = "", *section_sep = "";
  2566	
  2567		/*
  2568		 * State recovery can deadlock if the direct reclaim code tries
  2569		 * start NFS writeback. So ensure memory allocations are all
  2570		 * GFP_NOFS.
  2571		 */
> 2572		memflags = memalloc_nofs_save();
  2573	
  2574		/* Ensure exclusive access to NFSv4 state */
  2575		do {
  2576			trace_nfs4_state_mgr(clp);
  2577			clear_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
  2578			if (test_bit(NFS4CLNT_PURGE_STATE, &clp->cl_state)) {
  2579				section = "purge state";
  2580				status = nfs4_purge_lease(clp);
  2581				if (status < 0)
  2582					goto out_error;
  2583				continue;
  2584			}
  2585	
  2586			if (test_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state)) {
  2587				section = "lease expired";
  2588				/* We're going to have to re-establish a clientid */
  2589				status = nfs4_reclaim_lease(clp);
  2590				if (status < 0)
  2591					goto out_error;
  2592				continue;
  2593			}
  2594	
  2595			/* Initialize or reset the session */
  2596			if (test_and_clear_bit(NFS4CLNT_SESSION_RESET, &clp->cl_state)) {
  2597				section = "reset session";
  2598				status = nfs4_reset_session(clp);
  2599				if (test_bit(NFS4CLNT_LEASE_EXPIRED, &clp->cl_state))
  2600					continue;
  2601				if (status < 0)
  2602					goto out_error;
  2603			}
  2604	
  2605			/* Send BIND_CONN_TO_SESSION */
  2606			if (test_and_clear_bit(NFS4CLNT_BIND_CONN_TO_SESSION,
  2607					&clp->cl_state)) {
  2608				section = "bind conn to session";
  2609				status = nfs4_bind_conn_to_session(clp);
  2610				if (status < 0)
  2611					goto out_error;
  2612				continue;
  2613			}
  2614	
  2615			if (test_and_clear_bit(NFS4CLNT_CHECK_LEASE, &clp->cl_state)) {
  2616				section = "check lease";
  2617				status = nfs4_check_lease(clp);
  2618				if (status < 0)
  2619					goto out_error;
  2620				continue;
  2621			}
  2622	
  2623			if (test_and_clear_bit(NFS4CLNT_MOVED, &clp->cl_state)) {
  2624				section = "migration";
  2625				status = nfs4_handle_migration(clp);
  2626				if (status < 0)
  2627					goto out_error;
  2628			}
  2629	
  2630			if (test_and_clear_bit(NFS4CLNT_LEASE_MOVED, &clp->cl_state)) {
  2631				section = "lease moved";
  2632				status = nfs4_handle_lease_moved(clp);
  2633				if (status < 0)
  2634					goto out_error;
  2635			}
  2636	
  2637			/* First recover reboot state... */
  2638			if (test_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state)) {
  2639				section = "reclaim reboot";
  2640				status = nfs4_do_reclaim(clp,
  2641					clp->cl_mvops->reboot_recovery_ops);
  2642				if (status == -EAGAIN)
  2643					continue;
  2644				if (status < 0)
  2645					goto out_error;
  2646				nfs4_state_end_reclaim_reboot(clp);
  2647			}
  2648	
  2649			/* Detect expired delegations... */
  2650			if (test_and_clear_bit(NFS4CLNT_DELEGATION_EXPIRED, &clp->cl_state)) {
  2651				section = "detect expired delegations";
  2652				nfs_reap_expired_delegations(clp);
  2653				continue;
  2654			}
  2655	
  2656			/* Now recover expired state... */
  2657			if (test_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state)) {
  2658				section = "reclaim nograce";
  2659				status = nfs4_do_reclaim(clp,
  2660					clp->cl_mvops->nograce_recovery_ops);
  2661				if (status == -EAGAIN)
  2662					continue;
  2663				if (status < 0)
  2664					goto out_error;
  2665				clear_bit(NFS4CLNT_RECLAIM_NOGRACE, &clp->cl_state);
  2666			}
  2667	
> 2668			memalloc_nofs_restore(memflags);
  2669			nfs4_end_drain_session(clp);
  2670			nfs4_clear_state_manager_bit(clp);
  2671	
  2672			if (!test_and_set_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state)) {
  2673				if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
  2674					nfs_client_return_marked_delegations(clp);
  2675					set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
  2676				}
  2677				nfs4_layoutreturn_any_run(clp);
  2678				clear_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state);
  2679			}
  2680	
  2681			/* Did we race with an attempt to give us more work? */
  2682			if (!test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state))
  2683				return;
  2684			if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
  2685				return;
  2686			memflags = memalloc_nofs_save();
  2687		} while (refcount_read(&clp->cl_count) > 1 && !signalled());
  2688		goto out_drain;
  2689	
  2690	out_error:
  2691		if (strlen(section))
  2692			section_sep = ": ";
  2693		trace_nfs4_state_mgr_failed(clp, section, status);
  2694		pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
  2695				" with error %d\n", section_sep, section,
  2696				clp->cl_hostname, -status);
  2697		ssleep(1);
  2698	out_drain:
  2699		memalloc_nofs_restore(memflags);
  2700		nfs4_end_drain_session(clp);
  2701		nfs4_clear_state_manager_bit(clp);
  2702	}
  2703	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
