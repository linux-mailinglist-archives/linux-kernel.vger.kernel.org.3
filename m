Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FF64CCCA5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbiCDElb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiCDEl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:41:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB580180D29
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646368842; x=1677904842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aBR0XG0k+tv6/c82I4f74WJwaoS+TwzVjvDsorZXYQM=;
  b=AD2ohaOX2qdpY1tzegu9gduxtg8IN7mHlAakIo5l6ig9BiEX/y0Z8z2p
   Fv/Q4vdA2DSxiHdaGtDRb+8svLFNCnVXqwcUtvwi3UlhJNIelrNu87r/p
   ikONB9KCqcdamh6NStkBqksi0AQTgowAI2zt067iBDttNcWkYx5fBPE9A
   fi/SHGoEnqutYPTvBkeToMh51xIwyYXyp2z5saEUx+hKAzDQc1UJ+8QlN
   YIXFagWAvSQBnqucgcp6PVFeS6uTilQVmaSiqw94EvKGMuZWQvaWxT2C3
   Ca27aHuCKswQ2cWYFlL2uHSe2HsVzXGdkhZoZ73K1+JBBSYA4NARNFqeK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="317117980"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="317117980"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 20:40:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="508867809"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2022 20:40:40 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPzk8-0001Gh-6A; Fri, 04 Mar 2022 04:40:40 +0000
Date:   Fri, 4 Mar 2022 12:39:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Connor O'Brien <connoro@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 640/9999] kernel/bpf/core.c:1500:31: sparse: sparse: incorrect type in
 return expression (different address spaces)
Message-ID: <202203041208.lGSLS1gi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   4ab5bac1598e3ed91a6267f6cada336467312112
commit: 9e61c87b1f47b4dc3d48de83d85e9f17c320f91e [640/9999] UPSTREAM: bpf: multi program support for cgroup+bpf
config: i386-randconfig-s001-20211101 (https://download.01.org/0day-ci/archive/20220304/202203041208.lGSLS1gi-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/9e61c87b1f47b4dc3d48de83d85e9f17c320f91e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout 9e61c87b1f47b4dc3d48de83d85e9f17c320f91e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/virtio/ kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/bpf/core.c:1095:43: sparse: sparse: arithmetics on pointers to functions
>> kernel/bpf/core.c:1500:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct bpf_prog_array [noderef] <asn:4> * @@     got void * @@
   kernel/bpf/core.c:1500:31: sparse:     expected struct bpf_prog_array [noderef] <asn:4> *
   kernel/bpf/core.c:1500:31: sparse:     got void *
>> kernel/bpf/core.c:1504:17: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct bpf_prog_array [noderef] <asn:4> * @@     got struct bpf_prog_array * @@
   kernel/bpf/core.c:1504:17: sparse:     expected struct bpf_prog_array [noderef] <asn:4> *
   kernel/bpf/core.c:1504:17: sparse:     got struct bpf_prog_array *
   kernel/bpf/core.c:1512:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct callback_head *head @@     got struct callback_head [noderef] <asn:4> * @@
   kernel/bpf/core.c:1512:9: sparse:     expected struct callback_head *head
   kernel/bpf/core.c:1512:9: sparse:     got struct callback_head [noderef] <asn:4> *
   kernel/bpf/core.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/bpf.h, ...):
   include/trace/events/bpf.h:56:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:92:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:117:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:188:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:228:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:282:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/bpf.h:312:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/bpf/core.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/xdp.h, ...):
   include/trace/events/xdp.h:28:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:53:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:111:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:126:1: sparse: sparse: Using plain integer as NULL pointer

vim +1500 kernel/bpf/core.c

  1496	
  1497	struct bpf_prog_array __rcu *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags)
  1498	{
  1499		if (prog_cnt)
> 1500			return kzalloc(sizeof(struct bpf_prog_array) +
  1501				       sizeof(struct bpf_prog *) * (prog_cnt + 1),
  1502				       flags);
  1503	
> 1504		return &empty_prog_array.hdr;
  1505	}
  1506	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
