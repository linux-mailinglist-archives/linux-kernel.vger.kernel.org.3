Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5F4E92CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiC1KzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiC1KzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:55:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4637F12083
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:53:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so18657247wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pQvUwgGe2yUxoTgyZUNPtgyDX7Rla1bC9Fp/TydpPrQ=;
        b=EUPsZ0BapwUGRVBvI45LPlGGVpCgTp2IJICaghOpvSgNEI/GIJHLT40ZIDpzkHQipr
         4ApJswcAD8TGMNtTH5OeUgiZJCdBxRhzdIoeK2NG3nAQa+Wb2IpYD0KLhSdYyAjJHp8W
         w3nZyOEngZqaQfu0muA68xymOxEasCLD+auRqe6r/PdfBeXmV9B5f6hCwpO91DqVQVEX
         2JWGA02+1B4DvuIcajRxgVifEunaFgpDOzrezUhWJblsoEpmVA3b61TBKvyBygdp2LuC
         wpePzCRkMalMTKORVbfHkGNQEvcOIDRRiX1CZ68gCz40o1pRznZ+rfJxdGf5UoH9yKL9
         XQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pQvUwgGe2yUxoTgyZUNPtgyDX7Rla1bC9Fp/TydpPrQ=;
        b=cwlwDHc9t3FacwB8niAgt2aurYp2Zot6reUn/di9b7dO/XA/MKBQBPgXNcXUjEOqMI
         r2fcQ6USalOOJEP7N/JcdyjiwUHA9hDelzdr4ZyrJpka8+ulD2llkswpNIqDyTdGZGXB
         MKegmoooU8dyRC6uvxGDDa9JnV4JHy4Vyqna1KH47mxjAxkKzdC9vi/9ydFs8bQ61aOG
         xGvWP1eE1vKlGIcqQBRCGDaulv1lwZCc458AJEuYhQVeu1h0MAkYeXr7WlsPehRoMGTA
         0YNwhR3LMxjfoammwwi+nrlGpNHxUNUyEQFj1tF5gwXoEDzIfE+WMSfJeXdkfv2Z7pKU
         DUlw==
X-Gm-Message-State: AOAM5319uiZ7JRSxZ7y6mcyZaoI4ATNETiy+NqE1tIiqqW5Ye0Vntz5v
        IMexi1VZYOzXDY4Sxu6GnYiwjp8Ur4h46Q==
X-Google-Smtp-Source: ABdhPJzfW9YDSUoDqPF/6iL0fbw7yC3QCVyS/FFbWHw05MpIh2rYo5I/45yXykhosnFub4goGvtDwg==
X-Received: by 2002:a5d:6d05:0:b0:205:8631:cfae with SMTP id e5-20020a5d6d05000000b002058631cfaemr22519718wrq.612.1648464802866;
        Mon, 28 Mar 2022 03:53:22 -0700 (PDT)
Received: from [192.168.0.32] ([137.101.87.65])
        by smtp.gmail.com with ESMTPSA id v4-20020adfa1c4000000b00205c6dfc41esm1776263wrv.18.2022.03.28.03.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 03:53:22 -0700 (PDT)
Message-ID: <fdf68128-b743-2ad5-a4e0-25451c387417@gmail.com>
Date:   Mon, 28 Mar 2022 12:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] soc: mediatek: mmsys: Add sw0_rst_offset for MT8192
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, rex-bc.chen@mediatek.com
References: <20220323091932.10648-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220323091932.10648-1-angelogioacchino.delregno@collabora.com>
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



On 23/03/2022 10:19, AngeloGioacchino Del Regno wrote:
> MT8192 has the same sw0 reset offset as MT8186: add the parameter
> to be able to use mmsys as a reset controller for managing at
> least the DSI reset line.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied thanks!

> ---
> 
> v2: Change the offset to 0x160 (as defined for MT8186). Thanks, Rex-BC!
> 
>   drivers/soc/mediatek/mtk-mmsys.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 4fc4c2c9ea20..f69521fabcce 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -70,6 +70,7 @@ static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8192-mm",
>   	.routes = mmsys_mt8192_routing_table,
>   	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
> +	.sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>   };
>   
>   static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
