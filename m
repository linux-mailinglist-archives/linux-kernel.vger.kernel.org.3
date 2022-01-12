Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96A648CA93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356028AbiALSDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:03:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:34465 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355902AbiALSCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642010552; x=1673546552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=peCOLHBM3+E7NaIzL8oRlL1xCDcIV08L04w1ldsTMcY=;
  b=kjjkkLzesKb7C0R+GiZuW9pmZFDEG3iFMPI7qDpjTJ4hASujhpPBMOHc
   OAiHgspLOJlinV0ugYvH0S4AfiZUv45DKpYrBBGoLJxWEVB+SQHn2nkAu
   p6Lp1dRNEPeHP34npuR5Mj0c/hpUS9Ihmvk+0cZjH/be2g6r5OfDJNRJT
   sjXeQpxhC7asNSbMFsiZo1UzigyOO/Rei0iUWt/bteMoqfbtk8EATkbhJ
   Gfn0BDgDqfIYRewh/xohO2aKkHha9BX4O7opBjv9LyXEh874VQaqjuUN+
   pf7fjnd3M6+7NHpQRNRPow3uBqdX9P1EmCeQRCNffWXNMRhSKWIOHH823
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307148257"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="307148257"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 10:02:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="613650646"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2022 10:02:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7hwk-0006CT-02; Wed, 12 Jan 2022 18:02:06 +0000
Date:   Thu, 13 Jan 2022 02:01:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, linux-graphics-maintainer@vmware.com
Cc:     kbuild-all@lists.01.org, airlied@linux.ie,
        CGEL ZTE <cgel.zte@gmail.com>, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vmwgfx: remove redundant ret variable
Message-ID: <202201130145.eexFh3na-lkp@intel.com>
References: <20220112082422.667488-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112082422.667488-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on next-20220112]
[cannot apply to v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/drm-vmwgfx-remove-redundant-ret-variable/20220112-162527
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220113/202201130145.eexFh3na-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/3542ac844ea28aaa8528f5deb3ee52d1690f1f8a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/drm-vmwgfx-remove-redundant-ret-variable/20220112-162527
        git checkout 3542ac844ea28aaa8528f5deb3ee52d1690f1f8a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/vmwgfx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c: In function 'vmw_dumb_create':
>> drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:794:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     794 | void vmw_bo_swap_notify(struct ttm_buffer_object *bo)
         | ^~~~
   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:860:1: error: expected declaration or statement at end of input
     860 | }
         | ^
   At top level:
   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:853:6: warning: 'vmw_bo_is_vmw_bo' defined but not used [-Wunused-function]
     853 | bool vmw_bo_is_vmw_bo(struct ttm_buffer_object *bo)
         |      ^~~~~~~~~~~~~~~~
   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:815:6: warning: 'vmw_bo_move_notify' defined but not used [-Wunused-function]
     815 | void vmw_bo_move_notify(struct ttm_buffer_object *bo,
         |      ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:794:6: warning: 'vmw_bo_swap_notify' defined but not used [-Wunused-function]
     794 | void vmw_bo_swap_notify(struct ttm_buffer_object *bo)
         |      ^~~~~~~~~~~~~~~~~~


vim +794 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c

e9431ea5076a91 Thomas Hellstrom 2018-06-19  761  
e9431ea5076a91 Thomas Hellstrom 2018-06-19  762  
e9431ea5076a91 Thomas Hellstrom 2018-06-19  763  /**
e9431ea5076a91 Thomas Hellstrom 2018-06-19  764   * vmw_dumb_create - Create a dumb kms buffer
e9431ea5076a91 Thomas Hellstrom 2018-06-19  765   *
e9431ea5076a91 Thomas Hellstrom 2018-06-19  766   * @file_priv: Pointer to a struct drm_file identifying the caller.
e9431ea5076a91 Thomas Hellstrom 2018-06-19  767   * @dev: Pointer to the drm device.
e9431ea5076a91 Thomas Hellstrom 2018-06-19  768   * @args: Pointer to a struct drm_mode_create_dumb structure
e9431ea5076a91 Thomas Hellstrom 2018-06-19  769   * Return: Zero on success, negative error code on failure.
e9431ea5076a91 Thomas Hellstrom 2018-06-19  770   *
e9431ea5076a91 Thomas Hellstrom 2018-06-19  771   * This is a driver callback for the core drm create_dumb functionality.
e9431ea5076a91 Thomas Hellstrom 2018-06-19  772   * Note that this is very similar to the vmw_bo_alloc ioctl, except
e9431ea5076a91 Thomas Hellstrom 2018-06-19  773   * that the arguments have a different format.
e9431ea5076a91 Thomas Hellstrom 2018-06-19  774   */
e9431ea5076a91 Thomas Hellstrom 2018-06-19  775  int vmw_dumb_create(struct drm_file *file_priv,
e9431ea5076a91 Thomas Hellstrom 2018-06-19  776  		    struct drm_device *dev,
e9431ea5076a91 Thomas Hellstrom 2018-06-19  777  		    struct drm_mode_create_dumb *args)
e9431ea5076a91 Thomas Hellstrom 2018-06-19  778  {
e9431ea5076a91 Thomas Hellstrom 2018-06-19  779  	struct vmw_private *dev_priv = vmw_priv(dev);
e9431ea5076a91 Thomas Hellstrom 2018-06-19  780  	struct vmw_buffer_object *vbo;
e9431ea5076a91 Thomas Hellstrom 2018-06-19  781  
e9431ea5076a91 Thomas Hellstrom 2018-06-19  782  	args->pitch = args->width * ((args->bpp + 7) / 8);
8afa13a0583f94 Zack Rusin       2021-12-06  783  	args->size = ALIGN(args->pitch * args->height, PAGE_SIZE);
e9431ea5076a91 Thomas Hellstrom 2018-06-19  784  
3542ac844ea28a Minghao Chi      2022-01-12  785  	return vmw_gem_object_create_with_handle(dev_priv, file_priv,
8afa13a0583f94 Zack Rusin       2021-12-06  786  						args->size, &args->handle,
8afa13a0583f94 Zack Rusin       2021-12-06  787  						&vbo);
e9431ea5076a91 Thomas Hellstrom 2018-06-19  788  
e9431ea5076a91 Thomas Hellstrom 2018-06-19  789  /**
e9431ea5076a91 Thomas Hellstrom 2018-06-19  790   * vmw_bo_swap_notify - swapout notify callback.
e9431ea5076a91 Thomas Hellstrom 2018-06-19  791   *
e9431ea5076a91 Thomas Hellstrom 2018-06-19  792   * @bo: The buffer object to be swapped out.
e9431ea5076a91 Thomas Hellstrom 2018-06-19  793   */
e9431ea5076a91 Thomas Hellstrom 2018-06-19 @794  void vmw_bo_swap_notify(struct ttm_buffer_object *bo)
e9431ea5076a91 Thomas Hellstrom 2018-06-19  795  {
e9431ea5076a91 Thomas Hellstrom 2018-06-19  796  	/* Is @bo embedded in a struct vmw_buffer_object? */
8afa13a0583f94 Zack Rusin       2021-12-06  797  	if (vmw_bo_is_vmw_bo(bo))
e9431ea5076a91 Thomas Hellstrom 2018-06-19  798  		return;
e9431ea5076a91 Thomas Hellstrom 2018-06-19  799  
e9431ea5076a91 Thomas Hellstrom 2018-06-19  800  	/* Kill any cached kernel maps before swapout */
e9431ea5076a91 Thomas Hellstrom 2018-06-19  801  	vmw_bo_unmap(vmw_buffer_object(bo));
e9431ea5076a91 Thomas Hellstrom 2018-06-19  802  }
e9431ea5076a91 Thomas Hellstrom 2018-06-19  803  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
