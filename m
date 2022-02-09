Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32804AFFD6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiBIWDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:03:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiBIWDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:03:22 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95135DF498A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:03:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u6so6858580lfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m/jM298Q2lilwuRAcB9szC9CfZcuho3/psKjLfOmipk=;
        b=TBVPofOcDZHSNsfDSrK9N25wXlUqmiOwgAkzkjmAX7pRNqnzIlCv+Yazw38kCracB1
         PfVDsmtnw7AZxa6Rvn5RueZwpXPFbDHYD7wl8veFe5kS1uzo3pW+Q54NcX6wK7F4ifN9
         kCIpFQOmGPlWeI+F+Daz9XRNW0Np/b/ccFxBcKS7/6U+f2704dO9X6NRZidd5HhbDpDO
         jDr5wylLX3hFKJ2e6jweRbE0x4iGflbnv4rwQe6jxf7pTSNFufATUiEHoKNdn4H37ZiU
         l2QWN6u7oLNWiu3x7fhNSVxYWqN2s67IOWxnFQ+cHgpG4/KqiJottk6xQuvfFpjx+4zG
         p3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m/jM298Q2lilwuRAcB9szC9CfZcuho3/psKjLfOmipk=;
        b=VZTFXm6pXH/DhAkxbnyJL0eJQFfr/ar/ZENSkqJEAe/PtQvegYynfNmct0Ex2c/r8B
         j/T0RK1xWroYKLD09pZECs3hO9wDHM4CmbhuIt0AwwqugifIFyUZw1isaCu/VskyIUx0
         dUTG7Jn3tiLbgy3ZViKFGdgbrZQYD73kCLx4lTLtg/LS/tnf83EShwVApR6hJszOd4ac
         bhAaq0ZciJbORbcJYL0hZB/Ms+n+tXwieWrNvqQxZ002x/twRZdT9eYDOrKN64O5Q9XV
         re9CCifhYsUeZaqBvPfQr01ImXfGc7nLut8P7m5uJ6+2AYEBC/3nXdHKcP0UML/BD7Zr
         DnbQ==
X-Gm-Message-State: AOAM530q8ostBEzF0KtZCki8AiVJPO2Y4HPapxW7ywdf4nau4FvoPLzc
        nw6owFJdjR0C0gNjqYMFW2+t8w==
X-Google-Smtp-Source: ABdhPJxwEImBidIbwgxkjiktuZ2LvjO6+doHOTUKPtcJPGxnGqzJVQKkxUsjyj77e/ZRZY8CKdu1Dg==
X-Received: by 2002:a05:6512:3a93:: with SMTP id q19mr3041722lfu.487.1644444202900;
        Wed, 09 Feb 2022 14:03:22 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a27sm2541809lfg.140.2022.02.09.14.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 14:03:22 -0800 (PST)
Message-ID: <32259670-1261-a305-2bcb-57ebde792f24@linaro.org>
Date:   Thu, 10 Feb 2022 01:03:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 2/2] drm/msm/hdmi: Remove spurious IRQF_ONESHOT flag
Content-Language: en-GB
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220201174734.196718-1-daniel.thompson@linaro.org>
 <20220201174734.196718-3-daniel.thompson@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220201174734.196718-3-daniel.thompson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2022 20:47, Daniel Thompson wrote:
> Quoting the header comments, IRQF_ONESHOT is "Used by threaded interrupts
> which need to keep the irq line disabled until the threaded handler has
> been run.". When applied to an interrupt that doesn't request a threaded
> irq then IRQF_ONESHOT has a lesser known (undocumented?) side effect,
> which it to disable the forced threading of irqs. For "normal" kernels
> if there is no thread_fn then IRQF_ONESHOT is a nop.
> 
> In this case disabling forced threading is not appropriate because the
> driver calls wake_up_all() (via msm_hdmi_i2c_irq) and also directly uses
> the regular spinlock API for locking (in msm_hdmi_hdcp_irq() ). Neither
> of these APIs can be called from no-thread interrupt handlers on
> PREEMPT_RT systems.
> 
> Fix this by removing IRQF_ONESHOT.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index 719720709e9e7..e167817b42958 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -306,7 +306,7 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
>   	}
>   
>   	ret = devm_request_irq(&pdev->dev, hdmi->irq,
> -			msm_hdmi_irq, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +			msm_hdmi_irq, IRQF_TRIGGER_HIGH,
>   			"hdmi_isr", hdmi);
>   	if (ret < 0) {
>   		DRM_DEV_ERROR(dev->dev, "failed to request IRQ%u: %d\n",


-- 
With best wishes
Dmitry
