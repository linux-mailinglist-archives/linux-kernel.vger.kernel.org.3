Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519F95A1214
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbiHYN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbiHYN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:28:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0251B0885
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:28:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d16so19341242wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iEih3CJpUsuGBVnUm+LssLfYV99RduebxdAn+oy7W9Q=;
        b=iDKFvgFzoNX3VPEfVSzihuaD2IexrhHvq1o2cgGOVVY7mNnrUcm4trLKFlFMr1Hoqy
         7pB6istL7X3lUMZcLPyRvf5D2LDSZyKmVVibcnhxHpHjtteHuXi5AuOxCdSZVtnlZI37
         KeM5Et7vgCUg1ew+BNszhwKhMrhsVSCUIV8JnDCKLviBLQc7Dxwk8Td/JzgPB+MvN4qt
         XflnBnZFdYLmnH7GRgXOnVVw40L96hiPUgbsMiLSwlH0xyKmYcMW2oK9CjYntAPP7Y1k
         PNCoSDnpKWMDAcacnDCe8uq7WFeUEWMoqIbi0od+ySyLJn/r59tYNhA2Qc32TrpwrXht
         gb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iEih3CJpUsuGBVnUm+LssLfYV99RduebxdAn+oy7W9Q=;
        b=RyNtjsVRhAonyZ754u4DGly/BSqbjgoHYkGXmK9T3F7WNP38S/wI+sO8XjAEabb778
         XqOlnW4sEHHBeCWKVlTTmJkELB6+ri0O5J5iZ30JazCycCylkYajp0+PCU0yvmcpNDe3
         SWk+W52BYNnkFk19dW/qCKzcR6N4cUcM72W1h5wJK4E/VzEWpSetfxHR7iKghinQY6/i
         dTf3h0nW37lCzH60WTm/SECwlwekJPcFzxBXiDPG8xG+aRntSS3/31UeEh49tEGKWOxA
         sQ6htExqFNVLmfVKwvNvs1SaoQK+HfSr/qN86HGG21c1JIJVw6UKKvcaCpA04Hu67jvv
         JibA==
X-Gm-Message-State: ACgBeo0qNA4gfdsXF1k1sjDqYBzuVnW1FzpzcC0fWQQAn9qO58GzarJf
        YwLVXiVN7+JMIXQ0ncCl2Xo=
X-Google-Smtp-Source: AA6agR4daUGe+73sMMfqktGypNv9NGm9SBqpzRBZ3ILjGMylRu+HjErcCxcmMcoUM+Y4m4D2Ml3iMw==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr2337050wrq.718.1661434127193;
        Thu, 25 Aug 2022 06:28:47 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b003a2f2bb72d5sm7475472wmp.45.2022.08.25.06.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:28:46 -0700 (PDT)
Message-ID: <b9feaa81-0443-a466-486a-33c387ab26b5@gmail.com>
Date:   Thu, 25 Aug 2022 15:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 5/6] soc: mediatek: mtk-svs: Use devm variant for
 dev_pm_opp_of_add_table()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-6-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220726141653.177948-6-angelogioacchino.delregno@collabora.com>
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



On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
> In error cases, this driver never calls dev_pm_opp_of_remove_table():
> instead of doing that, simple switch to a devm variant, which will
> automagically do that for us.
> 
> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   drivers/soc/mediatek/mtk-svs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 80d0bab1a045..25b49d8af59a 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1626,7 +1626,7 @@ static int svs_bank_resource_setup(struct svs_platform *svsp)
>   
>   		dev_set_drvdata(svsb->dev, svsp);
>   
> -		ret = dev_pm_opp_of_add_table(svsb->opp_dev);
> +		ret = devm_pm_opp_of_add_table(svsb->opp_dev);
>   		if (ret) {
>   			dev_err(svsb->dev, "add opp table fail: %d\n", ret);
>   			return ret;
