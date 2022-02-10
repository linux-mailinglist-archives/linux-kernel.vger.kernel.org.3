Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F754B020B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiBJBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:24:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiBJBYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:24:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA1FCE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456284; x=1675992284;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EvZiGcfPvMM6suTQWbMkqIJVhBa8h6gBD4AG2/Vm1nI=;
  b=aZ4edA0KjUjacg7L4m/kQTyqOG8RWK3ouQt67YtlsmDf6XT5avWxgYox
   YHJvDOn/BVGwS6Tlty9J+JOHuPp7LEcrn4lKJFkZRHSnydgF2EHbULUOX
   r44APDzmbjU76/muQuu/ssMywbpbwZOyg3jmqkNIHcOxuF2WGVQcux/X4
   jbhpw5n3LwS2/txUsKUjJZcJyl/WKyRaPzVNGspzjALO7GeBjwgBqfLrU
   OIRPXx0kFnhnsZQB2HTh3SAiQBqfeEbzQCbg6ySLIV5YFqQ3I4qa9pyCd
   sEmncE+39zFNp6RxzfLAo2BWkvWKzmW+otusi8m1LIdeZq89QtvnPVVTo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248206589"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="248206589"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="678961615"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 16:21:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHxD2-0002SA-IL; Thu, 10 Feb 2022 00:21:16 +0000
Date:   Thu, 10 Feb 2022 08:20:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: [drm-misc:drm-misc-next 11/11]
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5056:56: error: too few arguments
 to function call, expected 2, have 1
Message-ID: <202202100829.6oxshKjq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   3675c2f26f33ab4928859fb8950a4697a16be5c9
commit: 3675c2f26f33ab4928859fb8950a4697a16be5c9 [11/11] drm/amdgpu: Revert 'drm/amdgpu: annotate a false positive recursive locking'
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220210/202202100829.6oxshKjq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e8bff9ae54a55b4dbfeb6ba55f723abbd81bf494)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc drm-misc-next
        git checkout 3675c2f26f33ab4928859fb8950a4697a16be5c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1210:18: warning: result of comparison of constant 4294967296 with expression of type 'resource_size_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
                       res->start > 0x100000000ull)
                       ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5056:56: error: too few arguments to function call, expected 2, have 1
           amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                       ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_reset.h:121:6: note: 'amdgpu_device_lock_reset_domain' declared here
   void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain,
        ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5480:53: error: too few arguments to function call, expected 2, have 1
                   amdgpu_device_lock_reset_domain(adev->reset_domain);
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                   ^
   drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_reset.h:121:6: note: 'amdgpu_device_lock_reset_domain' declared here
   void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain,
        ^
   1 warning and 2 errors generated.


vim +5056 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

  4979	
  4980	/**
  4981	 * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  4982	 *
  4983	 * @adev: amdgpu_device pointer
  4984	 * @job: which job trigger hang
  4985	 *
  4986	 * Attempt to reset the GPU if it has hung (all asics).
  4987	 * Attempt to do soft-reset or full-reset and reinitialize Asic
  4988	 * Returns 0 for success or an error on failure.
  4989	 */
  4990	
  4991	int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
  4992				      struct amdgpu_job *job)
  4993	{
  4994		struct list_head device_list, *device_list_handle =  NULL;
  4995		bool job_signaled = false;
  4996		struct amdgpu_hive_info *hive = NULL;
  4997		struct amdgpu_device *tmp_adev = NULL;
  4998		int i, r = 0;
  4999		bool need_emergency_restart = false;
  5000		bool audio_suspended = false;
  5001		int tmp_vram_lost_counter;
  5002		struct amdgpu_reset_context reset_context;
  5003	
  5004		memset(&reset_context, 0, sizeof(reset_context));
  5005	
  5006		/*
  5007		 * Special case: RAS triggered and full reset isn't supported
  5008		 */
  5009		need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
  5010	
  5011		/*
  5012		 * Flush RAM to disk so that after reboot
  5013		 * the user can read log and see why the system rebooted.
  5014		 */
  5015		if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
  5016			DRM_WARN("Emergency reboot.");
  5017	
  5018			ksys_sync_helper();
  5019			emergency_restart();
  5020		}
  5021	
  5022		dev_info(adev->dev, "GPU %s begin!\n",
  5023			need_emergency_restart ? "jobs stop":"reset");
  5024	
  5025		if (!amdgpu_sriov_vf(adev))
  5026			hive = amdgpu_get_xgmi_hive(adev);
  5027		if (hive)
  5028			mutex_lock(&hive->hive_lock);
  5029	
  5030		reset_context.method = AMD_RESET_METHOD_NONE;
  5031		reset_context.reset_req_dev = adev;
  5032		reset_context.job = job;
  5033		reset_context.hive = hive;
  5034		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
  5035	
  5036		/*
  5037		 * Build list of devices to reset.
  5038		 * In case we are in XGMI hive mode, resort the device list
  5039		 * to put adev in the 1st position.
  5040		 */
  5041		INIT_LIST_HEAD(&device_list);
  5042		if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
  5043			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
  5044				list_add_tail(&tmp_adev->reset_list, &device_list);
  5045			if (!list_is_first(&adev->reset_list, &device_list))
  5046				list_rotate_to_front(&adev->reset_list, &device_list);
  5047			device_list_handle = &device_list;
  5048		} else {
  5049			list_add_tail(&adev->reset_list, &device_list);
  5050			device_list_handle = &device_list;
  5051		}
  5052	
  5053		/* We need to lock reset domain only once both for XGMI and single device */
  5054		tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
  5055					    reset_list);
> 5056		amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
  5057	
  5058		/* block all schedulers and reset given job's ring */
  5059		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
  5060	
  5061			amdgpu_device_set_mp1_state(tmp_adev);
  5062	
  5063			/*
  5064			 * Try to put the audio codec into suspend state
  5065			 * before gpu reset started.
  5066			 *
  5067			 * Due to the power domain of the graphics device
  5068			 * is shared with AZ power domain. Without this,
  5069			 * we may change the audio hardware from behind
  5070			 * the audio driver's back. That will trigger
  5071			 * some audio codec errors.
  5072			 */
  5073			if (!amdgpu_device_suspend_display_audio(tmp_adev))
  5074				audio_suspended = true;
  5075	
  5076			amdgpu_ras_set_error_query_ready(tmp_adev, false);
  5077	
  5078			cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
  5079	
  5080			if (!amdgpu_sriov_vf(tmp_adev))
  5081				amdgpu_amdkfd_pre_reset(tmp_adev);
  5082	
  5083			/*
  5084			 * Mark these ASICs to be reseted as untracked first
  5085			 * And add them back after reset completed
  5086			 */
  5087			amdgpu_unregister_gpu_instance(tmp_adev);
  5088	
  5089			drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
  5090	
  5091			/* disable ras on ALL IPs */
  5092			if (!need_emergency_restart &&
  5093			      amdgpu_device_ip_need_full_reset(tmp_adev))
  5094				amdgpu_ras_suspend(tmp_adev);
  5095	
  5096			for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
  5097				struct amdgpu_ring *ring = tmp_adev->rings[i];
  5098	
  5099				if (!ring || !ring->sched.thread)
  5100					continue;
  5101	
  5102				drm_sched_stop(&ring->sched, job ? &job->base : NULL);
  5103	
  5104				if (need_emergency_restart)
  5105					amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
  5106			}
  5107			atomic_inc(&tmp_adev->gpu_reset_counter);
  5108		}
  5109	
  5110		if (need_emergency_restart)
  5111			goto skip_sched_resume;
  5112	
  5113		/*
  5114		 * Must check guilty signal here since after this point all old
  5115		 * HW fences are force signaled.
  5116		 *
  5117		 * job->base holds a reference to parent fence
  5118		 */
  5119		if (job && job->base.s_fence->parent &&
  5120		    dma_fence_is_signaled(job->base.s_fence->parent)) {
  5121			job_signaled = true;
  5122			dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
  5123			goto skip_hw_reset;
  5124		}
  5125	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
