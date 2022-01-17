Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B94910F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbiAQU1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:27:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:55705 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235244AbiAQU1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642451269; x=1673987269;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6J7EAmc3BVCdekV+9fAAd4SfvYLQlJjb0v5rHGXaptc=;
  b=kN+7rvC3fpZ8sEv3gydCBFKLKWSGump5nd1C7PrhUP5/ZZMHWs0kekH8
   j0myBaUgX/ytXYUH9W8Ovvs00JQ/lF/QsHb+1TklEmi4t18jOrv7TJJtg
   OCo7PfHlt/J4dpq+hlyjL6nXECh+OEjSh10ovP9SkgQ5yaRFrR0RYayls
   /k0IJNFRNVIbt92jrq4sPw+p+Hryxq1szJvfmcXH+Zquo3ndXsC/A2kww
   dJBYkxZH9Ei0WYl4hIcS2OI3P8Efg/ZuGeeArq4MOC2ZyOufrqV912zz9
   KH/JfOWPYjXVzOYwidjI99CirC22SySCae2Ul6yW6apLkjhIVEQeavX0Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="224669290"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224669290"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 12:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="625289742"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2022 12:27:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9YbS-000Bqo-Nm; Mon, 17 Jan 2022 20:27:46 +0000
Date:   Tue, 18 Jan 2022 04:26:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [drm-misc:drm-misc-next 3/5] ld.lld: error: undefined symbol:
 drm_dp_calc_pbn_mode
Message-ID: <202201180447.2T9OteXU-lkp@intel.com>
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
config: hexagon-randconfig-r041-20220116 (https://download.01.org/0day-ci/archive/20220118/202201180447.2T9OteXU-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout adb9d5a2cc77e8aefe98fe4c11656c5b7025c248
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: drm_dp_calc_pbn_mode
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(igt_dp_mst_calc_pbn_mode) in archive drivers/built-in.a
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(igt_dp_mst_calc_pbn_mode) in archive drivers/built-in.a
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(igt_dp_mst_calc_pbn_mode) in archive drivers/built-in.a
   >>> referenced 7 more times
--
>> ld.lld: error: undefined symbol: drm_dp_encode_sideband_req
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(sideband_msg_req_encode_decode) in archive drivers/built-in.a
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(sideband_msg_req_encode_decode) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_dp_decode_sideband_req
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(sideband_msg_req_encode_decode) in archive drivers/built-in.a
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(sideband_msg_req_encode_decode) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: drm_dp_dump_sideband_msg_req_body
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(sideband_msg_req_encode_decode) in archive drivers/built-in.a
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(sideband_msg_req_encode_decode) in archive drivers/built-in.a
   >>> referenced by test-drm_dp_mst_helper.c
   >>> gpu/drm/selftests/test-drm_dp_mst_helper.o:(sideband_msg_req_encode_decode) in archive drivers/built-in.a
   >>> referenced 1 more times

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
