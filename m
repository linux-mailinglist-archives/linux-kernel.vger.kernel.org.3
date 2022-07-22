Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60857DCEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiGVIxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbiGVIwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:52:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0C7A0249
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:52:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u5so5588709wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=2Pn4rXwJt2p3TU+sUueEHtQodbg6OuCCH2XmCube7cQ=;
        b=r27r4fHqAh0CWRW3DSWor9BS2qur9Q41GzIHFZqQES6pCfAcZx5CuJFslnk7z+fv47
         6jlKigelz6Pb4RrJn0Hc1qzBD7Ev/b836NwnSQXWysNnhTuPdlQeJETOu1ZiXH1+eKPf
         Vqqni8cAY5bOcuzzngHlGJPBOi96W81wpdlhXmSqij+iqajS9YrtkIoGjZzApDyYAXcL
         sUL9U1xoEy9H+L83cIq0PHm6MUAmRm47KeQGih47T5/IxLZ4fGG5BYYBOF7VpjjIxhnf
         O96jmScWEVUOPGmmsgY1ZIH3Yp+WqvcOHuZWh5coUHu9umTjLfJhdoPvCipn7JX75cLB
         O0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=2Pn4rXwJt2p3TU+sUueEHtQodbg6OuCCH2XmCube7cQ=;
        b=X5fHxiC152Tnbt07sCYHv2775x0DntHhEU/XwYJNHq5x0HkqzQXGFbBFWGphb377Oh
         n7fFZf5YBGtUqg9Ww5xFjqk0I3vhC5pLhORSlZi4VTz94SYnch6MsY2AWpW/pEzLnReN
         vk9AeBa77eY17frXzhh5xVYEyF1PQ3JL7lyvkEvZgF23FoRzGHgIq7KEf7s4VlOrGix6
         zECLhWi7zoJt5EfHYQiEyt1Y9CyzQBT8ZOy5n5be5jDhKKYryUZf4avMMKJlKvTNzCln
         6WnV8mN/YfSAq7Ghgw2chd+88iJyLjdE5q11WyUdfJFF+wjXJBQLYj2ZZh9ViGGHD5BB
         KzzA==
X-Gm-Message-State: AJIora8HQd6fiZSrUTC8un9xRgdvFhGvkFdGsaq31a4DrP3BZVtfeC+V
        kaLZfyIxd5S8zckBCC4QxTHKvw==
X-Google-Smtp-Source: AGRyM1uKdvpmi+vQrw3tcNIve4triqR6UDhGsTHpKea8nf/rvMaGuXeiQBf96xeCJUr5qlFO6NsSZA==
X-Received: by 2002:adf:ef49:0:b0:21e:4688:5c66 with SMTP id c9-20020adfef49000000b0021e46885c66mr1635319wrp.145.1658479964036;
        Fri, 22 Jul 2022 01:52:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:57a9:b2a2:82d5:8786? ([2a01:e0a:982:cbb0:57a9:b2a2:82d5:8786])
        by smtp.gmail.com with ESMTPSA id m184-20020a1c26c1000000b003a04722d745sm8031736wmm.23.2022.07.22.01.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 01:52:43 -0700 (PDT)
Message-ID: <6467b619-d03f-a108-659f-062c96998848@baylibre.com>
Date:   Fri, 22 Jul 2022 10:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Use dev_err_probe() to avoid
 polluting the log
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Erico Nunes <ernunes@redhat.com>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
References: <20220722074755.660258-1-javierm@redhat.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220722074755.660258-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 09:47, Javier Martinez Canillas wrote:
> If devm_drm_of_get_bridge() can't find the connected bridge, it returns an
> ERR_PTR(-EPROBE_DEFER) to indicate that the probe should be deferred.
> 
> But this path also prints an error message, which pollutes the kernel log
> since is printed on every probe deferral, i.e:
> 
>    $ dmesg | grep "failed to create panel bridge" | wc -l
>    38
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 369bf72717f6..90bbabde1595 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1206,10 +1206,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
>   	int ret;
>   
>   	pdata->next_bridge = devm_drm_of_get_bridge(pdata->dev, np, 1, 0);
> -	if (IS_ERR(pdata->next_bridge)) {
> -		DRM_ERROR("failed to create panel bridge\n");
> -		return PTR_ERR(pdata->next_bridge);
> -	}
> +	if (IS_ERR(pdata->next_bridge))
> +		return dev_err_probe(pdata->dev, PTR_ERR(pdata->next_bridge),
> +				     "failed to create panel bridge\n");
>   
>   	ti_sn_bridge_parse_lanes(pdata, np);
>   

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
