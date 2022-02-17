Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260484B9B03
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiBQIaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:30:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiBQIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:30:21 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE898206DE2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645086607; x=1676622607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DNxzpVU2M5u2NQ9RyA6W5fZK2jqGruulU/pr3OaoB8c=;
  b=c/xPXRdTHDugRmOGw0FochcwCWsigQFMEktqvW04knaxFF+gtXNq9T+O
   twjts2gHrYdHyP92u1CFaYtE+8fQbFrph9JHu1nTC+YNRyW/e9DSyDtAr
   sAvLerBJzQiZHy0FGTKbW50ufiRhUSmgJh27v4R+gM6wdU8es7Y/O2CA3
   0+8PhiFwIE3X8iYrKY2fWLkYIoKPbShv5pALFvqnS4xLdrMp2WQ3qtXS2
   mwZ7C9yPUN5rDFtTPhEOEKr/RJewAMmveHo0mSxeeuc9vcmih6oUHPShr
   w2G5IWnVkcd4ZNLF1Ji5cIL402mrRvd7rP+cqsVOxXNJDC64+pzCk+5LO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="251023359"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="251023359"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="704689428"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2022 00:30:06 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKcAv-000Bef-BP; Thu, 17 Feb 2022 08:30:05 +0000
Date:   Thu, 17 Feb 2022 16:29:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Subject: [agd5f:drm-next 34/66]
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3757: warning: expecting
 prototype for dc_process_dmub_aux_transfer_async(). Prototype was for
 dc_enable_dmub_notifications() instead
Message-ID: <202202171607.KKSe7nmi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   5bbebaae14913a4180ff0cc7ddccfa177dba9705
commit: ed7208706448953c6f15009cf139135776c15713 [34/66] drm/amd/display: Fix for dmub outbox notification enable
config: microblaze-buildonly-randconfig-r003-20220216 (https://download.01.org/0day-ci/archive/20220217/202202171607.KKSe7nmi-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout ed7208706448953c6f15009cf139135776c15713
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:419: warning: Cannot understand  *****************************************************************************
    on line 419 - I thought it was a doc line
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3757: warning: Function parameter or member 'dc' not described in 'dc_enable_dmub_notifications'
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3757: warning: expecting prototype for dc_process_dmub_aux_transfer_async(). Prototype was for dc_enable_dmub_notifications() instead
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3762: warning: Cannot understand  *****************************************************************************
    on line 3762 - I thought it was a doc line
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3783: warning: Cannot understand  *****************************************************************************
    on line 3783 - I thought it was a doc line
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3873: warning: Cannot understand  *****************************************************************************
    on line 3873 - I thought it was a doc line
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3923: warning: Cannot understand  *****************************************************************************
    on line 3923 - I thought it was a doc line
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3987: warning: Cannot understand  *****************************************************************************
    on line 3987 - I thought it was a doc line


vim +3757 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c

  3739	
  3740	/**
  3741	 * dc_process_dmub_aux_transfer_async - Submits aux command to dmub via inbox message
  3742	 *  Function: dc_enable_dmub_notifications
  3743	 *
  3744	 *  @brief
  3745	 *		Calls dc_is_dmub_outbox_supported to check if dmub fw supports outbox
  3746	 *		notifications. All DMs shall switch to dc_is_dmub_outbox_supported.
  3747	 *		This API shall be removed after switching.
  3748	 *
  3749	 *  @param
  3750	 *		[in] dc: dc structure
  3751	 *
  3752	 *  @return
  3753	 *		True if DMUB FW supports outbox notifications, False otherwise
  3754	 *****************************************************************************
  3755	 */
  3756	bool dc_enable_dmub_notifications(struct dc *dc)
> 3757	{
  3758		return dc_is_dmub_outbox_supported(dc);
  3759	}
  3760	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
