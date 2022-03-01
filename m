Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD24C8555
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiCAHk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCAHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:40:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492370F6E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:39:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so18952440wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6qd4wly0ZYkUmRnAy3gZktl5PxXqoeJ7cLSu4TZL6L8=;
        b=C8+Nw59KMWOuBxqg2PDDm56mlc0KA7UwqTkS5hR4J7x31VCcaffB3b3Arxx2cpUSDe
         319ZSA+SJxvCN9E92HBjHkspHIibgEO26tZPaPlt3z6oCnt2EF2OsJCofQxOKdPyG6uL
         TqvetWOcwu9po5HQD62DvgKhzftqrEnFy1cmTS1xpYqb9VAP13lR95a3iHR5OierBZLr
         RmpdMce8IRHVHFR6Bf6Ptspn3e4UIx4pysmvxLQWD2bOwzkEM0XLK86o6K1PfN7GMCba
         aC4p4S+LKjWUlnlA/rmt14wAtAglWwM7IA3zvcoSiziAFMyO/t4VleAJwG+OIvAJnMZn
         +bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6qd4wly0ZYkUmRnAy3gZktl5PxXqoeJ7cLSu4TZL6L8=;
        b=Mm6obCGMa2nyf3niNEIDO8miy3WmGMmlx/ICJZYJA8fgeYOrTTMrhFOZhPP303yaQa
         ft7YFeD02Bi6iRMZJiVU+WawxrFqaJYGXu4UXa4qpVezq46ruXKwssYrAls0g+2HGFcl
         gZYGY6kdZJt9aOYSTGuHFAqkvjit4VvvNLlak34vHxNfOyJ/PBaWrdN3GvJb5PXIoPU5
         Gwpn4Y7yvovub8Lv2yMlD1eDeF/sNTMxpCkJtSlmjtEFcRJkTk6bbc/6uefp/BihwTyX
         p1O1USL7QSz2K6NYOUp/rsf8U9kdPGzHAFHUFrAG7mY2MPuQOy45u7m3370Nyze/dCbc
         IA6Q==
X-Gm-Message-State: AOAM531craASgIe5epvmsmsEwj31cuShhR91hv8x5A6HfTU/q17uU9YA
        ujiTOU/nrwf7UtRA8vnH+Cvv1MjrXPBK8Q==
X-Google-Smtp-Source: ABdhPJxVrjIm1agzAk9N23dwEgJBgrES/gCSzeZ7KtVImnSp0vU9M1HD+N1+6VZr1sFokVQSMEfqeg==
X-Received: by 2002:a5d:64a8:0:b0:1ef:f99c:8c12 with SMTP id m8-20020a5d64a8000000b001eff99c8c12mr3496161wrp.214.1646120384677;
        Mon, 28 Feb 2022 23:39:44 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e20-20020adfa454000000b001f01a14dce8sm667149wra.97.2022.02.28.23.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:39:44 -0800 (PST)
Message-ID: <9cc89fdf-f98b-8fba-eab7-ce292f6ae75b@gmail.com>
Date:   Tue, 1 Mar 2022 08:39:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] soc: mediatek: mt8192-mmsys: Fix dither to dsi0 path's
 input sel
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yongqiang.niu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220128142056.359900-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220128142056.359900-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2022 15:20, AngeloGioacchino Del Regno wrote:
> In commit d687e056a18f ("soc: mediatek: mmsys: Add mt8192 mmsys routing table"),
> the mmsys routing table for mt8192 was introduced but the input selector
> for DITHER->DSI0 has no value assigned to it.
> 
> This means that we are clearing bit 0 instead of setting it, blocking
> communication between these two blocks; due to that, any display that
> is connected to DSI0 will not work, as no data will go through.
> The effect of that issue is that, during bootup, the DRM will block for
> some time, while atomically waiting for a vblank that never happens;
> later, the situation doesn't get better, leaving the display in a
> non-functional state.
> 
> To fix this issue, fix the route entry in the table by assigning the
> dither input selector to MT8192_DISP_DSI0_SEL_IN.
> 
> Fixes: d687e056a18f ("soc: mediatek: mmsys: Add mt8192 mmsys routing table")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mt8192-mmsys.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mt8192-mmsys.h b/drivers/soc/mediatek/mt8192-mmsys.h
> index 6f0a57044a7b..6aae0b12b6ff 100644
> --- a/drivers/soc/mediatek/mt8192-mmsys.h
> +++ b/drivers/soc/mediatek/mt8192-mmsys.h
> @@ -53,7 +53,8 @@ static const struct mtk_mmsys_routes mmsys_mt8192_routing_table[] = {
>   		MT8192_AAL0_SEL_IN_CCORR0
>   	}, {
>   		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> -		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0
> +		MT8192_DISP_DSI0_SEL_IN, MT8192_DSI0_SEL_IN_DITHER0,
> +		MT8192_DSI0_SEL_IN_DITHER0
>   	}, {
>   		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
>   		MT8192_DISP_RDMA0_SOUT_SEL, MT8192_RDMA0_SOUT_COLOR0,
