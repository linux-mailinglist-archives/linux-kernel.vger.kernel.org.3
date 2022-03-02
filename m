Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7504B4CA64D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbiCBNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiCBNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:50:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA446EB0C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:50:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636CB13D5;
        Wed,  2 Mar 2022 05:50:02 -0800 (PST)
Received: from [10.57.37.244] (unknown [10.57.37.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E8743F73D;
        Wed,  2 Mar 2022 05:50:01 -0800 (PST)
Message-ID: <6929cf3f-31a4-8ba5-cb5a-e2f1c9dcabbe@arm.com>
Date:   Wed, 2 Mar 2022 13:49:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/panfrost: cleanup comments
Content-Language: en-GB
To:     trix@redhat.com, robh@kernel.org, tomeu.vizoso@collabora.com,
        alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220302124535.358060-1-trix@redhat.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20220302124535.358060-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 12:45, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> For spdx
> change tab to space delimiter
> Use // for *.c
> 
> Replacements
> commited to committed
> regsiters to registers
> initialze to initialize
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v2: remove multiline comment change

Thanks for the update. I'll push this to drm-misc-next.

Steve

> 
>  drivers/gpu/drm/panfrost/panfrost_drv.c          | 2 +-
>  drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c | 2 +-
>  drivers/gpu/drm/panfrost/panfrost_issues.h       | 2 +-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c          | 2 +-
>  drivers/gpu/drm/panfrost/panfrost_regs.h         | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 96bb5a4656278..94b6f0a19c83a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -562,7 +562,7 @@ static int panfrost_probe(struct platform_device *pdev)
>  
>  	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
>  
> -	/* Allocate and initialze the DRM device. */
> +	/* Allocate and initialize the DRM device. */
>  	ddev = drm_dev_alloc(&panfrost_drm_driver, &pdev->dev);
>  	if (IS_ERR(ddev))
>  		return PTR_ERR(ddev);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> index b0142341e2235..77e7cb6d1ae3b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +// SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2019 Arm Ltd.
>   *
>   * Based on msm_gem_freedreno.c:
> diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
> index 8e59d765bf19f..501a76c5e95ff 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_issues.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
> @@ -14,7 +14,7 @@
>   */
>  enum panfrost_hw_issue {
>  	/* Need way to guarantee that all previously-translated memory accesses
> -	 * are commited */
> +	 * are committed */
>  	HW_ISSUE_6367,
>  
>  	/* On job complete with non-done the cache is not flushed */
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index 39562f2d11a47..d3f82b26a631d 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier:	GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
>  /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
>  
>  #include <drm/panfrost_drm.h>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index 6c5a11ef1ee87..efe4b75149d35 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -292,7 +292,7 @@
>  #define AS_FAULTADDRESS_LO(as)		(MMU_AS(as) + 0x20) /* (RO) Fault Address for address space n, low word */
>  #define AS_FAULTADDRESS_HI(as)		(MMU_AS(as) + 0x24) /* (RO) Fault Address for address space n, high word */
>  #define AS_STATUS(as)			(MMU_AS(as) + 0x28) /* (RO) Status flags for address space n */
> -/* Additional Bifrost AS regsiters */
> +/* Additional Bifrost AS registers */
>  #define AS_TRANSCFG_LO(as)		(MMU_AS(as) + 0x30) /* (RW) Translation table configuration for address space n, low word */
>  #define AS_TRANSCFG_HI(as)		(MMU_AS(as) + 0x34) /* (RW) Translation table configuration for address space n, high word */
>  #define AS_FAULTEXTRA_LO(as)		(MMU_AS(as) + 0x38) /* (RO) Secondary fault address for address space n, low word */

