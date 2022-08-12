Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691A590FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiHLKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiHLKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:49:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12FA59B3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:49:26 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z6so815097lfu.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UJnFvf2CipkkOM+lYgM36L0ZtmP7Hx57QaN536b3YCw=;
        b=GOKMFNg1REVIwFrExYqDnxeUxvmN6E6p1tHUohNkXRce3yIDW9omFNKeKDn50YdSj7
         jR+iLaL7K7o1v1j+HwmvXdLnGwH/Z4n7sra00irgT2f7Wk4Bv28PT1fqBGO0XV2WQSRH
         FtIqjm63bbe8hZEAVGKm+hELlLOmxMqxInFpYj27Ap1mRoWRDVEvzIbAM9fCd8njNmYw
         ZLy1OQXmqj9WtiJM2UEdbgb+9QJJGrhPewkdoh7QsIclb1Ip0jSPzjdZ7z3fSmGF4Aq1
         syIo5izG7Mk7/uh40LPecqsMusRl25/M2WVcFcl+iVulYvxUi9jx4q5FEjRLv/M8fs0G
         Z5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UJnFvf2CipkkOM+lYgM36L0ZtmP7Hx57QaN536b3YCw=;
        b=M1JlbioH3VINeGkLNIGFv0cwDMtpzAM1W8VJMoeI9xxcEHHfUXLCHZMlfyofq77qTw
         fUNJqgdPGp9Oh4Oj5gpO0HkaiKiIt8CD2emzqlrhd6cfM/ftruRi/+y2BHElByzB8Ksg
         3Y0lDuty0JseVK/4S9QKFeNRp7YD1fIE/cq/c7uztesS2WG7jiwVRvKxqEpigaGbTEdT
         VCJg+hsvX7GhgbJ9Z9h0ts/o+w/jgKd7DcfGQ2Qry/QK3YmZpcjOWXpTZxqHDPisO/0O
         Aw15x+pjdv3Mx2d5Je2p5YDQHCmH6PoLmJEabbeshtvIK72dlvDMzS+05dCkUf2RNHkd
         twKw==
X-Gm-Message-State: ACgBeo312rLA2aBToNoJP4BlnzijXMpa2uu5lQZu8rN5MpceOJhZDegK
        yYK/iat9qPY8lA+ReKQptrTQFg==
X-Google-Smtp-Source: AA6agR5b1udKMfU6HMSFMRaqG2/gb4fi6eYQzjti5Wtvya5ucwIJC/D1/rchFHsRLMSOw7dMOtSjPw==
X-Received: by 2002:ac2:5cc6:0:b0:48a:f879:f6ef with SMTP id f6-20020ac25cc6000000b0048af879f6efmr1018055lfq.347.1660301364948;
        Fri, 12 Aug 2022 03:49:24 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id p8-20020ac24ec8000000b0048b29b13d22sm166371lfr.299.2022.08.12.03.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:49:24 -0700 (PDT)
Message-ID: <13fcaa01-d2c0-e57f-bedc-b2e0536a55f9@linaro.org>
Date:   Fri, 12 Aug 2022 13:49:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] dt-bindings: display: sun6i-dsi: Add the A100 variant
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220812074257.58254-1-samuel@sholland.org>
 <20220812074257.58254-3-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812074257.58254-3-samuel@sholland.org>
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

On 12/08/2022 10:42, Samuel Holland wrote:
> The "40nm" MIPI DSI controller found in the A100 and D1 SoCs has the
> same register layout as previous SoC integrations. However, its module
> clock now comes from the TCON, which means it no longer runs at a fixed
> rate, so this needs to be distinguished in the driver.
> 
> The controller also now uses pins on Port D instead of dedicated pins,
> so it drops the separate power domain.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> Removal of the vcc-dsi-supply is maybe a bit questionable. Since there
> is no "VCC-DSI" pin anymore, it's not obvious which pin actually does
> power the DSI controller/PHY. Possibly power comes from VCC-PD or VCC-IO
> or VCC-LVDS. So far, all boards have all of these as always-on supplies,
> so it is hard to test.
> 
>  .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> index ae55ef3fb1fe..c53c25b87bd4 100644
> --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> @@ -12,9 +12,14 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - allwinner,sun6i-a31-mipi-dsi
> -      - allwinner,sun50i-a64-mipi-dsi
> +    oneOf:
> +      - enum:
> +          - allwinner,sun6i-a31-mipi-dsi
> +          - allwinner,sun50i-a64-mipi-dsi
> +          - allwinner,sun50i-a100-mipi-dsi

While you are moving code, how about bringing alphabetical order?

> +      - items:
> +          - const: allwinner,sun20i-d1-mipi-dsi
> +          - const: allwinner,sun50i-a100-mipi-dsi
>  
>    reg:
>      maxItems: 1
> @@ -59,7 +64,6 @@ required:
>    - phys
>    - phy-names
>    - resets
> -  - vcc-dsi-supply
>    - port
>  
>  allOf:
> @@ -68,7 +72,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: allwinner,sun6i-a31-mipi-dsi
> +            enum:
> +              - allwinner,sun6i-a31-mipi-dsi
> +              - allwinner,sun50i-a100-mipi-dsi

Here as well

>  
>      then:
>        properties:
> @@ -83,6 +89,18 @@ allOf:
>          clocks:
>            maxItems: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - allwinner,sun6i-a31-mipi-dsi
> +              - allwinner,sun50i-a64-mipi-dsi

and here


Best regards,
Krzysztof
