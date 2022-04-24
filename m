Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D07950D26C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiDXOyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbiDXOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:54:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FF537AA0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:51:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w16so3816557ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jlt+fA+vOeb8IM3V8yMFQW99adzhPmpEhEfI7X3D0o8=;
        b=xeLzYyAxGEKZXJVZR8n/Z+L0TleSlbbCDYMIsekFHrLJJXhoc16KCrNshrqD7h+So7
         YJVCAjNJp/d3ON+3+w27WiDSyKh0Oiu0bkNnoc6V9NA+E9b5k0nCMBlz3BrMfsf7q6Kg
         ivH0w4+gfkiGJjyswvkGlbA9zr7I6sPSm3UHTKNHDZdlbGGTp7Nk0yPHqhLTd1ZHLI5O
         sJgsBZBbxMSuteX90eXV3OBk944DMYJmqoH8qjaIxWHiSPWf7os5eN371ckv9POny5An
         cSoJEDhre2uHahuJa4QizcOI3xbX7/d70Y4MqgVciQ8xR/uN2kCzAeb6IK8MpwXK0w6U
         GxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jlt+fA+vOeb8IM3V8yMFQW99adzhPmpEhEfI7X3D0o8=;
        b=NZhz8Bi+V0mMLcQQ+9YxYoRXP3o8lHD+xlpzKxYRfjjFO3gQcYD+8JPPF1RiRHPwpb
         EJFmmmvJRJuWDepHrWQl8ZdHA13/JNmSWv1zEmhr0lElJmsWC96fRpshRKmmzZbgA5HP
         atz2iIVwu0q/UeGosW88og+E2QsByo/EHHP2a+rKs1J6kBRWPcfDfwATZ/ov9uDVXh2b
         zBHLfaHP4U3QuftrXHV5zy0j8LMSX1B5hY9f7+XjKmns8AN70HHSWtqn+pkXT/isUQtR
         unSJ5+UtmHSL+8whvztyeLQuutaO1a/wdCFTrqFHLCaecDb/nAc6G5jn+3rIZ1LJ0F/Y
         NDFg==
X-Gm-Message-State: AOAM532ja9hqD9pgj3OrleSXaFNiBVM8HZivZFAPupN0uEOOQSXnyxyR
        rQjpWogkK0q0HP0wE6MlIO59Fw==
X-Google-Smtp-Source: ABdhPJwVoYu3IEZHp02b1FMVj/R5bCFc9eYx5xl8CAE+uM+mYpF2alIbWgr36wrbYUlSz8v9RQqtdg==
X-Received: by 2002:a17:906:2709:b0:6f0:13d5:d58f with SMTP id z9-20020a170906270900b006f013d5d58fmr12392721ejc.443.1650811868117;
        Sun, 24 Apr 2022 07:51:08 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mp8-20020a1709071b0800b006efc915e1ccsm2659478ejc.118.2022.04.24.07.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 07:51:07 -0700 (PDT)
Message-ID: <66e03e68-3a73-1b2e-0694-cba5b072d8e6@linaro.org>
Date:   Sun, 24 Apr 2022 16:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/1] dt-bindings: timer: mediatek: Convert binding to YAML
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220422131317.25410-1-allen-kh.cheng@mediatek.com>
 <20220422131317.25410-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422131317.25410-2-allen-kh.cheng@mediatek.com>
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

On 22/04/2022 15:13, Allen-KH Cheng wrote:

You should also fix the DTSes to match the new schema.

> +$id: http://devicetree.org/schemas/timer/mediatek,mtk-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SoCs timers bindings
> +
> +description:
> +  MediaTek SoCs have two different timers on different platforms,
> +  - GPT (General Purpose Timer)
> +  - SYST (System Timer)
> +
> +maintainers:
> +  - Fengquan Chen <fengquan.chen@mediatek.com>
> +  - Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> +
> +properties:
> +  $nodename:
> +    pattern: '^timer@[a-f0-9]+$'
> +
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt6577-timer
> +      - const: mediatek,mt6765-timer

These two entries should be an enum.

> +      - items:
> +          - enum:
> +              - mediatek,mt2701-timer
> +              - mediatek,mt6580-timer
> +              - mediatek,mt6582-timer
> +              - mediatek,mt6589-timer
> +              - mediatek,mt7623-timer
> +              - mediatek,mt8127-timer
> +              - mediatek,mt8135-timer
> +              - mediatek,mt8173-timer
> +              - mediatek,mt8516-timer
> +          - const: mediatek,mt6577-timer
> +      - items:
> +          - enum:
> +              - mediatek,mt7629-timer
> +              - mediatek,mt8183-timer
> +              - mediatek,mt8186-timer
> +              - mediatek,mt8192-timer
> +              - mediatek,mt8195-timer
> +          - const: mediatek,mt6765-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: clk13m
> +      - const: bus

When is the bus clock optional?

> +
> +required:
> +  - compatible
> +  - reg

clocks are required in the old bindings

> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@10008000 {
> +        compatible = "mediatek,mt6577-timer";
> +        reg = <0xd4014000 0x100>;

reg does not match unit address.


> +        interrupts = <13>;
> +        clocks = <&coreclk 2>;
> +    };
> +
> +...


Best regards,
Krzysztof
