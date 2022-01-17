Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2365B491082
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiAQSzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:55:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:54723 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233574AbiAQSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642445747; x=1673981747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jGxQR1NAPq34rowHwZf+YnxGBKCulWznhSjNSCXmWsI=;
  b=SAelhPXsBzr5KjKIFwaAX1LjOV/8qH96JJZ+ob2aWkQyHLG9rkk/4uFc
   U+r6smJOsyh7NDbNNW8Gs1G86Ujs+6Iu8h8lA7bqa5COxNFKo2eUJM52S
   j3uQOTRRU5aHzLpzRqrzAq4ly9UjtMXirjWdkHcie4yiepfrGOzU+SLrn
   vyhE8RY/m4b3Pg1JIRj3q+6oTSHz7CX10itY6LNRLOtYI7YhDyGyO01VT
   2PRiYEjIx75YjxifjpvBcWvFNvrLAl86EpmMVMASqWVNysN26YQoCQN+R
   VC+sThGEniHQEvLbYPbEx7ERhv1S/em5y4H58ANdKObP4YF/GYpAYquc2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="331027474"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="331027474"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="621893298"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2022 10:55:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9XAO-000Bmv-Rk; Mon, 17 Jan 2022 18:55:44 +0000
Date:   Tue, 18 Jan 2022 02:54:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 4/5] drivers/gpu/drm/msm/edp/edp.h:15:10:
 fatal error: 'drm/drm_dp_helper.h' file not found
Message-ID: <202201180257.Ntm7G4ic-lkp@intel.com>
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
config: arm-randconfig-r014-20220117 (https://download.01.org/0day-ci/archive/20220118/202201180257.Ntm7G4ic-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 5b529e8d9c387a34ca2b8008dc65f55d539b3ef6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/edp/edp_aux.c:6:
>> drivers/gpu/drm/msm/edp/edp.h:15:10: fatal error: 'drm/drm_dp_helper.h' file not found
   #include <drm/drm_dp_helper.h>
            ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/gpu/drm/msm/edp/edp_ctrl.c:10:10: fatal error: 'drm/drm_dp_helper.h' file not found
   #include <drm/drm_dp_helper.h>
            ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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
