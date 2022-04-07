Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79E4F79AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243005AbiDGIbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiDGIbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:31:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79310C335C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:29:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j12so6705491wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=j2Kem2UHWwWtT1XQMF4+RRZCgeb8SiVpqswTkaM965I=;
        b=n0zghx7LjA9vSgwDkHv9YFtBHCHIfhUd0NgVt5lYxOnkYFjorTyqyJwXm/AT84sjnL
         DIH9ykBGaB6wwlsAGA8ZxmCrFA4RV6IPRlTV+GqLCBxRn8HDOEnJoFOnT82et5MKjC/Y
         HjC1k9L/U6QmtgiKrZpT3yH/S2RCmTzn4rJD+BwqSIVdeAlhpo8sUkwK4eCnfucmcBfc
         aUI6qH5wGJnM9XFv89z00qM6lsm8qKo+OpoeWG8QcxGi+X1MKH8dNzJ7gtvaqGfD8OXT
         W70x9l5wSEeRvDqj2RmsbhiYb2gykMnHbTbTch5iVajXKe4o05du0XETljCqMthmXvjr
         pVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=j2Kem2UHWwWtT1XQMF4+RRZCgeb8SiVpqswTkaM965I=;
        b=aYVRwz6d/bz0K2/Xl8fjr5IzaKicXPRtBLoaoLXP91WDwZ8ehmLCp4C7OoiTyqVtun
         PYynZQyjsjWzr8Co/qUNB5Hv083/kgnRyBVLxogR7qSdQLbavD9w1kiopIbjXJ6k7urB
         VsWgUdjFSi8+Q/KoYh8Lu+YNM8IPjWMQpKBxxsrLqm1ZWNcUuO+irCSov6K8+o+bWCON
         yYCpx4llG9Z/wsuQzawrM+qeFGCMGNbnod6gkx5fW+2Xj8ZoP3I31+FRUoOtGVCEQ36u
         Om78gaHUengx1lFoH5douMXRLP4llYblfvVD9xJbNR9hVpdfi2+8CVLMIC/oJ/UYeQ/4
         JtZw==
X-Gm-Message-State: AOAM533O9D1QzABCwjRWBY9m9aWRO43vF3K833FgCBKCoNF19WstEQXr
        vRQg9wTubxTAxgM1xlfNJRXRBA==
X-Google-Smtp-Source: ABdhPJzslswTLBwz8bASq5ZhoM6pQ0HR0M0Q4WNO3dHYkVPWtR2YQYx66iDbjuqGaVINSGZvnlusVw==
X-Received: by 2002:adf:d1c6:0:b0:205:dbfb:7892 with SMTP id b6-20020adfd1c6000000b00205dbfb7892mr9935170wrd.193.1649320157924;
        Thu, 07 Apr 2022 01:29:17 -0700 (PDT)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm16453043wre.22.2022.04.07.01.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 01:29:17 -0700 (PDT)
Message-ID: <9d3f8bfb-74f7-cbd9-a6f5-1e8acae4c13b@baylibre.com>
Date:   Thu, 7 Apr 2022 10:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 5/6] drm/bridge: dw-hdmi: add YCBCR formats only if
 CSC is available
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     letux-kernel@openphoenux.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>
References: <cover.1649262368.git.hns@goldelico.com>
 <d5801eb7733a616df30fef1d192e88ad147afc1c.1649262368.git.hns@goldelico.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <d5801eb7733a616df30fef1d192e88ad147afc1c.1649262368.git.hns@goldelico.com>
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

On 06/04/2022 18:26, H. Nikolaus Schaller wrote:
> otherwise they will produce a black HDMI screen.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index b5a665c5e406e..ec40dd8865065 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2628,10 +2628,12 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>   		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>   	}
>   
> -	if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCBCR422)
> +	if (hdmi->csc_available && hdmi->sink_is_hdmi &&
> +	    (info->color_formats & DRM_COLOR_FORMAT_YCBCR422))
>   		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>   
> -	if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
> +	if (hdmi->csc_available && hdmi->sink_is_hdmi &&
> +	    (info->color_formats & DRM_COLOR_FORMAT_YCBCR444))
>   		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>   
>   	/* Default 8bit RGB fallback */

This patch shouldn't be needed anymore with proper filtering in patch 1.

Neil
