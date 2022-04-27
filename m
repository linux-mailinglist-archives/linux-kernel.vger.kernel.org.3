Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD85112B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358966AbiD0Hns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358964AbiD0Hnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:43:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F62DD5A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651045233; x=1682581233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hF9c+FB7HgrRDp4F9gAZ9a9xTwJyUt294/W0ot0ltLw=;
  b=bzTbKOxDNgBT7WkOyUaAX2YvF4lOfGgL/ccbX52SU9J8xmHM3zlLRE2c
   /bJDEma95onNA/atP3WEW0gx5BrspAs2nqcoWDEF9aPmpQHNywe/jBxyJ
   MCFqBzeXyjYkSDCL5TOnr3LHelcW8S2FOxtq7M+FrEK7yPqSdZfBKvWHV
   6X+SRD+iILIG84qtsICysGSbOJBZDpmfKx8Fqan4ZfUWsOUwBMmDrJQQ9
   Sj81WgCKwXn7TZ8XUf+jJWcUlE+qLiBYzecJRUSuExqPaxGPfNR416+L6
   www99ARwXrFXIOgp2AJJaLyj+nOA3LX6gVEacnELQLxT2efyVFL3USlzZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="247779294"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="247779294"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="596155189"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2022 00:40:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njcHn-0004Ss-55;
        Wed, 27 Apr 2022 07:40:31 +0000
Date:   Wed, 27 Apr 2022 15:39:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Lin <tsung-hua.lin@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3629:18: error: 'struct
 amdgpu_pm' has no member named 'old_ac_power'; did you mean 'ac_power'?
Message-ID: <202204271505.yvdh6LlM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220427-100203/Ryan-Lin/UPSTREAM-drm-amdgpu-Disable-ABM-when-AC-mode/20220325-093104
head:   dcdafc6d9aece5228da7c4c31f54f37d35095caa
commit: dcdafc6d9aece5228da7c4c31f54f37d35095caa drm/amdgpu: Disable ABM when AC mode
date:   6 hours ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220427/202204271505.yvdh6LlM-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dcdafc6d9aece5228da7c4c31f54f37d35095caa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220427-100203/Ryan-Lin/UPSTREAM-drm-amdgpu-Disable-ABM-when-AC-mode/20220325-093104
        git checkout dcdafc6d9aece5228da7c4c31f54f37d35095caa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: In function 'amdgpu_device_init':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3629:18: error: 'struct amdgpu_pm' has no member named 'old_ac_power'; did you mean 'ac_power'?
    3629 |         adev->pm.old_ac_power = true;
         |                  ^~~~~~~~~~~~
         |                  ac_power
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:30:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:3049:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    3049 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c: In function 'dmub_abm_get_current_backlight':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:163:43: error: 'struct amdgpu_pm' has no member named 'old_ac_power'; did you mean 'ac_power'?
     163 |         if (adev->pm.ac_power != adev->pm.old_ac_power) {
         |                                           ^~~~~~~~~~~~
         |                                           ac_power
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:166:26: error: 'struct amdgpu_pm' has no member named 'old_ac_power'; did you mean 'ac_power'?
     166 |                 adev->pm.old_ac_power = adev->pm.ac_power;
         |                          ^~~~~~~~~~~~
         |                          ac_power
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm.c:32:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:129:22: warning: 'SYNAPTICS_DEVICE_ID' defined but not used [-Wunused-const-variable=]
     129 | static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
         |                      ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_SINK_DEVICE_STR_ID_2' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_SINK_DEVICE_STR_ID_1' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
         |                      ^~~~~~~~~~~~~~~~~~~~~~~


vim +3629 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

  3516	
  3517	/**
  3518	 * amdgpu_device_init - initialize the driver
  3519	 *
  3520	 * @adev: amdgpu_device pointer
  3521	 * @flags: driver flags
  3522	 *
  3523	 * Initializes the driver info and hw (all asics).
  3524	 * Returns 0 for success or an error on failure.
  3525	 * Called at driver startup.
  3526	 */
  3527	int amdgpu_device_init(struct amdgpu_device *adev,
  3528			       uint32_t flags)
  3529	{
  3530		struct drm_device *ddev = adev_to_drm(adev);
  3531		struct pci_dev *pdev = adev->pdev;
  3532		int r, i;
  3533		bool px = false;
  3534		u32 max_MBps;
  3535	
  3536		adev->shutdown = false;
  3537		adev->flags = flags;
  3538	
  3539		if (amdgpu_force_asic_type >= 0 && amdgpu_force_asic_type < CHIP_LAST)
  3540			adev->asic_type = amdgpu_force_asic_type;
  3541		else
  3542			adev->asic_type = flags & AMD_ASIC_MASK;
  3543	
  3544		adev->usec_timeout = AMDGPU_MAX_USEC_TIMEOUT;
  3545		if (amdgpu_emu_mode == 1)
  3546			adev->usec_timeout *= 10;
  3547		adev->gmc.gart_size = 512 * 1024 * 1024;
  3548		adev->accel_working = false;
  3549		adev->num_rings = 0;
  3550		adev->mman.buffer_funcs = NULL;
  3551		adev->mman.buffer_funcs_ring = NULL;
  3552		adev->vm_manager.vm_pte_funcs = NULL;
  3553		adev->vm_manager.vm_pte_num_scheds = 0;
  3554		adev->gmc.gmc_funcs = NULL;
  3555		adev->harvest_ip_mask = 0x0;
  3556		adev->fence_context = dma_fence_context_alloc(AMDGPU_MAX_RINGS);
  3557		bitmap_zero(adev->gfx.pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
  3558	
  3559		adev->smc_rreg = &amdgpu_invalid_rreg;
  3560		adev->smc_wreg = &amdgpu_invalid_wreg;
  3561		adev->pcie_rreg = &amdgpu_invalid_rreg;
  3562		adev->pcie_wreg = &amdgpu_invalid_wreg;
  3563		adev->pciep_rreg = &amdgpu_invalid_rreg;
  3564		adev->pciep_wreg = &amdgpu_invalid_wreg;
  3565		adev->pcie_rreg64 = &amdgpu_invalid_rreg64;
  3566		adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
  3567		adev->uvd_ctx_rreg = &amdgpu_invalid_rreg;
  3568		adev->uvd_ctx_wreg = &amdgpu_invalid_wreg;
  3569		adev->didt_rreg = &amdgpu_invalid_rreg;
  3570		adev->didt_wreg = &amdgpu_invalid_wreg;
  3571		adev->gc_cac_rreg = &amdgpu_invalid_rreg;
  3572		adev->gc_cac_wreg = &amdgpu_invalid_wreg;
  3573		adev->audio_endpt_rreg = &amdgpu_block_invalid_rreg;
  3574		adev->audio_endpt_wreg = &amdgpu_block_invalid_wreg;
  3575	
  3576		DRM_INFO("initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X).\n",
  3577			 amdgpu_asic_name[adev->asic_type], pdev->vendor, pdev->device,
  3578			 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
  3579	
  3580		/* mutex initialization are all done here so we
  3581		 * can recall function without having locking issues */
  3582		mutex_init(&adev->firmware.mutex);
  3583		mutex_init(&adev->pm.mutex);
  3584		mutex_init(&adev->gfx.gpu_clock_mutex);
  3585		mutex_init(&adev->srbm_mutex);
  3586		mutex_init(&adev->gfx.pipe_reserve_mutex);
  3587		mutex_init(&adev->gfx.gfx_off_mutex);
  3588		mutex_init(&adev->grbm_idx_mutex);
  3589		mutex_init(&adev->mn_lock);
  3590		mutex_init(&adev->virt.vf_errors.lock);
  3591		hash_init(adev->mn_hash);
  3592		mutex_init(&adev->psp.mutex);
  3593		mutex_init(&adev->notifier_lock);
  3594		mutex_init(&adev->pm.stable_pstate_ctx_lock);
  3595		mutex_init(&adev->benchmark_mutex);
  3596	
  3597		amdgpu_device_init_apu_flags(adev);
  3598	
  3599		r = amdgpu_device_check_arguments(adev);
  3600		if (r)
  3601			return r;
  3602	
  3603		spin_lock_init(&adev->mmio_idx_lock);
  3604		spin_lock_init(&adev->smc_idx_lock);
  3605		spin_lock_init(&adev->pcie_idx_lock);
  3606		spin_lock_init(&adev->uvd_ctx_idx_lock);
  3607		spin_lock_init(&adev->didt_idx_lock);
  3608		spin_lock_init(&adev->gc_cac_idx_lock);
  3609		spin_lock_init(&adev->se_cac_idx_lock);
  3610		spin_lock_init(&adev->audio_endpt_idx_lock);
  3611		spin_lock_init(&adev->mm_stats.lock);
  3612	
  3613		INIT_LIST_HEAD(&adev->shadow_list);
  3614		mutex_init(&adev->shadow_list_lock);
  3615	
  3616		INIT_LIST_HEAD(&adev->reset_list);
  3617	
  3618		INIT_LIST_HEAD(&adev->ras_list);
  3619	
  3620		INIT_DELAYED_WORK(&adev->delayed_init_work,
  3621				  amdgpu_device_delayed_init_work_handler);
  3622		INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
  3623				  amdgpu_device_delay_enable_gfx_off);
  3624	
  3625		INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
  3626	
  3627		adev->gfx.gfx_off_req_count = 1;
  3628		adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> 3629		adev->pm.old_ac_power = true;
  3630	
  3631		atomic_set(&adev->throttling_logging_enabled, 1);
  3632		/*
  3633		 * If throttling continues, logging will be performed every minute
  3634		 * to avoid log flooding. "-1" is subtracted since the thermal
  3635		 * throttling interrupt comes every second. Thus, the total logging
  3636		 * interval is 59 seconds(retelimited printk interval) + 1(waiting
  3637		 * for throttling interrupt) = 60 seconds.
  3638		 */
  3639		ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1);
  3640		ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON_RELEASE);
  3641	
  3642		/* Registers mapping */
  3643		/* TODO: block userspace mapping of io register */
  3644		if (adev->asic_type >= CHIP_BONAIRE) {
  3645			adev->rmmio_base = pci_resource_start(adev->pdev, 5);
  3646			adev->rmmio_size = pci_resource_len(adev->pdev, 5);
  3647		} else {
  3648			adev->rmmio_base = pci_resource_start(adev->pdev, 2);
  3649			adev->rmmio_size = pci_resource_len(adev->pdev, 2);
  3650		}
  3651	
  3652		for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
  3653			atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
  3654	
  3655		adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
  3656		if (adev->rmmio == NULL) {
  3657			return -ENOMEM;
  3658		}
  3659		DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
  3660		DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
  3661	
  3662		amdgpu_device_get_pcie_info(adev);
  3663	
  3664		if (amdgpu_mcbp)
  3665			DRM_INFO("MCBP is enabled\n");
  3666	
  3667		if (amdgpu_mes && adev->asic_type >= CHIP_NAVI10)
  3668			adev->enable_mes = true;
  3669	
  3670		/*
  3671		 * Reset domain needs to be present early, before XGMI hive discovered
  3672		 * (if any) and intitialized to use reset sem and in_gpu reset flag
  3673		 * early on during init and before calling to RREG32.
  3674		 */
  3675		adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
  3676		if (!adev->reset_domain)
  3677			return -ENOMEM;
  3678	
  3679		/* detect hw virtualization here */
  3680		amdgpu_detect_virtualization(adev);
  3681	
  3682		r = amdgpu_device_get_job_timeout_settings(adev);
  3683		if (r) {
  3684			dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
  3685			return r;
  3686		}
  3687	
  3688		/* early init functions */
  3689		r = amdgpu_device_ip_early_init(adev);
  3690		if (r)
  3691			return r;
  3692	
  3693		amdgpu_gmc_noretry_set(adev);
  3694		/* Need to get xgmi info early to decide the reset behavior*/
  3695		if (adev->gmc.xgmi.supported) {
  3696			r = adev->gfxhub.funcs->get_xgmi_info(adev);
  3697			if (r)
  3698				return r;
  3699		}
  3700	
  3701		/* enable PCIE atomic ops */
  3702		if (amdgpu_sriov_vf(adev))
  3703			adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
  3704				adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
  3705				(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
  3706		else
  3707			adev->have_atomics_support =
  3708				!pci_enable_atomic_ops_to_root(adev->pdev,
  3709						  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
  3710						  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
  3711		if (!adev->have_atomics_support)
  3712			dev_info(adev->dev, "PCIE atomic ops is not supported\n");
  3713	
  3714		/* doorbell bar mapping and doorbell index init*/
  3715		amdgpu_device_doorbell_init(adev);
  3716	
  3717		if (amdgpu_emu_mode == 1) {
  3718			/* post the asic on emulation mode */
  3719			emu_soc_asic_init(adev);
  3720			goto fence_driver_init;
  3721		}
  3722	
  3723		amdgpu_reset_init(adev);
  3724	
  3725		/* detect if we are with an SRIOV vbios */
  3726		amdgpu_device_detect_sriov_bios(adev);
  3727	
  3728		/* check if we need to reset the asic
  3729		 *  E.g., driver was not cleanly unloaded previously, etc.
  3730		 */
  3731		if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
  3732			if (adev->gmc.xgmi.num_physical_nodes) {
  3733				dev_info(adev->dev, "Pending hive reset.\n");
  3734				adev->gmc.xgmi.pending_reset = true;
  3735				/* Only need to init necessary block for SMU to handle the reset */
  3736				for (i = 0; i < adev->num_ip_blocks; i++) {
  3737					if (!adev->ip_blocks[i].status.valid)
  3738						continue;
  3739					if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
  3740					      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
  3741					      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
  3742					      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
  3743						DRM_DEBUG("IP %s disabled for hw_init.\n",
  3744							adev->ip_blocks[i].version->funcs->name);
  3745						adev->ip_blocks[i].status.hw = true;
  3746					}
  3747				}
  3748			} else {
  3749				r = amdgpu_asic_reset(adev);
  3750				if (r) {
  3751					dev_err(adev->dev, "asic reset on init failed\n");
  3752					goto failed;
  3753				}
  3754			}
  3755		}
  3756	
  3757		pci_enable_pcie_error_reporting(adev->pdev);
  3758	
  3759		/* Post card if necessary */
  3760		if (amdgpu_device_need_post(adev)) {
  3761			if (!adev->bios) {
  3762				dev_err(adev->dev, "no vBIOS found\n");
  3763				r = -EINVAL;
  3764				goto failed;
  3765			}
  3766			DRM_INFO("GPU posting now...\n");
  3767			r = amdgpu_device_asic_init(adev);
  3768			if (r) {
  3769				dev_err(adev->dev, "gpu post error!\n");
  3770				goto failed;
  3771			}
  3772		}
  3773	
  3774		if (adev->is_atom_fw) {
  3775			/* Initialize clocks */
  3776			r = amdgpu_atomfirmware_get_clock_info(adev);
  3777			if (r) {
  3778				dev_err(adev->dev, "amdgpu_atomfirmware_get_clock_info failed\n");
  3779				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
  3780				goto failed;
  3781			}
  3782		} else {
  3783			/* Initialize clocks */
  3784			r = amdgpu_atombios_get_clock_info(adev);
  3785			if (r) {
  3786				dev_err(adev->dev, "amdgpu_atombios_get_clock_info failed\n");
  3787				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_GET_CLOCK_FAIL, 0, 0);
  3788				goto failed;
  3789			}
  3790			/* init i2c buses */
  3791			if (!amdgpu_device_has_dc_support(adev))
  3792				amdgpu_atombios_i2c_init(adev);
  3793		}
  3794	
  3795	fence_driver_init:
  3796		/* Fence driver */
  3797		r = amdgpu_fence_driver_sw_init(adev);
  3798		if (r) {
  3799			dev_err(adev->dev, "amdgpu_fence_driver_sw_init failed\n");
  3800			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_FENCE_INIT_FAIL, 0, 0);
  3801			goto failed;
  3802		}
  3803	
  3804		/* init the mode config */
  3805		drm_mode_config_init(adev_to_drm(adev));
  3806	
  3807		r = amdgpu_device_ip_init(adev);
  3808		if (r) {
  3809			/* failed in exclusive mode due to timeout */
  3810			if (amdgpu_sriov_vf(adev) &&
  3811			    !amdgpu_sriov_runtime(adev) &&
  3812			    amdgpu_virt_mmio_blocked(adev) &&
  3813			    !amdgpu_virt_wait_reset(adev)) {
  3814				dev_err(adev->dev, "VF exclusive mode timeout\n");
  3815				/* Don't send request since VF is inactive. */
  3816				adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
  3817				adev->virt.ops = NULL;
  3818				r = -EAGAIN;
  3819				goto release_ras_con;
  3820			}
  3821			dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
  3822			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
  3823			goto release_ras_con;
  3824		}
  3825	
  3826		amdgpu_fence_driver_hw_init(adev);
  3827	
  3828		dev_info(adev->dev,
  3829			"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
  3830				adev->gfx.config.max_shader_engines,
  3831				adev->gfx.config.max_sh_per_se,
  3832				adev->gfx.config.max_cu_per_sh,
  3833				adev->gfx.cu_info.number);
  3834	
  3835		adev->accel_working = true;
  3836	
  3837		amdgpu_vm_check_compute_bug(adev);
  3838	
  3839		/* Initialize the buffer migration limit. */
  3840		if (amdgpu_moverate >= 0)
  3841			max_MBps = amdgpu_moverate;
  3842		else
  3843			max_MBps = 8; /* Allow 8 MB/s. */
  3844		/* Get a log2 for easy divisions. */
  3845		adev->mm_stats.log2_max_MBps = ilog2(max(1u, max_MBps));
  3846	
  3847		r = amdgpu_pm_sysfs_init(adev);
  3848		if (r) {
  3849			adev->pm_sysfs_en = false;
  3850			DRM_ERROR("registering pm debugfs failed (%d).\n", r);
  3851		} else
  3852			adev->pm_sysfs_en = true;
  3853	
  3854		r = amdgpu_ucode_sysfs_init(adev);
  3855		if (r) {
  3856			adev->ucode_sysfs_en = false;
  3857			DRM_ERROR("Creating firmware sysfs failed (%d).\n", r);
  3858		} else
  3859			adev->ucode_sysfs_en = true;
  3860	
  3861		/*
  3862		 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
  3863		 * Otherwise the mgpu fan boost feature will be skipped due to the
  3864		 * gpu instance is counted less.
  3865		 */
  3866		amdgpu_register_gpu_instance(adev);
  3867	
  3868		/* enable clockgating, etc. after ib tests, etc. since some blocks require
  3869		 * explicit gating rather than handling it automatically.
  3870		 */
  3871		if (!adev->gmc.xgmi.pending_reset) {
  3872			r = amdgpu_device_ip_late_init(adev);
  3873			if (r) {
  3874				dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
  3875				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
  3876				goto release_ras_con;
  3877			}
  3878			/* must succeed. */
  3879			amdgpu_ras_resume(adev);
  3880			queue_delayed_work(system_wq, &adev->delayed_init_work,
  3881					   msecs_to_jiffies(AMDGPU_RESUME_MS));
  3882		}
  3883	
  3884		if (amdgpu_sriov_vf(adev))
  3885			flush_delayed_work(&adev->delayed_init_work);
  3886	
  3887		r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
  3888		if (r)
  3889			dev_err(adev->dev, "Could not create amdgpu device attr\n");
  3890	
  3891		if (IS_ENABLED(CONFIG_PERF_EVENTS))
  3892			r = amdgpu_pmu_init(adev);
  3893		if (r)
  3894			dev_err(adev->dev, "amdgpu_pmu_init failed\n");
  3895	
  3896		/* Have stored pci confspace at hand for restore in sudden PCI error */
  3897		if (amdgpu_device_cache_pci_state(adev->pdev))
  3898			pci_restore_state(pdev);
  3899	
  3900		/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
  3901		/* this will fail for cards that aren't VGA class devices, just
  3902		 * ignore it */
  3903		if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
  3904			vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
  3905	
  3906		if (amdgpu_device_supports_px(ddev)) {
  3907			px = true;
  3908			vga_switcheroo_register_client(adev->pdev,
  3909						       &amdgpu_switcheroo_ops, px);
  3910			vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
  3911		}
  3912	
  3913		if (adev->gmc.xgmi.pending_reset)
  3914			queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
  3915					   msecs_to_jiffies(AMDGPU_RESUME_MS));
  3916	
  3917		amdgpu_device_check_iommu_direct_map(adev);
  3918	
  3919		return 0;
  3920	
  3921	release_ras_con:
  3922		amdgpu_release_ras_context(adev);
  3923	
  3924	failed:
  3925		amdgpu_vf_error_trans_all(adev);
  3926	
  3927		return r;
  3928	}
  3929	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
