Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B976C57F4D4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiGXLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:36:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD72195AA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658662560; x=1690198560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tYwA7UW5Hg0l8T5ZjQdhHfUuI3eav6VYn3z+782NLiQ=;
  b=mOkBmhFLk7yhwMlSre7sKDXqYw120Ej/rx38iOfWQ65hA7AGlKQA7fd+
   lNiYpTrNKm/ALLslhzntZF60eN8PEEyG/03T58cMHGWffyz41xHmcUBq8
   WTNg0TH3t7Nw/CjkAlBJZvjq/ShLNmyVjKPpaOg2wjxbuin8++o/6I+c4
   RZt6gfsRnmqacqO7fRa+13BQLI8D+zQHXn4Pus2bQBFcxHj1qUmS+wM9c
   wqOmEUDSIRvNAi0TZTqtkScUf7BPuLpGWUGkHkcvjqX+vrWkqez/1Uy68
   EDofS4jOVAJg2XQRNA/U85pqtg1Ai8rdoa6I/pJgK29pPd/wTJL10HCGP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288719589"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288719589"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 04:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="574708575"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2022 04:35:58 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFZtu-0003px-06;
        Sun, 24 Jul 2022 11:35:58 +0000
Date:   Sun, 24 Jul 2022 19:34:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 1155/6555]
 drivers/gpu/drm/drm_atomic_uapi.c:1052: Error: unrecognized opcode `csrs
 sstatus,a3'
Message-ID: <202207241948.010TSkxB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: dfdec43d0411076dc70591a0496a0824a8620695 [1155/6555] UPSTREAM: drm: extract drm_atomic_uapi.c
config: riscv-randconfig-r042-20220724 (https://download.01.org/0day-ci/archive/20220724/202207241948.010TSkxB-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/dfdec43d0411076dc70591a0496a0824a8620695
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout dfdec43d0411076dc70591a0496a0824a8620695
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash M=drivers/gpu/drm

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_atomic_uapi.c: In function 'complete_signaling':
   drivers/gpu/drm/drm_atomic_uapi.c:1193:26: warning: variable 'crtc' set but not used [-Wunused-but-set-variable]
    1193 |         struct drm_crtc *crtc;
         |                          ^~~~
   drivers/gpu/drm/drm_atomic_uapi.c: Assembler messages:
>> drivers/gpu/drm/drm_atomic_uapi.c:1052: Error: unrecognized opcode `csrs sstatus,a3'
>> drivers/gpu/drm/drm_atomic_uapi.c:1052: Error: unrecognized opcode `csrc sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:1230: Error: unrecognized opcode `csrs sstatus,s6'
   drivers/gpu/drm/drm_atomic_uapi.c:1230: Error: unrecognized opcode `csrc sstatus,s6'
   drivers/gpu/drm/drm_atomic_uapi.c:466: Error: unrecognized opcode `csrs sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:466: Error: unrecognized opcode `csrc sstatus,a3'
>> drivers/gpu/drm/drm_atomic_uapi.c:366: Error: unrecognized opcode `csrs sstatus,a2'
>> drivers/gpu/drm/drm_atomic_uapi.c:366: Error: unrecognized opcode `csrc sstatus,a2'
   drivers/gpu/drm/drm_atomic_uapi.c:1297: Error: unrecognized opcode `csrs sstatus,s5'
   drivers/gpu/drm/drm_atomic_uapi.c:1297: Error: unrecognized opcode `csrc sstatus,s5'
   drivers/gpu/drm/drm_atomic_uapi.c:1314: Error: unrecognized opcode `csrs sstatus,s5'
   drivers/gpu/drm/drm_atomic_uapi.c:1314: Error: unrecognized opcode `csrc sstatus,s5'
   drivers/gpu/drm/drm_atomic_uapi.c:1327: Error: unrecognized opcode `csrs sstatus,s5'
   drivers/gpu/drm/drm_atomic_uapi.c:1327: Error: unrecognized opcode `csrc sstatus,s5'


vim +1052 drivers/gpu/drm/drm_atomic_uapi.c

  1044	
  1045	static int setup_out_fence(struct drm_out_fence_state *fence_state,
  1046				   struct dma_fence *fence)
  1047	{
  1048		fence_state->fd = get_unused_fd_flags(O_CLOEXEC);
  1049		if (fence_state->fd < 0)
  1050			return fence_state->fd;
  1051	
> 1052		if (put_user(fence_state->fd, fence_state->out_fence_ptr))
  1053			return -EFAULT;
  1054	
  1055		fence_state->sync_file = sync_file_create(fence);
  1056		if (!fence_state->sync_file)
  1057			return -ENOMEM;
  1058	
  1059		return 0;
  1060	}
  1061	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
