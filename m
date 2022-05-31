Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424DB538B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbiEaGnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiEaGnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:43:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3786621A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653979381; x=1685515381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dG/uD1VrE1+qp1nFF3MDQDPg5XOEJSDsifAYe+DaPFs=;
  b=cBgrxQj1kAK/prGA0Vp1EJRs9nheBPh9raSv4KGtrp3242V52xVffYyo
   gBvWgIKAjkXEczsSEUsATLbo0bamUaOiD/THR6uNhdlxU+H2xSdwVKIVn
   G/mgT/sy98xDkNfW+mOGAPlfgtHE64gP3QHbM5j6RJmBjDPOT9HcZvdBg
   04/L9PaoYAxpr7TSFOb5MuFUqQi36S5up8tWReeEAJM7NQFC0iMGOUWUM
   bf071iLVaiJip2XhqQYNmC8tac6GUTRvSNLUxtDM2mdwW4JdghmEa405m
   gEYd1Mj2AeScSeWR+CLD1tRGEqrsV/+KzFj5EiCxJE2EdNxuxi/IAJeXb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="255031317"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="255031317"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 23:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="720173473"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2022 23:42:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvvak-0002Qq-Rs;
        Tue, 31 May 2022 06:42:58 +0000
Date:   Tue, 31 May 2022 14:42:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Lin <chen45464546@163.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: mm/page_alloc.c:5662:3: error: unterminated function-like macro
 invocation
Message-ID: <202205311407.wLMslMvl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220530-221559/Chen-Lin/mm-page_frag-Warn_on-when-frag_alloc-size-is-bigger-than-PAGE_SIZE/20220528-234129
head:   ae1fa085ba9d71fac2969d9cd14a81dbef7bbec4
commit: ae1fa085ba9d71fac2969d9cd14a81dbef7bbec4 mm: page_frag: Warn_on when frag_alloc size is bigger than PAGE_SIZE
date:   16 hours ago
config: hexagon-randconfig-r041-20220531 (https://download.01.org/0day-ci/archive/20220531/202205311407.wLMslMvl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ae1fa085ba9d71fac2969d9cd14a81dbef7bbec4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220530-221559/Chen-Lin/mm-page_frag-Warn_on-when-frag_alloc-size-is-bigger-than-PAGE_SIZE/20220528-234129
        git checkout ae1fa085ba9d71fac2969d9cd14a81dbef7bbec4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/page_alloc.c:5662:11: warning: missing terminating '"' character [-Winvalid-pp-token]
                   WARN(1, "alloc fragsz(%d) > PAGE_SIZE(%ld) not supported,
                           ^
   mm/page_alloc.c:5663:16: warning: missing terminating '"' character [-Winvalid-pp-token]
                           alloc fail\n", fragsz, PAGE_SIZE);
                                       ^
>> mm/page_alloc.c:5662:3: error: unterminated function-like macro invocation
                   WARN(1, "alloc fragsz(%d) > PAGE_SIZE(%ld) not supported,
                   ^
   include/asm-generic/bug.h:130:9: note: macro 'WARN' defined here
   #define WARN(condition, format...) ({                                   \
           ^
>> mm/page_alloc.c:9638:29: error: expected '}'
   #endif /* CONFIG_ZONE_DMA */
                               ^
   mm/page_alloc.c:5661:36: note: to match this '{'
           if (unlikely(fragsz > PAGE_SIZE)) {
                                             ^
>> mm/page_alloc.c:9638:29: error: expected '}'
   #endif /* CONFIG_ZONE_DMA */
                               ^
   mm/page_alloc.c:5653:1: note: to match this '{'
   {
   ^
   2 warnings and 3 errors generated.


vim +5662 mm/page_alloc.c

  5649	
  5650	void *page_frag_alloc_align(struct page_frag_cache *nc,
  5651			      unsigned int fragsz, gfp_t gfp_mask,
  5652			      unsigned int align_mask)
  5653	{
  5654		unsigned int size = PAGE_SIZE;
  5655		struct page *page;
  5656		int offset;
  5657	
  5658		/* frag_alloc is not suitable for memory alloc which fragsz
  5659		 * is bigger than PAGE_SIZE, use kmalloc or alloc_pages instead.
  5660		 */
  5661		if (unlikely(fragsz > PAGE_SIZE)) {
> 5662			WARN(1, "alloc fragsz(%d) > PAGE_SIZE(%ld) not supported,
  5663				alloc fail\n", fragsz, PAGE_SIZE);
  5664	
  5665			return NULL;
  5666		}
  5667	
  5668		if (unlikely(!nc->va)) {
  5669	refill:
  5670			page = __page_frag_cache_refill(nc, gfp_mask);
  5671			if (!page)
  5672				return NULL;
  5673	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
