Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387458EED8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiHJOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiHJOxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:53:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A774DF3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660143233; x=1691679233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/kiRD5KASeEm0qrDCgsbhpYlcpK5GKHycyo+DHLTPo=;
  b=gf+QOZNp6fQNlekMxSEpZvjxR2JzPqKgIt7oSAvDxAdLVhJ1nRFZxFw9
   lupyRLGJKiR4/Vu81F0zLHLqh8r8mr2mFEFm61xWM3SQMLHdHHPfuxPAe
   9CH3KKoqeTrAfYofUNMTDZO8jwoGV+7sHo0AWbrp0lwetoQpyorkFt3Uh
   +3ps4n8HRDMIj3eHSR5uC+RnLMvIxGvPo6tzsF1tB9YtI5h9SNl/cepSV
   sijN2DcXVvSOD5F9KlCB1+BwucwQXJFSq3qV74zVumq1dPPaWhpsT5eIv
   MV8q2xAlAX9Hb4ZfNr5ztC2MFBRBEwYltOiR3k4Cxss/vgwM8BRDiJZ7c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="270876083"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="270876083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 07:53:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="694543865"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2022 07:53:51 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLn5i-0000N7-2D;
        Wed, 10 Aug 2022 14:53:50 +0000
Date:   Wed, 10 Aug 2022 22:53:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     oushixiong <oushixiong@kylinos.cn>,
        Dave Airlie <airlied@redhat.com>
Cc:     kbuild-all@lists.01.org, Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm/ast: radeon amdgpu for ast add prime
Message-ID: <202208102237.Mz7bao9A-lkp@intel.com>
References: <20220810010216.15941-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810010216.15941-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi oushixiong,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-intel/for-linux-next linus/master v5.19 next-20220810]
[cannot apply to drm-misc/drm-misc-next drm-tip/drm-tip]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/oushixiong/drm-ast-radeon-amdgpu-for-ast-add-prime/20220810-100424
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220810/202208102237.Mz7bao9A-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a2b719dc6ac02cee10916696a4ba1caf7b24b20f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review oushixiong/drm-ast-radeon-amdgpu-for-ast-add-prime/20220810-100424
        git checkout a2b719dc6ac02cee10916696a4ba1caf7b24b20f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/ast/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/ast/ast_drv.c:54:24: warning: no previous prototype for 'ast_gem_prime_import_sg_table' [-Wmissing-prototypes]
      54 | struct drm_gem_object *ast_gem_prime_import_sg_table(struct drm_device *dev,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/gpu/drm/ast/ast_mode.c:1713:5: warning: no previous prototype for 'ast_handle_damage' [-Wmissing-prototypes]
    1713 | int ast_handle_damage(struct drm_framebuffer *fb, int x, int y,
         |     ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/ast/ast_mode.c:1772:5: warning: no previous prototype for 'ast_user_framebuffer_dirty' [-Wmissing-prototypes]
    1772 | int ast_user_framebuffer_dirty(struct drm_framebuffer *fb,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/ast/ast_mode.c:1815:1: warning: no previous prototype for 'ast_gem_fb_create_with_dirty' [-Wmissing-prototypes]
    1815 | ast_gem_fb_create_with_dirty(struct drm_device *dev, struct drm_file *file,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
