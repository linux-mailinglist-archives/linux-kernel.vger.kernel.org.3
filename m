Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78311540F77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354374AbiFGTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351510AbiFGSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 14:16:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFBB1632B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654624177; x=1686160177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MwXOb607W12oSy77wmTKbPyYz73B2e703VHk9nBKJ8c=;
  b=lWFat+mUFxMnIOCFgPH4/6Fd6hASWVOLGntURGcrMwKnSaJ06fXMI2QJ
   hIUpnivdCTlwaxC0ZFoyv9bxN8av2xUZCD/bv7pOn7ITFmofMi/nTfkBj
   HP83KRN7jbF1ZucmKR1F2Po7zeFO01fjjDv4HcNnaLJXrjWpw1bOSTpEQ
   /8G69JFTDflDrFeA41lD2o9gTUkFuOVYV+m50y3QUs1kpAktoPyGzi5HX
   z0qVLnuEySNZnuVvsyz8vDFj54v9AJIXZcC7g9dnxEgDGqgtsOBG80/g3
   aSicso/Tkn/XZbRytLeYP2TDAX0UjsPcoLQiN57/aZ0doka2j9U1UhuEr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277635848"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277635848"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 10:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="614995298"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2022 10:07:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nycgQ-000Dnp-Tx;
        Tue, 07 Jun 2022 17:07:58 +0000
Date:   Wed, 8 Jun 2022 01:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [drm-misc:drm-misc-next 1/1]
 drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes
 address space '__rcu' of expression
Message-ID: <202206080105.4Bm4v1ri-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   dfa687bffc8a4a21ed929c7dececf01b8f1f52ee
commit: 14374e3eee1b02dbf162e1dd75b789373f07ef43 [1/1] dma-buf: cleanup dma_fence_chain_walk
config: ia64-randconfig-s032-20220605 (https://download.01.org/0day-ci/archive/20220608/202206080105.4Bm4v1ri-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-26-gb3cf30ba-dirty
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 14374e3eee1b02dbf162e1dd75b789373f07ef43
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/dma-buf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression
>> drivers/dma-buf/dma-fence-chain.c:65:23: sparse: sparse: cast removes address space '__rcu' of expression

vim +/__rcu +65 drivers/dma-buf/dma-fence-chain.c

    30	
    31	/**
    32	 * dma_fence_chain_walk - chain walking function
    33	 * @fence: current chain node
    34	 *
    35	 * Walk the chain to the next node. Returns the next fence or NULL if we are at
    36	 * the end of the chain. Garbage collects chain nodes which are already
    37	 * signaled.
    38	 */
    39	struct dma_fence *dma_fence_chain_walk(struct dma_fence *fence)
    40	{
    41		struct dma_fence_chain *chain, *prev_chain;
    42		struct dma_fence *prev, *replacement, *tmp;
    43	
    44		chain = to_dma_fence_chain(fence);
    45		if (!chain) {
    46			dma_fence_put(fence);
    47			return NULL;
    48		}
    49	
    50		while ((prev = dma_fence_chain_get_prev(chain))) {
    51	
    52			prev_chain = to_dma_fence_chain(prev);
    53			if (prev_chain) {
    54				if (!dma_fence_is_signaled(prev_chain->fence))
    55					break;
    56	
    57				replacement = dma_fence_chain_get_prev(prev_chain);
    58			} else {
    59				if (!dma_fence_is_signaled(prev))
    60					break;
    61	
    62				replacement = NULL;
    63			}
    64	
  > 65			tmp = unrcu_pointer(cmpxchg(&chain->prev, RCU_INITIALIZER(prev),
    66						     RCU_INITIALIZER(replacement)));
    67			if (tmp == prev)
    68				dma_fence_put(tmp);
    69			else
    70				dma_fence_put(replacement);
    71			dma_fence_put(prev);
    72		}
    73	
    74		dma_fence_put(fence);
    75		return prev;
    76	}
    77	EXPORT_SYMBOL(dma_fence_chain_walk);
    78	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
