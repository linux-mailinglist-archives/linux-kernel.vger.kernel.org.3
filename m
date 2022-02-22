Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA794BF91F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiBVNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiBVNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:20:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F3FBD2F5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645535982; x=1677071982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NndnFPRYWtuIIxTmT7iL9a8cEQbFdTEMsAlSZBZruJ4=;
  b=GmnTg0aKmRBez9Fzg4uTPd8yYznmoqHfz+jkSJ05qWyRSHhjY4LzCLWH
   ChlUxBrjjChv28NH86UGe6XbhGsFOphEZ5OtOPWoPPmqgpEUySrzdy6Rr
   ONfgkpX8DYyM2N7wmjDzbho4ueh0mpKXTVc92yt6GvoEpDMggPZJZFqq2
   gECV8kXQCA685PAqPD6eqkTtbnWoLPoQYTNkCZgQowkLh6rxiO+hutraZ
   z2qsrUkxgdO1oeEDjDis3IvkkLrkQjssUGItsApPJ5TJ8Uxigzeuo3U6w
   CN6lmUvXDl/4I+B9sYx0FHgj3tX67NCaiXvFwYgi+j0eLchT1iiM4hw4k
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249280240"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="249280240"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 05:19:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="606688461"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Feb 2022 05:19:41 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMV4u-0000GM-89; Tue, 22 Feb 2022 13:19:40 +0000
Date:   Tue, 22 Feb 2022 21:18:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 4044/9999] drivers/dma-buf/heaps/page_pool.c:236:17: sparse: sparse: symbol
 'pool_shrinker' was not declared. Should it be static?
Message-ID: <202202222121.0IUBHSwF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   29002d26b47f382cfaad78623470129c398f8563
commit: 44008f99d9ca0793e2562967e1da01fa74ee4a41 [4044/9999] ANDROID: dma-buf: system_heap: Add pagepool support to system heap
config: x86_64-randconfig-s022-20220221 (https://download.01.org/0day-ci/archive/20220222/202202222121.0IUBHSwF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/44008f99d9ca0793e2562967e1da01fa74ee4a41
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.4
        git checkout 44008f99d9ca0793e2562967e1da01fa74ee4a41
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dma-buf/heaps/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/dma-buf/heaps/page_pool.c:236:17: sparse: sparse: symbol 'pool_shrinker' was not declared. Should it be static?
   drivers/dma-buf/heaps/page_pool.c:243:5: sparse: sparse: symbol 'dmabuf_page_pool_init_shrinker' was not declared. Should it be static?

vim +/pool_shrinker +236 drivers/dma-buf/heaps/page_pool.c

bd4db96bfc247af John Stultz 2020-10-02  235  
bd4db96bfc247af John Stultz 2020-10-02 @236  struct shrinker pool_shrinker = {
bd4db96bfc247af John Stultz 2020-10-02  237  	.count_objects = dmabuf_page_pool_shrink_count,
bd4db96bfc247af John Stultz 2020-10-02  238  	.scan_objects = dmabuf_page_pool_shrink_scan,
bd4db96bfc247af John Stultz 2020-10-02  239  	.seeks = DEFAULT_SEEKS,
bd4db96bfc247af John Stultz 2020-10-02  240  	.batch = 0,
bd4db96bfc247af John Stultz 2020-10-02  241  };
bd4db96bfc247af John Stultz 2020-10-02  242  

:::::: The code at line 236 was first introduced by commit
:::::: bd4db96bfc247afdaf7a4cfde85fd8147522f3e6 ANDROID: dma-buf: heaps: Add a shrinker controlled page pool

:::::: TO: John Stultz <john.stultz@linaro.org>
:::::: CC: John Stultz <john.stultz@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
