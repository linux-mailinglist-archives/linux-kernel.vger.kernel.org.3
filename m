Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8430575946
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiGOB4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiGOB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:56:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1225D6B75E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657850159; x=1689386159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PvdmQ9w+gapwigO731le5cyFiNOvHbo1Pum/NKeja04=;
  b=CemLdAbn2Rjgxp6D2ai92vv8ClEzuPpcrNYx+J0uK21R1WOcbRy+BB+6
   sRW79IJXO2g8c0Kkj3FefNRhulQ5nX+OPjaMy72ZsLNNKGNWe6BxvNFXX
   HImw++n4UNpZMmA9EW1L4rxJYIrh8roAtnhanitVcO1sKBquQDajLeDG3
   oDlCrVSIOFznp13uuDZj1USf9m7+vV8aKcunSoq+dbGWGdL9eYCkRwiTt
   20ko63+QyL+Yvvtr0++LCdfziSB7wtDJ4uehdPI6zBwA0Sg29rYcdYVz5
   lG2CMo2mJI5qEa1y1BmBZMXBQDaadQ5eUDxR3NqNfw5w2iW3IWJ1CoD0z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268703588"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="268703588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="623660962"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2022 18:55:57 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCAYe-0001Pn-FH;
        Fri, 15 Jul 2022 01:55:56 +0000
Date:   Fri, 15 Jul 2022 09:55:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ast-bpf:memalloc 1/7] kernel/bpf/memalloc.c:158:10: error: call to
 undeclared function 'get_mem_cgroup_from_objcg'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202207150914.NwhVRROz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git memalloc
head:   02e9f2eaae15bfdbc6ab59716ec63c471daa8822
commit: a4e9a79dc137aa2436d0217a0ac415e884cfa862 [1/7] bpf: Introduce any context BPF specific memory allocator.
config: hexagon-randconfig-r006-20220714 (https://download.01.org/0day-ci/archive/20220715/202207150914.NwhVRROz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?id=a4e9a79dc137aa2436d0217a0ac415e884cfa862
        git remote add ast-bpf https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git
        git fetch --no-tags ast-bpf memalloc
        git checkout a4e9a79dc137aa2436d0217a0ac415e884cfa862
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/bpf/memalloc.c:158:10: error: call to undeclared function 'get_mem_cgroup_from_objcg'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   return get_mem_cgroup_from_objcg(c->objcg);
                          ^
   kernel/bpf/memalloc.c:158:10: note: did you mean 'get_mem_cgroup_from_mm'?
   include/linux/memcontrol.h:1271:34: note: 'get_mem_cgroup_from_mm' declared here
   static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
                                    ^
>> kernel/bpf/memalloc.c:158:10: warning: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct mem_cgroup *' [-Wint-conversion]
                   return get_mem_cgroup_from_objcg(c->objcg);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/get_mem_cgroup_from_objcg +158 kernel/bpf/memalloc.c

   154	
   155	static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
   156	{
   157		if (c->objcg)
 > 158			return get_mem_cgroup_from_objcg(c->objcg);
   159	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
