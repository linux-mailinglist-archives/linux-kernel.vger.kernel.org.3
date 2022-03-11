Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08734D68DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351012AbiCKTD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346271AbiCKTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:03:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6320848890
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647025368; x=1678561368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6OB4B+4u4bJUkff8S9HsxqQidY+uv8RWGSGkNX5sfdY=;
  b=GD2CQWSMlOMlgFS6HwuOpxUAoYBOPsouRisO0O9WQozbY1kAcTFptM+2
   Z5dFfG26nxjSy8QFb4SNZQe3YaXJdZaE4yMkM1MFbi7cEfnZ/YFevYafI
   y+SIKSRhMVqmj1tDgN1E6UPIJzFikOiKbFQ48PvXRLjADMvXOwZLZ6spf
   3N6epAG6mRT324E/JG82R/UHaDjj12d8Z9qGSoDDmYedxVttgQYxNwSTy
   YFKxjOuE/GFApGs9uCGdo6BZVnNZ/EyjYgvjp9mnshHzkKvqAZAXoY7Jx
   h49nCldKVjmGuR+lW4u20exMA8nw4HteeXdiuP/b0eIVewgH75Kjk0iZV
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255368686"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="255368686"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 11:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="645021844"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2022 11:02:46 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSkXF-0006xo-D0; Fri, 11 Mar 2022 19:02:45 +0000
Date:   Sat, 12 Mar 2022 03:02:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: [agd5f:amd-staging-drm-next 1275/1333]
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5089: warning: expecting
 prototype for amdgpu_device_gpu_recover(). Prototype was for
 amdgpu_device_gpu_recover_imp() instead
Message-ID: <202203120337.51TmNkmV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git amd-staging-drm-next
head:   d974d4a696618e82ed6d39ad2b3688d915bb13dd
commit: 92fc842d9da15ae9b14dc964d115e250c7b568e1 [1275/1333] drm/amdgpu: Serialize non TDR gpu recovery with TDRs
config: riscv-randconfig-c006-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120337.51TmNkmV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f amd-staging-drm-next
        git checkout 92fc842d9da15ae9b14dc964d115e250c7b568e1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5089: warning: expecting prototype for amdgpu_device_gpu_recover(). Prototype was for amdgpu_device_gpu_recover_imp() instead


vim +5089 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

e6c6338f393b74 Jack Zhang            2021-03-08  5075  
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5076  /**
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5077   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5078   *
982a820bac1b64 Mauro Carvalho Chehab 2020-10-21  5079   * @adev: amdgpu_device pointer
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5080   * @job: which job trigger hang
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5081   *
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5082   * Attempt to reset the GPU if it has hung (all asics).
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5083   * Attempt to do soft-reset or full-reset and reinitialize Asic
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5084   * Returns 0 for success or an error on failure.
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5085   */
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5086  
92fc842d9da15a Andrey Grodzovsky     2021-12-17  5087  int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5088  			      struct amdgpu_job *job)
26bc534094ed45 Andrey Grodzovsky     2018-11-22 @5089  {
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5090  	struct list_head device_list, *device_list_handle =  NULL;
7dd8c205eaedfa Evan Quan             2020-04-16  5091  	bool job_signaled = false;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5092  	struct amdgpu_hive_info *hive = NULL;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5093  	struct amdgpu_device *tmp_adev = NULL;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5094  	int i, r = 0;
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5095  	bool need_emergency_restart = false;
3f12acc8d6d4b2 Evan Quan             2020-04-21  5096  	bool audio_suspended = false;
e6c6338f393b74 Jack Zhang            2021-03-08  5097  	int tmp_vram_lost_counter;
04442bf70debb1 Lijo Lazar            2021-03-16  5098  	struct amdgpu_reset_context reset_context;
04442bf70debb1 Lijo Lazar            2021-03-16  5099  
04442bf70debb1 Lijo Lazar            2021-03-16  5100  	memset(&reset_context, 0, sizeof(reset_context));
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5101  
6e3cd2a9a6ac32 Mauro Carvalho Chehab 2020-10-23  5102  	/*
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5103  	 * Special case: RAS triggered and full reset isn't supported
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5104  	 */
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5105  	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5106  
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5107  	/*
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5108  	 * Flush RAM to disk so that after reboot
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5109  	 * the user can read log and see why the system rebooted.
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5110  	 */
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5111  	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5112  		DRM_WARN("Emergency reboot.");
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5113  
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5114  		ksys_sync_helper();
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5115  		emergency_restart();
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5116  	}
d5ea093eebf022 Andrey Grodzovsky     2019-08-22  5117  
b823821f2244ad Le Ma                 2019-11-27  5118  	dev_info(adev->dev, "GPU %s begin!\n",
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5119  		need_emergency_restart ? "jobs stop":"reset");
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5120  
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5121  	/*
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5122  	 * Here we trylock to avoid chain of resets executing from
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5123  	 * either trigger by jobs on different adevs in XGMI hive or jobs on
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5124  	 * different schedulers for same device while this TO handler is running.
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5125  	 * We always reset all schedulers for device and all devices for XGMI
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5126  	 * hive so that should take care of them too.
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5127  	 */
175ac6ec6bd8db Zhigang Luo           2021-11-26  5128  	if (!amdgpu_sriov_vf(adev))
d95e8e97e2d522 Dennis Li             2020-08-18  5129  		hive = amdgpu_get_xgmi_hive(adev);
53b3f8f40e6cff Dennis Li             2020-08-19  5130  	if (hive) {
53b3f8f40e6cff Dennis Li             2020-08-19  5131  		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5132  			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
0b2d2c2eecf27f Andrey Grodzovsky     2019-08-27  5133  				job ? job->base.id : -1, hive->hive_id);
d95e8e97e2d522 Dennis Li             2020-08-18  5134  			amdgpu_put_xgmi_hive(hive);
ff99849b00fef5 Jingwen Chen          2021-07-20  5135  			if (job && job->vm)
91fb309d8294be Horace Chen           2021-01-20  5136  				drm_sched_increase_karma(&job->base);
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5137  			return 0;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5138  		}
53b3f8f40e6cff Dennis Li             2020-08-19  5139  		mutex_lock(&hive->hive_lock);
53b3f8f40e6cff Dennis Li             2020-08-19  5140  	}
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5141  
04442bf70debb1 Lijo Lazar            2021-03-16  5142  	reset_context.method = AMD_RESET_METHOD_NONE;
04442bf70debb1 Lijo Lazar            2021-03-16  5143  	reset_context.reset_req_dev = adev;
04442bf70debb1 Lijo Lazar            2021-03-16  5144  	reset_context.job = job;
04442bf70debb1 Lijo Lazar            2021-03-16  5145  	reset_context.hive = hive;
04442bf70debb1 Lijo Lazar            2021-03-16  5146  	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
04442bf70debb1 Lijo Lazar            2021-03-16  5147  
91fb309d8294be Horace Chen           2021-01-20  5148  	/*
91fb309d8294be Horace Chen           2021-01-20  5149  	 * lock the device before we try to operate the linked list
91fb309d8294be Horace Chen           2021-01-20  5150  	 * if didn't get the device lock, don't touch the linked list since
91fb309d8294be Horace Chen           2021-01-20  5151  	 * others may iterating it.
91fb309d8294be Horace Chen           2021-01-20  5152  	 */
91fb309d8294be Horace Chen           2021-01-20  5153  	r = amdgpu_device_lock_hive_adev(adev, hive);
91fb309d8294be Horace Chen           2021-01-20  5154  	if (r) {
91fb309d8294be Horace Chen           2021-01-20  5155  		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
91fb309d8294be Horace Chen           2021-01-20  5156  					job ? job->base.id : -1);
91fb309d8294be Horace Chen           2021-01-20  5157  
91fb309d8294be Horace Chen           2021-01-20  5158  		/* even we skipped this reset, still need to set the job to guilty */
ff99849b00fef5 Jingwen Chen          2021-07-20  5159  		if (job && job->vm)
91fb309d8294be Horace Chen           2021-01-20  5160  			drm_sched_increase_karma(&job->base);
91fb309d8294be Horace Chen           2021-01-20  5161  		goto skip_recovery;
91fb309d8294be Horace Chen           2021-01-20  5162  	}
91fb309d8294be Horace Chen           2021-01-20  5163  
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5164  	/*
9e94d22c008585 Evan Quan             2020-04-16  5165  	 * Build list of devices to reset.
9e94d22c008585 Evan Quan             2020-04-16  5166  	 * In case we are in XGMI hive mode, resort the device list
9e94d22c008585 Evan Quan             2020-04-16  5167  	 * to put adev in the 1st position.
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5168  	 */
9e94d22c008585 Evan Quan             2020-04-16  5169  	INIT_LIST_HEAD(&device_list);
175ac6ec6bd8db Zhigang Luo           2021-11-26  5170  	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
655ce9cb13b596 shaoyunl              2021-03-04  5171  		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
655ce9cb13b596 shaoyunl              2021-03-04  5172  			list_add_tail(&tmp_adev->reset_list, &device_list);
655ce9cb13b596 shaoyunl              2021-03-04  5173  		if (!list_is_first(&adev->reset_list, &device_list))
655ce9cb13b596 shaoyunl              2021-03-04  5174  			list_rotate_to_front(&adev->reset_list, &device_list);
655ce9cb13b596 shaoyunl              2021-03-04  5175  		device_list_handle = &device_list;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5176  	} else {
655ce9cb13b596 shaoyunl              2021-03-04  5177  		list_add_tail(&adev->reset_list, &device_list);
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5178  		device_list_handle = &device_list;
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5179  	}
26bc534094ed45 Andrey Grodzovsky     2018-11-22  5180  
12ffa55da60f83 Andrey Grodzovsky     2019-08-30  5181  	/* block all schedulers and reset given job's ring */
655ce9cb13b596 shaoyunl              2021-03-04  5182  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
3f12acc8d6d4b2 Evan Quan             2020-04-21  5183  		/*
3f12acc8d6d4b2 Evan Quan             2020-04-21  5184  		 * Try to put the audio codec into suspend state
3f12acc8d6d4b2 Evan Quan             2020-04-21  5185  		 * before gpu reset started.
3f12acc8d6d4b2 Evan Quan             2020-04-21  5186  		 *
3f12acc8d6d4b2 Evan Quan             2020-04-21  5187  		 * Due to the power domain of the graphics device
3f12acc8d6d4b2 Evan Quan             2020-04-21  5188  		 * is shared with AZ power domain. Without this,
3f12acc8d6d4b2 Evan Quan             2020-04-21  5189  		 * we may change the audio hardware from behind
3f12acc8d6d4b2 Evan Quan             2020-04-21  5190  		 * the audio driver's back. That will trigger
3f12acc8d6d4b2 Evan Quan             2020-04-21  5191  		 * some audio codec errors.
3f12acc8d6d4b2 Evan Quan             2020-04-21  5192  		 */
3f12acc8d6d4b2 Evan Quan             2020-04-21  5193  		if (!amdgpu_device_suspend_display_audio(tmp_adev))
3f12acc8d6d4b2 Evan Quan             2020-04-21  5194  			audio_suspended = true;
3f12acc8d6d4b2 Evan Quan             2020-04-21  5195  
9e94d22c008585 Evan Quan             2020-04-16  5196  		amdgpu_ras_set_error_query_ready(tmp_adev, false);
9e94d22c008585 Evan Quan             2020-04-16  5197  
52fb44cf30fc6b Evan Quan             2020-04-16  5198  		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
52fb44cf30fc6b Evan Quan             2020-04-16  5199  
428890a3fec131 shaoyunl              2021-11-29  5200  		if (!amdgpu_sriov_vf(tmp_adev))
9e94d22c008585 Evan Quan             2020-04-16  5201  			amdgpu_amdkfd_pre_reset(tmp_adev);
9e94d22c008585 Evan Quan             2020-04-16  5202  
fdafb3597a2cc4 Evan Quan             2019-06-26  5203  		/*
fdafb3597a2cc4 Evan Quan             2019-06-26  5204  		 * Mark these ASICs to be reseted as untracked first
fdafb3597a2cc4 Evan Quan             2019-06-26  5205  		 * And add them back after reset completed
fdafb3597a2cc4 Evan Quan             2019-06-26  5206  		 */
fdafb3597a2cc4 Evan Quan             2019-06-26  5207  		amdgpu_unregister_gpu_instance(tmp_adev);
fdafb3597a2cc4 Evan Quan             2019-06-26  5208  
087451f372bf76 Evan Quan             2021-10-19  5209  		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
565d1941557756 Evan Quan             2020-03-11  5210  
f1c1314be42971 xinhui pan            2019-07-04  5211  		/* disable ras on ALL IPs */
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5212  		if (!need_emergency_restart &&
b823821f2244ad Le Ma                 2019-11-27  5213  		      amdgpu_device_ip_need_full_reset(tmp_adev))
f1c1314be42971 xinhui pan            2019-07-04  5214  			amdgpu_ras_suspend(tmp_adev);
f1c1314be42971 xinhui pan            2019-07-04  5215  
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5216  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5217  			struct amdgpu_ring *ring = tmp_adev->rings[i];
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5218  
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5219  			if (!ring || !ring->sched.thread)
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5220  				continue;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5221  
0b2d2c2eecf27f Andrey Grodzovsky     2019-08-27  5222  			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5223  
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5224  			if (need_emergency_restart)
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5225  				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5226  		}
8f8c80f4300967 Jingwen Chen          2021-02-25  5227  		atomic_inc(&tmp_adev->gpu_reset_counter);
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5228  	}
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5229  
bb5c7235eaafb4 Wenhui Sheng          2020-07-13  5230  	if (need_emergency_restart)
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5231  		goto skip_sched_resume;
7c6e68c777f109 Andrey Grodzovsky     2019-09-13  5232  
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5233  	/*
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5234  	 * Must check guilty signal here since after this point all old
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5235  	 * HW fences are force signaled.
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5236  	 *
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5237  	 * job->base holds a reference to parent fence
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5238  	 */
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5239  	if (job && job->base.s_fence->parent &&
7dd8c205eaedfa Evan Quan             2020-04-16  5240  	    dma_fence_is_signaled(job->base.s_fence->parent)) {
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5241  		job_signaled = true;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5242  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5243  		goto skip_hw_reset;
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5244  	}
1d721ed679db18 Andrey Grodzovsky     2019-04-18  5245  

:::::: The code at line 5089 was first introduced by commit
:::::: 26bc534094ed45fdedef6b4ce8b96030340c5ce7 drm/amdgpu: Refactor GPU reset for XGMI hive case

:::::: TO: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
