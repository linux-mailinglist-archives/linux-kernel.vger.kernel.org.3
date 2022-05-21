Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F91A52FF9C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 23:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbiEUVf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiEUVf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 17:35:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D910FE1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 14:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653168954; x=1684704954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zR7Y1g/C/Z6Cz8ORNwIwd2RSqbEMll7sIDR6xIUT72s=;
  b=eF2eLBmX/M8yN10q2x7P/0JEP0PoDSM6dluTdJwxPnYYyrsn8uN4O0kM
   272d0LaVFwVyK1y6MsaLsHul00y1In/PJV9Axb+Ky2PK31Ml7X8QbsHdv
   l2dKPoTymM1f34Iyq6/5QjnazMvcDQ7i2SCVzVVLLf62KbY0Ctv9f1EyE
   XBe/V/lJ5b2O4IzCvcEClbMFfH1htORs/Cgpn2H5BadoVw7BGl6NN7hOu
   3TdiC8IeNKBzYsSl9PaCxn/f0AQqiFWvlduU8fJsmzv63FyUomHBqBcli
   hozVNFedO40rEtMJwV9TGvnnROjivvVmTYbfCxqtP5jP5Nh/VfjIuzAZO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="270488198"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="270488198"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 14:35:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="744019050"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2022 14:35:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsWlM-0006cy-6u;
        Sat, 21 May 2022 21:35:52 +0000
Date:   Sun, 22 May 2022 05:35:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 1/3] net/core/skb_map.c:264:36: warning: unused
 variable 'bpf_skb_map_pop_proto'
Message-ID: <202205220540.iNtltJFv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   c3a4f3837326ac3d30a3775f7671467b27cc42b7
commit: a9c541fc36e03672a64d65cfa7a08e65743f34c2 [1/3] bpf: introduce skb map
config: hexagon-randconfig-r006-20220522 (https://download.01.org/0day-ci/archive/20220522/202205220540.iNtltJFv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b369762beb70dfef22c7e793aed79b94d7dc0757)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/a9c541fc36e03672a64d65cfa7a08e65743f34c2
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout a9c541fc36e03672a64d65cfa7a08e65743f34c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/core/skb_map.c:264:36: warning: unused variable 'bpf_skb_map_pop_proto' [-Wunused-const-variable]
   static const struct bpf_func_proto bpf_skb_map_pop_proto = {
                                      ^
>> net/core/skb_map.c:287:36: warning: unused variable 'bpf_skb_map_push_proto' [-Wunused-const-variable]
   static const struct bpf_func_proto bpf_skb_map_push_proto = {
                                      ^
   2 warnings generated.


vim +/bpf_skb_map_pop_proto +264 net/core/skb_map.c

   263	
 > 264	static const struct bpf_func_proto bpf_skb_map_pop_proto = {
   265		.func		= bpf_skb_map_pop,
   266		.gpl_only	= false,
   267		.ret_type	= RET_INTEGER,
   268		.arg1_type	= ARG_CONST_MAP_PTR,
   269		.arg2_type	= ARG_ANYTHING,
   270	};
   271	
   272	BPF_CALL_3(bpf_skb_map_push, struct bpf_map *, map, struct sk_buff *, skb, u64, key)
   273	{
   274		struct bpf_skb_map *rb = bpf_skb_map(map);
   275		unsigned long flags;
   276	
   277		if (atomic_inc_return(&rb->count) > rb->map.max_entries)
   278			return -ENOBUFS;
   279		skb = skb_get(skb);
   280		skb_map_cb(skb)->rank = key;
   281		raw_spin_lock_irqsave(&rb->lock, flags);
   282		skb_rb_push(&rb->root, skb);
   283		raw_spin_unlock_irqrestore(&rb->lock, flags);
   284		return 0;
   285	}
   286	
 > 287	static const struct bpf_func_proto bpf_skb_map_push_proto = {
   288		.func		= bpf_skb_map_push,
   289		.gpl_only	= false,
   290		.ret_type	= RET_INTEGER,
   291		.arg1_type	= ARG_CONST_MAP_PTR,
   292		.arg2_type	= ARG_PTR_TO_CTX,
   293		.arg3_type	= ARG_ANYTHING,
   294	};
   295	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
