Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EF550B82D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447847AbiDVNSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447845AbiDVNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:18:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F3262E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:15:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h25so4987474wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KXSryNAtcD6MCCN4EC/wnZeLO+lxpIfVz2PutIYx238=;
        b=CCQA0TksIIpc2e/aqFcmfUoohLaxyNF4RyV36AYsQ0rRpavUHYH5vZxDISexINNq3U
         YR6CqLFaF4L3GFijS5+LXHr/z0GaVJzG6ZItZOG5Zir6Y4sLf/j9PwZ1LSsL4zegWsbb
         VIIyS8nQ/a23VCLxyXOgunUcoZ8B9P+viN2IzwLnuVyVXTEePuj7oMEaUZWihSeBGKkC
         i9SwFNbJRhJqhj1jNqiYNRbMgP5QQhu6UXDFkJswux4FcETaIrtTpYZUmL0BCf4OLvPf
         fE4lzVVg5SZFYV4FKP4EXwbhWi42UxFR/KT5uGJamKIGCfzUeenOM2gr1vnRzGI1u5Cg
         kgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KXSryNAtcD6MCCN4EC/wnZeLO+lxpIfVz2PutIYx238=;
        b=h1gXoMvDgvkdSOenfbs2irPhok5T4IiOyzwCLwAUA2DCx6wOZ7gqQjQCdDNMMgbN4c
         MuMde9CCICri8aOB/BZ6kHIejz4oXZ42LSEuvoaS3xFT8VZsZyh9gfqGccdzvlkE7CAL
         dZmz0MzJhS9arsvpbaihI7jHWYs9QZLQkZsaKUV2WP06bj2vUf7KPbao2GvEqFjltwBV
         GYWHTEwf70KQRKKHtiH/Jtv5t1yuAWJVVclFrQxzazm0QA72viG8PwKxujpQ3dSkgfHX
         xammKXprptFtr4B2dnOyf8yihzjATdYd5FRIkRHjIp7NTijX+dmm7wGUlY+bcc/Jw5Ej
         At4A==
X-Gm-Message-State: AOAM532NT966WtmFVXbi2/DIj3cgLxrdmIEfBeM56tEx1EmPwQbG1VB1
        xNDjjhK7oa/NSQ+Brskl6Zx8yw==
X-Google-Smtp-Source: ABdhPJyGxGysP/MVeYhMT2oZiy+gjJmiD6BzcHN0XOIRPSiIplpgWUKRW0L7jVHCKLOxp8RFiBrNBQ==
X-Received: by 2002:a5d:5953:0:b0:206:b5c:dfe8 with SMTP id e19-20020a5d5953000000b002060b5cdfe8mr3777012wri.35.1650633352065;
        Fri, 22 Apr 2022 06:15:52 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49? ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm1849163wrf.10.2022.04.22.06.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 06:15:51 -0700 (PDT)
Message-ID: <737ba7a0-400e-4fa0-82e8-f27f62d7c870@baylibre.com>
Date:   Fri, 22 Apr 2022 15:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] drm/bridge: Fix it6505 Kconfig DRM_DP_AUX_BUS
 dependency
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, andrzej.hajda@intel.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        hermes.wu@ite.com.tw, angelogioacchino.delregno@collabora.com,
        allen.chen@ite.com.tw, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>
References: <20220421131415.1289469-1-robert.foss@linaro.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220421131415.1289469-1-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 15:14, Robert Foss wrote:
> it6505 depends on DRM_DP_AUX_BUS, the kconfig for it6505 should
> reflect this dependency using 'select'.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   drivers/gpu/drm/bridge/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index c08ccb4b332b..4cff9206045b 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -78,6 +78,7 @@ config DRM_DISPLAY_CONNECTOR
>   config DRM_ITE_IT6505
>           tristate "ITE IT6505 DisplayPort bridge"
>           depends on OF
> +        select DRM_DP_AUX_BUS
>   	select DRM_DP_HELPER
>           select DRM_KMS_HELPER
>           select EXTCON

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
