Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20014A54CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiBABzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:55:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:16009 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbiBABzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643680508; x=1675216508;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v3wh/698ibf7E2PdXQzkVxlrbWSs1MWyc5ZydSb3ie8=;
  b=liLW8YC9r2hQmBuTmwxPgieQn81EiMB3I1nEuq/IKdEJVA+f3D34AFs5
   VXiCR3pEroWxnjaIP6xNKVIJQANoODsgxQx9yQF31zEqoFvjSOMoJJGp7
   LB8FtVlCZqRnZKRWWeWtdFZDYE0cHrlfncDa1eCiMpQ+TP09P7nqWjh2C
   d928A5sQWedpEZRvTV+R1QGS4f0ihXXrPHiiwNj8WCTz3HpWjIbuGog3N
   J+AAmMg0Uy7V03rDXE+NlUJRNorxZnxRL0+hKUvYrOWK++zCWYnjrKYfp
   7SgLxB1mu0doSTTXDN6z3yE7MTG9Fua9Hy/nQxD+925+ctN/CLxwxxHRZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="234997348"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="234997348"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:55:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="619641333"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2022 17:55:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEiNt-000Sa5-Bd; Tue, 01 Feb 2022 01:55:05 +0000
Date:   Tue, 1 Feb 2022 09:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomohito Esaki <etom@igel.co.jp>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [drm-misc:drm-misc-next 3/4] drivers/gpu/drm/sprd/sprd_drm.c:46:25:
 error: 'struct drm_mode_config' has no member named 'allow_fb_modifiers'
Message-ID: <202202010923.1fCku8oB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   d80976d9ffd9d7f89a26134a299b236910477f3b
commit: 3d082157a24216ca084082ce421a37d14ecfcfad [3/4] drm: remove allow_fb_modifiers
config: arc-randconfig-r043-20220130 (https://download.01.org/0day-ci/archive/20220201/202202010923.1fCku8oB-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 3d082157a24216ca084082ce421a37d14ecfcfad
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/sprd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/sprd/sprd_drm.c: In function 'sprd_drm_mode_config_init':
>> drivers/gpu/drm/sprd/sprd_drm.c:46:25: error: 'struct drm_mode_config' has no member named 'allow_fb_modifiers'
      46 |         drm->mode_config.allow_fb_modifiers = true;
         |                         ^


vim +46 drivers/gpu/drm/sprd/sprd_drm.c

43531edd53f07c Kevin Tang 2021-12-07  39  
43531edd53f07c Kevin Tang 2021-12-07  40  static void sprd_drm_mode_config_init(struct drm_device *drm)
43531edd53f07c Kevin Tang 2021-12-07  41  {
43531edd53f07c Kevin Tang 2021-12-07  42  	drm->mode_config.min_width = 0;
43531edd53f07c Kevin Tang 2021-12-07  43  	drm->mode_config.min_height = 0;
43531edd53f07c Kevin Tang 2021-12-07  44  	drm->mode_config.max_width = 8192;
43531edd53f07c Kevin Tang 2021-12-07  45  	drm->mode_config.max_height = 8192;
43531edd53f07c Kevin Tang 2021-12-07 @46  	drm->mode_config.allow_fb_modifiers = true;
43531edd53f07c Kevin Tang 2021-12-07  47  
43531edd53f07c Kevin Tang 2021-12-07  48  	drm->mode_config.funcs = &sprd_drm_mode_config_funcs;
43531edd53f07c Kevin Tang 2021-12-07  49  	drm->mode_config.helper_private = &sprd_drm_mode_config_helper;
43531edd53f07c Kevin Tang 2021-12-07  50  }
43531edd53f07c Kevin Tang 2021-12-07  51  

:::::: The code at line 46 was first introduced by commit
:::::: 43531edd53f07cbe977a0b33dea6dd6c29b21fea drm/sprd: add Unisoc's drm kms master

:::::: TO: Kevin Tang <kevin3.tang@gmail.com>
:::::: CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
