Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB44D9511
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbiCOHRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiCOHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:17:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE023969E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647328562; x=1678864562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q6I9KqQ8AG2SG/JyHCrH0lpS6xnaD0vMfa3HpA1uIJA=;
  b=B5VUb4DYQ9DhkdoPFJ87Ovar/62IOIfY8VCtwqEyeHYnbBEmrJotzal3
   FcnsIIAAuV8ylhGm4a4rEQI6PSfZsO/kBLWngLdMCBGYJ6TSaqXBBwiR1
   M9VGuojspwORWmbfYUM51pc0ab/YeUsEAfRoefe5GKoN+SmanOz5F6iFZ
   dfGeddpf01FoOTh+wdpEmJ458KbiQOOA3kaWPGAs1MaZ8ePxvkOyOmNWP
   wqgERkgf/6RnsWB0SWUsGX1OT0iwnJzMi1URPVM6kalnZga2oyANT5YGm
   kmx5sYS5xtzKLeaRbGxWgCdDlWRcj9hywPnX4P3I1XKb5F2OGSN6LxwTd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255062200"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="255062200"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 00:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="540314783"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2022 00:16:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nU1PU-000Ag9-Fj; Tue, 15 Mar 2022 07:16:00 +0000
Date:   Tue, 15 Mar 2022 15:15:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt.ud1 39/56] net/sunrpc/clnt.o: warning:
 objtool: rpc_run_task() falls through to next function
 rpc_call_null_helper()
Message-ID: <202203151512.HTVGuNrr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt.ud1
head:   f86aacc74625dc1b2b1d2ae309d2a832dba4d4f4
commit: 4c90d8ae1079abe5849747099a8ba128a7a19d84 [39/56] x86: Mark __invalid_creds() __noreturn
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220315/202203151512.HTVGuNrr-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4c90d8ae1079abe5849747099a8ba128a7a19d84
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt.ud1
        git checkout 4c90d8ae1079abe5849747099a8ba128a7a19d84
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs// kernel// net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sunrpc/clnt.o: warning: objtool: rpc_run_task() falls through to next function rpc_call_null_helper()
--
>> net/sunrpc/auth.o: warning: objtool: rpcauth_init_cred() falls through to next function rpcauth_get_authops()
--
>> fs/nfs/nfs4state.o: warning: objtool: nfs4_establish_lease() falls through to next function nfs4_state_end_reclaim_reboot()
>> fs/nfs/nfs4state.o: warning: objtool: nfs4_state_end_reclaim_reboot() falls through to next function nfs4_recovery_handle_error()
   fs/nfs/nfs4state.o: warning: objtool: nfs4_get_machine_cred() falls through to next function nfs4_get_renew_cred()
   fs/nfs/nfs4state.o: warning: objtool: nfs4_get_renew_cred() falls through to next function nfs4_get_clid_cred()
>> fs/nfs/nfs4state.o: warning: objtool: nfs4_get_clid_cred() falls through to next function nfs4_get_state_owner()
--
>> fs/nfs/nfs4renewd.o: warning: objtool: nfs4_renew_state() falls through to next function nfs4_kill_renewd()
--
>> fs/nfs/delegation.o: warning: objtool: nfs_do_return_delegation() falls through to next function nfs4_do_check_delegation()
   fs/nfs/delegation.o: warning: objtool: nfs4_copy_delegation_stateid() falls through to next function nfs4_delegation_flush_on_close()
--
>> fs/nfs/nfs4idmap.o: warning: objtool: put_cred() falls through to next function nfs_idmap_legacy_upcall()
--
>> fs/nfs/nfs4client.o: warning: objtool: nfs4_create_referral_server() falls through to next function nfs4_update_server()

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
