Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96BF533D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbiEYNBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbiEYNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:00:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F65CA5AA0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653483657; x=1685019657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4vqZVOne7+JP59KbJNv2BCyBGV1QPICbhBfMiurQ9lk=;
  b=BaiOctQVtUO0cO4dy4F/aV7AnDvrzzHHRjJ49L2TdK2zsMDJO+3U+JUP
   S3Ycsdt77KQp2ERnT2IGQHdRMODaYzsw/McTDMze7tPBnDaq3vYWVfL/9
   7HGWfMU/lvbEvAUWuJyMwZYJBRkh3QM1LyKWxY9AJvx0uqECkpj8qEzgL
   OMEtdNf+sNaUBWPtlw2vybyPg78C+cGG+I1zvA/iJc/d7fQgHwp0q10Ee
   9F3ksTimurcbO4HHZ8mN7KnJl54d9IHHRUHFV6eHxhVWmiwHpmeebaaBW
   ORTAj9xtSbd2+EBB3kAsTWczCrd+jnCaQpC/DW9PGgDMftZ0oULRRjm5v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="360196241"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="360196241"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 06:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="901480960"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 May 2022 06:00:54 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntqdC-00031o-AI;
        Wed, 25 May 2022 13:00:54 +0000
Date:   Wed, 25 May 2022 21:00:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: drivers/dma-buf/st-dma-fence-unwrap.c:125:13: warning: variable
 'err' set but not used
Message-ID: <202205252017.OlDscDi2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fdaf9a5840acaab18694a19e0eb0aa51162eeeed
commit: 64a8f92fd783e750cdb81af75942dcd53bbf61bd dma-buf: add dma_fence_unwrap v2
date:   9 weeks ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205252017.OlDscDi2-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64a8f92fd783e750cdb81af75942dcd53bbf61bd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 64a8f92fd783e750cdb81af75942dcd53bbf61bd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/dma-buf/

If you fix the issue, kindly add following tag where applicable
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
