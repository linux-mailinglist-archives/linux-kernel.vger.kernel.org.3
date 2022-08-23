Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B345959D8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiHWJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiHWJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:54:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08349F763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:46:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x25so12842142ljm.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JKH4ft/HojJoLFaDDgeksLkaodkyHdDC/mjKTNTZhPs=;
        b=oEmXzyGTsY1Jm/8QDV/fL0tMWnA8/aqTqARmji/gwW4uTPzoaSR9ltEOjszs48LwHm
         zyX/2IkiLkYutSnRSWpOccw4/fVZC22paPUEgeX0TFhWjMkc3Eq31lWv0gtcXzhHctXf
         yo/hfbmujNbjQSELNCY9smsLaTfejwC11ajGhW+AvQqxRQgVPa2G/n7j3SOr1l0A5TiP
         mr1ekZIM6Ipy1b1AOHF/Xjlj6p8M4AQonkKqaiLQJhZcJhu4wO8rMbt8qed8m9jSjyf5
         z2XDb1tNAeBwxdP1JbNfNAYNi34zvD0AmyZ+Zf2rVyIj5J31nKNeZl/wWO2qgzSRjokk
         9dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JKH4ft/HojJoLFaDDgeksLkaodkyHdDC/mjKTNTZhPs=;
        b=V133o7D+BEuS0uARBcc0rTMOqXlz64naVk7Pt+J4pXwdc41fY/uBMBUGTbdgR3m0P3
         GW1nkw+vPGlG7cuxqGjqpEGTIVrXe1WCjVwT0HdLXFaQ/IecGxq4yTHhZBd84DGpYzaK
         aoSD6L2XELdGhBt+81nQ32YAgXq9Cq9M19w5QsYYXkJ4Lru3E3lCO8FqlTRl0uG0Hwhx
         xHJXUtj68n5kMwivLkaVwCfRtB2jyFXo0Q+Vq6PA0bWcNS9o7NCXUraXl8i/LDirCguH
         u6S2Z8wufXa3G3jrE7Y19nTAvi/T7+ivZcKXWMYgHmYNbSFCnUk2lDlv3qXuRLrYWxQ8
         O/Hg==
X-Gm-Message-State: ACgBeo0OrZc6hiIrRJR2gFlLKbSajpxhzjUAtuI00f2Wv0FjsTyEwCF7
        mr1fhvYzQ83nQfTOm+/DNl5gzMBnrRTrAsVN
X-Google-Smtp-Source: AA6agR4YBTjnWyro2PJsJoAncXN9rtMdAV8mFoIfbItwV+OsR3C7RYb9maJWlvJph7+5H40eCY+DFA==
X-Received: by 2002:a05:651c:210c:b0:25e:6a39:23ed with SMTP id a12-20020a05651c210c00b0025e6a3923edmr6546406ljq.43.1661243908301;
        Tue, 23 Aug 2022 01:38:28 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id n2-20020a2e7202000000b00261d619fb16sm329148ljc.82.2022.08.23.01.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:38:27 -0700 (PDT)
Message-ID: <2bbafb3f-3f69-c014-b86c-476f56d93659@linaro.org>
Date:   Tue, 23 Aug 2022 11:38:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: Add gamma compatible for
 mt8195
Content-Language: en-US
To:     "zheng-yan.chen" <zheng-yan.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220822091945.21343-1-zheng-yan.chen@mediatek.com>
 <20220822091945.21343-2-zheng-yan.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822091945.21343-2-zheng-yan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2022 12:19, zheng-yan.chen wrote:
> mt8195 uses 10bit-to-12bit gamma-LUT, which is different from
> current 9bit-to-10bit gamma-LUT, so this patch add its own compatible
> for mt8195.

I am not sure if this explains the need for change. Is mt8195 still
compatible with mt8183 or not? Your driver change suggests that it is
and points that this commit is wrong.

> 
> Signed-off-by: zheng-yan.chen <zheng-yan.chen@mediatek.com>
> 
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml   | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> index a89ea0ea7542..fbd7b9664a78 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> @@ -25,11 +25,12 @@ properties:
>            - const: mediatek,mt8173-disp-gamma
>        - items:
>            - const: mediatek,mt8183-disp-gamma
> +      - items:
> +          - const: mediatek,mt8195-disp-gamma
>        - items:
>            - enum:
>                - mediatek,mt8186-disp-gamma
>                - mediatek,mt8192-disp-gamma
> -              - mediatek,mt8195-disp-gamma


Best regards,
Krzysztof
