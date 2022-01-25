Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF70649ACC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384256AbiAYGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376539AbiAYGuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:50:32 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27DC07851F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:19:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id h14so1254807plf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9g6KBkre2BFoosp7D2Ahbfqd085BZ7a6ZvmcPUHUFa0=;
        b=5GljMn+wAkmQhaUszwM0ant7VEZH1Q6PgU1nIC9zsQ246sJ9yXQqWI5OjYiJBbuZka
         hXemwJuorh0PN3nd3an99MII6zerTGj2eS0a1+1v7ZO3wZUpikqSMm+1+y+O1deLw3hQ
         oIvQYfQhyqt06dVl8zJKl7VMNg0Qe4dZOWXm3LfDuu0lEYO0fkP2oQSIpKu2fuPuQaft
         9NpOIkkhG8MhNVggokHcZKCxMLwQ98Rs5MVvAyMWtkuZSXzm3ChaI5HKZQYHVmW4SncL
         Qp601fy9A9Zg0/pinuCgzApGQe7XhYjAfjPqXB/C8ZojzbCM8q/1NPxD7NBIT47OZm00
         8Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9g6KBkre2BFoosp7D2Ahbfqd085BZ7a6ZvmcPUHUFa0=;
        b=n+xTkHh824owcnrqpJfziRbzJaj7eRz1cyEh/tOOBxHmod/ktel2M9csuAihAYMhM6
         LW5cGLGXmUoejqJ4vl4ZALAcjsPZLzE75R3g5UsfuTBk1IjueGI+GUCYIni8Xgu0qWaA
         puN7VX5hW+nW/pCHiHxUFlkmBrveCr44HZMZ7lm2vdu5VyeyB3Xzxu5vnzQmYOWo9Fpp
         RAurihbgAM77dA0rt8ZVeBc+PZ5WhjMucBhRgEeZZJc4qCqTfkFEMkiT7x7zNimhf9Wk
         139+OAZ5Cl2L3uW07MoU0xL4+LcI56aPkt7CXLQqXBqDQSlUw6xobkAzWWDDp/N/yegu
         1c+Q==
X-Gm-Message-State: AOAM532gfLVp2H+DDvvO6ovXLCr4j6G3v/+18hKAeGqS8syZKUhphLWA
        exbM4MjXvW3gnJL/j1MGkL92pg==
X-Google-Smtp-Source: ABdhPJx3tJwGX0zcVGZdtSwy24wcOQUhybth6WJAMbYUBfqr5MH3qFb04LHdgWgH3blgvWE89QBDxA==
X-Received: by 2002:a17:902:9884:b0:14a:c885:720a with SMTP id s4-20020a170902988400b0014ac885720amr17439833plp.68.1643087990313;
        Mon, 24 Jan 2022 21:19:50 -0800 (PST)
Received: from [10.16.129.73] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id g5sm966103pjj.36.2022.01.24.21.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 21:19:49 -0800 (PST)
Message-ID: <c4455e8e-1e9e-76ed-8e31-34da6efc7ee6@igel.co.jp>
Date:   Tue, 25 Jan 2022 14:19:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v3 1/3] drm: introduce fb_modifiers_not_supported flag
 in mode_config
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
References: <20220114101753.24996-1-etom@igel.co.jp>
 <20220114101753.24996-2-etom@igel.co.jp>
 <Ye3b0x3QwlKBF7nl@pendragon.ideasonboard.com>
From:   Esaki Tomohito <etom@igel.co.jp>
In-Reply-To: <Ye3b0x3QwlKBF7nl@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent-san

Thank you for your reviews and advices.

I'll fix this patch series following your advice.

Thanks,
Esaki

On 2022/01/24 7:50, Laurent Pinchart wrote:
> Hello Esaki-san,
> 
> On Fri, Jan 14, 2022 at 07:17:51PM +0900, Tomohito Esaki wrote:
>> If only linear modifier is advertised, since there are many drivers that
>> only linear supported, the DRM core should handle this rather than
>> open-coding in every driver. However, there are legacy drivers such as
>> radeon that do not support modifiers but infer the actual layout of the
>> underlying buffer. Therefore, a new flag fb_modifiers_not_supported is
>> introduced for these legacy drivers, and allow_fb_modifiers is replaced
>> with this new flag.
>>
>> Signed-off-by: Tomohito Esaki <etom@igel.co.jp>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       |  6 +++---
>>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c             |  1 +
>>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             |  2 ++
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
>>   drivers/gpu/drm/drm_framebuffer.c                 |  6 +++---
>>   drivers/gpu/drm/drm_ioctl.c                       |  2 +-
>>   drivers/gpu/drm/nouveau/nouveau_display.c         |  6 ++++--
>>   drivers/gpu/drm/radeon/radeon_display.c           |  2 ++
>>   include/drm/drm_mode_config.h                     | 10 ++++++++++
>>   11 files changed, 33 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index 82011e75ed85..edbb30d47b8c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -954,7 +954,7 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
>>   	int ret;
>>   	unsigned int i, block_width, block_height, block_size_log2;
>>   
>> -	if (!rfb->base.dev->mode_config.allow_fb_modifiers)
>> +	if (rfb->base.dev->mode_config.fb_modifiers_not_supported)
>>   		return 0;
>>   
>>   	for (i = 0; i < format_info->num_planes; ++i) {
>> @@ -1141,7 +1141,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (!dev->mode_config.allow_fb_modifiers) {
>> +	if (dev->mode_config.fb_modifiers_not_supported) {
>>   		drm_WARN_ONCE(dev, adev->family >= AMDGPU_FAMILY_AI,
>>   			      "GFX9+ requires FB check based on format modifier\n");
>>   		ret = check_tiling_flags_gfx6(rfb);
>> @@ -1149,7 +1149,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
>>   			return ret;
>>   	}
>>   
>> -	if (dev->mode_config.allow_fb_modifiers &&
>> +	if (!dev->mode_config.fb_modifiers_not_supported &&
>>   	    !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
>>   		ret = convert_tiling_flags_to_modifier(rfb);
>>   		if (ret) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> index d1570a462a51..fb61c0814115 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
>> @@ -2798,6 +2798,8 @@ static int dce_v10_0_sw_init(void *handle)
>>   	adev_to_drm(adev)->mode_config.preferred_depth = 24;
>>   	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
>>   
>> +	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
>> +
>>   	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>>   
>>   	r = amdgpu_display_modeset_create_props(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> index 18a7b3bd633b..17942a11366d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
>> @@ -2916,6 +2916,8 @@ static int dce_v11_0_sw_init(void *handle)
>>   	adev_to_drm(adev)->mode_config.preferred_depth = 24;
>>   	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
>>   
>> +	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
>> +
>>   	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>>   
>>   	r = amdgpu_display_modeset_create_props(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index c7803dc2b2d5..2ec99ec8e1a3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -2674,6 +2674,7 @@ static int dce_v6_0_sw_init(void *handle)
>>   	adev_to_drm(adev)->mode_config.max_height = 16384;
>>   	adev_to_drm(adev)->mode_config.preferred_depth = 24;
>>   	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
>> +	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
>>   	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>>   
>>   	r = amdgpu_display_modeset_create_props(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> index 8318ee8339f1..de11fbe5aba2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
>> @@ -2695,6 +2695,8 @@ static int dce_v8_0_sw_init(void *handle)
>>   	adev_to_drm(adev)->mode_config.preferred_depth = 24;
>>   	adev_to_drm(adev)->mode_config.prefer_shadow = 1;
>>   
>> +	adev_to_drm(adev)->mode_config.fb_modifiers_not_supported = true;
>> +
>>   	adev_to_drm(adev)->mode_config.fb_base = adev->gmc.aper_base;
>>   
>>   	r = amdgpu_display_modeset_create_props(adev);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 2f0b14f8f833..61cb41766fae 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -7868,6 +7868,9 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>   	if (res)
>>   		return res;
>>   
>> +	if (modifiers == NULL)
>> +		adev_to_drm(dm->adev)->mode_config.fb_modifiers_not_supported = true;
>> +
>>   	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
>>   				       &dm_plane_funcs, formats, num_formats,
>>   				       modifiers, plane->type, NULL);
>> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
>> index 07f5abc875e9..4562a8b86579 100644
>> --- a/drivers/gpu/drm/drm_framebuffer.c
>> +++ b/drivers/gpu/drm/drm_framebuffer.c
>> @@ -309,7 +309,7 @@ drm_internal_framebuffer_create(struct drm_device *dev,
>>   	}
>>   
>>   	if (r->flags & DRM_MODE_FB_MODIFIERS &&
>> -	    !dev->mode_config.allow_fb_modifiers) {
>> +	    dev->mode_config.fb_modifiers_not_supported) {
>>   		DRM_DEBUG_KMS("driver does not support fb modifiers\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
>> @@ -594,7 +594,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
>>   	r->pixel_format = fb->format->format;
>>   
>>   	r->flags = 0;
>> -	if (dev->mode_config.allow_fb_modifiers)
>> +	if (!dev->mode_config.fb_modifiers_not_supported)
>>   		r->flags |= DRM_MODE_FB_MODIFIERS;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(r->handles); i++) {
>> @@ -607,7 +607,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
>>   	for (i = 0; i < fb->format->num_planes; i++) {
>>   		r->pitches[i] = fb->pitches[i];
>>   		r->offsets[i] = fb->offsets[i];
>> -		if (dev->mode_config.allow_fb_modifiers)
>> +		if (!dev->mode_config.fb_modifiers_not_supported)
>>   			r->modifier[i] = fb->modifier;
>>   	}
>>   
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index 8b8744dcf691..51fcf1298023 100644
>> --- a/drivers/gpu/drm/drm_ioctl.c
>> +++ b/drivers/gpu/drm/drm_ioctl.c
>> @@ -297,7 +297,7 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>>   			req->value = 64;
>>   		break;
>>   	case DRM_CAP_ADDFB2_MODIFIERS:
>> -		req->value = dev->mode_config.allow_fb_modifiers;
>> +		req->value = !dev->mode_config.fb_modifiers_not_supported;
>>   		break;
>>   	case DRM_CAP_CRTC_IN_VBLANK_EVENT:
>>   		req->value = 1;
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
>> index 2b460835a438..2cd0932b3d68 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
>> @@ -708,10 +708,12 @@ nouveau_display_create(struct drm_device *dev)
>>   				     &disp->disp);
>>   		if (ret == 0) {
>>   			nouveau_display_create_properties(dev);
>> -			if (disp->disp.object.oclass < NV50_DISP)
>> +			if (disp->disp.object.oclass < NV50_DISP) {
>> +				dev->mode_config.fb_modifiers_not_supported = true;
>>   				ret = nv04_display_create(dev);
>> -			else
>> +			} else {
>>   				ret = nv50_display_create(dev);
>> +			}
>>   		}
>>   	} else {
>>   		ret = 0;
>> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
>> index 573154268d43..b9a07677a71e 100644
>> --- a/drivers/gpu/drm/radeon/radeon_display.c
>> +++ b/drivers/gpu/drm/radeon/radeon_display.c
>> @@ -1596,6 +1596,8 @@ int radeon_modeset_init(struct radeon_device *rdev)
>>   	rdev->ddev->mode_config.preferred_depth = 24;
>>   	rdev->ddev->mode_config.prefer_shadow = 1;
>>   
>> +	rdev->ddev->mode_config.fb_modifiers_not_supported = true;
>> +
>>   	rdev->ddev->mode_config.fb_base = rdev->mc.aper_base;
>>   
>>   	ret = radeon_modeset_create_props(rdev);
>> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
>> index 91ca575a78de..da82f45351c7 100644
>> --- a/include/drm/drm_mode_config.h
>> +++ b/include/drm/drm_mode_config.h
>> @@ -933,6 +933,16 @@ struct drm_mode_config {
>>   	 */
>>   	bool allow_fb_modifiers;
>>   
>> +	/**
>> +	 * @fb_modifiers_not_supported:
>> +	 *
>> +	 * This flag is for legacy drivers such as radeon that do not support
>> +	 * modifiers but infer the actual layout of the underlying buffer.
>> +	 * Generally, each drivers must support modifiers, this flag should not
>> +	 * be set.
> 
> I'd write it a bit differently, to explain what the flag does:
> 
> 	 * When this flag is set, the DRM device will not expose modifier
> 	 * support to userspace. This is only used by legacy drivers (such as
> 	 * radeon) that infer the buffer layout through heuristics without using
> 	 * modifiers. New drivers shall not set fhis flag.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> +	 */
>> +	bool fb_modifiers_not_supported;
>> +
>>   	/**
>>   	 * @normalize_zpos:
>>   	 *
> 
