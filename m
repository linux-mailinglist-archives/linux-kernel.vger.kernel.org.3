Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23065699C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiGGFWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGFWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:22:16 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FC931235
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657171335; x=1688707335;
  h=subject:references:in-reply-to:to:cc:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=cgpZha1s5dA6gyI9CtDNDzu+a392ye6eCb7MU68+lQA=;
  b=cAohRH5TEXot7D7uv8WPvpdvls8WpBorlzIh0kXY6qaR5kpzksTkEQwS
   YoKC/r7KRwA5EawCAuRf8d8MqQUnnFKHURJnzSt+qPtFrP/BzAkH5eQGs
   YDj62NYUXTKwHXO3k6tNrzBComBI2xCyNwomF1w5RpMY8A1qvS4eRsySr
   WwMMqTfNW4yYtclIMfk319oj1/WuVAmnl+dov/pa1sZnK01ZVzXxeHWTZ
   aPg+vqEGRAO7uZ874CyDkQyKo1Yeo+oLur1FKVw7p0K4SAxaQvXhS40Cz
   e8cmQtEIJpk+zGGzWQrxU+PkfOgOMh7/mOvfTFVlCOPavJpBGticOwROg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="309490302"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="309490302"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 22:22:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650976337"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.6]) ([10.255.31.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 22:22:12 -0700
Subject: Re: [PATCH v2 3/4] drm/gem: rename struct drm_gem_dma_object.{paddr
 => dma_addr}
References: <202207070526.dLjM1DgB-lkp@intel.com>
In-Reply-To: <202207070526.dLjM1DgB-lkp@intel.com>
To:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        tzimmermann@suse.de
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202207070526.dLjM1DgB-lkp@intel.com>
Message-ID: <d09cd160-8dae-a474-0594-bf079373f1ac@intel.com>
Date:   Thu, 7 Jul 2022 13:22:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.19-rc5]
[also build test ERROR on linus/master]
[cannot apply to drm-misc/drm-misc-next anholt/for-next 
pinchartl-media/drm/du/next next-20220706]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url: 
https://github.com/intel-lab-lkp/linux/commits/Danilo-Krummrich/drm-rename-CMA-helpers-to-DMA-helpers/20220706-204716
base:    88084a3df1672e131ddc1b4e39eeacfd39864acf
config: arm-defconfig 
(https://download.01.org/0day-ci/archive/20220707/202207070526.dLjM1DgB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
         wget 
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
-O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # 
https://github.com/intel-lab-lkp/linux/commit/54853a66aeea45ecb99d39dec51a7018803174e6
         git remote add linux-review https://github.com/intel-lab-lkp/linux
         git fetch --no-tags linux-review 
Danilo-Krummrich/drm-rename-CMA-helpers-to-DMA-helpers/20220706-204716
         git checkout 54853a66aeea45ecb99d39dec51a7018803174e6
         # save the config file
         mkdir build_dir && cp config build_dir/.config
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross 
W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/atmel-hlcdc/ 
drivers/gpu/drm/fsl-dcu/ drivers/gpu/drm/rcar-du/ drivers/gpu/drm/sti/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

    drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c: In function 
'atmel_hlcdc_plane_update_buffers':
>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c:452:46: error: 'struct drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
      452 |                 state->dscrs[i]->addr = gem->paddr + 
state->offsets[i];
          |                                              ^~~~~
          |                                              vaddr
--
    drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c: In function 
'fsl_dcu_drm_plane_atomic_update':
>> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c:138:53: error: 'struct drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
      138 |                      DCU_CTRLDESCLN(index, 3), gem->paddr);
          |                                                     ^~~~~
          |                                                     vaddr
--
    drivers/gpu/drm/rcar-du/rcar_du_kms.c: In function 
'rcar_du_gem_prime_import_sg_table':
>> drivers/gpu/drm/rcar-du/rcar_du_kms.c:368:18: error: 'struct drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
      368 |         dma_obj->paddr = 0;
          |                  ^~~~~
          |                  vaddr
--
    drivers/gpu/drm/rcar-du/rcar_du_plane.c: In function 
'rcar_du_plane_setup_scanout':
>> drivers/gpu/drm/rcar-du/rcar_du_plane.c:353:39: error: 'struct drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
      353 |                         dma[i] = gem->paddr + fb->offsets[i];
          |                                       ^~~~~
          |                                       vaddr
--
    In file included from include/drm/drm_mm.h:51,
                     from include/drm/drm_vma_manager.h:26,
                     from include/drm/drm_gem.h:40,
                     from include/drm/drm_gem_dma_helper.h:7,
                     from drivers/gpu/drm/sti/sti_gdp.c:16:
    drivers/gpu/drm/sti/sti_gdp.c: In function 'sti_gdp_atomic_update':
>> drivers/gpu/drm/sti/sti_gdp.c:783:50: error: 'struct drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
      783 |                          (unsigned long)dma_obj->paddr);
          |                                                  ^~~~~
    include/drm/drm_print.h:530:41: note: in definition of macro 
'DRM_DEBUG_DRIVER'
      530 |         __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
          |                                         ^~~~~~~~~~~
    drivers/gpu/drm/sti/sti_gdp.c:787:48: error: 'struct 
drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
      787 |         top_field->gam_gdp_pml = (u32)dma_obj->paddr + 
fb->offsets[0];
          |                                                ^~~~~
          |                                                vaddr
    In file included from include/linux/device.h:15,
                     from include/linux/dma-mapping.h:7,
                     from drivers/gpu/drm/sti/sti_gdp.c:9:
    drivers/gpu/drm/sti/sti_gdp.c:832:41: error: 'struct 
drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
      832 |                 (unsigned long)dma_obj->paddr,
          |                                         ^~~~~
    include/linux/dev_printk.h:129:48: note: in definition of macro 
'dev_printk'
      129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__); 
            \
          |                                                ^~~~~~~~~~~
    drivers/gpu/drm/sti/sti_gdp.c:831:9: note: in expansion of macro 
'dev_dbg'
      831 |         dev_dbg(gdp->dev, "Posted buff: %lx current buff: %x\n",
          |         ^~~~~~~
--
    In file included from include/drm/drm_mm.h:51,
                     from include/drm/drm_vma_manager.h:26,
                     from include/drm/drm_gem.h:40,
                     from include/drm/drm_gem_dma_helper.h:7,
                     from drivers/gpu/drm/sti/sti_hqvdp.c:20:
    drivers/gpu/drm/sti/sti_hqvdp.c: In function 'sti_hqvdp_atomic_update':
>> drivers/gpu/drm/sti/sti_hqvdp.c:1183:50: error: 'struct drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
     1183 |                          (unsigned long)dma_obj->paddr);
          |                                                  ^~~~~
    include/drm/drm_print.h:530:41: note: in definition of macro 
'DRM_DEBUG_DRIVER'
      530 |         __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
          |                                         ^~~~~~~~~~~
    drivers/gpu/drm/sti/sti_hqvdp.c:1186:47: error: 'struct 
drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
     1186 |         cmd->top.current_luma = (u32)dma_obj->paddr + 
fb->offsets[0];
          |                                               ^~~~~
          |                                               vaddr
    drivers/gpu/drm/sti/sti_hqvdp.c:1187:49: error: 'struct 
drm_gem_dma_object' has no member named 'paddr'; did you mean 'vaddr'?
     1187 |         cmd->top.current_chroma = (u32)dma_obj->paddr + 
fb->offsets[1];
          |                                                 ^~~~~
          |                                                 vaddr


vim +452 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c

364a7bf574ebbd Peter Rosin      2017-06-22  438  1a396789f65a22 Boris 
Brezillon  2015-01-06  439  static void 
atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
2389fc1305fc1e Boris Brezillon  2015-02-05  440  					struct 
atmel_hlcdc_plane_state *state)
1a396789f65a22 Boris Brezillon  2015-01-06  441  {
9a45d33cdf82f1 Boris Brezillon  2017-02-06  442  	const struct 
atmel_hlcdc_layer_desc *desc = plane->layer.desc;
9a45d33cdf82f1 Boris Brezillon  2017-02-06  443  	struct drm_framebuffer 
*fb = state->base.fb;
9a45d33cdf82f1 Boris Brezillon  2017-02-06  444  	u32 sr;
1a396789f65a22 Boris Brezillon  2015-01-06  445  	int i;
1a396789f65a22 Boris Brezillon  2015-01-06  446  9a45d33cdf82f1 Boris 
Brezillon  2017-02-06  447  	sr = 
atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHSR);
1a396789f65a22 Boris Brezillon  2015-01-06  448  2389fc1305fc1e Boris 
Brezillon  2015-02-05  449  	for (i = 0; i < state->nplanes; i++) {
efb5bf503f38a8 Danilo Krummrich 2022-07-06  450  		struct 
drm_gem_dma_object *gem = drm_fb_dma_get_gem_obj(fb, i);
9a45d33cdf82f1 Boris Brezillon  2017-02-06  451  9a45d33cdf82f1 Boris 
Brezillon  2017-02-06 @452  		state->dscrs[i]->addr = gem->paddr + 
state->offsets[i];
9a45d33cdf82f1 Boris Brezillon  2017-02-06  453  9a45d33cdf82f1 Boris 
Brezillon  2017-02-06  454  		atmel_hlcdc_layer_write_reg(&plane->layer,
9a45d33cdf82f1 Boris Brezillon  2017-02-06  455  					 
ATMEL_HLCDC_LAYER_PLANE_HEAD(i),
9a45d33cdf82f1 Boris Brezillon  2017-02-06  456  					 
state->dscrs[i]->self);
9a45d33cdf82f1 Boris Brezillon  2017-02-06  457  9a45d33cdf82f1 Boris 
Brezillon  2017-02-06  458  		if (!(sr & ATMEL_HLCDC_LAYER_EN)) {
9a45d33cdf82f1 Boris Brezillon  2017-02-06  459  		 
atmel_hlcdc_layer_write_reg(&plane->layer,
9a45d33cdf82f1 Boris Brezillon  2017-02-06  460  				 
ATMEL_HLCDC_LAYER_PLANE_ADDR(i),
9a45d33cdf82f1 Boris Brezillon  2017-02-06  461  				 
state->dscrs[i]->addr);
9a45d33cdf82f1 Boris Brezillon  2017-02-06  462  		 
atmel_hlcdc_layer_write_reg(&plane->layer,
9a45d33cdf82f1 Boris Brezillon  2017-02-06  463  				 
ATMEL_HLCDC_LAYER_PLANE_CTRL(i),
9a45d33cdf82f1 Boris Brezillon  2017-02-06  464  				 
state->dscrs[i]->ctrl);
9a45d33cdf82f1 Boris Brezillon  2017-02-06  465  		 
atmel_hlcdc_layer_write_reg(&plane->layer,
9a45d33cdf82f1 Boris Brezillon  2017-02-06  466  				 
ATMEL_HLCDC_LAYER_PLANE_NEXT(i),
9a45d33cdf82f1 Boris Brezillon  2017-02-06  467  				 
state->dscrs[i]->self);
1a396789f65a22 Boris Brezillon  2015-01-06  468  		}
1a396789f65a22 Boris Brezillon  2015-01-06  469  9a45d33cdf82f1 Boris 
Brezillon  2017-02-06  470  		if (desc->layout.xstride[i])
9a45d33cdf82f1 Boris Brezillon  2017-02-06  471  		 
atmel_hlcdc_layer_write_cfg(&plane->layer,
9a45d33cdf82f1 Boris Brezillon  2017-02-06  472  						 
desc->layout.xstride[i],
9a45d33cdf82f1 Boris Brezillon  2017-02-06  473  						 
state->xstride[i]);
9a45d33cdf82f1 Boris Brezillon  2017-02-06  474  9a45d33cdf82f1 Boris 
Brezillon  2017-02-06  475  		if (desc->layout.pstride[i])
9a45d33cdf82f1 Boris Brezillon  2017-02-06  476  		 
atmel_hlcdc_layer_write_cfg(&plane->layer,
9a45d33cdf82f1 Boris Brezillon  2017-02-06  477  						 
desc->layout.pstride[i],
2389fc1305fc1e Boris Brezillon  2015-02-05  478  						 
state->pstride[i]);
1a396789f65a22 Boris Brezillon  2015-01-06  479  	}
1a396789f65a22 Boris Brezillon  2015-01-06  480  }
1a396789f65a22 Boris Brezillon  2015-01-06  481
-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

