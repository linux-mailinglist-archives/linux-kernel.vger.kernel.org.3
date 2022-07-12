Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A541F5714CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiGLIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiGLIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:39:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D820182
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:39:08 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u13so12758029lfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=omRgN0J5yZix+Z65ddu+tHeBZrf7vaMQw16XFNCfZoE=;
        b=INPcpr5fSURpySLQoUpwTeVxIZyAJyPeGNY4vyVHDfDUyd4YJBsE29rkNEGaTW5Jlo
         WMp7hGjWg3zfeVA/gKMm9wA/yDcljNnT8IFYWvtATc6ZVVPIJdfvvRsjmXgFh98QUxUJ
         wP033DHPhOANHLEEWm77C0hbw13aVaSFBoIDuAqg4gDFYJyDygLNQks3S+dFt/he2Xye
         zmk6fBDwNdUeB23cA12bPDpzpX2IadzAsruamoCpZdIai9PPiChTEkj8wAqe1ACQkIaI
         cGPQN0ZU9U1RAei2xT/AX5otcYQDIX0goD+pIHTZjC6uqyvAEabpQMlNO4ZJSxRy8/Zc
         0eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=omRgN0J5yZix+Z65ddu+tHeBZrf7vaMQw16XFNCfZoE=;
        b=h+UwAzRyOZFx/BLisFh53tZ9utuNEI+JRt0yW52vEfe/TNVoyovvbBzYBRUXsrSrgH
         0EP2GVu9aDOE1GXvbfrWQyXxa8XEKIPc/fR8r9grNgw/J90l0yG353Jlhv2rh8jmu9VW
         /1ZeA/gBRE73emEFbg1pDSPSBWCd+Z4F5tSveCIvbGT9dVIP4bGBUEdhbXBywIvqUwoO
         GKHMl4xaTyWhzJvA28HWLahNB40Q6RO+IT/f3V0wopVN83II7L6Dmi2f2PCRCZgqPYNm
         QAYMp6jlIfD3OAaVeb//sztjXoX1cjMUe1c7unF9xaLiUtqy6oPfW8kkbLPcfXh35VVB
         GCug==
X-Gm-Message-State: AJIora/dItRpQ+Z7S8hetzHHUVCrfYYvXTr5qOScW4XTmkeaPpJFbftH
        rW1w6A00WROKm/zmsxrgjbTiJQ==
X-Google-Smtp-Source: AGRyM1vJWqunUMEEMc/jclwCCRXBmtDYhVAs6xxWGTzvIR3Ne3/Z6Gv3umiOi6ILzvstKeSp4knBrA==
X-Received: by 2002:a05:6512:505:b0:489:c93d:a95c with SMTP id o5-20020a056512050500b00489c93da95cmr12270053lfb.115.1657615146468;
        Tue, 12 Jul 2022 01:39:06 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id c19-20020ac25f73000000b0048759bc6c1asm2056194lfc.203.2022.07.12.01.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:39:05 -0700 (PDT)
Message-ID: <0eff0dd7-2d77-5341-5079-09d4a9309b1e@linaro.org>
Date:   Tue, 12 Jul 2022 10:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] soc: mediatek: pm-domains: Grab SCPSYS registers from
 phandle to syscon
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
 <20220711122503.286743-4-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711122503.286743-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

On 11/07/2022 14:25, AngeloGioacchino Del Regno wrote:
> Instead of requiring nesting of the power-controller inside of a
> "syscon", "simple-mfd" node, look for a phandle to SCPSYS in the
> "syscon" property of the power controller node.
> 
> Compatibility with older devicetrees is retained by falling back
> to looking for a parent node if no syscon phandle is found.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/soc/mediatek/mtk-pm-domains.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index a3dae391a38a..c5a1c766cd50 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -590,8 +590,7 @@ static int scpsys_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	const struct scpsys_soc_data *soc;
> -	struct device_node *node;
> -	struct device *parent;
> +	struct device_node *node, *syscon;
>  	struct scpsys *scpsys;
>  	int ret;
>  
> @@ -611,13 +610,16 @@ static int scpsys_probe(struct platform_device *pdev)
>  	scpsys->pd_data.domains = scpsys->domains;
>  	scpsys->pd_data.num_domains = soc->num_domains;
>  
> -	parent = dev->parent;
> -	if (!parent) {
> -		dev_err(dev, "no parent for syscon devices\n");
> -		return -ENODEV;
> +	syscon = of_parse_phandle(dev->of_node, "syscon", 0);
> +	if (!syscon) {
> +		if (!dev->parent)
> +			return -ENODEV;
> +		scpsys->base = syscon_node_to_regmap(dev->parent->of_node);
> +	} else {
> +		scpsys->base = syscon_node_to_regmap(syscon);
> +		of_node_put(syscon);
>  	}

I responded in previous DTS thread. Technically code looks ok, but it
does not make really sense - either this is a child or a sibling. Not
both for the same hardware!

Best regards,
Krzysztof
