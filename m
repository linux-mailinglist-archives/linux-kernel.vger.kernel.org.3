Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D4553FED2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbiFGMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbiFGMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:32:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C62F6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:32:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id e5so2412398wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZPej/hkIOluYizjzd52Y0iwdquh2H8sBzwUHjN322Cg=;
        b=h7zmZiEVGw+xXk2BouUedAGbB+RMk2UJbp1Pot8Hbszr87XRanYGp9w3poZNrzgXu6
         uHg/tBESE8XaOiYxekFmoVQKeYknI3zz9ndkjT4W3t6GidYqEkz3CY/zbeYIpnrqzO3Y
         hNG56Y7wYIw2kOCrj2yI30aNY/ULoGmFUfnHZv/6ASM+BoZN9w/88UTlJMPMeQCj6d6h
         peBfGNbAtzxjTiLZ3pJb3spZ5NYdrXduVhsB5Se5Tn40aFPJni6JtN6WhfblK7JPexro
         hTLE3/3gizqEmvfqyoNgMsPR4Xwj7rq2d5PJ3jMi2LLtFwyPiz/6Wo5pTDjJiP9g16kH
         NkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZPej/hkIOluYizjzd52Y0iwdquh2H8sBzwUHjN322Cg=;
        b=aII4+E6dPKAWvOt1F+1cuUynUMmSs2PcN9YNYBHHQsaj6XzIl9lD1OlK9ksjszGx67
         XgvdXTIL0mGzse5yggTIAmDLsZZtsjLUM9o8Umo/gyrW+jhVaEe2G42j4pFIG1gLYFWD
         ZxDnq2+p6Vmw4LL55lBOQwzqBJPhqMP6gbN8GPkd2aiH/LnJip92eHFctpl+1tRQetGh
         hDdg3A4egGBWCHY+v+ZoVOXt5jZAh6kN/1DR5eovp7exJiRiWvtWBOR8S6DcNwuv68jl
         f4GPM2LhdXZeolazmJWX+4bsg/4wa0eEET1WuRBEACSB8bulohluxOuVUVqMLMJOQziP
         TW5A==
X-Gm-Message-State: AOAM531XZYoSI0IW+O6hdjRrzFUKiiyJdw38LVKtryvm1hxdaN9LAeP/
        Pb6WH9Ue7Y/gBA9wOJQlkathceNcJx9DOg==
X-Google-Smtp-Source: ABdhPJzHNUCYWqAvB5f92dDj+Uj86kzEleeJ16sWhTlmffjBdxumu/sPOgiYCthaJWBS/8KV70JxnA==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr41327163wmq.88.1654605153066;
        Tue, 07 Jun 2022 05:32:33 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:87c5:1f51:1550:2ebc? ([2001:861:44c0:66c0:87c5:1f51:1550:2ebc])
        by smtp.gmail.com with ESMTPSA id k12-20020adfd84c000000b0021126891b05sm17721960wrl.61.2022.06.07.05.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:32:32 -0700 (PDT)
Message-ID: <3e51df22-5747-7536-257a-77d279c57254@baylibre.com>
Date:   Tue, 7 Jun 2022 14:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/bridge: lt9611uxc: Cancel only driver's work
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220601233818.1877963-1-bjorn.andersson@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220601233818.1877963-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 01:38, Bjorn Andersson wrote:
> During device remove care needs to be taken that no work is pending
> before it removes the underlying DRM bridge etc, but this can be done on
> the specific work rather than waiting for the flush of the system-wide
> workqueue.
> 
> Fixes: bc6fa8676ebb ("drm/bridge/lontium-lt9611uxc: move HPD notification out of IRQ handler")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 3d62e6bf6892..310b3b194491 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -982,7 +982,7 @@ static int lt9611uxc_remove(struct i2c_client *client)
>   	struct lt9611uxc *lt9611uxc = i2c_get_clientdata(client);
>   
>   	disable_irq(client->irq);
> -	flush_scheduled_work();
> +	cancel_work_sync(&lt9611uxc->work);
>   	lt9611uxc_audio_exit(lt9611uxc);
>   	drm_bridge_remove(&lt9611uxc->bridge);
>   

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
