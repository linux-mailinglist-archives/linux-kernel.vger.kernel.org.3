Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C901D51AE15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiEDToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377611AbiEDToA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:44:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B058760C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651693223; x=1683229223;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YZhveE0tRxxXA0SEnZwijU5Fk8RXn+Oktsw2oc6zHVY=;
  b=dS46Fb9r65Pd5f/K8oR9D8Wh9W+IGJMuv4Rw0FaDFnx35CELKKjYRT1r
   insWw4oEuRDZAwozmJvpWrzBf1LCBP77wi0dMy5LUThhmgr0BfLlRGLo5
   wT7J9sIYXnyW3BHgAErzq6SJkhzGUEfL0VUsU6i3ZRWCAa+gib8rcrn2I
   wpJdGmmMgXztA0YdJLLfGU+k3Hel/9eklfN5R3HBxPl954ZjKci2uWag7
   4RFM9vCDcKkM7hH/gLDZ64SJjqcB2tvdQSLJQt31tBoYbIXWKSUgIarwA
   jX6Uf+F3TeUeqGVn2yYsU6n2DQQ12mpxSTksP2El9oFmPhK2/EH2J9nwE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="330865102"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="330865102"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 12:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="536991905"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 12:40:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmKrF-000BjT-6H;
        Wed, 04 May 2022 19:40:21 +0000
Date:   Thu, 5 May 2022 03:39:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Xiao <Jack.Xiao@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [agd5f:drm-next 395/460]
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:864:13: warning: variable 'r' set
 but not used
Message-ID: <202205050315.yMErlGvA-lkp@intel.com>
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

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   d6ffefccf7f04eefddc8e8aa35fb4afe05a42e0c
commit: e3652b0976f383dea912607a404e974632b019b1 [395/460] drm/amdgpu/mes: add helper functions to alloc/free ctx metadata
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220505/202205050315.yMErlGvA-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout e3652b0976f383dea912607a404e974632b019b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_ctx_alloc_meta_data':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:864:13: warning: variable 'r' set but not used [-Wunused-but-set-variable]
     864 |         int r;
         |             ^


vim +/r +864 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c

   860	
   861	int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
   862					   struct amdgpu_mes_ctx_data *ctx_data)
   863	{
 > 864		int r;
   865	
   866		r = amdgpu_bo_create_kernel(adev,
   867				    sizeof(struct amdgpu_mes_ctx_meta_data),
   868				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
   869				    &ctx_data->meta_data_obj, NULL,
   870				    &ctx_data->meta_data_ptr);
   871		if (!ctx_data->meta_data_obj)
   872			return -ENOMEM;
   873	
   874		memset(ctx_data->meta_data_ptr, 0,
   875		       sizeof(struct amdgpu_mes_ctx_meta_data));
   876	
   877		return 0;
   878	}
   879	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
