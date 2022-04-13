Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CE500222
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiDMW4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238658AbiDMW4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:56:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B172F004
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649890464; x=1681426464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rWC4K8bYYeKA/MkuNfMIhfyXvP8RFuP87LKQgPTsW0Q=;
  b=MAM0CVPWYyjqu9XeaSYF5uvG6SJydanX8AA47y5OHEjW4Th8BA7xH5Nd
   Ef71O1innNRUlUpsFmZTj7PWWd9617356RERMatTbbqpu3oD4RpRzRGB3
   zjSP3A99fOVTbm7O6xaoSwGDEDkYJADtZ15lSbWuloZj7OuTDYN9VeqAJ
   xG6iUpbRopJ4CQgx5gXcvTh2JJhi4FdCQbw98cSqtCW7c3bnQ0n4dqBL1
   jThZQiw4sQmAhCRTGuZ0oSKsvPgowxcNasrFBG8J1hXFsFtas9C2K2ZOx
   nIv3oHV0smrEl2JBlmAkhd5ekex4O4vsQHh+zTr2S8pUentCf6qiWjZvi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250085798"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="250085798"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 15:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="655750479"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2022 15:54:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nelsN-0000gv-4A;
        Wed, 13 Apr 2022 22:54:15 +0000
Date:   Thu, 14 Apr 2022 06:53:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 1/4] ld.lld: error: duplicate symbol:
 kallsyms_lookup_names
Message-ID: <202204140602.5dwlNXPa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   ba203a35f44376540c3c5dd72bf9ba0b9cfc4473
commit: c42ec4e0334aacc783148e3571f3e0db53e4220a [1/4] kallsyms: Add kallsyms_lookup_names function
config: arm-randconfig-c002-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140602.5dwlNXPa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=c42ec4e0334aacc783148e3571f3e0db53e4220a
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout c42ec4e0334aacc783148e3571f3e0db53e4220a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at analogix_dp_core.c
   >>> drivers/gpu/drm/bridge/analogix/analogix_dp_core.o:(kallsyms_lookup_names)
   >>> defined at analogix-i2c-dptx.c
   >>> drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at analogix_dp_core.c
   >>> drivers/gpu/drm/bridge/analogix/analogix_dp_core.o:(kallsyms_lookup_names)
   >>> defined at analogix_dp_reg.c
   >>> drivers/gpu/drm/bridge/analogix/analogix_dp_reg.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at kmb_crtc.c
   >>> drivers/gpu/drm/kmb/kmb_crtc.o:(kallsyms_lookup_names)
   >>> defined at kmb_drv.c
   >>> drivers/gpu/drm/kmb/kmb_drv.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at kmb_crtc.c
   >>> drivers/gpu/drm/kmb/kmb_crtc.o:(kallsyms_lookup_names)
   >>> defined at kmb_dsi.c
   >>> drivers/gpu/drm/kmb/kmb_dsi.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at kmb_crtc.c
   >>> drivers/gpu/drm/kmb/kmb_crtc.o:(kallsyms_lookup_names)
   >>> defined at kmb_plane.c
   >>> drivers/gpu/drm/kmb/kmb_plane.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at atmel_hlcdc_crtc.c
   >>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.o:(kallsyms_lookup_names)
   >>> defined at atmel_hlcdc_dc.c
   >>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at atmel_hlcdc_crtc.c
   >>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.o:(kallsyms_lookup_names)
   >>> defined at atmel_hlcdc_plane.c
   >>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at atmel_hlcdc_crtc.c
   >>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.o:(kallsyms_lookup_names)
   >>> defined at atmel_hlcdc_output.c
   >>> drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at shmob_drm_backlight.c
   >>> drivers/gpu/drm/shmobile/shmob_drm_backlight.o:(kallsyms_lookup_names)
   >>> defined at shmob_drm_crtc.c
   >>> drivers/gpu/drm/shmobile/shmob_drm_crtc.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at shmob_drm_backlight.c
   >>> drivers/gpu/drm/shmobile/shmob_drm_backlight.o:(kallsyms_lookup_names)
   >>> defined at shmob_drm_drv.c
   >>> drivers/gpu/drm/shmobile/shmob_drm_drv.o:(.text+0x1)
--
>> ld.lld: error: duplicate symbol: kallsyms_lookup_names
   >>> defined at shmob_drm_backlight.c
   >>> drivers/gpu/drm/shmobile/shmob_drm_backlight.o:(kallsyms_lookup_names)
   >>> defined at shmob_drm_plane.c
   >>> drivers/gpu/drm/shmobile/shmob_drm_plane.o:(.text+0x1)
..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
