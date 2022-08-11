Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87D05905D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiHKR1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiHKR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:27:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E445071
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660238821; x=1691774821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9sI4oxnww2fiOkHy8m67wJBameA5pi7QXPxfqb0WHaI=;
  b=GWPXhD4QBTnr9JNlYdS81WSqST8R1qrh7wboY7+aVU0Sv91B1ZeUaeWX
   W+Bood5SjI1AksOzeRR4V8Wh//+Wtluzr3S9+GBV1xcDNdPyZxPDT9mFP
   BGT8BRM1847v+8htj8rd4x5VeEDU3uRsI2KxJ4bJDyWPpU2ET1ue5Ld15
   BwyHStNJe101Ec/cmpK0c/ZEpFh+4cF0InQqdoDFtqUkwipaYbhHzxDrd
   Fd8Hr86eIuj+/ieaZskCfweH2EN3MJTH83QTxQuBwzDNI3GYqYHgE4XHt
   FoyW6x8IBoF5Ca4TnMX9WsXyaudJ6EvWHGEqSWL4nNBe7rnTJ8yckycYs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="353154808"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="353154808"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 10:27:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="933406465"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2022 10:26:59 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMBxS-0000SR-1J;
        Thu, 11 Aug 2022 17:26:58 +0000
Date:   Fri, 12 Aug 2022 01:26:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     oushixiong <oushixiong@kylinos.cn>,
        Dave Airlie <airlied@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm/ast: radeon amdgpu for ast add prime
Message-ID: <202208120134.9nXiGv1Q-lkp@intel.com>
References: <20220809114439.2063863-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809114439.2063863-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi oushixiong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-intel/for-linux-next linus/master v5.19 next-20220811]
[cannot apply to drm-misc/drm-misc-next drm-tip/drm-tip]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/oushixiong/drm-ast-radeon-amdgpu-for-ast-add-prime/20220811-115710
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: arm64-randconfig-r033-20220810 (https://download.01.org/0day-ci/archive/20220812/202208120134.9nXiGv1Q-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/1b9b79a00132f2917ca66bea714a6f21fc939b0f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review oushixiong/drm-ast-radeon-amdgpu-for-ast-add-prime/20220811-115710
        git checkout 1b9b79a00132f2917ca66bea714a6f21fc939b0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/ast/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/ast/ast_drv.c:54:24: warning: no previous prototype for function 'ast_gem_prime_import_sg_table' [-Wmissing-prototypes]
   struct drm_gem_object *ast_gem_prime_import_sg_table(struct drm_device *dev,
                          ^
   drivers/gpu/drm/ast/ast_drv.c:54:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct drm_gem_object *ast_gem_prime_import_sg_table(struct drm_device *dev,
   ^
   static 
   1 warning generated.
--
>> drivers/gpu/drm/ast/ast_mode.c:1713:5: warning: no previous prototype for function 'ast_handle_damage' [-Wmissing-prototypes]
   int ast_handle_damage(struct drm_framebuffer *fb, int x, int y,
       ^
   drivers/gpu/drm/ast/ast_mode.c:1713:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ast_handle_damage(struct drm_framebuffer *fb, int x, int y,
   ^
   static 
>> drivers/gpu/drm/ast/ast_mode.c:1772:5: warning: no previous prototype for function 'ast_user_framebuffer_dirty' [-Wmissing-prototypes]
   int ast_user_framebuffer_dirty(struct drm_framebuffer *fb,
       ^
   drivers/gpu/drm/ast/ast_mode.c:1772:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ast_user_framebuffer_dirty(struct drm_framebuffer *fb,
   ^
   static 
>> drivers/gpu/drm/ast/ast_mode.c:1815:1: warning: no previous prototype for function 'ast_gem_fb_create_with_dirty' [-Wmissing-prototypes]
   ast_gem_fb_create_with_dirty(struct drm_device *dev, struct drm_file *file,
   ^
   drivers/gpu/drm/ast/ast_mode.c:1814:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct drm_framebuffer *
   ^
   static 
   3 warnings generated.


vim +/ast_gem_prime_import_sg_table +54 drivers/gpu/drm/ast/ast_drv.c

    53	
  > 54	struct drm_gem_object *ast_gem_prime_import_sg_table(struct drm_device *dev,
    55						struct dma_buf_attachment *attach,
    56						struct sg_table *sg)
    57	{
    58		struct drm_gem_vram_object *gbo;
    59		struct dma_resv *resv = attach->dmabuf->resv;
    60	
    61		ww_mutex_lock(&resv->lock, NULL);
    62		gbo = drm_gem_vram_create(dev, attach->dmabuf->size, 0, sg, resv);
    63		ww_mutex_unlock(&resv->lock);
    64	
    65		if (IS_ERR(gbo))
    66			return NULL;
    67	
    68		return &gbo->bo.base;
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
