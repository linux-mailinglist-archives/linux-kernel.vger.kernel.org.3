Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC24505B41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbiDRPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbiDRPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:37:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1493845AF5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650294035; x=1681830035;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YBMPu+5Ttay9AwlZBpFIIB/NtmyxSgLS+XsgFGslUoo=;
  b=hR2WdpD7+Lao/NjUnxGgkvPuX4ibMHs/G1KB0jWrYNyqGA49/zT2VbTC
   MiLFpD+Kh+xQmge+iS8d3y6F6o6PEnSO61P6czFsAX6pLGGQ4sGMOfovw
   6tZFagX4qMmeBevEVJkKp6LDV34FRAXGYK5fwYw2g+s7GqBZ9l4um81A8
   0J7iMxLeRlB3t9ylVMDtYIPyr4NXyCs3eBpv5DC1zoMvITewhLqdpzuzQ
   zI7bW+LTrPREjRCqfHlCsQmWyOh3WaMswN51d+5szi9gRLmUCTllvhBLN
   fflYA8WD22DiJdcHt/UeMYfWFsZEK7vRNlWiy8SoBl2Bp8fXQFvMTde2Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262393168"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="262393168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 08:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="529573602"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Apr 2022 08:00:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngSrf-0004ip-1o;
        Mon, 18 Apr 2022 15:00:31 +0000
Date:   Mon, 18 Apr 2022 22:59:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap 45/47] include/linux/bitmap.h:615:16: sparse: sparse:
 non size-preserving integer to pointer cast
Message-ID: <202204182229.GGvxHzBu-lkp@intel.com>
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

tree:   https://github.com/norov/linux bitmap
head:   45a9e3feb171ccf077979b7ff6a0c6a732cfc17b
commit: 1a21df17d726b4f3c19a148e10d09ec632603f1c [45/47] lib: add bitmap_{from,to}_arr64
config: arm-randconfig-s032-20220417 (https://download.01.org/0day-ci/archive/20220418/202204182229.GGvxHzBu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/norov/linux/commit/1a21df17d726b4f3c19a148e10d09ec632603f1c
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap
        git checkout 1a21df17d726b4f3c19a148e10d09ec632603f1c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash kernel/events/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/events/core.c:1402:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context *
   kernel/events/core.c:1415:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1415:28: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:1415:28: sparse:    struct perf_event_context *
   kernel/events/core.c:3399:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3399:18: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3399:18: sparse:    struct perf_event_context *
   kernel/events/core.c:3400:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3400:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3400:23: sparse:    struct perf_event_context *
   kernel/events/core.c:3448:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3448:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3448:25: sparse:    struct perf_event_context *
   kernel/events/core.c:3449:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:3449:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:3449:25: sparse:    struct perf_event_context *
   kernel/events/core.c:4683:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:4683:25: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:4683:25: sparse:    struct perf_event_context *
   kernel/events/core.c:5948:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5948:9: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5948:9: sparse:    struct perf_buffer *
   kernel/events/core.c:5420:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
   kernel/events/core.c:5664:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5664:22: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5664:22: sparse:    struct perf_buffer *
   kernel/events/core.c:5788:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5788:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5788:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5821:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5821:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5821:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5878:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5878:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5878:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5969:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5969:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5969:14: sparse:    struct perf_buffer *
   kernel/events/core.c:5985:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:5985:14: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:5985:14: sparse:    struct perf_buffer *
   kernel/events/core.c:7628:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7628:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7628:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7680:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7680:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:7680:23: sparse:    struct perf_event_context *
   kernel/events/core.c:7719:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:7719:13: sparse:    struct perf_buffer [noderef] __rcu *
   kernel/events/core.c:7719:13: sparse:    struct perf_buffer *
   kernel/events/core.c:7824:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7824:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7824:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:7826:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/events/core.c:7826:61: sparse:     expected struct task_struct *p
   kernel/events/core.c:7826:61: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/events/core.c:8527:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:8527:23: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:8527:23: sparse:    struct perf_event_context *
   kernel/events/core.c:9521:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9521:9: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9521:9: sparse:    struct swevent_hlist *
   kernel/events/core.c:9560:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9560:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9560:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:10920:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
   kernel/events/core.c:12724:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12724:9: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12724:9: sparse:    struct perf_event_context *
   kernel/events/core.c:12834:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:12834:17: sparse:    struct perf_event_context [noderef] __rcu *
   kernel/events/core.c:12834:17: sparse:    struct perf_event_context *
   kernel/events/core.c:13264:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:13264:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:13264:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:167:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
   kernel/events/core.c:175:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
   kernel/events/core.c: note: in included file (through include/linux/rculist.h, include/linux/dcache.h, include/linux/fs.h):
   include/linux/rcupdate.h:725:9: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
   kernel/events/core.c:1449:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
   kernel/events/core.c:2772:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
   kernel/events/core.c:4655:17: sparse: sparse: context imbalance in 'find_get_context' - unexpected unlock
   kernel/events/core.c: note: in included file (through include/linux/cpumask.h, include/linux/smp.h, include/linux/lockdep.h, ...):
>> include/linux/bitmap.h:615:16: sparse: sparse: non size-preserving integer to pointer cast
   kernel/events/core.c: note: in included file:
   kernel/events/internal.h:197:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *src @@
   kernel/events/core.c:9370:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9370:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9370:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9390:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9390:17: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9390:17: sparse:    struct swevent_hlist *
   kernel/events/core.c:9510:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9510:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9510:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9510:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9510:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9510:16: sparse:    struct swevent_hlist *
   kernel/events/core.c:9510:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:9510:16: sparse:    struct swevent_hlist [noderef] __rcu *
   kernel/events/core.c:9510:16: sparse:    struct swevent_hlist *

vim +615 include/linux/bitmap.h

   602	
   603	/**
   604	 * bitmap_from_u64 - Check and swap words within u64.
   605	 *  @mask: source bitmap
   606	 *  @dst:  destination bitmap
   607	 *
   608	 * In 32-bit Big Endian kernel, when using ``(u32 *)(&val)[*]``
   609	 * to read u64 mask, we will get the wrong word.
   610	 * That is ``(u32 *)(&val)[0]`` gets the upper 32 bits,
   611	 * but we expect the lower 32-bits of u64.
   612	 */
   613	static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
   614	{
 > 615		return bitmap_from_arr64(dst, mask, 64);
   616	}
   617	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
