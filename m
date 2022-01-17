Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39627491080
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbiAQSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:55:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:52857 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233296AbiAQSzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642445746; x=1673981746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OOvDBzf/x/mAjHZWTgT2oB2UUi0ZTBgH/ykCE1wtCDU=;
  b=D5nYQ8SdSgHAwjaLqhzBg5fyW2gyfvCDfLDOopgJrB58z0vodAT09meW
   dnDLgqMqmwEARdZuhUmPxVaDQ+lU7bHVzw+bpiwaFJwQhMc1l1ot2wj2b
   WXjsbVblKMYP3XH+I0l+ylI3No6L7VmGFBMy9ZiLSVFyFtb1wwYR/8AR/
   XW3lJhQtXy8fdvIwBBseUOwKIWaFMYfoUJsq4c4A4GzfYnfL7aygxVMMG
   aDta7OAdYTR8kKbsVvkWCjl3JRotuZgo+v/LbVUdUHjk1D4WVd3G/Bq22
   55ckaSwyYZVA4fyLJpRSwZzZA+KNE7GfORW/7GT+UR0Yekzc459dTV9KB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="305411291"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="305411291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="476737854"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2022 10:55:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9XAO-000Bmd-NP; Mon, 17 Jan 2022 18:55:44 +0000
Date:   Tue, 18 Jan 2022 02:54:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 3/5] ERROR: modpost:
 "drm_dp_dump_sideband_msg_req_body"
 [drivers/gpu/drm/selftests/test-drm_modeset.ko] undefined!
Message-ID: <202201180225.QB8esALn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   032a125904995985334766911de9e26ee2bbd646
commit: adb9d5a2cc77e8aefe98fe4c11656c5b7025c248 [3/5] drm/dp: Move DisplayPort helpers into separate helper module
config: x86_64-randconfig-a004-20220117 (https://download.01.org/0day-ci/archive/20220118/202201180225.QB8esALn-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout adb9d5a2cc77e8aefe98fe4c11656c5b7025c248
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "drm_dp_dump_sideband_msg_req_body" [drivers/gpu/drm/selftests/test-drm_modeset.ko] undefined!
>> ERROR: modpost: "drm_dp_decode_sideband_req" [drivers/gpu/drm/selftests/test-drm_modeset.ko] undefined!
>> ERROR: modpost: "drm_dp_encode_sideband_req" [drivers/gpu/drm/selftests/test-drm_modeset.ko] undefined!
>> ERROR: modpost: "drm_dp_calc_pbn_mode" [drivers/gpu/drm/selftests/test-drm_modeset.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
