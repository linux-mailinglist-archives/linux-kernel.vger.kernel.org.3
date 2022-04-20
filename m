Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3285080D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357346AbiDTGJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357156AbiDTGJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:09:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F585387B8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650434830; x=1681970830;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KuTd6E5ybvZ3QtSW21mxFZwhHyRoMHrc0tzA+AaNBso=;
  b=XcQNcqX2vwIUbkR2yUc0V5nINXvxkEFmT+uIOYyRLJrFPmjCgZS/9PvQ
   dYPIfHD099UMkFdINxd32gukqT3dJEVGbo2ByxQf7yMY2ylrYCJK2SnCz
   y85UbR3uXKNIItFmPRsXSuKDghNCG2qvwLlllfrd0mYS6ufqu2uS+VVXw
   JlGttyo1V0eHuwZcYazf/0/NiGBztTDTqNI1OHfMqtqmcgaa6jND747QH
   +jN48KKmb8NAAwhnxzgnMFySHQ5Da1ZtQTAvLfUOdsC28PGWZc52lul+I
   AIu4aml7UkvSV4HW5tirt9cYZDNUftDBTiUoPJ7pkn+xIYDHinrkWc7qe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326848666"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="326848666"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 23:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="510425000"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2022 23:07:06 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh3UY-0006dh-6F;
        Wed, 20 Apr 2022 06:07:06 +0000
Date:   Wed, 20 Apr 2022 14:06:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhi Wang <zhi.a.wang@intel.com>
Cc:     kbuild-all@lists.01.org, zhenyu.z.wang@intel.com,
        terrence.xu@intel.com, intel-gvt-dev@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [intel-gvt:gvt-next-bak-2022-04-13 2/4]
 drivers/gpu/drm/i915/intel_gvt.h:66:5: error: no previous prototype for
 'intel_gvt_iterate_mmio_table'
Message-ID: <202204201327.wDSzH3pV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/gvt-linux.git gvt-next-bak-2022-04-13
head:   f267d34e47f33a283b785a31b7b8d1c899502743
commit: e870ce1791520cd03f67c5a16f309d94e4aede85 [2/4] i915/gvt: Separate the MMIO tracking table from GVT-g
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220420/202204201327.wDSzH3pV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/gvt-linux/commit/e870ce1791520cd03f67c5a16f309d94e4aede85
        git remote add intel-gvt https://github.com/intel/gvt-linux.git
        git fetch --no-tags intel-gvt gvt-next-bak-2022-04-13
        git checkout e870ce1791520cd03f67c5a16f309d94e4aede85
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/gvt/gvt.h:39,
                    from drivers/gpu/drm/i915/gvt/mpt.h:36,
                    from <command-line>:
   drivers/gpu/drm/i915/intel_gvt.h:66:41: error: 'struct intel_gvt_mmio_table_iter' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
      66 | int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *iter)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/intel_gvt.h:66:5: error: no previous prototype for 'intel_gvt_iterate_mmio_table' [-Werror=missing-prototypes]
      66 | int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *iter)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/intel_gvt_iterate_mmio_table +66 drivers/gpu/drm/i915/intel_gvt.h

    65	
  > 66	int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *iter)
    67	{
    68		return 0;
    69	}
    70	#endif
    71	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
