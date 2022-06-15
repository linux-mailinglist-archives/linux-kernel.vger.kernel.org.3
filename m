Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F454C8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbiFOMph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347236AbiFOMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:45:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F5C443D7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:45:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s6so18678336lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2zOauB4b7g5lcbnITMMxeE2s0wgTpDslehgvoxa82L8=;
        b=UMAfnrE2aWigR/q6xMPtvhg2ojjat/jbG6oiLiFyBq+r77LyfInB/UMBk0IZsK/KTN
         bXJCj64jpBE273Mdgpj6B4Iwfw5bchCRj3qT6ZNRvb7KglCzvVzMpkWT1ShGllZkTGVA
         JRLBof22O17mYlvel5ag4PwkY4hU6i9DoP09yHKsHhtQJcOoifgDHkyLHTcyIPUFtrFL
         k7KhZHVn7eEynoa4tNELhdGo2DxCKcqEWT1y1ewG8NyNJnWlmSUGJW2jC6DMHlOfSGX6
         LxRwaaQt9NG2rmzZ6ymFOsB7ofiiWR6/kYw9FzQ+fjNP98X4/Efj4sFhuDkazw+exMvC
         FcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2zOauB4b7g5lcbnITMMxeE2s0wgTpDslehgvoxa82L8=;
        b=UBN4u1jUQ8Ck6VKbW9MyFapv4NvJv1d1F56XT8V/IyiXWnv8PeC6+7wykkP1hOg6sx
         I9EmA+WWR70TfuJuESZMPVML0i893AOLXC8O5IQVoQ+49lUC7S5gGIE+qScOSGs+z6sz
         xJZLMY7HJ1Yi+EbUwoTT6XGpaAkpYZvxAo8km+I4T9ydQxxM2QlqyPVxxtpDbObB2q1P
         /STjfK8SEbog2q9daTBA/tUIruTLDgImVgVCMi8Sl/7t9YLoyFhU7x1TTvzXx7dxf1cz
         r73Du6TTXKYmLDXs3qRtVaewLDsWeZ9pYE/Qi83rcF6mqgVfGpR1fVCIPk8VgG8Ms0Fn
         TNig==
X-Gm-Message-State: AJIora9iJMmhu/QIsY+cLQ/vtDNoiCJUPZbAXiE3EbcuQ9zVEEdm3Chx
        WqeNR+I9fSqoDVDGlLeU2BdxzQ==
X-Google-Smtp-Source: AGRyM1uErqHFJQHAFNutC12wS6K6kS65Ce/no+PwzNQ7oDUszt3CS3a7ktVh56u8Xg1iwUq49+/qrw==
X-Received: by 2002:ac2:4e86:0:b0:479:242:61da with SMTP id o6-20020ac24e86000000b00479024261damr5995734lfr.40.1655297133091;
        Wed, 15 Jun 2022 05:45:33 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id br21-20020a056512401500b0047255d2114asm1780870lfb.121.2022.06.15.05.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:45:32 -0700 (PDT)
Message-ID: <5066e977-52b5-ce18-98e9-44dcfe018127@linaro.org>
Date:   Wed, 15 Jun 2022 15:45:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/2] drm: Add DRM_GEM_FOPS
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chris Healy <cphealy@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220609174213.2265938-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220609174213.2265938-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 20:42, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The DEFINE_DRM_GEM_FOPS() helper is a bit limiting if a driver wants to
> provide additional file ops, like show_fdinfo().
> 
> v2: Split out DRM_GEM_FOPS instead of making DEFINE_DRM_GEM_FOPS
>      varardic
> v3: nits
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

I suspect that with Tomas's ack we can pick this through the drm/msm. Is 
this correct? (I'll then pick it for the msm-lumag).

> ---
>   include/drm/drm_gem.h | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 9d7c61a122dc..87cffc9efa85 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -314,6 +314,23 @@ struct drm_gem_object {
>   	const struct drm_gem_object_funcs *funcs;
>   };
>   
> +/**
> + * DRM_GEM_FOPS - Default drm GEM file operations
> + *
> + * This macro provides a shorthand for setting the GEM file ops in the
> + * &file_operations structure.  If all you need are the default ops, use
> + * DEFINE_DRM_GEM_FOPS instead.
> + */
> +#define DRM_GEM_FOPS \
> +	.open		= drm_open,\
> +	.release	= drm_release,\
> +	.unlocked_ioctl	= drm_ioctl,\
> +	.compat_ioctl	= drm_compat_ioctl,\
> +	.poll		= drm_poll,\
> +	.read		= drm_read,\
> +	.llseek		= noop_llseek,\
> +	.mmap		= drm_gem_mmap
> +
>   /**
>    * DEFINE_DRM_GEM_FOPS() - macro to generate file operations for GEM drivers
>    * @name: name for the generated structure
> @@ -330,14 +347,7 @@ struct drm_gem_object {
>   #define DEFINE_DRM_GEM_FOPS(name) \
>   	static const struct file_operations name = {\
>   		.owner		= THIS_MODULE,\
> -		.open		= drm_open,\
> -		.release	= drm_release,\
> -		.unlocked_ioctl	= drm_ioctl,\
> -		.compat_ioctl	= drm_compat_ioctl,\
> -		.poll		= drm_poll,\
> -		.read		= drm_read,\
> -		.llseek		= noop_llseek,\
> -		.mmap		= drm_gem_mmap,\
> +		DRM_GEM_FOPS,\
>   	}
>   
>   void drm_gem_object_release(struct drm_gem_object *obj);


-- 
With best wishes
Dmitry
