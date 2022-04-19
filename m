Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA850629A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbiDSD3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346588AbiDSD3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:29:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46AB2899B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650338791; x=1681874791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r+QISWs4fMwsMVKIBPuBSRZ9kMAUjuYmYVVU7WsKJDw=;
  b=PaCItAxhqX/fM4pvr0FFcL/817Sxm7abSjMHxGcuXFC65usCXt2/Ty5I
   3VOv8GU/INdgsOKQphv5IroEUhn+16y5bWJdZ0BtlXMaY871dh+ynRwZE
   dBidsG1/73ckeyokTnYG7yVi31ggT08MftwyiIDRl7NjLq9UBPJ20Zk+f
   gW5inrHwwRyVS92sBxwdEncjM6aOLnA9vvgjC9psxedpdkea/Y19CjPaL
   capN+X7Bh1dPMmcujf23bFluUefmN0alTUyY3rbjADRCwSG3ahb7Rnf/B
   wNxFIwIOm+eqYXVcpOBBFvKMZsUMDplFVWK4a0/eDrbX4UwjW7rPShvAW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350113224"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350113224"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="561559520"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2022 20:26:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngeVQ-0005Hv-AF;
        Tue, 19 Apr 2022 03:26:20 +0000
Date:   Tue, 19 Apr 2022 11:26:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1662/2356]
 include/linux/bpf-cgroup-api.h:99:17: warning: incompatible integer to
 pointer conversion initializing 'struct cgroup *' with an expression of type
 'int'
Message-ID: <202204191109.jMo5t4hA-lkp@intel.com>
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
commit: 946f6b0a519a1210d974a40c8400726c341e0bd6 [1662/2356] headers/deps: cgroup: Split <linux/bpf-cgroup.h> into <linux/bpf-cgroup-types.h> and <linux/bpf-cgroup-api.h>
config: x86_64-randconfig-a013-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191109.jMo5t4hA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=946f6b0a519a1210d974a40c8400726c341e0bd6
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 946f6b0a519a1210d974a40c8400726c341e0bd6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/bpf/ mm/ net/ipv4/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/bpf/cgroup.c:17:
   include/linux/bpf-cgroup-api.h:99:24: error: implicit declaration of function 'sock_cgroup_ptr' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
                                 ^
>> include/linux/bpf-cgroup-api.h:99:17: warning: incompatible integer to pointer conversion initializing 'struct cgroup *' with an expression of type 'int' [-Wint-conversion]
           struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
                          ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/bpf/cgroup.c:31:
   In file included from kernel/bpf/../cgroup/cgroup-internal.h:7:
   include/linux/cgroup_api.h:875:30: error: static declaration of 'sock_cgroup_ptr' follows non-static declaration
   static inline struct cgroup *sock_cgroup_ptr(struct sock_cgroup_data *skcd)
                                ^
   include/linux/bpf-cgroup-api.h:99:24: note: previous implicit declaration is here
           struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
                                 ^
   1 warning and 2 errors generated.
--
   In file included from net/ipv4/udp.c:103:
   include/linux/bpf-cgroup-api.h:99:24: error: implicit declaration of function 'sock_cgroup_ptr' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
                                 ^
>> include/linux/bpf-cgroup-api.h:99:17: warning: incompatible integer to pointer conversion initializing 'struct cgroup *' with an expression of type 'int' [-Wint-conversion]
           struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
                          ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +99 include/linux/bpf-cgroup-api.h

    90	
    91	int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void *value);
    92	int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
    93					     void *value, u64 flags);
    94	
    95	/* Opportunistic check to see whether we have any BPF program attached*/
    96	static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
    97						   enum cgroup_bpf_attach_type type)
    98	{
  > 99		struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
   100		struct bpf_prog_array *array;
   101	
   102		array = rcu_access_pointer(cgrp->bpf.effective[type]);
   103		return array != &bpf_empty_prog_array.hdr;
   104	}
   105	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
