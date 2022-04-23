Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5450C960
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiDWKxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiDWKxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:53:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF4C8A9B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:50:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u15so20761224ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jt7t08XM71PPX5xDtgCOGsTpwspL9tE75jus/MAoHPs=;
        b=oiGi0POJilcBtbNKFabGqepzIv5pT7yhzyyjLcErSA31f46wuqqBvktkCjPkXh7B6a
         W7z02GDMuxTOqE4KtXIc0Y29LuJgN0+WF8oU/Ey0cWRa3gQWrvml7hKb2O50xvUz55RJ
         otapMq3bH+10LO/MQHplcbA6tu087jwYC9Djmli8LEy/xmhM6UL++NM/r7P6J8iu39KB
         /CoTrDNvjphExO15q+wj6stCx8OPv2sOsVyj+OxavdVeiWbCwfUSIeasKjRLoRWoywzM
         Eia39gSF0CFMVhdHVjf8phWl8lTaATTWlwba7gysFc4ImVqcH42mVDPxbqfNMHsB4nVk
         BcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jt7t08XM71PPX5xDtgCOGsTpwspL9tE75jus/MAoHPs=;
        b=nl1K8wokJWlUPfugr4U5lT7RZG/uY83qtLOhfRCbO575nVj0ibKC63ACMHJiSBXvDB
         FRai9uJmV9LkRDjzXIXT7NSGyR7DvQnzVVB+zkAm6FG2M8k4eSDN2a05ke/mBWfv2VoY
         GcT3Rmd/zCBMMvlO0zUJsvHJO9GDijX2RgNW00NmulbyCFtbubYZ+wshClyfFxLm2pGB
         0vhUzC5NjnXnj5h0yAeUFPoa22dXDgMoSrRl3S7OUJf2Hc8wwdlwe7hfX4DJUL/VJ54I
         uyJYTfAW9PjTaL/14i+j2UPwkMwfXsWW5Opv6HMbAOFm1RzW0BdRpKOOqw2sAkqzoOLG
         1FXA==
X-Gm-Message-State: AOAM530Poo0C2p1Ob1tpUvrd7oF0+pjgXmckZ7B9Du50zqzGWpb0p8fa
        KOFEmGTXgwXAnE50QQz7gNh3pw==
X-Google-Smtp-Source: ABdhPJwQ9yuMbQh0RzFC223R05bz86jGS0wl4UTmhWhvIadkKNLf19ZFl6pOwvCie3p+j3xnvWswSA==
X-Received: by 2002:a17:907:c06:b0:6e0:9149:8047 with SMTP id ga6-20020a1709070c0600b006e091498047mr7687864ejc.765.1650711017261;
        Sat, 23 Apr 2022 03:50:17 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s9-20020a056402520900b00425c1e6764fsm1741688edd.9.2022.04.23.03.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:50:16 -0700 (PDT)
Message-ID: <704ffa56-4bae-fc33-fddf-3e3dd8be0db9@linaro.org>
Date:   Sat, 23 Apr 2022 12:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 05/11] dt-bindings: timer: Add HPE GXP Timer Binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
 <20220421192132.109954-6-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220421192132.109954-6-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 21:21, nick.hawkins@hpe.com wrote:
> diff --git a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> new file mode 100644
> index 000000000000..a4572be8d89a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/hpe,gxp-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP TIMER

s/TIMER/Timer/

> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: hpe,gxp-timer
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: iopclk

s/iopclk/iop/

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: true

This has to be false and you need to define the children (since you use
simple-mfd).

> +
> +examples:
> +  - |
> +    timer0: timer@c0000000 {
> +        compatible = "hpe,gxp-timer","simple-mfd";

Missing space after ','.

> +        reg = <0x80 0x16>;
> +        interrupts = <0>;
> +        interrupt-parent = <&vic0>;
> +        clocks = <&iopclk>;
> +        clock-names = "iopclk";
> +    };


Best regards,
Krzysztof
