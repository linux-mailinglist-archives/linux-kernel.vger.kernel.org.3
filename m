Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DAB5663F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiGEHW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiGEHW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:22:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2511143
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:22:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o4so16202889wrh.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8usoLhk9ovXL0VS3GA/YN9J82Mt+1GOJy2yE4dko6a0=;
        b=txG/xRqNc6oEFbK0RW1XEurQ0naCyxCJC/Eiilem93tWdd9hnz85Y8XFr1hgWYsbbK
         RGehH4WkOmGstmSt0iaiJ/MR42Txb6KfIn14+W2PtA0f1Q8ILxDZtelZXLBBbgFSD+0I
         nFA8O/Mv41ABZ7BR5vbmH1iVk6ZiO46+I9adc+oxbLiVk3LD3mLbJUg5ONZMDCXkKDmR
         y2tHcvYlQk50Pip8Gr8Zr2ZTXk+4hd7p2Qr9k4wvJ3Lf/WUXmFosEVFvP2PFBWFYVBAA
         HWCcduzModaFma/1939yHkpuz4SRjld80v/HfDXTw2861sP29uGwpq3XWYH+JH2jFzaY
         MSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8usoLhk9ovXL0VS3GA/YN9J82Mt+1GOJy2yE4dko6a0=;
        b=RAPrywnw8FS2Tk6T+5IO3Nvi1MURBjq2HtLOPr0nm7+myZGmuFm50YgHkT1nofwBaC
         cGw4zZ5yh2oO//Y4hhFbaQmGFizN+NSiIcW0Dz8gQEyVLfXRkWXL4/UW+vsyqOWvJwvf
         9A4iN7YFu+SUKPorsOKkFnq7T7UgjYMQsjjb76NHmiGn5Olq+eXaqhzGANmQfvvUuX3G
         h7reM5dMTx0V3k7sKSpZmR2UZIeDNByWKChsolzCXNp+wHKsNlLuz2fpSxC6tQNdKZQL
         wxX+KV3Ahl0dDFVk0ieFonx+74+I5kOaewZzirZU64/xGTpndZHiziqj5z9fk+ETdOva
         lxNQ==
X-Gm-Message-State: AJIora83uaAW9HBZ5XAZtPtMLj3Ly9OIF6vWOF6SrXeQG2xCcu6vs+7s
        DVWIKt22un6dNYB4pWScssEnHg==
X-Google-Smtp-Source: AGRyM1uLfoGwkyfaq+jx1rt6UosZKcFRh1dnyTkBvMdLgCBKeSxXdFLJaQ7qcwlcvo2Y2gDyzeuf8A==
X-Received: by 2002:a05:6000:118e:b0:21d:701e:7cc5 with SMTP id g14-20020a056000118e00b0021d701e7cc5mr3214424wrx.376.1657005743778;
        Tue, 05 Jul 2022 00:22:23 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:3c4f:78be:dc90:14f9? ([2001:861:44c0:66c0:3c4f:78be:dc90:14f9])
        by smtp.gmail.com with ESMTPSA id d7-20020a5d5387000000b0021d5c52f4b4sm8416024wrv.34.2022.07.05.00.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 00:22:23 -0700 (PDT)
Message-ID: <da01677e-8a53-060a-f5ff-075106696c46@baylibre.com>
Date:   Tue, 5 Jul 2022 09:22:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] soc: amlogic: meson-pwrc: Hold reference returned by
 of_get_parent()
Content-Language: en-US
To:     Liang He <windhl@126.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        inux-amlogic@lists.infradead.org
References: <20220705022032.281665-1-windhl@126.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220705022032.281665-1-windhl@126.com>
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

+ linux-amlogic, linux-arm-kernel, linux-kernel

On 05/07/2022 04:20, Liang He wrote:
> We should hold the reference returned by of_get_parent() and use
> it to call of_node_put() for refcount balance.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>   drivers/soc/amlogic/meson-ee-pwrc.c     | 5 ++++-
>   drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 5 ++++-
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> index 2be3afe6c2e3..872ab8ba90bc 100644
> --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> @@ -470,6 +470,7 @@ static int meson_ee_pwrc_probe(struct platform_device *pdev)
>   	const struct meson_ee_pwrc_domain_data *match;
>   	struct regmap *regmap_ao, *regmap_hhi;
>   	struct meson_ee_pwrc *pwrc;
> +	struct device_node *np;
>   	int i, ret;
>   
>   	match = of_device_get_match_data(&pdev->dev);
> @@ -495,7 +496,9 @@ static int meson_ee_pwrc_probe(struct platform_device *pdev)
>   
>   	pwrc->xlate.num_domains = match->count;
>   
> -	regmap_hhi = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
> +	np = of_get_parent(pdev->dev.of_node);
> +	regmap_hhi = syscon_node_to_regmap(np);
> +	of_node_put(np);
>   	if (IS_ERR(regmap_hhi)) {
>   		dev_err(&pdev->dev, "failed to get HHI regmap\n");
>   		return PTR_ERR(regmap_hhi);
> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> index b4615b288625..75a4e1cec416 100644
> --- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> +++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> @@ -274,6 +274,7 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
>   	struct regmap *regmap_ao, *regmap_hhi;
>   	struct meson_gx_pwrc_vpu *vpu_pd;
>   	struct reset_control *rstc;
> +	struct device_node *np;
>   	struct clk *vpu_clk;
>   	struct clk *vapb_clk;
>   	bool powered_off;
> @@ -291,7 +292,9 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
>   
>   	memcpy(vpu_pd, vpu_pd_match, sizeof(*vpu_pd));
>   
> -	regmap_ao = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
> +	np = of_get_parent(pdev->dev.of_node);
> +	regmap_ao = syscon_node_to_regmap(np);
> +	of_node_put(np);
>   	if (IS_ERR(regmap_ao)) {
>   		dev_err(&pdev->dev, "failed to get regmap\n");
>   		return PTR_ERR(regmap_ao);

