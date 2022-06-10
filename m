Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDC9546FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbiFJXFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbiFJXE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:04:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC71238DB2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654902297; x=1686438297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jwy0lMjC5qOj1+aKxm9YuQSuH+oZkV4ySJKRveeWpXA=;
  b=Vxbq1MdrjkCSi6ru9aJUd4RwvCK7pUYoarNF1akzipI79PWRXk8g9vYu
   vy11zrE4CjtmWHvfMGEab8VBlEpKZYg7u4jUAor2oGR9oM7yWWbQuNJHb
   E31wL/G5D190doG/0XyrRfUJQrWI1zAuBN0q6nQ/tw3Ud+JT5QkkyrmJL
   ync2WTyDq+ucmM+eq94/fkZwbafkynhgPw14TR6ORuFq89EKlykPuTD1N
   mzo/uradb4Z8CY83NG+pkHmF+cYP1nQjhAsao8q/g1JIDQQDIe/NKnB+h
   JMv17lKxK3/04p8Le3F3xfP24bKqazka/Wg84PxQpQCop2d1KoiYyAyuk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="277810272"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="277810272"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="638370355"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2022 16:04:55 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzngU-000ILj-Sr;
        Fri, 10 Jun 2022 23:04:54 +0000
Date:   Sat, 11 Jun 2022 07:04:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: [agd5f:drm-next 183/198]
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5081: warning: expecting
 prototype for amdgpu_device_gpu_recover_imp(). Prototype was for
 amdgpu_device_gpu_recover() instead
Message-ID: <202206110628.6e8xc6Is-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   a6eba20601a3c518f8c60af9da788f9559e0a03c
commit: cf727044144d47c3e8482b9a7775bd3f04a87341 [183/198] drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to amdgpu_device_gpu_recover
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220611/202206110628.6e8xc6Is-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout cf727044144d47c3e8482b9a7775bd3f04a87341
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5081: warning: expecting prototype for amdgpu_device_gpu_recover_imp(). Prototype was for amdgpu_device_gpu_recover() instead


vim +5081 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

e6c6338f393b74 Jack Zhang            2021-03-08  5067  
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5068  /**
c7703ce38c1ecd Andrey Grodzovsky     2022-02-11  5069   * amdgpu_device_gpu_recover_imp - reset the asic and recover scheduler
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5070   *
982a820bac1b64 Mauro Carvalho Chehab 2020-10-21  5071   * @adev: amdgpu_device pointer
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5072   * @job: which job trigger hang
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5073   *
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5074   * Attempt to reset the GPU if it has hung (all asics).
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5075   * Attempt to do soft-reset or full-reset and reinitialize Asic
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5076   * Returns 0 for success or an error on failure.
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5077   */
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5078  
cf727044144d47 Andrey Grodzovsky     2022-05-17  5079  int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5080  			      struct amdgpu_job *job)
26bc534094ed45 Andrey Grodzovsky     2018-11-22 @5081  {
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5082  	struct list_head device_list, *device_list_handle =  NULL;
7dd8c205eaedfa Evan Quan             2020-04-16  5083  	bool job_signaled = false;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5084  	struct amdgpu_hive_info *hive = NULL;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5085  	struct amdgpu_device *tmp_adev = NULL;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5086  	int i, r = 0;
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5087  	bool need_emergency_restart = false;
3f12acc8d6d4b2 Evan Quan             2020-04-21  5088  	bool audio_suspended = false;
e6c6338f393b74 Jack Zhang            2021-03-08  5089  	int tmp_vram_lost_counter;
04442bf70debb1 Lijo Lazar            2021-03-16  5090  	struct amdgpu_reset_context reset_context;
04442bf70debb1 Lijo Lazar            2021-03-16  5091  
04442bf70debb1 Lijo Lazar            2021-03-16  5092  	memset(&reset_context, 0, sizeof(reset_context));
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5093  
6e3cd2a9a6ac32 Mauro Carvalho Chehab 2020-10-23  5094  	/*
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5095  	 * Special case: RAS triggered and full reset isn't supported
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5096  	 */
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5097  	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5098  
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5099  	/*
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5100  	 * Flush RAM to disk so that after reboot
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5101  	 * the user can read log and see why the system rebooted.
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5102  	 */
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5103  	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5104  		DRM_WARN("Emergency reboot.");
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5105  
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5106  		ksys_sync_helper();
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5107  		emergency_restart();
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5108  	}
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5109  
b823821f2244ad Le Ma                 2019-11-27  5110  	dev_info(adev->dev, "GPU %s begin!\n",
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5111  		need_emergency_restart ? "jobs stop":"reset");
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5112  
175ac6ec6bd8db Zhigang Luo           2021-11-26  5113  	if (!amdgpu_sriov_vf(adev))
d95e8e97e2d522 Dennis Li             2020-08-18  5114  		hive = amdgpu_get_xgmi_hive(adev);
681260df4dad45 Andrey Grodzovsky     2021-12-15  5115  	if (hive)
53b3f8f40e6cff Dennis Li             2020-08-19  5116  		mutex_lock(&hive->hive_lock);
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5117  
04442bf70debb1 Lijo Lazar            2021-03-16  5118  	reset_context.method = AMD_RESET_METHOD_NONE;
04442bf70debb1 Lijo Lazar            2021-03-16  5119  	reset_context.reset_req_dev = adev;
04442bf70debb1 Lijo Lazar            2021-03-16  5120  	reset_context.job = job;
04442bf70debb1 Lijo Lazar            2021-03-16  5121  	reset_context.hive = hive;
04442bf70debb1 Lijo Lazar            2021-03-16  5122  	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
04442bf70debb1 Lijo Lazar            2021-03-16  5123  
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5124  	/*
9e94d22c008585 Evan Quan             2020-04-16  5125  	 * Build list of devices to reset.
9e94d22c008585 Evan Quan             2020-04-16  5126  	 * In case we are in XGMI hive mode, resort the device list
9e94d22c008585 Evan Quan             2020-04-16  5127  	 * to put adev in the 1st position.
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5128  	 */
9e94d22c008585 Evan Quan             2020-04-16  5129  	INIT_LIST_HEAD(&device_list);
175ac6ec6bd8db Zhigang Luo           2021-11-26  5130  	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
655ce9cb13b596 shaoyunl              2021-03-04  5131  		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
655ce9cb13b596 shaoyunl              2021-03-04  5132  			list_add_tail(&tmp_adev->reset_list, &device_list);
655ce9cb13b596 shaoyunl              2021-03-04  5133  		if (!list_is_first(&adev->reset_list, &device_list))
655ce9cb13b596 shaoyunl              2021-03-04  5134  			list_rotate_to_front(&adev->reset_list, &device_list);
655ce9cb13b596 shaoyunl              2021-03-04  5135  		device_list_handle = &device_list;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5136  	} else {
655ce9cb13b596 shaoyunl              2021-03-04  5137  		list_add_tail(&adev->reset_list, &device_list);
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5138  		device_list_handle = &device_list;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5139  	}
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5140  
e923be9934a9c5 Andrey Grodzovsky     2022-01-25  5141  	/* We need to lock reset domain only once both for XGMI and single device */
e923be9934a9c5 Andrey Grodzovsky     2022-01-25  5142  	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
e923be9934a9c5 Andrey Grodzovsky     2022-01-25  5143  				    reset_list);
3675c2f26f33ab Andrey Grodzovsky     2022-01-25  5144  	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
e923be9934a9c5 Andrey Grodzovsky     2022-01-25  5145  
12ffa55da60f83 Andrey Grodzovsky     2019-08-30  5146  	/* block all schedulers and reset given job's ring */
655ce9cb13b596 shaoyunl              2021-03-04  5147  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
f287a3c5b03f51 Andrey Grodzovsky     2021-12-16  5148  
e923be9934a9c5 Andrey Grodzovsky     2022-01-25  5149  		amdgpu_device_set_mp1_state(tmp_adev);
f287a3c5b03f51 Andrey Grodzovsky     2021-12-16  5150  
3f12acc8d6d4b2 Evan Quan             2020-04-21  5151  		/*
3f12acc8d6d4b2 Evan Quan             2020-04-21  5152  		 * Try to put the audio codec into suspend state
3f12acc8d6d4b2 Evan Quan             2020-04-21  5153  		 * before gpu reset started.
3f12acc8d6d4b2 Evan Quan             2020-04-21  5154  		 *
3f12acc8d6d4b2 Evan Quan             2020-04-21  5155  		 * Due to the power domain of the graphics device
3f12acc8d6d4b2 Evan Quan             2020-04-21  5156  		 * is shared with AZ power domain. Without this,
3f12acc8d6d4b2 Evan Quan             2020-04-21  5157  		 * we may change the audio hardware from behind
3f12acc8d6d4b2 Evan Quan             2020-04-21  5158  		 * the audio driver's back. That will trigger
3f12acc8d6d4b2 Evan Quan             2020-04-21  5159  		 * some audio codec errors.
3f12acc8d6d4b2 Evan Quan             2020-04-21  5160  		 */
3f12acc8d6d4b2 Evan Quan             2020-04-21  5161  		if (!amdgpu_device_suspend_display_audio(tmp_adev))
3f12acc8d6d4b2 Evan Quan             2020-04-21  5162  			audio_suspended = true;
3f12acc8d6d4b2 Evan Quan             2020-04-21  5163  
9e94d22c008585 Evan Quan             2020-04-16  5164  		amdgpu_ras_set_error_query_ready(tmp_adev, false);
9e94d22c008585 Evan Quan             2020-04-16  5165  
52fb44cf30fc6b Evan Quan             2020-04-16  5166  		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
52fb44cf30fc6b Evan Quan             2020-04-16  5167  
c004d44e103775 Mukul Joshi           2022-03-31  5168  		if (!amdgpu_sriov_vf(tmp_adev))
9e94d22c008585 Evan Quan             2020-04-16  5169  			amdgpu_amdkfd_pre_reset(tmp_adev);
9e94d22c008585 Evan Quan             2020-04-16  5170  
fdafb3597a2cc4 Evan Quan             2019-06-26  5171  		/*
fdafb3597a2cc4 Evan Quan             2019-06-26  5172  		 * Mark these ASICs to be reseted as untracked first
fdafb3597a2cc4 Evan Quan             2019-06-26  5173  		 * And add them back after reset completed
fdafb3597a2cc4 Evan Quan             2019-06-26  5174  		 */
fdafb3597a2cc4 Evan Quan             2019-06-26  5175  		amdgpu_unregister_gpu_instance(tmp_adev);
fdafb3597a2cc4 Evan Quan             2019-06-26  5176  
087451f372bf76 Evan Quan             2021-10-19  5177  		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
565d1941557756 Evan Quan             2020-03-11  5178  
f1c1314be42971 xinhui pan            2019-07-04  5179  		/* disable ras on ALL IPs */
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5180  		if (!need_emergency_restart &&
b823821f2244ad Le Ma                 2019-11-27  5181  		      amdgpu_device_ip_need_full_reset(tmp_adev))
f1c1314be42971 xinhui pan            2019-07-04  5182  			amdgpu_ras_suspend(tmp_adev);
f1c1314be42971 xinhui pan            2019-07-04  5183  
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5184  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5185  			struct amdgpu_ring *ring = tmp_adev->rings[i];
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5186  
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5187  			if (!ring || !ring->sched.thread)
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5188  				continue;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5189  
0b2d2c2eecf27f Andrey Grodzovsky     2019-08-27  5190  			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5191  
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5192  			if (need_emergency_restart)
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5193  				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5194  		}
8f8c80f4300967 Jingwen Chen          2021-02-25  5195  		atomic_inc(&tmp_adev->gpu_reset_counter);
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5196  	}
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5197  
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5198  	if (need_emergency_restart)
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5199  		goto skip_sched_resume;
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5200  
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5201  	/*
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5202  	 * Must check guilty signal here since after this point all old
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5203  	 * HW fences are force signaled.
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5204  	 *
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5205  	 * job->base holds a reference to parent fence
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5206  	 */
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5207  	if (job && job->base.s_fence->parent &&
7dd8c205eaedfa Evan Quan             2020-04-16  5208  	    dma_fence_is_signaled(job->base.s_fence->parent)) {
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5209  		job_signaled = true;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5210  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5211  		goto skip_hw_reset;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5212  	}
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5213  

:::::: The code at line 5081 was first introduced by commit
:::::: 26bc534094ed45fdedef6b4ce8b96030340c5ce7 drm/amdgpu: Refactor GPU reset for XGMI hive case

:::::: TO: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
