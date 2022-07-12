Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984B5727A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiGLUsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiGLUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:48:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707B4D15A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:48:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u15so357188lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T3rJsbQfsC4pWsZ0OeZCZ/yUBmCsy051ZUHKGlMrphY=;
        b=gpV3sjqDMu2bTNevWRp7/qYwFKCnI4WatOzRkblLbcMX8pl0rrbzSwmGVw6Wm65cFm
         8LMvu9ZJleVcrmp1GK2glONYa8z0rJc1n+HG808Kv1derUqS4QQ2mWpqoBhNUVmFrk34
         HT8x2S/i8oJpuVsjvmY3eSOJ1pIaXw/UtO+HK+XjASq6scIQq1pvI4v7jb0H11+QQb3B
         gghLBYITq4QyZCMhRA7LHmWbw+nVDV3nQjyL1x1iJQNtsa8Y45UvDsCJXr/LH3VfYuTX
         KETPUuj+miGHLk0UhAKpuCuh5kG5KAnpyQxeosj6M9E6gLsYaDszPwVeta6ObBLSiw9H
         U9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T3rJsbQfsC4pWsZ0OeZCZ/yUBmCsy051ZUHKGlMrphY=;
        b=ZsjUtZQo5s1j8N4GY0bDyxDoTj9KwndXgw3Siq5T5wy+f7t8x/rGCb/uAqvdJPHTSq
         DLYwFP5eO7A9qUG2601CX6Wzq1U65dG6jxBq1bVQTXiiS7IIDMJsocJBpQLNUD+fTOmt
         GKWAe9ZGaOSD44OOB0YwjR7ZUwz0uuv8JzgcMj1F3S0LQ8XaH18DkwQbJj+MgLR1y/Iz
         5CIi43EfVcmteQJcCTbVeqdrHmymunxk0bybumXNvyDxs5SID/OEGNG5loN0TQ4X+uDE
         SQwnZCCGoBOExR1uK9HIofptR7jXIvQYJKA94Ua9Tuh1WEOo4uCxJZy59TGrEGceBPsF
         Nu4A==
X-Gm-Message-State: AJIora8fuEB4BToROMUuOWZzo0KXbZPAxH2t6B76VZq5HeMajp9XWRpo
        In9QA63FCPPNzfzqQerrqR2ySKPtXCsfEGFT
X-Google-Smtp-Source: AGRyM1t5qMhpWpDxR+S01a3b5CFaHgIqWdr5TGwOhHmkVou4JLhSQxAM26Z1QE1BqKfH6t8kbBkK/w==
X-Received: by 2002:a2e:a264:0:b0:25d:63ce:29ed with SMTP id k4-20020a2ea264000000b0025d63ce29edmr9891262ljm.32.1657658881171;
        Tue, 12 Jul 2022 13:48:01 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e90d7000000b0025bf4eddbb6sm2673014ljg.133.2022.07.12.13.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:48:00 -0700 (PDT)
Message-ID: <68b8da6a-03e2-9da7-795d-f028bc0ed05b@linaro.org>
Date:   Tue, 12 Jul 2022 22:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Sony Tama TD4353 JDI
 display panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712200244.960018-1-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712200244.960018-1-konrad.dybcio@somainline.org>
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

On 12/07/2022 22:02, Konrad Dybcio wrote:
> Add bindings for the display panel used on some Sony Xperia XZ2 and XZ2
> Compact smartphones.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../display/panel/sony,td4353-jdi.yaml        | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
> new file mode 100644
> index 000000000000..d75abc72ad1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sony,td4353-jdi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony TD4353 JDI 5 / 5.7" 2160x1080 MIPI-DSI Panel
> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@somainline.org>
> +
> +description: |
> +  The Sony TD4353 JDI is a 5 (XZ2c) / 5.7 (XZ2) inch 2160x1080
> +  MIPI-DSI panel, used in Xperia XZ2 and XZ2 Compact smartphones.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sony,td4353-jdi-akari
> +      - sony,td4353-jdi-apollo

Shouldn't the properties of panel like width and height be specified by
dedicated properties, instead of customizing compatible? The device is
"td4353-jdi", the same in both cases, isn't it?

> +
> +  reg: true
> +
> +  backlight: true
> +
> +  vddio-supply:
> +    description: VDDIO 1.8V supply
> +
> +  vsp-supply:
> +    description: Positive 5.5V supply
> +
> +  vsn-supply:
> +    description: Negative 5.5V supply
> +
> +  preset-gpios:
> +    description: Display panel reset pin
> +
> +  treset-gpios:
> +    description: Touch panel reset pin
> +
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply
> +  - vsp-supply
> +  - vsn-supply
> +  - preset-gpios
> +  - treset-gpios
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel: panel@0 {
> +            compatible = "sony,td4353-jdi-akari";
> +            reg = <0>;
> +
> +            backlight = <&pmi8998_wled>;
> +            vddio-supply = <&vreg_l14a_1p8>;
> +            vsp-supply = <&lab>;
> +            vsn-supply = <&ibb>;
> +            preset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +            treset-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                    panel_in: endpoint {

Inconsistent indentation.

> +                            remote-endpoint = <&dsi0_out>;
> +                    };
> +            };
> +        };
> +    };
> +...


Best regards,
Krzysztof
