Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725514B0629
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiBJGRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:17:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbiBJGRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:17:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84525258
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644473850; x=1676009850;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q1KVmeG6TbPU2vWjSqOOcESZajdi5ewDLSnF2RlyYiI=;
  b=S1rnfKJH4YlhmRF2ZtfJcTJ7AbUufCHC6TW83J5a8Kuv9L1NC8nenSfd
   mDsDaB8TFkT1iAIL6NOzj2TmT8XxCyzwWdXPLcSq85sWl34AnAALmsHOw
   pmB0oFtDJq7z+6O9BnL/JPN0hC0ve2hFw6JDds/UtkTtp+/FJhhix9SAw
   wjMvleuvOdzljqmF0hsJ9JadtG9BAVJgHd3h/vYbaXqEYbNOQfHonVzhb
   ZE69akJIe5EORBZSP+xZbCOV33Xdxm5E57vZXX+v2/mW4H7PowvZOOpJp
   kASbtiYLIPDaYOpedMBB/E32BGex6d4b22/3GLQsJ/d777C3GL1d0jwAU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249366167"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="249366167"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 22:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="526347744"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2022 22:17:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI2lj-0002np-TA; Thu, 10 Feb 2022 06:17:27 +0000
Date:   Thu, 10 Feb 2022 14:16:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: [drm-misc:drm-misc-next 3/11] htmldocs:
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5038: warning: expecting
 prototype for amdgpu_device_gpu_recover(). Prototype was for
 amdgpu_device_gpu_recover_imp() instead
Message-ID: <202202101432.3hTskTpX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
head:   3675c2f26f33ab4928859fb8950a4697a16be5c9
commit: 54f329cc7a7a7ea265c45b206d45e3d09192aba7 [3/11] drm/amdgpu: Serialize non TDR gpu recovery with TDRs
reproduce: make htmldocs

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5038: warning: expecting prototype for amdgpu_device_gpu_recover(). Prototype was for amdgpu_device_gpu_recover_imp() instead

vim +5038 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

e6c6338f393b74a Jack Zhang            2021-03-08  5024  
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5025  /**
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5026   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5027   *
982a820bac1b643 Mauro Carvalho Chehab 2020-10-21  5028   * @adev: amdgpu_device pointer
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5029   * @job: which job trigger hang
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5030   *
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5031   * Attempt to reset the GPU if it has hung (all asics).
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5032   * Attempt to do soft-reset or full-reset and reinitialize Asic
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5033   * Returns 0 for success or an error on failure.
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5034   */
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5035  
54f329cc7a7a7ea Andrey Grodzovsky     2021-12-17  5036  int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5037  			      struct amdgpu_job *job)
26bc534094ed45f Andrey Grodzovsky     2018-11-22 @5038  {
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5039  	struct list_head device_list, *device_list_handle =  NULL;
7dd8c205eaedfa3 Evan Quan             2020-04-16  5040  	bool job_signaled = false;
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5041  	struct amdgpu_hive_info *hive = NULL;
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5042  	struct amdgpu_device *tmp_adev = NULL;
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5043  	int i, r = 0;
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5044  	bool need_emergency_restart = false;
3f12acc8d6d4b2e Evan Quan             2020-04-21  5045  	bool audio_suspended = false;
e6c6338f393b74a Jack Zhang            2021-03-08  5046  	int tmp_vram_lost_counter;
04442bf70debb19 Lijo Lazar            2021-03-16  5047  	struct amdgpu_reset_context reset_context;
04442bf70debb19 Lijo Lazar            2021-03-16  5048  
04442bf70debb19 Lijo Lazar            2021-03-16  5049  	memset(&reset_context, 0, sizeof(reset_context));
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5050  
6e3cd2a9a6ac322 Mauro Carvalho Chehab 2020-10-23  5051  	/*
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5052  	 * Special case: RAS triggered and full reset isn't supported
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5053  	 */
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5054  	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5055  
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5056  	/*
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5057  	 * Flush RAM to disk so that after reboot
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5058  	 * the user can read log and see why the system rebooted.
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5059  	 */
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5060  	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5061  		DRM_WARN("Emergency reboot.");
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5062  
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5063  		ksys_sync_helper();
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5064  		emergency_restart();
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5065  	}
d5ea093eebf022e Andrey Grodzovsky     2019-08-22  5066  
b823821f2244add Le Ma                 2019-11-27  5067  	dev_info(adev->dev, "GPU %s begin!\n",
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5068  		need_emergency_restart ? "jobs stop":"reset");
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5069  
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5070  	/*
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5071  	 * Here we trylock to avoid chain of resets executing from
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5072  	 * either trigger by jobs on different adevs in XGMI hive or jobs on
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5073  	 * different schedulers for same device while this TO handler is running.
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5074  	 * We always reset all schedulers for device and all devices for XGMI
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5075  	 * hive so that should take care of them too.
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5076  	 */
175ac6ec6bd8db6 Zhigang Luo           2021-11-26  5077  	if (!amdgpu_sriov_vf(adev))
d95e8e97e2d522b Dennis Li             2020-08-18  5078  		hive = amdgpu_get_xgmi_hive(adev);
53b3f8f40e6cff3 Dennis Li             2020-08-19  5079  	if (hive) {
53b3f8f40e6cff3 Dennis Li             2020-08-19  5080  		if (atomic_cmpxchg(&hive->in_reset, 0, 1) != 0) {
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5081  			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
0b2d2c2eecf27f4 Andrey Grodzovsky     2019-08-27  5082  				job ? job->base.id : -1, hive->hive_id);
d95e8e97e2d522b Dennis Li             2020-08-18  5083  			amdgpu_put_xgmi_hive(hive);
ff99849b00fef59 Jingwen Chen          2021-07-20  5084  			if (job && job->vm)
91fb309d8294be5 Horace Chen           2021-01-20  5085  				drm_sched_increase_karma(&job->base);
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5086  			return 0;
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5087  		}
53b3f8f40e6cff3 Dennis Li             2020-08-19  5088  		mutex_lock(&hive->hive_lock);
53b3f8f40e6cff3 Dennis Li             2020-08-19  5089  	}
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5090  
04442bf70debb19 Lijo Lazar            2021-03-16  5091  	reset_context.method = AMD_RESET_METHOD_NONE;
04442bf70debb19 Lijo Lazar            2021-03-16  5092  	reset_context.reset_req_dev = adev;
04442bf70debb19 Lijo Lazar            2021-03-16  5093  	reset_context.job = job;
04442bf70debb19 Lijo Lazar            2021-03-16  5094  	reset_context.hive = hive;
04442bf70debb19 Lijo Lazar            2021-03-16  5095  	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
04442bf70debb19 Lijo Lazar            2021-03-16  5096  
91fb309d8294be5 Horace Chen           2021-01-20  5097  	/*
91fb309d8294be5 Horace Chen           2021-01-20  5098  	 * lock the device before we try to operate the linked list
91fb309d8294be5 Horace Chen           2021-01-20  5099  	 * if didn't get the device lock, don't touch the linked list since
91fb309d8294be5 Horace Chen           2021-01-20  5100  	 * others may iterating it.
91fb309d8294be5 Horace Chen           2021-01-20  5101  	 */
91fb309d8294be5 Horace Chen           2021-01-20  5102  	r = amdgpu_device_lock_hive_adev(adev, hive);
91fb309d8294be5 Horace Chen           2021-01-20  5103  	if (r) {
91fb309d8294be5 Horace Chen           2021-01-20  5104  		dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
91fb309d8294be5 Horace Chen           2021-01-20  5105  					job ? job->base.id : -1);
91fb309d8294be5 Horace Chen           2021-01-20  5106  
91fb309d8294be5 Horace Chen           2021-01-20  5107  		/* even we skipped this reset, still need to set the job to guilty */
ff99849b00fef59 Jingwen Chen          2021-07-20  5108  		if (job && job->vm)
91fb309d8294be5 Horace Chen           2021-01-20  5109  			drm_sched_increase_karma(&job->base);
91fb309d8294be5 Horace Chen           2021-01-20  5110  		goto skip_recovery;
91fb309d8294be5 Horace Chen           2021-01-20  5111  	}
91fb309d8294be5 Horace Chen           2021-01-20  5112  
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5113  	/*
9e94d22c0085858 Evan Quan             2020-04-16  5114  	 * Build list of devices to reset.
9e94d22c0085858 Evan Quan             2020-04-16  5115  	 * In case we are in XGMI hive mode, resort the device list
9e94d22c0085858 Evan Quan             2020-04-16  5116  	 * to put adev in the 1st position.
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5117  	 */
9e94d22c0085858 Evan Quan             2020-04-16  5118  	INIT_LIST_HEAD(&device_list);
175ac6ec6bd8db6 Zhigang Luo           2021-11-26  5119  	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
655ce9cb13b5967 shaoyunl              2021-03-04  5120  		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
655ce9cb13b5967 shaoyunl              2021-03-04  5121  			list_add_tail(&tmp_adev->reset_list, &device_list);
655ce9cb13b5967 shaoyunl              2021-03-04  5122  		if (!list_is_first(&adev->reset_list, &device_list))
655ce9cb13b5967 shaoyunl              2021-03-04  5123  			list_rotate_to_front(&adev->reset_list, &device_list);
655ce9cb13b5967 shaoyunl              2021-03-04  5124  		device_list_handle = &device_list;
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5125  	} else {
655ce9cb13b5967 shaoyunl              2021-03-04  5126  		list_add_tail(&adev->reset_list, &device_list);
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5127  		device_list_handle = &device_list;
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5128  	}
26bc534094ed45f Andrey Grodzovsky     2018-11-22  5129  
12ffa55da60f835 Andrey Grodzovsky     2019-08-30  5130  	/* block all schedulers and reset given job's ring */
655ce9cb13b5967 shaoyunl              2021-03-04  5131  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
3f12acc8d6d4b2e Evan Quan             2020-04-21  5132  		/*
3f12acc8d6d4b2e Evan Quan             2020-04-21  5133  		 * Try to put the audio codec into suspend state
3f12acc8d6d4b2e Evan Quan             2020-04-21  5134  		 * before gpu reset started.
3f12acc8d6d4b2e Evan Quan             2020-04-21  5135  		 *
3f12acc8d6d4b2e Evan Quan             2020-04-21  5136  		 * Due to the power domain of the graphics device
3f12acc8d6d4b2e Evan Quan             2020-04-21  5137  		 * is shared with AZ power domain. Without this,
3f12acc8d6d4b2e Evan Quan             2020-04-21  5138  		 * we may change the audio hardware from behind
3f12acc8d6d4b2e Evan Quan             2020-04-21  5139  		 * the audio driver's back. That will trigger
3f12acc8d6d4b2e Evan Quan             2020-04-21  5140  		 * some audio codec errors.
3f12acc8d6d4b2e Evan Quan             2020-04-21  5141  		 */
3f12acc8d6d4b2e Evan Quan             2020-04-21  5142  		if (!amdgpu_device_suspend_display_audio(tmp_adev))
3f12acc8d6d4b2e Evan Quan             2020-04-21  5143  			audio_suspended = true;
3f12acc8d6d4b2e Evan Quan             2020-04-21  5144  
9e94d22c0085858 Evan Quan             2020-04-16  5145  		amdgpu_ras_set_error_query_ready(tmp_adev, false);
9e94d22c0085858 Evan Quan             2020-04-16  5146  
52fb44cf30fc6b1 Evan Quan             2020-04-16  5147  		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
52fb44cf30fc6b1 Evan Quan             2020-04-16  5148  
428890a3fec1315 shaoyunl              2021-11-29  5149  		if (!amdgpu_sriov_vf(tmp_adev))
9e94d22c0085858 Evan Quan             2020-04-16  5150  			amdgpu_amdkfd_pre_reset(tmp_adev);
9e94d22c0085858 Evan Quan             2020-04-16  5151  
fdafb3597a2cc46 Evan Quan             2019-06-26  5152  		/*
fdafb3597a2cc46 Evan Quan             2019-06-26  5153  		 * Mark these ASICs to be reseted as untracked first
fdafb3597a2cc46 Evan Quan             2019-06-26  5154  		 * And add them back after reset completed
fdafb3597a2cc46 Evan Quan             2019-06-26  5155  		 */
fdafb3597a2cc46 Evan Quan             2019-06-26  5156  		amdgpu_unregister_gpu_instance(tmp_adev);
fdafb3597a2cc46 Evan Quan             2019-06-26  5157  
087451f372bf76d Evan Quan             2021-10-19  5158  		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
565d1941557756a Evan Quan             2020-03-11  5159  
f1c1314be429718 xinhui pan            2019-07-04  5160  		/* disable ras on ALL IPs */
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5161  		if (!need_emergency_restart &&
b823821f2244add Le Ma                 2019-11-27  5162  		      amdgpu_device_ip_need_full_reset(tmp_adev))
f1c1314be429718 xinhui pan            2019-07-04  5163  			amdgpu_ras_suspend(tmp_adev);
f1c1314be429718 xinhui pan            2019-07-04  5164  
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5165  		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5166  			struct amdgpu_ring *ring = tmp_adev->rings[i];
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5167  
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5168  			if (!ring || !ring->sched.thread)
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5169  				continue;
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5170  
0b2d2c2eecf27f4 Andrey Grodzovsky     2019-08-27  5171  			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
7c6e68c777f1094 Andrey Grodzovsky     2019-09-13  5172  
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5173  			if (need_emergency_restart)
7c6e68c777f1094 Andrey Grodzovsky     2019-09-13  5174  				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5175  		}
8f8c80f43009672 Jingwen Chen          2021-02-25  5176  		atomic_inc(&tmp_adev->gpu_reset_counter);
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5177  	}
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5178  
bb5c7235eaafb4e Wenhui Sheng          2020-07-13  5179  	if (need_emergency_restart)
7c6e68c777f1094 Andrey Grodzovsky     2019-09-13  5180  		goto skip_sched_resume;
7c6e68c777f1094 Andrey Grodzovsky     2019-09-13  5181  
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5182  	/*
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5183  	 * Must check guilty signal here since after this point all old
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5184  	 * HW fences are force signaled.
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5185  	 *
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5186  	 * job->base holds a reference to parent fence
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5187  	 */
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5188  	if (job && job->base.s_fence->parent &&
7dd8c205eaedfa3 Evan Quan             2020-04-16  5189  	    dma_fence_is_signaled(job->base.s_fence->parent)) {
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5190  		job_signaled = true;
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5191  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5192  		goto skip_hw_reset;
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5193  	}
1d721ed679db188 Andrey Grodzovsky     2019-04-18  5194  

:::::: The code at line 5038 was first introduced by commit
:::::: 26bc534094ed45fdedef6b4ce8b96030340c5ce7 drm/amdgpu: Refactor GPU reset for XGMI hive case

:::::: TO: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
