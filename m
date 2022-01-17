Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645ED4910BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiAQTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 14:36:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:59794 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbiAQTgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642448207; x=1673984207;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UyjrWJG/POpNrAsuZbj/MHXkMT5g9toKIAj5HkWIZyE=;
  b=OM57/2UAgpBPMXIAOLZfxlMGTk1wXYNEjPHC/NzTSojsfTeT2tW3F5nS
   yKFA+FU0eKETRPVADIWSvywxxbgIGy+d4/bzCuYs5Gf//bHegF4knWUaZ
   Vze3EuDgVgM4ap4PZ9XPhgIBHai/sNfQ2RclqIMRzltWk+woHDtHm7Cwh
   4GDwcF27xk56e43W+Nh5N8m1Vik6ArStaRsI3peMl5py7DyVirO+oAU29
   bMTIRIYX+IW5XLRbeD9XEiWNv72c3f+ywZbmy/BMD76y2g5tcmyucNaIX
   9GR1ohwfWO4iArXlp8geEJPp3y8P+icV2zf1ZCgBp/Eg+FL9FZe5OD/z4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="331032769"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="331032769"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 11:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="476746864"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2022 11:36:46 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9Xo5-000BoG-EA; Mon, 17 Jan 2022 19:36:45 +0000
Date:   Tue, 18 Jan 2022 03:35:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 4/5] drivers/gpu/drm/msm/edp/edp.h:15:10:
 fatal error: drm/drm_dp_helper.h: No such file or directory
Message-ID: <202201180312.OD3moFCw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   032a125904995985334766911de9e26ee2bbd646
commit: 5b529e8d9c387a34ca2b8008dc65f55d539b3ef6 [4/5] drm/dp: Move public DisplayPort headers into dp/
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220118/202201180312.OD3moFCw-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 5b529e8d9c387a34ca2b8008dc65f55d539b3ef6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/edp/edp.c:7:
>> drivers/gpu/drm/msm/edp/edp.h:15:10: fatal error: drm/drm_dp_helper.h: No such file or directory
      15 | #include <drm/drm_dp_helper.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/gpu/drm/msm/edp/edp_ctrl.c:10:10: fatal error: drm/drm_dp_helper.h: No such file or directory
      10 | #include <drm/drm_dp_helper.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +15 drivers/gpu/drm/msm/edp/edp.h

ab5b0107ccf382 Hai Li          2015-01-07   8  
ab5b0107ccf382 Hai Li          2015-01-07   9  #include <linux/i2c.h>
ab5b0107ccf382 Hai Li          2015-01-07  10  #include <linux/interrupt.h>
ab5b0107ccf382 Hai Li          2015-01-07  11  #include <linux/kernel.h>
ab5b0107ccf382 Hai Li          2015-01-07  12  #include <linux/platform_device.h>
ee68c743f8d074 Boris Brezillon 2019-08-26  13  #include <drm/drm_bridge.h>
78f27b1ce3f852 Masahiro Yamada 2017-04-24  14  #include <drm/drm_crtc.h>
78f27b1ce3f852 Masahiro Yamada 2017-04-24 @15  #include <drm/drm_dp_helper.h>
ab5b0107ccf382 Hai Li          2015-01-07  16  

:::::: The code at line 15 was first introduced by commit
:::::: 78f27b1ce3f852543443b5d2f12a40f217e3555e drm/msm: fix include notation and remove -Iinclude/drm flag

:::::: TO: Masahiro Yamada <yamada.masahiro@socionext.com>
:::::: CC: Daniel Vetter <daniel.vetter@ffwll.ch>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
