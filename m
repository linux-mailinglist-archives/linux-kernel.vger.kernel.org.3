Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B5758E98B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiHJJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiHJJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:23:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795816B17B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660123427; x=1691659427;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rgieq/Wsgk3jqwiwYP1VAy49GFLpvxdyT4P/eM4dz9o=;
  b=Y7gz7eOKoWMr1OjJS8aF7QtXBQj+jYdirl/tQs+Ay/YNyum75n2f7tFC
   U45Z4PqpF7ExDjNNsFaHMpwGCyLZzCN66mFfW1T2KD3WHrr3sJEk7qtFF
   eLAhrStbC8wmzHla9/XtoVyMOzTK1sU2HUz09jNsoYePJ8L/5L+iDRhy4
   gGD70+bcv3oyNleri54L97T+SDDaGUh8LiCEj5eeRy+FJha8vxstaWi/L
   vEwzbzUsRWZbNUavhpwLKqbEx+fq5GQr/DkgKvh5wUDrS9hTnSGJiLgEJ
   lD1x4gjvQ+FDXxS0F7UB0mVZHUXtyisxlPzn1bfTqCkbYBV04bs3r8Z2p
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="291828825"
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="291828825"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 02:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,226,1654585200"; 
   d="scan'208";a="932821049"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2022 02:23:45 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLhwG-00006h-1W;
        Wed, 10 Aug 2022 09:23:44 +0000
Date:   Wed, 10 Aug 2022 17:22:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jude Shih <shenshih@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 8765/9027]
 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:632:6: warning:
 no previous prototype for 'dmub_aux_setconfig_callback'
Message-ID: <202208101710.k7almVm5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   9c5eacc2ad1f605c31c69d9e2436823ada99f1dc
commit: 734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd [8765/9027] drm/amd/display: Support for DMUB HPD interrupt handling
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220810/202208101710.k7almVm5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 734d5ce02cb069cccedc993d8f1dc0ea41cfa3dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:632:6: warning: no previous prototype for 'dmub_aux_setconfig_callback' [-Wmissing-prototypes]
     632 | void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:648:6: warning: no previous prototype for 'dmub_hpd_callback' [-Wmissing-prototypes]
     648 | void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
         |      ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:702:6: warning: no previous prototype for 'register_dmub_notify_callback' [-Wmissing-prototypes]
     702 | bool register_dmub_notify_callback(struct amdgpu_device *adev, enum dmub_notification_type type,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:37,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:29:
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'dm_dmub_outbox1_low_irq':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:763:51: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'unsigned int' [-Wformat=]
     763 |                                         DRM_ERROR("DM: notify type %d larger than the array size %ld !", notify.type,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_print.h:498:19: note: in definition of macro 'DRM_ERROR'
     498 |         __drm_err(fmt, ##__VA_ARGS__)
         |                   ^~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:763:100: note: format string is defined here
     763 |                                         DRM_ERROR("DM: notify type %d larger than the array size %ld !", notify.type,
         |                                                                                                  ~~^
         |                                                                                                    |
         |                                                                                                    long int
         |                                                                                                  %d
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'dm_update_mst_vcpi_slots_for_dsc':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7014:19: warning: variable 'clock' set but not used [-Wunused-but-set-variable]
    7014 |         int i, j, clock;
         |                   ^~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:633: warning: expecting prototype for dmub_aux_setconfig_reply_callback(). Prototype was for dmub_aux_setconfig_callback() instead


vim +/dmub_aux_setconfig_callback +632 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

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
 > 632	void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
 > 633	{
   634		if (adev->dm.dmub_notify)
   635			memcpy(adev->dm.dmub_notify, notify, sizeof(struct dmub_notification));
   636		if (notify->type == DMUB_NOTIFICATION_AUX_REPLY)
   637			complete(&adev->dm.dmub_aux_transfer_done);
   638	}
   639	
   640	/**
   641	 * dmub_hpd_callback - DMUB HPD interrupt processing callback.
   642	 * @adev: amdgpu_device pointer
   643	 * @notify: dmub notification structure
   644	 *
   645	 * Dmub Hpd interrupt processing callback. Gets displayindex through the
   646	 * ink index and calls helper to do the processing.
   647	 */
 > 648	void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
   649	{
   650		struct amdgpu_dm_connector *aconnector;
   651		struct drm_connector *connector;
   652		struct drm_connector_list_iter iter;
   653		struct dc_link *link;
   654		uint8_t link_index = 0;
   655		struct drm_device *dev = adev->dm.ddev;
   656	
   657		if (adev == NULL)
   658			return;
   659	
   660		if (notify == NULL) {
   661			DRM_ERROR("DMUB HPD callback notification was NULL");
   662			return;
   663		}
   664	
   665		if (notify->link_index > adev->dm.dc->link_count) {
   666			DRM_ERROR("DMUB HPD index (%u)is abnormal", notify->link_index);
   667			return;
   668		}
   669	
   670		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
   671	
   672		link_index = notify->link_index;
   673	
   674		link = adev->dm.dc->links[link_index];
   675	
   676		drm_connector_list_iter_begin(dev, &iter);
   677		drm_for_each_connector_iter(connector, &iter) {
   678			aconnector = to_amdgpu_dm_connector(connector);
   679			if (link && aconnector->dc_link == link) {
   680				DRM_INFO("DMUB HPD callback: link_index=%u\n", link_index);
   681				handle_hpd_irq_helper(aconnector);
   682				break;
   683			}
   684		}
   685		drm_connector_list_iter_end(&iter);
   686		drm_modeset_unlock(&dev->mode_config.connection_mutex);
   687	
   688	}
   689	
   690	/**
   691	 * register_dmub_notify_callback - Sets callback for DMUB notify
   692	 * @adev: amdgpu_device pointer
   693	 * @type: Type of dmub notification
   694	 * @callback: Dmub interrupt callback function
   695	 * @dmub_int_thread_offload: offload indicator
   696	 *
   697	 * API to register a dmub callback handler for a dmub notification
   698	 * Also sets indicator whether callback processing to be offloaded.
   699	 * to dmub interrupt handling thread
   700	 * Return: true if successfully registered, false if there is existing registration
   701	 */
 > 702	bool register_dmub_notify_callback(struct amdgpu_device *adev, enum dmub_notification_type type,
   703	dmub_notify_interrupt_callback_t callback, bool dmub_int_thread_offload)
   704	{
   705		if (callback != NULL && type < ARRAY_SIZE(adev->dm.dmub_thread_offload)) {
   706			adev->dm.dmub_callback[type] = callback;
   707			adev->dm.dmub_thread_offload[type] = dmub_int_thread_offload;
   708		} else
   709			return false;
   710	
   711		return true;
   712	}
   713	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
