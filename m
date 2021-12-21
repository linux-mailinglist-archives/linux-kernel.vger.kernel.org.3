Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B675047BA77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhLUHJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:09:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:31973 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhLUHJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640070591; x=1671606591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BrnYzdupK7Mon8z3LnNOHBwS+nRwQf8wZeTsebuwHBE=;
  b=ZUuVAo1unLlde9AiZYPNzfewVtFagDcmHbPUZhO+MvHPowzondsp+IoC
   J1Rc+fzGdqLIEoOict/ecabAux5twD0wx+wZLjnhHEgMjOd1c27r23pbn
   iCYTD6ibfbwdds2xgS7OvWpFf/JaD77FF8SXqhCulkgdWS+nZZw0QAaaj
   QQX99mfKZObpyVFhB52fIl/coqq90Drw3oRUOuNcXChjK4E1jRIZaMHeA
   8aSb+YlTbXuGGWWCLglUumu/2a3/qC1uBEQaH6gHjD6dwhH4HX08swdbi
   +oEsJAOM84HNqM3pbPwRsIf9dCszzrUucQvaBAKe30hcaS0mDtPq8POAJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="239087020"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="239087020"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:09:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="484329292"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2021 23:09:48 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzZHP-0008ni-FN; Tue, 21 Dec 2021 07:09:47 +0000
Date:   Tue, 21 Dec 2021 15:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liam Beguin <liambeguin@gmail.com>, peda@axentia.se,
        jic23@kernel.org, lars@metafoo.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v10 10/14] iio: test: add basic tests for the iio-rescale
 driver
Message-ID: <202112211453.3XBOHbkh-lkp@intel.com>
References: <20211219223953.16074-11-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211219223953.16074-11-liambeguin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1]

url:    https://github.com/0day-ci/linux/commits/Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211220-064048
base:   2b6bff0b122785f09cfbdc34b1aa9edceea6e4c1
config: ia64-buildonly-randconfig-r004-20211221 (https://download.01.org/0day-ci/archive/20211221/202112211453.3XBOHbkh-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/833188fad2d37f1e40f56eb7286d6dd2e1a2ced5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Liam-Beguin/iio-afe-add-temperature-rescaling-support/20211220-064048
        git checkout 833188fad2d37f1e40f56eb7286d6dd2e1a2ced5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
   (.text+0x732): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x792): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
   (.text+0x8f2): undefined reference to `unregister_framebuffer'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
   (.text+0x9c2): undefined reference to `fb_dealloc_cmap'
   ia64-linux-ld: (.text+0x9d2): undefined reference to `framebuffer_release'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
   (.text+0xba2): undefined reference to `fb_sys_read'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
   (.text+0x2c82): undefined reference to `framebuffer_alloc'
   ia64-linux-ld: (.text+0x2cc2): undefined reference to `fb_alloc_cmap'
   ia64-linux-ld: (.text+0x2d52): undefined reference to `fb_dealloc_cmap'
   ia64-linux-ld: (.text+0x2d72): undefined reference to `framebuffer_release'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x3072): undefined reference to `fb_deferred_io_init'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x3302): undefined reference to `register_framebuffer'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   (.text+0x4842): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
   (.text+0x5a82): undefined reference to `fb_sys_write'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
   (.text+0x5b22): undefined reference to `sys_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
   (.text+0x5bc2): undefined reference to `sys_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
   (.text+0x5c62): undefined reference to `sys_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
   (.text+0x5d02): undefined reference to `cfb_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
   (.text+0x5da2): undefined reference to `cfb_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
   (.text+0x5e42): undefined reference to `cfb_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
   drm_fb_helper.c:(.text+0x5f12): undefined reference to `cfb_imageblit'
   ia64-linux-ld: drm_fb_helper.c:(.text+0x5f32): undefined reference to `sys_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
   drm_fb_helper.c:(.text+0x5ff2): undefined reference to `cfb_copyarea'
   ia64-linux-ld: drm_fb_helper.c:(.text+0x6012): undefined reference to `sys_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
   drm_fb_helper.c:(.text+0x60d2): undefined reference to `cfb_fillrect'
   ia64-linux-ld: drm_fb_helper.c:(.text+0x60f2): undefined reference to `sys_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x6212): undefined reference to `fb_deferred_io_cleanup'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_client_unregister':
   drm_fb_helper.c:(.text+0x6402): undefined reference to `unregister_framebuffer'
   ia64-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
   iio-test-rescale.c:(.text+0x52): undefined reference to `kunit_kmalloc_array'
>> ia64-linux-ld: iio-test-rescale.c:(.text+0x1a0): undefined reference to `kunit_binary_assert_format'
>> ia64-linux-ld: iio-test-rescale.c:(.text+0x252): undefined reference to `kunit_do_assertion'
>> ia64-linux-ld: iio-test-rescale.c:(.text+0x280): undefined reference to `kunit_binary_str_assert_format'
   ia64-linux-ld: iio-test-rescale.c:(.text+0x342): undefined reference to `kunit_do_assertion'
   ia64-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
>> iio-test-rescale.c:(.text+0x570): undefined reference to `kunit_binary_assert_format'
>> ia64-linux-ld: iio-test-rescale.c:(.text+0x5b2): undefined reference to `kunit_kmalloc_array'
   ia64-linux-ld: iio-test-rescale.c:(.text+0x792): undefined reference to `kunit_do_assertion'
   ia64-linux-ld: iio-test-rescale.c:(.text+0xac2): undefined reference to `kunit_do_assertion'
   ia64-linux-ld: iio-test-rescale.c:(.text+0xb72): undefined reference to `kunit_do_assertion'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
