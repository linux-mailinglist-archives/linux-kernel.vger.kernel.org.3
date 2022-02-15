Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9334B6AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiBOLZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:25:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiBOLY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:24:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765110855C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644924289; x=1676460289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dGvHOm3GzQ/RImX1rvRjCrdnjiyvMfLPKbT8wZlS/6U=;
  b=Kv9lUBnzLQUrmbRdhycfAJrFP2Jfuzuz9gS6UCUktzn0FyaZCSJX9FTD
   VrTCh3mJP0DVpHt9UvYGXNaf21AW/WuVypIeHDny2lVMocvpxGHYvr7QU
   Jj9M9rxI+F6vvGfuCMxD8rEMXeoSSol2SxintQ2nEUO7PlZXkpKHhqlvQ
   QQz4LBfXNfMAGbQvQWf93dBBnzKKkLtP2cvgXDT2c89LPzhimJSiy/Jok
   /Pz3N/YvJWmCgWWD7340ZEArDe7Flr2zXm9sRuduDm/D/3cLSKDhRTewt
   ZRnwvCw9tpGVg4ZQa4NeqzqqXeBXxHoLkhdkDueYNMIxDDaQMjifvKZ2d
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250275049"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="250275049"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 03:24:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="502380139"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 03:24:46 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJvws-0009be-84; Tue, 15 Feb 2022 11:24:46 +0000
Date:   Tue, 15 Feb 2022 19:23:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:nfsd-courteous-server 32/34] fs/nfsd/nfs4state.c:5893:9: error:
 implicit declaration of function 'nfsd4_get_client_reaplist'; did you mean
 'nfs4_get_client_reaplist'?
Message-ID: <202202151804.8Tf5mieQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
head:   4b14f83e0bc79cb49f28fdc63a370c19637e2bfc
commit: 2fb4c8cd9a292bbee4428e9c6d33be28ca5775c6 [32/34] NFSD: Refactor nfsd4_laundromat()
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220215/202202151804.8Tf5mieQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=2fb4c8cd9a292bbee4428e9c6d33be28ca5775c6
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel nfsd-courteous-server
        git checkout 2fb4c8cd9a292bbee4428e9c6d33be28ca5775c6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/nfsd/nfs4state.c: In function 'nfs4_laundromat':
>> fs/nfsd/nfs4state.c:5893:9: error: implicit declaration of function 'nfsd4_get_client_reaplist'; did you mean 'nfs4_get_client_reaplist'? [-Werror=implicit-function-declaration]
    5893 |         nfsd4_get_client_reaplist(nn, &reaplist, &lt);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         nfs4_get_client_reaplist
   At top level:
   fs/nfsd/nfs4state.c:5841:1: warning: 'nfs4_get_client_reaplist' defined but not used [-Wunused-function]
    5841 | nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +5893 fs/nfsd/nfs4state.c

  5860	
  5861	static time64_t
  5862	nfs4_laundromat(struct nfsd_net *nn)
  5863	{
  5864		struct nfs4_client *clp;
  5865		struct nfs4_openowner *oo;
  5866		struct nfs4_delegation *dp;
  5867		struct nfs4_ol_stateid *stp;
  5868		struct nfsd4_blocked_lock *nbl;
  5869		struct list_head *pos, *next, reaplist;
  5870		struct laundry_time lt = {
  5871			.cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease,
  5872			.new_timeo = nn->nfsd4_lease
  5873		};
  5874		struct nfs4_cpntf_state *cps;
  5875		copy_stateid_t *cps_t;
  5876		int i;
  5877	
  5878		if (clients_still_reclaiming(nn)) {
  5879			lt.new_timeo = 0;
  5880			goto out;
  5881		}
  5882		nfsd4_end_grace(nn);
  5883	
  5884		spin_lock(&nn->s2s_cp_lock);
  5885		idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
  5886			cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
  5887			if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
  5888					state_expired(&lt, cps->cpntf_time))
  5889				_free_cpntf_state_locked(nn, cps);
  5890		}
  5891		spin_unlock(&nn->s2s_cp_lock);
  5892	
> 5893		nfsd4_get_client_reaplist(nn, &reaplist, &lt);
  5894		list_for_each_safe(pos, next, &reaplist) {
  5895			clp = list_entry(pos, struct nfs4_client, cl_lru);
  5896			trace_nfsd_clid_purged(&clp->cl_clientid);
  5897			list_del_init(&clp->cl_lru);
  5898			expire_client(clp);
  5899		}
  5900		spin_lock(&state_lock);
  5901		list_for_each_safe(pos, next, &nn->del_recall_lru) {
  5902			dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
  5903			if (!state_expired(&lt, dp->dl_time))
  5904				break;
  5905			WARN_ON(!unhash_delegation_locked(dp));
  5906			list_add(&dp->dl_recall_lru, &reaplist);
  5907		}
  5908		spin_unlock(&state_lock);
  5909		while (!list_empty(&reaplist)) {
  5910			dp = list_first_entry(&reaplist, struct nfs4_delegation,
  5911						dl_recall_lru);
  5912			list_del_init(&dp->dl_recall_lru);
  5913			revoke_delegation(dp);
  5914		}
  5915	
  5916		spin_lock(&nn->client_lock);
  5917		while (!list_empty(&nn->close_lru)) {
  5918			oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
  5919						oo_close_lru);
  5920			if (!state_expired(&lt, oo->oo_time))
  5921				break;
  5922			list_del_init(&oo->oo_close_lru);
  5923			stp = oo->oo_last_closed_stid;
  5924			oo->oo_last_closed_stid = NULL;
  5925			spin_unlock(&nn->client_lock);
  5926			nfs4_put_stid(&stp->st_stid);
  5927			spin_lock(&nn->client_lock);
  5928		}
  5929		spin_unlock(&nn->client_lock);
  5930	
  5931		/*
  5932		 * It's possible for a client to try and acquire an already held lock
  5933		 * that is being held for a long time, and then lose interest in it.
  5934		 * So, we clean out any un-revisited request after a lease period
  5935		 * under the assumption that the client is no longer interested.
  5936		 *
  5937		 * RFC5661, sec. 9.6 states that the client must not rely on getting
  5938		 * notifications and must continue to poll for locks, even when the
  5939		 * server supports them. Thus this shouldn't lead to clients blocking
  5940		 * indefinitely once the lock does become free.
  5941		 */
  5942		BUG_ON(!list_empty(&reaplist));
  5943		spin_lock(&nn->blocked_locks_lock);
  5944		while (!list_empty(&nn->blocked_locks_lru)) {
  5945			nbl = list_first_entry(&nn->blocked_locks_lru,
  5946						struct nfsd4_blocked_lock, nbl_lru);
  5947			if (!state_expired(&lt, nbl->nbl_time))
  5948				break;
  5949			list_move(&nbl->nbl_lru, &reaplist);
  5950			list_del_init(&nbl->nbl_list);
  5951		}
  5952		spin_unlock(&nn->blocked_locks_lock);
  5953	
  5954		while (!list_empty(&reaplist)) {
  5955			nbl = list_first_entry(&reaplist,
  5956						struct nfsd4_blocked_lock, nbl_lru);
  5957			list_del_init(&nbl->nbl_lru);
  5958			free_blocked_lock(nbl);
  5959		}
  5960	#ifdef CONFIG_NFSD_V4_2_INTER_SSC
  5961		/* service the server-to-server copy delayed unmount list */
  5962		nfsd4_ssc_expire_umount(nn);
  5963	#endif
  5964	out:
  5965		return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
  5966	}
  5967	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
