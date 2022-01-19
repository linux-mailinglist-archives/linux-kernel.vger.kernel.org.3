Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76274493D36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350809AbiASPba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355833AbiASPbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:31:23 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A49C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:31:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso14956510wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EEwszbL7JSaW2g9ncBScSaSCr2Cmm8pog96jqoGtWUU=;
        b=AvKGhaM2IE1rw4PUhZ9+6xqaFege0xTVTb1Vw41jAEodT/ztWFpLBR29Pn4i7DpzTC
         xlVlWYfTffSRHxmGl2Krh41GrdZmBlb4JomJPikj1katDlJvtMdqAy2zap3CKdnEt1VW
         lUF4Al55lPe6KDqF76HWPn6mevH6n9dtOJ79w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EEwszbL7JSaW2g9ncBScSaSCr2Cmm8pog96jqoGtWUU=;
        b=dMm/xnWUPSoXM3RF2nrIXM/5vw/4PX9iTNuzVMBBdU7oivQ9bv21OGKXcYF3j6Z3Pz
         iZ3sZc1QibtXdfaB/SR8i6yDoLc+SZaTPHJhjDyP8ZHz+MhMd4tlDob8O3nzKn0ZLq4V
         O49h6xpg6/G1SrBcaQjuXlwEy3C7xFX+E43dqHZ+gpKPx7tcj3RuPfxVW5zBLCWLcPah
         BY10NBnJNQJ8vN8sKGLnDpUaP7oDUEx6owUW8eaKaBfAAMq82lXF2Vcrk80ly0IHbZU3
         /3SqCvS1yWimAztjQh/8dOH/g+8r8yu9+Tqp2obtjPt0rw+f1Yd5aeI4x4+oTq1Y+ScO
         JnZg==
X-Gm-Message-State: AOAM5333KAn+SPdLSr/9bhVE22wMQGKZ3P8DQba1t3FTbpg7mVhhBmsm
        F50Sr8K5FatiZSsTFSnxPSexXjKb9HK+QQ==
X-Google-Smtp-Source: ABdhPJytSeK0nTa2OU28PzM7P+4b4R1+Yxc672QntbhSwADGiwocjVMhIYp3nDQRFrgdzWA0MOtsQw==
X-Received: by 2002:a5d:6a4c:: with SMTP id t12mr29059404wrw.677.1642606268397;
        Wed, 19 Jan 2022 07:31:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d6sm117015wrs.85.2022.01.19.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:31:07 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:31:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Raymond Jay Golo <rjgolo@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] drm: panel-orientation-quirks: Add quirk for the
 1Netbook OneXPlayer
Message-ID: <YeguukKExXYALEmv@phenom.ffwll.local>
Mail-Followup-To: Raymond Jay Golo <rjgolo@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20220113000619.90988-1-rjgolo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113000619.90988-1-rjgolo@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 08:06:20AM +0800, Raymond Jay Golo wrote:
> The 1Netbook OneXPlayer uses a panel which has been mounted
> 90 degrees rotated. Add a quirk for this.
> 
> Signed-off-by: Raymond Jay Golo <rjgolo@gmail.com>

Applied to drm-misc-next-fixes, should show pu in the merge window still
for -rc1.
-Daniel

> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 042bb80383c9..b910978d3e48 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -115,6 +115,12 @@ static const struct drm_dmi_panel_orientation_data lcd1280x1920_rightside_up = {
>  	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>  };
>  
> +static const struct drm_dmi_panel_orientation_data lcd1600x2560_leftside_up = {
> +	.width = 1600,
> +	.height = 2560,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
> +};
> +
>  static const struct dmi_system_id orientation_data[] = {
>  	{	/* Acer One 10 (S1003) */
>  		.matches = {
> @@ -275,6 +281,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Default string"),
>  		},
>  		.driver_data = (void *)&onegx1_pro,
> +	}, {	/* OneXPlayer */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK TECHNOLOGY CO., LTD."),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
>  	}, {	/* Samsung GalaxyBook 10.6 */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
