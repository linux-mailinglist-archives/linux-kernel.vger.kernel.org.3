Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF057F516
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiGXMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXMgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:36:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F59E0BF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658666162; x=1690202162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=50FGdPaYbE9bf8GxcA1c2YFF5erLru83QL9sb0OkJNs=;
  b=XRtFZlO/tUw5kkZWM58fSsdooR6viNA/BA3RW0/CQcDOFNijIRhXMC2F
   eNNjQW40gfKD6nkSO5fZt3H4wJB+3A8ymXxTGphxXWY6NBEih/zSFju4z
   N4ANrODGmoL6yPkPGL+pONHDOHszNqbZwvHi8ZOjkFoHgfE11CC82SajT
   Nt7KTVoMqajFFb0wW2b9LAQOJFKe6JjtVaONjSzHY/wmOlXueSdVsD0JJ
   tbcWvBDa1HxQ/dXRNcF9ju5tm0J+LU0TE0SUX4l4n3v0M5hQfak4N9A7l
   ba3TJ88sWUCN8vRJvHHBhe1JneYUNBZWswL6i0yGbb+demwnQY6YTpl7h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267933356"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="267933356"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 05:36:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="926572573"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 05:36:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFapz-0003rl-1r;
        Sun, 24 Jul 2022 12:35:59 +0000
Date:   Sun, 24 Jul 2022 20:35:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jude Shih <shenshih@amd.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.15 42/131]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:633: warning:
 expecting prototype for dmub_aux_setconfig_reply_callback(). Prototype was
 for dmub_aux_setconfig_callback() instead
Message-ID: <202207242010.Z8o6RAVI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.15
head:   5de1f462672e72669ad0ac037800c4d64ad6a891
commit: 263f18aecda9dd2f3e776a7cfebebca3dc3925d4 [42/131] drm/amd/display: Support for DMUB HPD interrupt handling
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20220724/202207242010.Z8o6RAVI-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/263f18aecda9dd2f3e776a7cfebebca3dc3925d4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.15
        git checkout 263f18aecda9dd2f3e776a7cfebebca3dc3925d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:633: warning: expecting prototype for dmub_aux_setconfig_reply_callback(). Prototype was for dmub_aux_setconfig_callback() instead


vim +633 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

   622	
   623	/**
   624	 * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONFIG command.
   625	 * @adev: amdgpu_device pointer
   626	 * @notify: dmub notification structure
   627	 *
   628	 * Dmub AUX or SET_CONFIG command completion processing callback
   629	 * Copies dmub notification to DM which is to be read by AUX command.
   630	 * issuing thread and also signals the event to wake up the thread.
   631	 */
   632	void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
 > 633	{
   634		if (adev->dm.dmub_notify)
   635			memcpy(adev->dm.dmub_notify, notify, sizeof(struct dmub_notification));
   636		if (notify->type == DMUB_NOTIFICATION_AUX_REPLY)
   637			complete(&adev->dm.dmub_aux_transfer_done);
   638	}
   639	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
