Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87053515E40
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242343AbiD3OoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiD3OoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:44:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C562BE6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:40:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l18so20338967ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=LokzJDa2Xe7TuFMhmFuD4DahOkDLaGkiEOATNl7BNRY=;
        b=SAIr1Da3H8/px5lgkHUteAvg3wWIR5C1ZP8E41UVrymDvA/1L4ndQ/hLupOphy7M7E
         pW8QZmVCDnkeHJrIffY5IhnABxkHC4DwBUgr29crPVwCRYC8d9FZkb1H8fkX93t19wQP
         Yp0PgSiwFkOa0QnKI5dSOIbyffkpPJCet9U8YQ/2xDKTzJ5Ca/MdE7Ls3eAJknOo8I3T
         JCOEprgLFd3oQyXol40btbAlYMjf2pv98uQXhRAbV5ZcwnTZX96ev0I37xj/FFgSQCGX
         OGSBBQXXxDl6Q48hle/4n/t1aTHeOp+E1BJWIDubE4ALMg9FUoPKr0QpzIET+K4IRCqE
         qKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LokzJDa2Xe7TuFMhmFuD4DahOkDLaGkiEOATNl7BNRY=;
        b=EW2Dx3fhR11AZ1gSoRAaDbSetdPrmxM6sRHUSfvNNpoPmHHzn2XeDioOOtW93ldtNz
         rDa1nkamBjZdw1tJMMj7ac/lhDgdZkUokiuAto02rSLianuKrH+g51REjFKYRv42hmk7
         xWgy77oPkJieuEjr/ikYrBoo6DLju0igeIDT0ZiQFpKO6f5/dIeh0dVvxntc40uiuhqC
         b16XovSQFsynNCk75QbSiieZ1i+WXisUGiYycvMxpZPdXFdLay8hztjHGqL7wo2ddwYy
         Gm4TapkI0UCOJUKgzP/A3pTF5YktUJcBTeADwyQ+hNY2zTVy6Kdc/Xbo9LFxD/ls15iU
         pFXw==
X-Gm-Message-State: AOAM530qsBqxcDTVvKQMNr31YL9xOiKq0YGGZ73qXzzKmWOCPaBcm2sc
        WABtDUs9ffeTdfUvFkiAyCvG0A==
X-Google-Smtp-Source: ABdhPJyiS+KNBRI3C8ryizI2zQv/To0znPNYuAakl7DG82X4EjBVXi7pNBCQhfq0oVkdGuvKoOFGzw==
X-Received: by 2002:a17:906:9b93:b0:6da:6388:dc57 with SMTP id dd19-20020a1709069b9300b006da6388dc57mr4002977ejc.338.1651329656122;
        Sat, 30 Apr 2022 07:40:56 -0700 (PDT)
Received: from [192.168.0.180] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qs24-20020a170906459800b006f3ef214e19sm1682904ejc.127.2022.04.30.07.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 07:40:55 -0700 (PDT)
Message-ID: <fec305d1-d4b3-3f9d-bc31-bc33490d1ad7@linaro.org>
Date:   Sat, 30 Apr 2022 16:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220430060125.9124-1-ansuelsmth@gmail.com>
 <20220430060125.9124-4-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220430060125.9124-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2022 08:01, Ansuel Smith wrote:
> Convert kpss-gcc driver Documentation to yaml.
> Add #clock-cells additional binding to required bindings and example
> as it's a required binding for clock-output-names.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>


(...)

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,kpss-gcc-ipq8064
> +          - qcom,kpss-gcc-apq8064
> +          - qcom,kpss-gcc-msm8974
> +          - qcom,kpss-gcc-msm8960
> +      - const: qcom,kpss-gcc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: phandle to pll8_vote
> +      - description: phandle to pxo_board
> +
> +  clock-names:
> +    items:
> +      - const: pll8_vote
> +      - const: pxo
> +
> +  clock-output-names:
> +    const: acpu_l2_aux

It does not make sense having a constant output name. What is the
meaning this property in such case? The original binding did not enforce it.



Best regards,
Krzysztof
