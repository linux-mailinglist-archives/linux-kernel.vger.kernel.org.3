Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74D523185
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbiEKL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241406AbiEKLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:25:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F3F235C2E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652268298; x=1683804298;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0mBxdYYhd/ynDopbSkM/840fXVGCFQrMoEdfUTAyB3M=;
  b=b7JwQq9dSeWR6oWw9U5jHN0ndWnP91DQVFIrHbjyAT4mLNuNoS+cADv5
   qlB2kjMoGiAySOsdEmxONq918C6hafCo/5YpUCbv5jxHEPFrA3Rk3+lZC
   B7E3n+h1S+pnBmLONwcWtBIlaWxqf1tqvUvF0cp464CHDV5h2llxsWjkO
   uURDfbPoIDu1Fu1c20pcVlFzUO2KbjD0+pfiiLlsstde9vr++W6eR30M5
   1VZhrWD2VJq6gurZSAEqnhkJVpOzOs3Dl1I9Q1Dw4MXr0yExWtuw16foz
   LTQK0+0PxaqLK8gU6zXHJ3Xyyas10QCDHiSlyDDVrQ1xvZSN9m2AChU9h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="356093662"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="356093662"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 04:24:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="636377532"
Received: from mstribae-mobl1.ger.corp.intel.com (HELO [10.249.254.135]) ([10.249.254.135])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 04:24:55 -0700
Message-ID: <ac755766559a3f1bdfefa7a34751dbe8ce3a80cc.camel@linux.intel.com>
Subject: Re: [PATCH 2/4] drm/i915: setup ggtt scratch page after memory
 regions
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matthew Auld <matthew.auld@intel.com>, linux-kernel@vger.kernel.org
Date:   Wed, 11 May 2022 13:24:53 +0200
In-Reply-To: <20220503191316.1145124-3-bob.beckett@collabora.com>
References: <20220503191316.1145124-1-bob.beckett@collabora.com>
         <20220503191316.1145124-3-bob.beckett@collabora.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 19:13 +0000, Robert Beckett wrote:
> reorder scratch page allocation so that memory regions are available

Nit: s/reorder/Reorder/

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

> to allocate the buffers
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_gt_gmch.c | 20 ++++++++++++++++++--
>  drivers/gpu/drm/i915/gt/intel_gt_gmch.h |  6 ++++++
>  drivers/gpu/drm/i915/i915_driver.c      | 16 ++++++++++------
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_gmch.c
> b/drivers/gpu/drm/i915/gt/intel_gt_gmch.c
> index 18e488672d1b..5411df1734ac 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_gmch.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_gmch.c
> @@ -440,8 +440,6 @@ static int ggtt_probe_common(struct i915_ggtt
> *ggtt, u64 size)
>         struct drm_i915_private *i915 = ggtt->vm.i915;
>         struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
>         phys_addr_t phys_addr;
> -       u32 pte_flags;
> -       int ret;
>  
>         GEM_WARN_ON(pci_resource_len(pdev, 0) !=
> gen6_gttmmadr_size(i915));
>         phys_addr = pci_resource_start(pdev, 0) +
> gen6_gttadr_offset(i915);
> @@ -463,6 +461,24 @@ static int ggtt_probe_common(struct i915_ggtt
> *ggtt, u64 size)
>         }
>  
>         kref_init(&ggtt->vm.resv_ref);
> +
> +       return 0;
> +}
> +
> +/**
> + * i915_ggtt_setup_scratch_page - setup ggtt scratch page
> + * @i915: i915 device
> + */
> +int i915_ggtt_setup_scratch_page(struct drm_i915_private *i915)
> +{
> +       struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
> +       u32 pte_flags;
> +       int ret;
> +
> +       /* gen5- scratch setup currently happens in @intel_gtt_init
> */
> +       if (GRAPHICS_VER(i915) <= 5)
> +               return 0;
> +
>         ret = setup_scratch_page(&ggtt->vm);
>         if (ret) {
>                 drm_err(&i915->drm, "Scratch setup failed\n");
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_gmch.h
> b/drivers/gpu/drm/i915/gt/intel_gt_gmch.h
> index 75ed55c1f30a..c6b79cb78637 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_gmch.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_gmch.h
> @@ -15,6 +15,7 @@ int intel_gt_gmch_gen6_probe(struct i915_ggtt
> *ggtt);
>  int intel_gt_gmch_gen8_probe(struct i915_ggtt *ggtt);
>  int intel_gt_gmch_gen5_probe(struct i915_ggtt *ggtt);
>  int intel_gt_gmch_gen5_enable_hw(struct drm_i915_private *i915);
> +int i915_ggtt_setup_scratch_page(struct drm_i915_private *i915);
>  
>  /* Stubs for non-x86 platforms */
>  #else
> @@ -41,6 +42,11 @@ static inline int
> intel_gt_gmch_gen5_enable_hw(struct drm_i915_private *i915)
>         /* No HW should be enabled for this case yet, return fail */
>         return -ENODEV;
>  }
> +
> +static inline int i915_ggtt_setup_scratch_page(struct
> drm_i915_private *i915)
> +{
> +       return 0;
> +}
>  #endif
>  
>  #endif /* __INTEL_GT_GMCH_H__ */
> diff --git a/drivers/gpu/drm/i915/i915_driver.c
> b/drivers/gpu/drm/i915/i915_driver.c
> index 90b0ce5051af..f67476b2f349 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -69,6 +69,7 @@
>  #include "gem/i915_gem_mman.h"
>  #include "gem/i915_gem_pm.h"
>  #include "gt/intel_gt.h"
> +#include "gt/intel_gt_gmch.h"
>  #include "gt/intel_gt_pm.h"
>  #include "gt/intel_rc6.h"
>  
> @@ -589,12 +590,16 @@ static int i915_driver_hw_probe(struct
> drm_i915_private *dev_priv)
>  
>         ret = intel_gt_tiles_init(dev_priv);
>         if (ret)
> -               goto err_mem_regions;
> +               goto err_ggtt;
> +
> +       ret = i915_ggtt_setup_scratch_page(dev_priv);
> +       if (ret)
> +               goto err_ggtt;
>  
>         ret = i915_ggtt_enable_hw(dev_priv);
>         if (ret) {
>                 drm_err(&dev_priv->drm, "failed to enable GGTT\n");
> -               goto err_mem_regions;
> +               goto err_ggtt;
>         }
>  
>         pci_set_master(pdev);
> @@ -646,11 +651,10 @@ static int i915_driver_hw_probe(struct
> drm_i915_private *dev_priv)
>  err_msi:
>         if (pdev->msi_enabled)
>                 pci_disable_msi(pdev);
> -err_mem_regions:
> -       intel_memory_regions_driver_release(dev_priv);
>  err_ggtt:
>         i915_ggtt_driver_release(dev_priv);
>         i915_gem_drain_freed_objects(dev_priv);
> +       intel_memory_regions_driver_release(dev_priv);
>         i915_ggtt_driver_late_release(dev_priv);
>  err_perf:
>         i915_perf_fini(dev_priv);
> @@ -896,9 +900,9 @@ int i915_driver_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>         intel_modeset_driver_remove_nogem(i915);
>  out_cleanup_hw:
>         i915_driver_hw_remove(i915);
> -       intel_memory_regions_driver_release(i915);
>         i915_ggtt_driver_release(i915);
>         i915_gem_drain_freed_objects(i915);
> +       intel_memory_regions_driver_release(i915);
>         i915_ggtt_driver_late_release(i915);
>  out_cleanup_mmio:
>         i915_driver_mmio_release(i915);
> @@ -955,9 +959,9 @@ static void i915_driver_release(struct drm_device
> *dev)
>  
>         i915_gem_driver_release(dev_priv);
>  
> -       intel_memory_regions_driver_release(dev_priv);
>         i915_ggtt_driver_release(dev_priv);
>         i915_gem_drain_freed_objects(dev_priv);
> +       intel_memory_regions_driver_release(dev_priv);
>         i915_ggtt_driver_late_release(dev_priv);
>  
>         i915_driver_mmio_release(dev_priv);


