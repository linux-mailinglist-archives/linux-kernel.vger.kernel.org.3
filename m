Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A88C4FE098
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiDLMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353714AbiDLMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:42:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53B4ECD0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:08:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc2so16317011ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FVIAFXOAOIOJ12nQCzBaSLbjoQdLOUEfCpAYk7lvVm0=;
        b=wiq7r7lJ9yp4D+OTk6Q+grZtg+6hq66kaQ617FTJRbbWhq3zokiAI6NetHVKCiiTOs
         PgNso4cqG3b3rjuEmJ3tOXQF780QxzQQfmemyq+gAXtF+njCdkYjrh0n//BczmzGhvYt
         o9HoH7eK0OscJUIU+0cy4HN1em/lNWxAvzmEWNBSKaEuoaXMcm8iJcwQ+qLiMnwTdWy5
         RsQWdVjmDbfdxTAIGv4L1fxsxncFbzlPz1JXUXNsFI7E9aqXFBBD9PJwTgyX72D3istU
         qR66DWGnHQNIguDYzO+Z/fQH0ZDdNNKjc4Ijo54HZpO0eawsoi7IgfHKOWaL0vu6wrPM
         wkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FVIAFXOAOIOJ12nQCzBaSLbjoQdLOUEfCpAYk7lvVm0=;
        b=yRQAunaiqBS9Von7tkeZYX4+RBe9DAa80hXOUz4AIN+Lk/RHGe8eRRF3n4ih9vC+Hb
         8IwQMxVxhuumMy1C6rqIThKHQuOebRoVhglx/C3+V5+UeTzaUVVLEEuS5ePJONTwBeM/
         owaoDcrM+QOJgA+9c2wjOGm6QVJNUKNr3YdIBBd7KsRUhe0REeUEEDzGwl//UAejgBSF
         BTZunA79O8Wlk15mIdMrhNXv+RBbiynv8YkvSjoq/eMSkTvCc8dpuYrZ7A9JkLHxCwJc
         PtoYTsSbDYZQ02bNwdm+3N1vagPLACXpgmu+rRFEZ3Esx7paq6KIv9vdUD4i2C/Xo7Jd
         HKgw==
X-Gm-Message-State: AOAM532+Km2Y6TIJTH6E3utlI9S8yDVV3MsaJvwlYmXHiAPphD1ejRnA
        6qeZJHY2w2J8+AY9TN7ckP4Gng==
X-Google-Smtp-Source: ABdhPJzxIrYJdlH/eCTtNSEdRrdTB/9sY8VsfheBg/P8DvRtlxoanCO5xY4tKvGm7nbJ/6fv1ySp5w==
X-Received: by 2002:a17:907:160a:b0:6e8:3c5d:9ce5 with SMTP id hb10-20020a170907160a00b006e83c5d9ce5mr23459258ejc.606.1649765295635;
        Tue, 12 Apr 2022 05:08:15 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906708700b006da8440d642sm13294798ejk.113.2022.04.12.05.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:08:14 -0700 (PDT)
Message-ID: <215584ce-da8f-d4a1-a557-4cd2abc35e49@linaro.org>
Date:   Tue, 12 Apr 2022 14:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: add mt8186 svs
 dt-bindings
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com
References: <20220412112127.21570-1-jia-wei.chang@mediatek.com>
 <20220412112127.21570-2-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412112127.21570-2-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 13:21, Tim Chang wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Add mt8186 svs compatible in dt-bindings.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> index eecfec13ee8b..122ffabb2be4 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> @@ -10,6 +10,7 @@ maintainers:
>    - Roger Lu <roger.lu@mediatek.com>
>    - Matthias Brugger <matthias.bgg@gmail.com>
>    - Kevin Hilman <khilman@kernel.org>
> +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>

It's perfectly fine with me, but it's not mentioned in the commit msg
and some acks from other folks might be useful.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
