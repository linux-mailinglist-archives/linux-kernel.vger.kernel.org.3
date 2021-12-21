Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5186D47B945
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhLUFHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:07:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:41843 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhLUFHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640063267; x=1671599267;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gLKGoQqFSX7RzmEWh4xz+UBBzOqesTFRFxCdY7EwnrU=;
  b=h/XvNFDNPt3VVWtQWoxAlDi4r/E0Fh+ICsGYiFq5X0hg+DMXL3t2AcLs
   b3eROK/MLJ1Fa3fXH2mI7fi2nBqbb2AW+bswZ+1VVzkloK712JYoqJlmI
   05S5WP/LdeqaXfKh7lkcGixbBrfJyX9NGVDWHVkgi56r875YUsKmAvBfK
   M7AQH8o6Y+3PRUkdiBytNvgG+h3cSAY7oGvjndn2x2eYFXzauOBZcFDwK
   jFp9cyCUeVozNOqGTB8gMyiHCnlxqWfv2q732/itW1Tx9Qn3vShPMJKJx
   wJJIS9XmFjKgb8rjKKXRsMb7Zevs0Y5LIoMPqU0dKgrzfa1Bt6tqhyrsD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="301096098"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="301096098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 21:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="547861626"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2021 21:07:45 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzXNJ-0008i8-8S; Tue, 21 Dec 2021 05:07:45 +0000
Date:   Tue, 21 Dec 2021 13:07:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudio Suarez <cssk@net-c.es>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [drm-misc:drm-misc-next 1/2]
 drivers/gpu/drm/selftests/test-drm_plane_helper.c:76:5: warning: stack frame
 size (1136) exceeds limit (1024) in 'igt_check_plane_state'
Message-ID: <202112211210.kJg5QWU6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   521d459b1935628a7caa0753429f880dae2dbfc9
commit: 943e6a8beeac1b676265f2dd81a69d7bede5e41d [1/2] mock a drm_plane in igt_check_plane_state to make the test more robust
config: arm-randconfig-r001-20211220 (https://download.01.org/0day-ci/archive/20211221/202112211210.kJg5QWU6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 555eacf75f21cd1dfc6363d73ad187b730349543)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 943e6a8beeac1b676265f2dd81a69d7bede5e41d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/selftests/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/selftests/test-drm_plane_helper.c:76:5: warning: stack frame size (1136) exceeds limit (1024) in 'igt_check_plane_state' [-Wframe-larger-than]
   int igt_check_plane_state(void *ignored)
       ^
   1 warning generated.


vim +/igt_check_plane_state +76 drivers/gpu/drm/selftests/test-drm_plane_helper.c

7420e04963587d drivers/gpu/drm/selftests/test-drm-helper.c       Maarten Lankhorst  2018-05-03  75  
e51767279f1157 drivers/gpu/drm/selftests/test-drm_plane_helper.c Alexandru Gheorghe 2018-10-19 @76  int igt_check_plane_state(void *ignored)

:::::: The code at line 76 was first introduced by commit
:::::: e51767279f11571b112dbeaef2628968c62f90a6 drm/selftest: Refactor test-drm_plane_helper

:::::: TO: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
:::::: CC: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
