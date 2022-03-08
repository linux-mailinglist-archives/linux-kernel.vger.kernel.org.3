Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CA4D1BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiCHPln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiCHPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:41:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A544ECC9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646754045; x=1678290045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=982OeylbgUqsOrJYjdn0FmN/E/k6EPVv1mvCzWyKIvo=;
  b=kobE0j5IzLZxPK9n1yALMePxeKTWtKmMsyySVSejbuRnz0UoAdGMYeUv
   4vtxK9bvHNCd0lIGrH3JenjLvi9LREM3K0FbObkYLkmbv2pWkFh7vle3O
   JKWYxSVmvnc8MoVBuWyuoMlTjyNcWLpmjyCOIRoiHmrwRgUr4cbMNRtIv
   lIEzgMeHAg1Ope35uEDgShqIF0i75U7Xj4npgimF6G3yZYUC+uIHpYliZ
   6fnyF7w2PkhiddwM2Gnc2Grk0yyVufZ6VEQz4ibfA724HpWj3G1M5e1be
   2+fTbBbWy4Igd7dEdz5w+9THqI+AThuxp4JtGKmDup0E+19VuacwsRINq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252284986"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="252284986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:40:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643692197"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 07:40:28 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRbwq-0001cV-29; Tue, 08 Mar 2022 15:40:28 +0000
Date:   Tue, 8 Mar 2022 23:39:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 4027/9999] drivers/dma-buf/heaps/page_pool.c:236:17: sparse: sparse: symbol
 'pool_shrinker' was not declared. Should it be static?
Message-ID: <202203082348.wcdj5T0l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   8a3679a75730c1babde6bf63e35d227f3305bd90
commit: 44008f99d9ca0793e2562967e1da01fa74ee4a41 [4027/9999] ANDROID: dma-buf: system_heap: Add pagepool support to system heap
config: x86_64-randconfig-s021-20220307 (https://download.01.org/0day-ci/archive/20220308/202203082348.wcdj5T0l-lkp@intel.com/config)
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
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dma-buf/heaps/ init/

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
