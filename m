Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF23539767
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 21:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347552AbiEaTy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 15:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiEaTy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 15:54:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3127B8FD48
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654026865; x=1685562865;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OJhpRbxBOMs4glA066gvOFcYtJZ2Eh/VWIaGZ2EgiQk=;
  b=VrrLEzYJlaUWgXtC/gP/AtkAAgqBmCWEllAQu2kXj98nWWpRgLbGLYXH
   VhT4Ne5sklRR41HZ6ocREQ61RrCtPyxPw73VZjaNbTO7Hsrv/4T43CdO7
   m1QMXiU7RZl1xJj2yyQP8h7f4muezYWqFzU6JM2+bXCEQGdDvX6BUAApG
   Pfmsme9NUCtzpuS4PmLB66cAwvMZw8MGunbKB4K5isad4AvdSDTD78EoA
   84/enoiCUNkiAcSCCcsSNAZKw4wkraChmidU5YyANP+gGKZdnMj5MmoSh
   hk668q2KorxbBvQOVuhYoO3G2FwfwnQRM38s5cDNnL2+jsaOQ8T0HLIcn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="361743052"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="361743052"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 12:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="667072348"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2022 12:54:23 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw7wc-00031I-QL;
        Tue, 31 May 2022 19:54:22 +0000
Date:   Wed, 1 Jun 2022 03:53:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Lin <chen45464546@163.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: mm/page_alloc.c:5662:16: error: use of undeclared identifier
 'fragz'; did you mean 'fragsz'?
Message-ID: <202206010311.t1nGkYl6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220531-224555/Chen-Lin/mm-page_frag-Warn_on-when-frag_alloc-size-is-bigger-than-PAGE_SIZE/20220528-234129
head:   21e940b5a66de64088e93248c21bce241c28a556
commit: 21e940b5a66de64088e93248c21bce241c28a556 mm: page_frag: Warn_on when frag_alloc size is bigger than PAGE_SIZE
date:   5 hours ago
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220601/202206010311.t1nGkYl6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/21e940b5a66de64088e93248c21bce241c28a556
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220531-224555/Chen-Lin/mm-page_frag-Warn_on-when-frag_alloc-size-is-bigger-than-PAGE_SIZE/20220528-234129
        git checkout 21e940b5a66de64088e93248c21bce241c28a556
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/page_alloc.c:5662:16: error: use of undeclared identifier 'fragz'; did you mean 'fragsz'?
           if (WARN_ONCE(fragz > PAGE_SIZE,
                         ^~~~~
                         fragsz
   include/asm-generic/bug.h:151:18: note: expanded from macro 'WARN_ONCE'
           DO_ONCE_LITE_IF(condition, WARN, 1, format)
                           ^
   include/linux/once_lite.h:15:27: note: expanded from macro 'DO_ONCE_LITE_IF'
                   bool __ret_do_once = !!(condition);                     \
                                           ^
   mm/page_alloc.c:5651:22: note: 'fragsz' declared here
                         unsigned int fragsz, gfp_t gfp_mask,
                                      ^
   1 error generated.


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
  5658		/*
  5659		 * frag_alloc is not suitable for memory alloc which fragsz
  5660		 * is bigger than PAGE_SIZE, use kmalloc or alloc_pages instead.
  5661		 */
> 5662		if (WARN_ONCE(fragz > PAGE_SIZE,
  5663			      "alloc fragsz(%d) > PAGE_SIZE(%ld) not supported, alloc fail\n",
  5664			      fragsz, PAGE_SIZE))
  5665			return NULL;
  5666	
  5667		if (unlikely(!nc->va)) {
  5668	refill:
  5669			page = __page_frag_cache_refill(nc, gfp_mask);
  5670			if (!page)
  5671				return NULL;
  5672	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
