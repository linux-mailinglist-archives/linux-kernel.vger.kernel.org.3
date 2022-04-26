Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49725101E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352311AbiDZPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352282AbiDZPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:32:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BFC35850
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:29:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so1747014wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xmjXZYEvSywyflOdtu3pkNrfJwUdbHNGH7EM0+3lZVs=;
        b=L4RlUWBCgH/ZB0PeLn4K5fCuKrA+EjjZafQlSs6yEUCypcy55DalUV8m9WbfeKrtvS
         5Q4VlPCyZeMlTzaUWsjFgpG+zaPwlEbgudXS1o1V+TyKR+1FLfOTFqqiFk1E2fphEBo0
         2HeQ17FuYkSOCxre2wrdZ+evxgNFg2uJE7japTfSsp1L8GQunxqFdd3mdLKPusHceX8l
         aBndPSXpW2z4Y1l4t+l9stpfdVb29VAjpphjmv8L9ut/agbry7U+IFzV1RONXXfiBlZD
         rNnJV0ShMY6uy2OAjkaZGTj3GnqSPleqvQ8c4nzD7TyRH/C3m6dq7HpBKs7H2HvUHSGD
         XZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xmjXZYEvSywyflOdtu3pkNrfJwUdbHNGH7EM0+3lZVs=;
        b=V3Q9UZbHZYOWy+FyNx5VUjcAFfpq/6DQGAIdMyM111msTn2Aar/IpgZoDimGO8iVoz
         txalgOd5+Sc8b/Ge7PPtHd9oDolSKCG4ZkOlfzP/AxLUmYq6JF3lPpcWETkcZS87IK7S
         NHHk5wF76EFmYsEYAj4IPpVl/l7S8ftczD6H76qJEKlN6RQ8HhHxB2kEQRovg2gC6CsA
         6E2320XIh+r4zFuIXUaWwuxo7oFOR/b0trngAcBRumAKK/cNxsaiodNODINpjDu5YLPH
         d3KgSGw4H3O/o7jHfxFrpJaOX/4hXETzTTb14qnURBXzZpT1rWUpU+1SWZ9GFH8bIHdg
         2+7g==
X-Gm-Message-State: AOAM533cgf0LKumFXDrHM7B/OHRDfQcx1z0FJBDRhrUZMqL4/J+W0xeO
        P5VilHPwrUfVSHpAERVhqTd4MA==
X-Google-Smtp-Source: ABdhPJx4o/yWEsHCDJMP2SoLs5GoZgq06izD/asRmKR9qCaO16o7SekLSb5++udJrRAQ0AaonO4vmg==
X-Received: by 2002:a1c:a181:0:b0:392:8f7e:d2f8 with SMTP id k123-20020a1ca181000000b003928f7ed2f8mr22115472wme.30.1650986973204;
        Tue, 26 Apr 2022 08:29:33 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:5959:ca32:2e01:b6fc? ([2001:861:44c0:66c0:5959:ca32:2e01:b6fc])
        by smtp.gmail.com with ESMTPSA id b11-20020adfc74b000000b0020ad84d3fa3sm7251824wrh.44.2022.04.26.08.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:29:32 -0700 (PDT)
Message-ID: <fd02a183-bcaa-86a8-8a13-52a9ddb374d5@baylibre.com>
Date:   Tue, 26 Apr 2022 17:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/bridge: ite-it6505: add missing Kconfig option select
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220426141536.274727-1-fparent@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220426141536.274727-1-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 16:15, Fabien Parent wrote:
> The IT6505 is using functions provided by the DRM_DP_HELPER driver.
> In order to avoid having the bridge enabled but the helper disabled,
> let's add a select in order to be sure that the DP helper functions are
> always available.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   drivers/gpu/drm/bridge/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 007e5a282f67..2145b08f9534 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -78,6 +78,7 @@ config DRM_ITE_IT6505
>           tristate "ITE IT6505 DisplayPort bridge"
>           depends on OF
>           select DRM_KMS_HELPER
> +        select DRM_DP_HELPER
>           select EXTCON
>           help
>             ITE IT6505 DisplayPort bridge chip driver.

http://lore.kernel.org/r/20220403151637.15546-1-rdunlap@infradead.org also select DRM_DP_AUX_BUS,
can you check if this is really neaded ?

Neil
