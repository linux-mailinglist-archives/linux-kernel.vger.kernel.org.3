Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAA246F84A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhLJBP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:15:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:36675 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235160AbhLJBPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639098710; x=1670634710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WhB2jO0HyGezHcFTF7Ve/COaoda0W2Ae/kw3nch98x4=;
  b=RvKOX9Apa4pyEOVDbeqRsFsdikf/cs/hCkmFrKF+OpHK7B3yj5xJfjaa
   GRx+W2iPS9u2SUYW2rLFdkkZ9OTrcMW8ukvyedtU82qN48rb/hH7iXvmI
   VD6/laLZG1QkeDGvbXUAgNEwRcURnxwxS6TqV/aIYDAjc43SgFidGqOO4
   o5FIyhjtx8Ak8XfYI4ZbMgi6qJ9R38XtClmyx/GoBimyy+4agXb1QXCAv
   d3mYIrey1fZy3GMo+vWTR88ptEDZsxmXrX/BDrxZ+gCqcDBMAgokq9QFg
   vmzBGEB0c9mzN4vexrCuisdKCFvzzXHojOr1IH3VnIqH2CHFU7SXZPppC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218266817"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="218266817"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 17:11:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="516555745"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2021 17:11:49 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvURw-0002aP-F3; Fri, 10 Dec 2021 01:11:48 +0000
Date:   Fri, 10 Dec 2021 09:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zack Rusin <zackr@vmware.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Martin Krastev <krastevm@vmware.com>
Subject: [drm-misc:for-linux-next 4/12]
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c:230:33: warning: format '%ld' expects
 argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned
 int'}
Message-ID: <202112100931.0DNGyGGp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   94eb7de6f4bec1c8bb99371c21df42cac0de6ee9
commit: 8afa13a0583f94c14607e3041c02f068ac8fb628 [4/12] drm/vmwgfx: Implement DRIVER_GEM
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20211210/202112100931.0DNGyGGp-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout 8afa13a0583f94c14607e3041c02f068ac8fb628
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/vmwgfx/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/vmwgfx/vmwgfx_gem.c: In function 'vmw_bo_print_info':
>> drivers/gpu/drm/vmwgfx/vmwgfx_gem.c:230:33: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     230 |  seq_printf(m, "\t\t0x%08x: %12ld bytes %s, type = %s",
         |                             ~~~~^
         |                                 |
         |                                 long int
         |                             %12d
     231 |      id, bo->base.base.size, placement, type);
         |          ~~~~~~~~~~~~~~~~~~      
         |                       |
         |                       size_t {aka unsigned int}


vim +230 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c

   188	
   189	static void vmw_bo_print_info(int id, struct vmw_buffer_object *bo, struct seq_file *m)
   190	{
   191		const char *placement;
   192		const char *type;
   193	
   194		switch (bo->base.resource->mem_type) {
   195		case TTM_PL_SYSTEM:
   196			placement = " CPU";
   197			break;
   198		case VMW_PL_GMR:
   199			placement = " GMR";
   200			break;
   201		case VMW_PL_MOB:
   202			placement = " MOB";
   203			break;
   204		case VMW_PL_SYSTEM:
   205			placement = "VCPU";
   206			break;
   207		case TTM_PL_VRAM:
   208			placement = "VRAM";
   209			break;
   210		default:
   211			placement = "None";
   212			break;
   213		}
   214	
   215		switch (bo->base.type) {
   216		case ttm_bo_type_device:
   217			type = "device";
   218			break;
   219		case ttm_bo_type_kernel:
   220			type = "kernel";
   221			break;
   222		case ttm_bo_type_sg:
   223			type = "sg    ";
   224			break;
   225		default:
   226			type = "none  ";
   227			break;
   228		}
   229	
 > 230		seq_printf(m, "\t\t0x%08x: %12ld bytes %s, type = %s",
   231			   id, bo->base.base.size, placement, type);
   232		seq_printf(m, ", priority = %u, pin_count = %u, GEM refs = %d, TTM refs = %d",
   233			   bo->base.priority,
   234			   bo->base.pin_count,
   235			   kref_read(&bo->base.base.refcount),
   236			   kref_read(&bo->base.kref));
   237		seq_puts(m, "\n");
   238	}
   239	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
