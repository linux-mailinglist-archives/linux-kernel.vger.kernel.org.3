Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD459E915
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiHWRSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiHWRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:18:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE711C3F5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:48:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id bx38so13541000ljb.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=etUNLniWHgJEJDCvw5GPxyP6mirBEPYcAYo8g53LeZg=;
        b=G6u/gMHONj31bKntnY4mYMMepTc/qL4So3m6ypkJTVSM6Qx8oF5a7AjqcKACF0T90o
         ABUxoYHTA10t/J7O8DagZehl8ZgohPjweSQbDRxeFvG0CKwaGJcJAsh7K0m+Ez5gy60a
         RnrKHF312WnBAg9ACxc1UIB4SvNn7d8s9aOH2d7Pyg86qIzn+tlaKNlwpDfLpAI29njg
         OZ9WRyx7e0k/Tbiqe6bDgOR43DH2MzXZWulM58eicHufIU36kVwe+ngKi9Xi8WGEUq26
         3xRAi6KUKa5Wh2MS0Pm3IaPjvZMtMzUE5ikE5T/s/LxFQ++UU+SXZhe1/GLxsJ+kIC+9
         NkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=etUNLniWHgJEJDCvw5GPxyP6mirBEPYcAYo8g53LeZg=;
        b=GfADiQhIPW2U7fGhIFH+6FNZnYNmSejZaBBcT1qZSinlOI/Q63XVgX6HzfCs9Wx8Hl
         /aPSX/yasswh62vC62K7EaqmtN0AGm2jp9C/K9iFaTze9LjSyr4yaQZaLsqiI0ZxxegM
         LzLK23y02KOWhJWFDVd8Nz8ufBtVOC+uS+2+Q64z8GuQiNjKIQoJpPfkygzUerOVZwl1
         l6QTXZatnT8Ob5Px8H4Vr9Zc0ItLxLHn/yrNSbvC5PWD+JStlio96wPSQx2xKPfn+5r1
         EB1IFknwzD6qDHWBSIyhmaGvZYCQfiOePpfY2pDC67ZrMEDcs7E94CueqFBvvAlZEfyE
         xn0A==
X-Gm-Message-State: ACgBeo146ag1KTsQjZget6urdvqIj5wNSGr0aWltpllqM1QSezaK7eeK
        8EfoF9RSDkq8h/+cWp/T/6/Wdw==
X-Google-Smtp-Source: AA6agR7LLkgQKhdY0aEo6fL4eDcJ/ReUbDhzV9yPR1SsZVcB8imNPrMITsvk9qQ5MHab1vJPAgJbIA==
X-Received: by 2002:a2e:a812:0:b0:261:8f2d:9530 with SMTP id l18-20020a2ea812000000b002618f2d9530mr6450626ljq.251.1661262492350;
        Tue, 23 Aug 2022 06:48:12 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id w23-20020ac24437000000b00492f6ddba59sm398330lfl.75.2022.08.23.06.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 06:48:10 -0700 (PDT)
Message-ID: <2d2511c7-760c-31d5-5283-8ab0b20849d6@linaro.org>
Date:   Tue, 23 Aug 2022 16:48:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] ASoC: mediatek: dt-bindings: modify machine bindings
 for SOF
Content-Language: en-US
To:     Chunxu Li <chunxu.li@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com,
        jiaxin.yu@mediatek.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        project_global_chrome_upstream_group@mediatek.com
References: <20220820075343.13993-1-chunxu.li@mediatek.com>
 <20220820075343.13993-2-chunxu.li@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820075343.13993-2-chunxu.li@mediatek.com>
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

On 20/08/2022 10:53, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> Add SOF related field.
> 1. Add a property "mediatek,adsp", Only when adsp phandle could be
> retrieved from DTS, the SOF related part of machine driver is executed.
> 2. Add a property "mediatek,dai-link" to support dai-links could be
> specified from DTS
> 
> Signed-off-by: chunxu.li <chunxu.li@mediatek.com>
> ---
>  .../bindings/sound/mt8186-mt6366-da7219-max98357.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> index 513cd28b2027..d810dfccd1f8 100644
> --- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> @@ -43,6 +43,16 @@ properties:
>      required:
>        - sound-dai
>  
> +  mediatek,adsp:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

No need for quotes.

Best regards,
Krzysztof
