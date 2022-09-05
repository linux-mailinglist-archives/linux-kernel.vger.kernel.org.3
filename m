Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA65ADBB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIEXHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiIEXHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:07:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D437C46DBD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662419219; x=1693955219;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0yEG+yi6czSDfdTB7591loWdi0xHHXveLYPJO6usfLQ=;
  b=AozR//eqO/dgTfIdIf33q20WL6XXo/XF763+75OT+bzt5YETYBsIab9m
   ghU6nNimFs6fqM6WGdjRgHWNqCQxU6+RgTqqm2gdFIj/G3FQC/oTh3SH5
   FA5ciPYzdvO3dp5TWDyxfHzpDcqRj9ozHN5z7DIDSUO+DR2BtmpnpOvlb
   4ngq3XiRxRL9WEiJTwo44KqxESIIv/UmwoLikh8kBRBrce7eU1Y9kmQbU
   LO6zwHHV4wdXIk1m0kichBSpRTcHNw3H5upiVxPKMSA9RS9z7pxLMi4J9
   ZOD1UAf4N70z51iU4dJyajuaSrei0jCaJW7N+AmE62SW+mWpZQCn8kAfP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="360411351"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="360411351"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 16:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="756162528"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Sep 2022 16:06:57 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVLBB-0004bN-0S;
        Mon, 05 Sep 2022 23:06:57 +0000
Date:   Tue, 6 Sep 2022 07:06:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhan Liu <zhan.liu@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Charlene Liu <charlene.liu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:88:14:
 warning: variable 'is_in_uma' set but not used
Message-ID: <202209060730.VeXAC3Z7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53e99dcff61e1523ec1c3628b2d564ba15d32eb7
commit: 3f68c01be9a2227de1e190317fe34a6fb835a094 drm/amd/display: add cyan_skillfish display support
date:   11 months ago
config: i386-buildonly-randconfig-r004-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060730.VeXAC3Z7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3f68c01be9a2227de1e190317fe34a6fb835a094
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3f68c01be9a2227de1e190317fe34a6fb835a094
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function 'gpu_addr_to_uma':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:88:14: warning: variable 'is_in_uma' set but not used [-Wunused-but-set-variable]
      88 |         bool is_in_uma;
         |              ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c: In function 'dcn201_pipe_control_lock':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:544:22: warning: variable 'hubp' set but not used [-Wunused-but-set-variable]
     544 |         struct hubp *hubp = NULL;
         |                      ^~~~
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c: In function 'dpp201_get_optimal_number_of_taps':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.c:185:18: warning: variable 'pixel_width' set but not used [-Wunused-but-set-variable]
     185 |         uint32_t pixel_width;
         |                  ^~~~~~~~~~~


vim +/is_in_uma +88 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c

    84	
    85	static void gpu_addr_to_uma(struct dce_hwseq *hwseq,
    86			PHYSICAL_ADDRESS_LOC *addr)
    87	{
  > 88		bool is_in_uma;
    89	
    90		if (hwseq->fb_base.quad_part <= addr->quad_part &&
    91				addr->quad_part < hwseq->fb_top.quad_part) {
    92			addr->quad_part -= hwseq->fb_base.quad_part;
    93			addr->quad_part += hwseq->fb_offset.quad_part;
    94			is_in_uma = true;
    95		} else if (hwseq->fb_offset.quad_part <= addr->quad_part &&
    96				addr->quad_part <= hwseq->uma_top.quad_part) {
    97			is_in_uma = true;
    98		} else if (addr->quad_part == 0) {
    99			is_in_uma = false;
   100		} else {
   101			is_in_uma = false;
   102		}
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
