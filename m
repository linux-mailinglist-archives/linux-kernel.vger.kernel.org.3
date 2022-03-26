Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF54E7FA7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 07:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiCZHAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiCZHAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:00:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE8237D7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 23:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648277942; x=1679813942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pv9J0nX7QXZsyvuogfLKn3Ox66ThIHnRddtjZO0oGmA=;
  b=mzxyEkbIJ+9P+HqXnWrd7OhS45NE4h2Ey5vnxmNPhPc24IgHrxaQHlhn
   Bx0R6+80TFlXqJM0qI6kkscgNfcdSP06vaj8/LhmXsnBCWHLjH2IuWPRM
   GoC8HZ0XA3ndz9bNWlbec+wk99QZf6kvA3My7K7yx2ut/XxS4cqAXWQW3
   6JCp6cHBM96k/5UXPRAq162Z1OYOPKGdo50jezHZ09TME25EA9T5KPOsg
   lbcappyp8HtBY02ZV1NftYFEBvGJJkw9ZQ70xO1vVevjj1X3xqGUzfNIu
   +d9Fq0iJ5r4yecEJS0fzD919/qgXpkVy7GK3pza4/1VIqgJtJjACj8cjh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="321955842"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="321955842"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 23:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="516766456"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Mar 2022 23:59:00 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY0O3-000N6G-CQ; Sat, 26 Mar 2022 06:58:59 +0000
Date:   Sat, 26 Mar 2022 14:58:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [drm-misc:for-linux-next 2/3]
 drivers/dma-buf/st-dma-fence-unwrap.c:125:13: warning: variable 'err' set
 but not used
Message-ID: <202203261449.ZA8GwHFt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   519f490db07e1a539490612f376487f61e48e39c
commit: 64a8f92fd783e750cdb81af75942dcd53bbf61bd [2/3] dma-buf: add dma_fence_unwrap v2
config: powerpc-randconfig-m031-20220326 (https://download.01.org/0day-ci/archive/20220326/202203261449.ZA8GwHFt-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout 64a8f92fd783e750cdb81af75942dcd53bbf61bd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma-buf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma-buf/st-dma-fence-unwrap.c: In function 'unwrap_array':
>> drivers/dma-buf/st-dma-fence-unwrap.c:125:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     125 |         int err = 0;
         |             ^~~
   drivers/dma-buf/st-dma-fence-unwrap.c: In function 'unwrap_chain':
   drivers/dma-buf/st-dma-fence-unwrap.c:167:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     167 |         int err = 0;
         |             ^~~
   drivers/dma-buf/st-dma-fence-unwrap.c: In function 'unwrap_chain_array':
   drivers/dma-buf/st-dma-fence-unwrap.c:209:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     209 |         int err = 0;
         |             ^~~


vim +/err +125 drivers/dma-buf/st-dma-fence-unwrap.c

   120	
   121	static int unwrap_array(void *arg)
   122	{
   123		struct dma_fence *fence, *f1, *f2, *array;
   124		struct dma_fence_unwrap iter;
 > 125		int err = 0;
   126	
   127		f1 = mock_fence();
   128		if (!f1)
   129			return -ENOMEM;
   130	
   131		f2 = mock_fence();
   132		if (!f2) {
   133			dma_fence_put(f1);
   134			return -ENOMEM;
   135		}
   136	
   137		array = mock_array(2, f1, f2);
   138		if (!array)
   139			return -ENOMEM;
   140	
   141		dma_fence_unwrap_for_each(fence, &iter, array) {
   142			if (fence == f1) {
   143				f1 = NULL;
   144			} else if (fence == f2) {
   145				f2 = NULL;
   146			} else {
   147				pr_err("Unexpected fence!\n");
   148				err = -EINVAL;
   149			}
   150		}
   151	
   152		if (f1 || f2) {
   153			pr_err("Not all fences seen!\n");
   154			err = -EINVAL;
   155		}
   156	
   157		dma_fence_signal(f1);
   158		dma_fence_signal(f2);
   159		dma_fence_put(array);
   160		return 0;
   161	}
   162	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
