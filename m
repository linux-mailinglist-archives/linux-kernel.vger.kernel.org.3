Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D771A4DD63F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiCRIfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiCRIfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:35:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9D19BFDF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:34:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso4297732wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JBS5kufLWoBh6jQkmIuGyN5TkwDV0dVUAqqIzxduWmI=;
        b=C2N9K5pfOPn/jknROvQpydIUdZhtPhgfzwtrdxtOqMriMgwmN9SOB0q2DoKREemaPT
         TmgFRoaDNpM5mX8cYICfo4xIavieRqMs9XzIqr7WZ8clUs4S7jlUnll8qhWo7yr91dXO
         zw1hNdAfijoFQZ6/ADo9cyiCR/3v9vQli9xaS4ShNCIygqVNhEoTHwWY291JHeMFK/Eu
         BfSBEvyGvsO7WVTDdvR0Jez+kU0n6Ce55MtxzLdMozvdDgLBocXfMAGOQVhVtmpbUpv6
         iHchIFSmE2FVAXoAYH2TZ2EuPxmm5C8FnGlmkkX4lAfv5rJsdC3PiBuXE2gf/pa2H4jG
         Rz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JBS5kufLWoBh6jQkmIuGyN5TkwDV0dVUAqqIzxduWmI=;
        b=6p1zF47NUAEsROsNijuDHaBhgeXn8QJ2SkQ5ac42i4CZMEf22xU1pTRGLqc2SVh944
         MOskKmlxkMv89Iyoixm7SPjjZaiR4cdQ8gBrTMkMnYjOpdvBmS0juPbFBjGwOAwffZ7Q
         KQW7DfwENOW+Bf/wayXENkrNc4c7WY5VXjU392oXlhsZhLzRs6ewEqqs1dXU2pWMIJVs
         jiSfCDbRXpPlqHyF0QWFMXMoZDfUkLycX1pGDplaX34jzgDpjdQRFkfWG4kHWVcoaQB5
         IVWj/qUZ/FXOnKYwhNAD3obCY5O20AldWjW/wscLa1aQv5q7odU7JgqJlf0zc+GLnIe9
         3xTA==
X-Gm-Message-State: AOAM530Xg+AEDbdj1aTR6pYpAEULY8uaq/5zEGNVN4AhoPhcATg+6jwk
        +gGya1YKBY8K5qx248Au5eGvxA==
X-Google-Smtp-Source: ABdhPJwdJb/+m+x3Q5ZCtXIp+6h80maidNey0nwW4zOpf/79eRHvrlLepalIv2+SeV8SZlK+2CGezw==
X-Received: by 2002:a7b:c3d5:0:b0:389:a49f:c7e6 with SMTP id t21-20020a7bc3d5000000b00389a49fc7e6mr14808995wmj.99.1647592460780;
        Fri, 18 Mar 2022 01:34:20 -0700 (PDT)
Received: from [192.168.1.10] (i16-les01-ntr-213-44-230-108.sfr.lns.abo.bbox.fr. [213.44.230.108])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000186f00b0020384249361sm6603079wri.104.2022.03.18.01.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:34:20 -0700 (PDT)
Message-ID: <ae37bbcc-14b9-8024-c10f-7a71bd90ff0e@baylibre.com>
Date:   Fri, 18 Mar 2022 09:34:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] drm: bridge: it66121: Fix the register page length
Content-Language: en-US
To:     Nicolas Belin <nbelin@baylibre.com>, andrzej.hajda@intel.com,
        robert.foss@linaro.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com
References: <20220316135733.173950-1-nbelin@baylibre.com>
 <20220316135733.173950-3-nbelin@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220316135733.173950-3-nbelin@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 14:57, Nicolas Belin wrote:
> Set the register page length or window length to
> 0x100 according to the documentation.
> 
> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---
>   drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 06b59b422c69..64912b770086 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -227,7 +227,7 @@ static const struct regmap_range_cfg it66121_regmap_banks[] = {
>   		.selector_mask = 0x1,
>   		.selector_shift = 0,
>   		.window_start = 0x00,
> -		.window_len = 0x130,
> +		.window_len = 0x100,
>   	},
>   };
>   

The documentation we have access to at [1] is confusing:
Reg00 ~ Reg2F are accessible in any register bank.
Reg30~ RegFF are accessible in register bank0
Reg130~ Reg1BF are accessible in register bank1. These are HDMI packet registers.

But indeed it means:
- Reg00 ~ Reg2F: are always accessible, whether bank0 or bank1 is set
- Reg30~ RegFF: only when bank0 is set
- Reg130~ Reg1BF: only when bank0 is set at Reg30~ RegF range

So 0x100 is the right window_len here.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

[1] https://rockchip.fr/radxa/IT66121_Register_List_Release_V1.0.pdf
