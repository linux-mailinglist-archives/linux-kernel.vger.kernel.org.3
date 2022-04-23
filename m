Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E152D50C942
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiDWKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiDWKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:32:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B941C048C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:29:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a21so1011656edb.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T1doDOEgacffxYLHRh8rB/qzYEgOkZW9WRd7tL8Bnmg=;
        b=Uq2QkeMj4YDx/HQMSBiMYbQ6hB5oDmdQNO5vrv6RZsV0W4hbLOlfcQfE9Fx+SorbgG
         MeBfPLDNjGQBN9jXgG5BBgWMk4ku+EZIK5tA7n91BL7LiJUig2PZR20nB4vhxhCfJcMG
         t6d2xzbi1EuNuz47K+u9ehbXvvjZ8kcpDisSvAJK4yj0jNqNnr/FlmotFTQIdwngVGZi
         87mIRQutpRMvI7Y76Ke2obhz8pH7azA2gURjmJ0JSv954JHBmzuGdv1BKUsPx5/slIgm
         vwbdwjM6Bl9W5ADyXkYlNsUd38w3K77+S6uxSZ6nNh9W2/Sj+Q0SNxkXfiIZlZvSWi/e
         IXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T1doDOEgacffxYLHRh8rB/qzYEgOkZW9WRd7tL8Bnmg=;
        b=e6k3weNE79UivKbd3GAV0XHjlSCIJSkh4TiJQH+EuzOduhQedOOfQ6g2gOukw0txSx
         Jm8I93MEN5NufN13e37U73dsLfBAzHO3GGRg+Npgt8ZFo4O9wktW9lp63bVJU4/1Gpcr
         yaa55oB1e18rz/e7Tow4Fr7jD82dSG1h1f0A4Qfe7/tA3oVWNmhhkaOa4W/UIWxrLcOP
         8bQujbct/jWPkzoLSSmnz/VgBhB5SgaWIll5+EUH+kltEpOpp9qNVrlUHqnKG0ombD5f
         e6kKcgX2YOq9C+a2WI4xveAPFPTrNVAYObqq4m7lnSqtDyfD4iBIY4R2Y7l9S9oDRqxi
         QN/g==
X-Gm-Message-State: AOAM530uLxTOgxoghISQu/VSpqIswcCBkb7KYuDejliEAcXdH/cq7+pB
        Tz4s/cBlwmyysErRDdHNY+ToaA==
X-Google-Smtp-Source: ABdhPJzzZENHEHVJTTVj4i/LY2EyfuP6i5J51hweFIRBo2TrNePYugK61Ib5JXoKcujbhrjpbonMsg==
X-Received: by 2002:a05:6402:1941:b0:413:2555:53e3 with SMTP id f1-20020a056402194100b00413255553e3mr9457841edz.164.1650709754411;
        Sat, 23 Apr 2022 03:29:14 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm1557661ejb.104.2022.04.23.03.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:29:14 -0700 (PDT)
Message-ID: <16311e64-6a7f-e20e-de12-5a9eab10af83@linaro.org>
Date:   Sat, 23 Apr 2022 12:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 14/17] dt-binding: mt8195: Add infra_ao reset bit
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
 <20220422060152.13534-15-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422060152.13534-15-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 08:01, Rex-BC Chen wrote:
> To support reset of infra_ao, add the bit definition for thermal/SVS.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8195-resets.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
> index a26bccc8b957..2479680616fb 100644
> --- a/include/dt-bindings/reset/mt8195-resets.h
> +++ b/include/dt-bindings/reset/mt8195-resets.h
> @@ -26,4 +26,11 @@
>  
>  #define MT8195_TOPRGU_SW_RST_NUM               16
>  
> +/* INFRA RST0 */
> +#define MT8195_INFRA_RST0_THERMAL_AP_RST       0
> +/* INFRA RST3 */
> +#define MT8195_INFRA_RST3_PTP_RST              5
> +/* INFRA RST4 */
> +#define MT8195_INFRA_RST4_THERMAL_MCU_RST      10

Same comments as for other reset.


Best regards,
Krzysztof
