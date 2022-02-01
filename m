Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA46C4A5B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiBALsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237466AbiBALsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643716126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAQrcI0deDlNA9eCisSMwUR/TZsbNGoMTXQyByv6Pq0=;
        b=cbsQnDxPhAtaUpA5pT3fWjMgPAGjUT4RvPW3wJO9Xd0nSDJPp7runxJupBMtfKkgCH+98+
        qQuN3elCves96TRH85WtKWXHDjpGBzMClMg2fgLK3Fsq+IIjTeFAOTOBKATqKD5nbpTkfF
        do+1hwMbjuni8r539idVOPEk/sCT2Zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-L3s25KGTPT-14kzI8HldGw-1; Tue, 01 Feb 2022 06:48:45 -0500
X-MC-Unique: L3s25KGTPT-14kzI8HldGw-1
Received: by mail-wm1-f70.google.com with SMTP id v190-20020a1cacc7000000b0034657bb6a66so3608296wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HAQrcI0deDlNA9eCisSMwUR/TZsbNGoMTXQyByv6Pq0=;
        b=Pzps+cOSFwsbuurIWJEkh3hf4W3cgfD0OeD/rLfyygsNS6JqmDykGjpxoCr7QdEAwC
         NG8Y7Pe/+X+GLROdvC6Xab0kY+uyLe5ymk3eFDi3oU0L29nTViwMGmlVg57X2KpMHad3
         Ut5FZJIuLAxkxc+VlrxgJmZG9nOlDMEnSJK+gYzk7uCZIt9/OwRu85Z3Z1VNy4vp5H8M
         Hz5GBv9VkwfA9LLmvuWSmVcindNJLVP0L0iSaK6ZNtKRTTVpokSba6EUN/NWGlFWBHHh
         n/GvgrLXthZNYK5DYThTlqR9wdT0PBAXxIpWuhHY0NuzAMuL8NyGITMWPH1CPh3vZmK9
         wCEg==
X-Gm-Message-State: AOAM530Azep1yaazPj6nn+5pMSiLuzotEemCtOHT3ojNVqP316B63ZRd
        fOEZarEmOpIVTxwslvRYWkip0c8TZlbxTv3qy8mFbbJJVbR/dlgTjy8SoN7EsL6zhuActOgMaN2
        Ok413Crc3jyIDjzROCL5vl+TD
X-Received: by 2002:adf:f58f:: with SMTP id f15mr12076474wro.192.1643716124452;
        Tue, 01 Feb 2022 03:48:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzd9BlV0HRMbyk/XwhfXyaNQQpXbeT1Gbtln4v7etwlKLUXdBdHLLvcKWVu2NnD4Vi+vIyooQ==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr12076463wro.192.1643716124242;
        Tue, 01 Feb 2022 03:48:44 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g6sm14023059wrq.97.2022.02.01.03.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:48:43 -0800 (PST)
Message-ID: <c10f8a68-6c45-41ec-7061-ff69360f1fbb@redhat.com>
Date:   Tue, 1 Feb 2022 12:48:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] drm/format-helper: Add
 drm_fb_gray8_to_mono_reversed()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-3-javierm@redhat.com>
 <e52560f0-bd0c-b51b-af1b-bd4be2df8702@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e52560f0-bd0c-b51b-af1b-bd4be2df8702@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

Thanks a lot for your feedback.

On 2/1/22 10:59, Thomas Zimmermann wrote:
> Hi
> 
> Am 31.01.22 um 21:12 schrieb Javier Martinez Canillas:
>> Add support to convert 8-bit grayscale to reversed monochrome for drivers
>> that control monochromatic displays, that only have 1 bit per pixel depth.
>>
>> This helper function was based on repaper_gray8_to_mono_reversed() from
>> the drivers/gpu/drm/tiny/repaper.c driver.
> 
> You could convert repaper to the new helper.
>

Yes, I plan to do it but was out of scope for this patch series.

>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>>
>>   drivers/gpu/drm/drm_format_helper.c | 35 +++++++++++++++++++++++++++++
>>   include/drm/drm_format_helper.h     |  2 ++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
>> index 0f28dd2bdd72..bf477c136082 100644
>> --- a/drivers/gpu/drm/drm_format_helper.c
>> +++ b/drivers/gpu/drm/drm_format_helper.c
>> @@ -584,3 +584,38 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
>>   	return -EINVAL;
>>   }
>>   EXPORT_SYMBOL(drm_fb_blit_toio);
>> +
>> +/**
>> + * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
>> + * @dst: reversed monochrome destination buffer
>> + * @src: 8-bit grayscale source buffer
>> + * @clip: Clip rectangle area to copy
>> + *
>> + * DRM doesn't have native monochrome or grayscale support.
>> + * Such drivers can announce the commonly supported XR24 format to userspace
>> + * and use drm_fb_xrgb8888_to_gray8() to convert to grayscale and then this
>> + * helper function to convert to the native format.
>> + */
>> +void drm_fb_gray8_to_mono_reversed(void *dst, void *src, const struct drm_rect *clip)
> 
> IMHO it would be better to have a function that converts xrgb8888 to 
> mono and let it handle the intermediate step of gray8.
>

That's a good idea. I'll add that too.

>> +{
>> +	size_t width = drm_rect_width(clip);
>> +	size_t height = drm_rect_width(clip);
>> +
>> +	u8 *mono = dst, *gray8 = src;
>> +	unsigned int y, xb, i;
>> +
>> +	for (y = 0; y < height; y++)
>> +		for (xb = 0; xb < width / 8; xb++) {
> 
> The inner loop should probably go into a separate helper function. See 
> the drm_fb_*_line() helpers in this file
>
> At some point, we's want to have a single blit helper that takes source 
> and destination formats/buffers. It would then pick the correct per-line 
> helper for the conversion. So yeah, we'd want something composable.
>

Agreed. I'll split that into a separate helper function.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

