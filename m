Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CFD4CBEF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiCCNfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCCNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:35:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED75188A36
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646314496; x=1677850496;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zwRQbzHSEEhhJ1nxzqHcTOzK5LNfD2R6KQ7CwY8Nkuw=;
  b=iWgC0pJBTDE+Q2/F7SLlUW5MeKIiKFLoPBu/+rAeGU3vSmIrOB34YONK
   +q7dXI2t3l8Cbr0VMEzioq1B0MkeUHeoVBVhBvuTUt63Gysfb6t6PKuSJ
   WFegeQWpTVLeFwuiCmnuxIsE/3uOcm3us28s5u0U8/C94dSkL8TuLl5Jr
   NTT8DEDoCSiby5kQouwZiCrGrdZ4NVDSNngbttSnyLxgqrZhdnvNTDmaL
   JHefyoZ88yo1gdWnKkv5slepPqcS+EjCyFBUpbpvPCuTfcarHtk5rvv3b
   pStnZ8J6xyDyXSbmDoE3LNzmOTyxJJa8A7SJGr6CLiGGTTV5Wbid86c7k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="316894609"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="316894609"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 05:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="630791640"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2022 05:34:55 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPlba-0000aD-CE; Thu, 03 Mar 2022 13:34:54 +0000
Date:   Thu, 3 Mar 2022 21:34:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dongjin Kim <tobetter@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tobetter:odroid-5.17.y 4/41] drivers/gpu/drm/drm_mipi_dbi.c:77:17:
 warning: unused variable 'mipi_dbi_dcs_read_commands'
Message-ID: <202203032157.rhC4yqLG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/tobetter/linux odroid-5.17.y
head:   e882d3aa45fcf49791433e9606016225df72a12e
commit: cac3180b84c170a7d3e892f4c9058b58c19bbc94 [4/41] ODROID-COMMON: gpu/drm: Add new Tiny DRM driver with Ili9488
config: hexagon-randconfig-r013-20220303 (https://download.01.org/0day-ci/archive/20220303/202203032157.rhC4yqLG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/tobetter/linux/commit/cac3180b84c170a7d3e892f4c9058b58c19bbc94
        git remote add tobetter https://github.com/tobetter/linux
        git fetch --no-tags tobetter odroid-5.17.y
        git checkout cac3180b84c170a7d3e892f4c9058b58c19bbc94
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_mipi_dbi.c:77:17: warning: unused variable 'mipi_dbi_dcs_read_commands' [-Wunused-const-variable]
   static const u8 mipi_dbi_dcs_read_commands[] = {
                   ^
   1 warning generated.


vim +/mipi_dbi_dcs_read_commands +77 drivers/gpu/drm/drm_mipi_dbi.c

02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   76  
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  @77  static const u8 mipi_dbi_dcs_read_commands[] = {
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   78  	MIPI_DCS_GET_DISPLAY_ID,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   79  	MIPI_DCS_GET_RED_CHANNEL,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   80  	MIPI_DCS_GET_GREEN_CHANNEL,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   81  	MIPI_DCS_GET_BLUE_CHANNEL,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   82  	MIPI_DCS_GET_DISPLAY_STATUS,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   83  	MIPI_DCS_GET_POWER_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   84  	MIPI_DCS_GET_ADDRESS_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   85  	MIPI_DCS_GET_PIXEL_FORMAT,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   86  	MIPI_DCS_GET_DISPLAY_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   87  	MIPI_DCS_GET_SIGNAL_MODE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   88  	MIPI_DCS_GET_DIAGNOSTIC_RESULT,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   89  	MIPI_DCS_READ_MEMORY_START,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   90  	MIPI_DCS_READ_MEMORY_CONTINUE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   91  	MIPI_DCS_GET_SCANLINE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   92  	MIPI_DCS_GET_DISPLAY_BRIGHTNESS,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   93  	MIPI_DCS_GET_CONTROL_DISPLAY,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   94  	MIPI_DCS_GET_POWER_SAVE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   95  	MIPI_DCS_GET_CABC_MIN_BRIGHTNESS,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   96  	MIPI_DCS_READ_DDB_START,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   97  	MIPI_DCS_READ_DDB_CONTINUE,
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   98  	0, /* sentinel */
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22   99  };
02dd95fe316936 drivers/gpu/drm/tinydrm/mipi-dbi.c Noralf Trønnes 2017-01-22  100  

:::::: The code at line 77 was first introduced by commit
:::::: 02dd95fe316936269a52d6ccb971bb956412b40a drm/tinydrm: Add MIPI DBI support

:::::: TO: Noralf Trønnes <noralf@tronnes.org>
:::::: CC: Noralf Trønnes <noralf@tronnes.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
