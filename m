Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DEF524C93
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353621AbiELMUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349371AbiELMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:20:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE42819C34
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:20:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b19so6977935wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=RB4UFWflnqT7YBqkDdk/tHJ953wpGWAq9+2dQip5Mgk=;
        b=SYyQEfdTxPtJhqIjDzLvhoXxyWDkBykTLx2EMy2UIBn9ANURE3n1SbvvtNKJiZRdb9
         QxgtIFjOVr0i1qU7eFxs7SAlFzFLIMyOfqJQRMcVZwp89iY5o2qN8fB/bRpKe413XYx6
         080m+FmyhUnWUdQhf33FL6LXzpjGiaJP383/f5NwouESb9+/Ap6JFzbb4ituiGdzm1o0
         no25PcXJuN67b6sN8hdFf4Fu9mryvYGvwYBqx35zXirO6yTRdPLYG2GInX6XHZoHBDGA
         w8y4OdbFAKcH+ezHiHm+UjUB5pt9wJuEFHUQvmwwSAUJOpdM4SXx2ohi5d2cuja7KxzU
         nCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=RB4UFWflnqT7YBqkDdk/tHJ953wpGWAq9+2dQip5Mgk=;
        b=kFkO1m6Gv1QhGDju2ajo3ts6mjGdaIcrY5/y4KVI0piOGjXiz1Hn67TZ1bA7ZspuCU
         zLMhbFTAH+ZH6H2rjVvFGStevIk5v6R1JQ5ZQ/rvH4DdixnTn0kwxr5Vw7rv+Yh/dwyn
         jr4RGX1ZFs7YOtSooBqK4Op6pI7blY5EOvx+9GFTZRTZKOUd8ebCZY+xCS5EZI+Sqtu0
         Cqj2EZMu5mCcD75mI+QbCYsimmk24aqMRQTo7ioQC8g/KrSgIuc2y4Pq8VyaXX1mBttn
         980LO5FQrOEFa8THS+EUR4+xlSzZpZwcVXFvpYVJMaHiSImrRaLRMW/pgZuA2iJLObRm
         QCmw==
X-Gm-Message-State: AOAM533slmCvrd9CJhbVB33XCmvz5Dsiq4hXTPd9jNjMoXsrayK330y4
        96FZRL1+E+Gta48sxA3PUIBQPtZ429nBmXW2
X-Google-Smtp-Source: ABdhPJyu1aKN5KiuDTzkBD61oRd1v63Bb1+xpDXJPlEui//nYUG2arMwW3pCr9WkbGGiND0niBZcfg==
X-Received: by 2002:a05:6000:144f:b0:20c:6090:3040 with SMTP id v15-20020a056000144f00b0020c60903040mr26377831wrx.479.1652358039271;
        Thu, 12 May 2022 05:20:39 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:8073:a89f:6230:abb? ([2001:861:44c0:66c0:8073:a89f:6230:abb])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b0020c5253d8ccsm4104892wrt.24.2022.05.12.05.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 05:20:38 -0700 (PDT)
Message-ID: <dabe6a15-b0ba-0458-bbd7-a07224071920@baylibre.com>
Date:   Thu, 12 May 2022 14:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220511054052.51981-1-linmq006@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220511054052.51981-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 07:40, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() in error path to avoid refcount
> leak.
> 
> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 5e306de6f485..de87f02cd388 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -435,8 +435,10 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
>   		cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
>   
>   		notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
> -		if (!notifier)
> +		if (!notifier) {
> +			put_device(&pdev->dev);
>   			return -ENOMEM;
> +		}
>   
>   		meson_encoder_hdmi->cec_notifier = notifier;
>   	}

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
