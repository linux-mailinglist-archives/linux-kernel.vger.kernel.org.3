Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE1590709
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiHKTkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiHKTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:40:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6889AF99
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660246806; x=1691782806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JrHMpkoBZh27P11JevwdKfsKx3Z7Su64n/hfX/1tiQI=;
  b=XlKB1JdSfNwhmxoPBKPAuU+0zEB2JG/7bww042TPlvpvmKBiKHmxtdim
   TWE9H+JMg+bNA58MmcKD7VmpV/Iya/OKcSMH4IbObE6vTbDM7eQ704RtI
   k/i5oB5NkXpERNTVH8XaEZlUojIVBtGxnfsmFOk3iSSKOxNMwGaYjuoxG
   B7GP/dWmxADtC7n4HFHL2MYr0Fg9h+GL4kkDZHTcu72dGZlKO1LqbyxQU
   nDppCkrq7hWFnJXfki2j1Zk2gHC/Qvp3SZME79r+OtV4m8u1O8ZkhzpHR
   SLT6E9r1xF2ebGoP0sR6CgXbQfY4YBj36hPW9ILpjKcsRV8+rihGl2kne
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="278394329"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="278394329"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 12:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="556265575"
Received: from lkp-server02.sh.intel.com (HELO cfab306db114) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2022 12:40:04 -0700
Received: from kbuild by cfab306db114 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oME2F-0000ap-1G;
        Thu, 11 Aug 2022 19:40:03 +0000
Date:   Fri, 12 Aug 2022 03:39:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     oushixiong <oushixiong@kylinos.cn>,
        Dave Airlie <airlied@redhat.com>
Cc:     kbuild-all@lists.01.org, Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm/ast: radeon amdgpu for ast add prime
Message-ID: <202208120345.REoTpw1K-lkp@intel.com>
References: <20220809114439.2063863-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809114439.2063863-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220812/202208120345.REoTpw1K-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/1b9b79a00132f2917ca66bea714a6f21fc939b0f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review oushixiong/drm-ast-radeon-amdgpu-for-ast-add-prime/20220811-115710
        git checkout 1b9b79a00132f2917ca66bea714a6f21fc939b0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/ast/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/ast/ast_drv.c:43:5: sparse: sparse: symbol 'ast_modeset' was not declared. Should it be static?
>> drivers/gpu/drm/ast/ast_drv.c:54:23: sparse: sparse: symbol 'ast_gem_prime_import_sg_table' was not declared. Should it be static?
--
   drivers/gpu/drm/ast/ast_mode.c:681:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/ast/ast_mode.c:681:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] [usertype] __iomem *dstxor @@     got unsigned char [usertype] * @@
   drivers/gpu/drm/ast/ast_mode.c:681:16: sparse:     expected unsigned char [noderef] [usertype] __iomem *dstxor
   drivers/gpu/drm/ast/ast_mode.c:681:16: sparse:     got unsigned char [usertype] *
>> drivers/gpu/drm/ast/ast_mode.c:1759:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/ast/ast_mode.c:1759:33: sparse:     expected void volatile [noderef] __iomem *
   drivers/gpu/drm/ast/ast_mode.c:1759:33: sparse:     got void *
>> drivers/gpu/drm/ast/ast_mode.c:1713:5: sparse: sparse: symbol 'ast_handle_damage' was not declared. Should it be static?
>> drivers/gpu/drm/ast/ast_mode.c:1814:24: sparse: sparse: symbol 'ast_gem_fb_create_with_dirty' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
