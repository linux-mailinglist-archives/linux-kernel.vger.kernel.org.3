Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF55467A17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381702AbhLCPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:13:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:57395 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381611AbhLCPNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:13:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="217007855"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="217007855"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 07:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="513273709"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 03 Dec 2021 07:10:12 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtACS-000Hht-5b; Fri, 03 Dec 2021 15:10:12 +0000
Date:   Fri, 3 Dec 2021 23:09:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [asahilinux:asahi 45/56] drivers/gpu/drm/tiny/simpledrm.c:915:1:
 error: redefinition of '__inittest'
Message-ID: <202112032244.L0cMZUzs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   69711d887d3f10a4f7dd6fd648bfff63ff66ba18
commit: 06412fc74f71c816ec5b0aab62be86b3d5cb3b83 [45/56] drm/simpledrm: Bind to OF framebuffers in /chosen
config: x86_64-randconfig-a015-20211203 (https://download.01.org/0day-ci/archive/20211203/202112032244.L0cMZUzs-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 1e328b06c15273edf4a40a27ca24931b5efb3a87)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/06412fc74f71c816ec5b0aab62be86b3d5cb3b83
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 06412fc74f71c816ec5b0aab62be86b3d5cb3b83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/tiny/ net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/tiny/simpledrm.c:915:1: error: redefinition of '__inittest'
   fs_initcall(simplefb_init);
   ^
   include/linux/module.h:119:27: note: expanded from macro 'fs_initcall'
   #define fs_initcall(fn)                 module_init(fn)
                                           ^
   include/linux/module.h:131:42: note: expanded from macro 'module_init'
           static inline initcall_t __maybe_unused __inittest(void)                \
                                                   ^
   drivers/gpu/drm/tiny/simpledrm.c:899:1: note: previous definition is here
   module_platform_driver(simpledrm_platform_driver);
   ^
   include/linux/platform_device.h:252:2: note: expanded from macro 'module_platform_driver'
           module_driver(__platform_driver, platform_driver_register, \
           ^
   include/linux/device/driver.h:262:3: note: expanded from macro 'module_driver'
   } \
     ^
   include/linux/module.h:131:42: note: expanded from macro '\
   module_init'
           static inline initcall_t __maybe_unused __inittest(void)                \
                                                   ^
>> drivers/gpu/drm/tiny/simpledrm.c:915:1: error: redefinition of 'init_module'
   fs_initcall(simplefb_init);
   ^
   include/linux/module.h:119:27: note: expanded from macro 'fs_initcall'
   #define fs_initcall(fn)                 module_init(fn)
                                           ^
   include/linux/module.h:133:6: note: expanded from macro 'module_init'
           int init_module(void) __copy(initfn)                    \
               ^
   drivers/gpu/drm/tiny/simpledrm.c:899:1: note: previous definition is here
   module_platform_driver(simpledrm_platform_driver);
   ^
   include/linux/platform_device.h:252:2: note: expanded from macro 'module_platform_driver'
           module_driver(__platform_driver, platform_driver_register, \
           ^
   include/linux/device/driver.h:262:3: note: expanded from macro 'module_driver'
   } \
     ^
   include/linux/module.h:133:6: note: expanded from macro '\
   module_init'
           int init_module(void) __copy(initfn)                    \
               ^
   2 errors generated.


vim +/__inittest +915 drivers/gpu/drm/tiny/simpledrm.c

   914	
 > 915	fs_initcall(simplefb_init);
   916	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
