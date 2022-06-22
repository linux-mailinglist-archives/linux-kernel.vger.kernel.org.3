Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819AB554C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357620AbiFVOHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiFVOHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:07:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9A37BD3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:07:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z17so9317001wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MzKWleynAfOZzr1G32uJu4jvVPYdSV6qOcoCG8BDdeI=;
        b=Yybid874HpfGUBNJPUpQicuLtK79W9BMcpg+PcvVhrK/OVuHkXUoO2oqO3aymUPI4H
         NjAF+XpIeU4InRKHibe6EaWdY1PBtBghxcvFcZXuZVWsn9dEfxEbD8kYZ16iQuS+7Fyg
         5Do1T/02aka/OxICUl+TNKuG09evEQSRXIOv4Z4j2KYRCT1TZdJ8bK1xUhG65QOFVYKl
         B1vUz+CI8CSimhaytO2075oJnFb5Ul6L+h55TV5yYgA3AM2r8zCFoF+BYCaiFfcbb4A+
         W3XSyCT1SxqdvvpkDHFX5njMe7qafyIXIppomoQAG6PsniNW9eb3Bq5mX8l6dr+41RCS
         pVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MzKWleynAfOZzr1G32uJu4jvVPYdSV6qOcoCG8BDdeI=;
        b=SJCxIMK2PMkISV/qp1g1QwxOESvSkRkCWVOdGjI+LURz4l7QuUQ71ZPHZQvzRNR4ij
         OOLF+yvxwZB+QL2BSiEVKyamohZfP0AG7nbUGe2uGkRzrusteOxbzl/WpALsfJwStHp4
         iwXZ/5bHuP+etqFwZTFg5yhTwerurX63S+nvPX2MD0bX8LbW9EKuNNlPtSQhR9D60tVS
         5FJwLJ6r/HNPb72/3WKPyqYax090BwcLj2WZzMYB4MJhiGT6ZLSelHRKA7TOkffcYqU8
         yI+UB4dNp67hkaeJesU4KJMSOt8mF71hHOp0vDUwFakkP+3SURS59xJAkPqSVqaZxD6s
         1CdA==
X-Gm-Message-State: AOAM531+3u4p6JS7jGYN+GY7EUOIRJNsbyM0gl+9pvauuw0FiAWFZgn+
        Dt5XLNgUZCjZ+BjKssiBhhI=
X-Google-Smtp-Source: ABdhPJze2ccttYHD6Z+ReNpSXGvAL7/WlO9i1HO+wGVa0wB4egIBmMjI9h78jpnILe5ZX0+xYrulJA==
X-Received: by 2002:a7b:c4cb:0:b0:39c:35b3:e8c1 with SMTP id g11-20020a7bc4cb000000b0039c35b3e8c1mr46816236wmk.183.1655906822523;
        Wed, 22 Jun 2022 07:07:02 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id d7-20020adfef87000000b0021b9153f80fsm8644703wro.71.2022.06.22.07.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:07:01 -0700 (PDT)
Message-ID: <d93c3721-8415-ad4d-2f68-2d55adbd1fff@gmail.com>
Date:   Wed, 22 Jun 2022 16:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] soc: mediatek: mutex: Use DDP_COMPONENT_DITHER0 mod index
 for MT8365
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     fparent@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>
References: <20220620102454.131417-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220620102454.131417-1-angelogioacchino.delregno@collabora.com>
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



On 20/06/2022 12:24, AngeloGioacchino Del Regno wrote:
> In commit
> 4e8988c634a1 ("soc: mediatek: add DDP_DOMPONENT_DITHER0 enum for mt8195 vdosys0")
> the enum mtk_ddp_comp_id was modified to add an index number to the
> DITHER component because some new SoCs have multiple dither blocks.
> 
> As a result, all of the mutex mod arrays have been changed to use the
> new definition instead of the old one (even if that's retained): for
> consistency purposes, follow the same trend on the newly introduced
> MT8365 mutex mod array.
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

Matthias

> ---
>   drivers/soc/mediatek/mtk-mutex.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index fa8e0ba38803..2fd8318c3bdc 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -358,7 +358,7 @@ static const unsigned int mt8365_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>   	[DDP_COMPONENT_AAL0] = MT8365_MUTEX_MOD_DISP_AAL,
>   	[DDP_COMPONENT_CCORR] = MT8365_MUTEX_MOD_DISP_CCORR,
>   	[DDP_COMPONENT_COLOR0] = MT8365_MUTEX_MOD_DISP_COLOR0,
> -	[DDP_COMPONENT_DITHER] = MT8365_MUTEX_MOD_DISP_DITHER,
> +	[DDP_COMPONENT_DITHER0] = MT8365_MUTEX_MOD_DISP_DITHER,
>   	[DDP_COMPONENT_DPI0] = MT8365_MUTEX_MOD_DISP_DPI0,
>   	[DDP_COMPONENT_DSI0] = MT8365_MUTEX_MOD_DISP_DSI0,
>   	[DDP_COMPONENT_GAMMA] = MT8365_MUTEX_MOD_DISP_GAMMA,
