Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A811149B42C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383578AbiAYMlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:41:17 -0500
Received: from foss.arm.com ([217.140.110.172]:40508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383607AbiAYMhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:37:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 968681FB;
        Tue, 25 Jan 2022 04:37:39 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7719C3F7D8;
        Tue, 25 Jan 2022 04:37:39 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 3856D684477; Tue, 25 Jan 2022 12:37:38 +0000 (GMT)
Date:   Tue, 25 Jan 2022 12:37:38 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     carsten.haitzler@foss.arm.com
Cc:     dri-devel@lists.freedesktop.org, brian.starkey@arm.com,
        airlied@linux.ie, daniel@ffwll.ch, steven.price@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/arm: arm hdlcd select DRM_GEM_CMA_HELPER
Message-ID: <Ye/vEilz6j8gX3wu@e110455-lin.cambridge.arm.com>
References: <20220124162437.2470344-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124162437.2470344-1-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 04:24:37PM +0000, carsten.haitzler@foss.arm.com wrote:
> From: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Without DRM_GEM_CMA_HELPER HDLCD won't build. This needs to be there too.
> 
> Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I will add Steven's reviewed-by as well when pushing it.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> index 58a242871b28..6e3f1d600541 100644
> --- a/drivers/gpu/drm/arm/Kconfig
> +++ b/drivers/gpu/drm/arm/Kconfig
> @@ -6,6 +6,7 @@ config DRM_HDLCD
>  	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
>  	depends on COMMON_CLK
>  	select DRM_KMS_HELPER
> +	select DRM_GEM_CMA_HELPER
>  	help
>  	  Choose this option if you have an ARM High Definition Colour LCD
>  	  controller.
> -- 
> 2.30.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
