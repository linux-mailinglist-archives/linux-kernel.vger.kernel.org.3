Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75F5097F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384980AbiDUGnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384965AbiDUGnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:43:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EA613F90
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523251; x=1682059251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nu5Wpf/FIryLF3arCfxEzEoOTvoNmAs9ROtYcVQsZuU=;
  b=dX7H+oeIX7C0iWL9QiReB3u8NPHWzrBhts0VQxupHDGnT06JM+xE9f8W
   oJNOODFMHYVk7eDL+W4kf4ozx/fE4uScnzGeoWkRmDGsKeTWClFjll4l1
   xdMwTIl8o2TQOOUoDWXWxut5O0D59q8+9ADQon6KEXFR9nordMJ4UL3YT
   L1gLCIOtvS7oyhJSCIAXNGF7ZO6tl7VngRIVWnBnWS5lJVscFMJE+wXc8
   wwL3w8z927BLM8YStBMWabC+MWxlt+Oc2+3SuRYxtoncPvYz24rcj7XyX
   Os2cadZcHBe4sLKZlzaaa76xJXDanqC0F7CCPuR+8G8k7MMF9S4Hp06l/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289368911"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289368911"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="658390984"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2022 23:40:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQUj-0007xm-CN;
        Thu, 21 Apr 2022 06:40:49 +0000
Date:   Thu, 21 Apr 2022 14:40:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.a.wang@intel.com>
Cc:     kbuild-all@lists.01.org, zhenyu.z.wang@intel.com,
        terrence.xu@intel.com, intel-gvt-dev@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [intel-gvt:gvt-next-bak-without-chris-patches 1/5]
 drivers/gpu/drm/i915/gvt/handlers.c:75:6: error: no previous prototype for
 'intel_gvt_match_device'
Message-ID: <202204202233.2S88zDWj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/gvt-linux.git gvt-next-bak-without-chris-patches
head:   1f9dedeee16643ba20fffd43296978bc434218d2
commit: 8c7bb1f9b70a7b490776961767e69f9423280181 [1/5] i915/gvt: Separate the MMIO tracking table from GVT-g
config: x86_64-syzkaller (https://download.01.org/0day-ci/archive/20220420/202204202233.2S88zDWj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/gvt-linux/commit/8c7bb1f9b70a7b490776961767e69f9423280181
        git remote add intel-gvt https://github.com/intel/gvt-linux.git
        git fetch --no-tags intel-gvt gvt-next-bak-without-chris-patches
        git checkout 8c7bb1f9b70a7b490776961767e69f9423280181
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/i915/gvt/handlers.c:75:6: error: no previous prototype for 'intel_gvt_match_device' [-Werror=missing-prototypes]
      75 | bool intel_gvt_match_device(struct intel_gvt *gvt,
         |      ^~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/intel_gvt_match_device +75 drivers/gpu/drm/i915/gvt/handlers.c

12d14cc43b3470 Zhi Wang 2016-08-30  74  
12d14cc43b3470 Zhi Wang 2016-08-30 @75  bool intel_gvt_match_device(struct intel_gvt *gvt,
12d14cc43b3470 Zhi Wang 2016-08-30  76  		unsigned long device)
12d14cc43b3470 Zhi Wang 2016-08-30  77  {
12d14cc43b3470 Zhi Wang 2016-08-30  78  	return intel_gvt_get_device_type(gvt) & device;
12d14cc43b3470 Zhi Wang 2016-08-30  79  }
12d14cc43b3470 Zhi Wang 2016-08-30  80  

:::::: The code at line 75 was first introduced by commit
:::::: 12d14cc43b34706283246917329b2182163ba9aa drm/i915/gvt: Introduce a framework for tracking HW registers.

:::::: TO: Zhi Wang <zhi.a.wang@intel.com>
:::::: CC: Zhenyu Wang <zhenyuw@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
