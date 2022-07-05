Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3F566646
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiGEJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGEJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:40:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A3764C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:40:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so16688491wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9c2zH5Ka/eXErCWc9OAeEIYZxxfn0kGsAuxHLmR0MwM=;
        b=JgKFYwGLb3WNTsHz51CqAdXff9PBIjZy1XgPLck66brhFctZtsLIz6DFizileE81G2
         8P3FfHIKhBLoA/m29D3sZ3Trz2e6aVHPTFkTWqrQWjW+LaJWXSnRDuxB4gyXVLpj0jOp
         QUoMYZgewPvFyRdEEVooGycGJlEfaFrDXaObXWg/dyjhrExDYj62FCXwGYnJ6oXq88J1
         VTgD2K3cAYZIleQDTNC+LNQZzPpK961y2973ljjQ+A7G9N9ym5imrEQIejg2T0lwQPeY
         61ycT2gtQTh8WYdiPclhstQX4chVB5CgDZOciBK9cJ7a31e1zyuel3aSl5lsowLAqda+
         t95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9c2zH5Ka/eXErCWc9OAeEIYZxxfn0kGsAuxHLmR0MwM=;
        b=FO47HsT69LvL7S9jQDzsHLjyXH9PTxA0bnZ7AcFC9wDVEEjF0/O2+Mv7mCnnLmIyYm
         pA3BdOZ7EI+2h+oIWPCCCcJnyCHuzhS+TNdD0jMCWtTzqyIsf+gOIIqiQMKZybAYYG9N
         jiZsA8R6NwoVa9qZVM/BOBq4xkPEdVmvuDTKtcMiUdVT1il0JGx2RUKXxqIZ/ye1jlzb
         6GLWRY5LRXNkvA7B4HDl/d+aFn1UJkpjE7nrkooUUj/aZnFfzJT5g6UrFtlJgarLtEUr
         TBuGCwZ6kahGVzbUIIAFizzQNRXJY4Ry9cH8keqne6og7pz4jKta05/fYEd4ewV2Dc4q
         QEJw==
X-Gm-Message-State: AJIora8d8ugYHbYFqgrvmWFMVCBrSDBBnHBeIrWBPWw/LUKYurCYhzty
        u1U23sMfp0uYJmuRyRq38OTKQ5gLFi0Q8lUT
X-Google-Smtp-Source: AGRyM1tr6pY5j2TTIj5nJsSBtLXQusyIjGe24us5gI23ia3KWn8EVRUCy2OD/Hd17J5lwsEX+pLbog==
X-Received: by 2002:a5d:598e:0:b0:21d:3f55:47a8 with SMTP id n14-20020a5d598e000000b0021d3f5547a8mr25273650wri.409.1657014002013;
        Tue, 05 Jul 2022 02:40:02 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id l20-20020a05600c1d1400b0039c4ba160absm21129871wms.2.2022.07.05.02.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:40:01 -0700 (PDT)
Message-ID: <8e278e36-c31b-b2bd-9cab-01bc940bcd44@linaro.org>
Date:   Tue, 5 Jul 2022 10:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvmem: mtk-efuse: Simplify with
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220623121558.107400-1-angelogioacchino.delregno@collabora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220623121558.107400-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2022 13:15, AngeloGioacchino Del Regno wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> No functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Applied thanks,

--srini

>   drivers/nvmem/mtk-efuse.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index e9a375dd84af..a08e0aedd21c 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -41,8 +41,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>   	if (!priv)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->base = devm_ioremap_resource(dev, res);
> +	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(priv->base))
>   		return PTR_ERR(priv->base);
>   
