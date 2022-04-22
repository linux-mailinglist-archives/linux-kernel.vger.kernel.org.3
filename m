Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80150BE09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiDVRM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiDVRMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB2F91355
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:09:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so17616147ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=poB9ks1liIRkNngIEosjFHVtuthCvp7bjTuPa7y3tD4=;
        b=ar9FVBqErpZGuzA8BkqsOWd+REzkut2Q45zH1nrUysn4agClJWjSbojgs0BjIkwYVk
         WysqyM1wSO/xcTFUx+VSHFZyd3w0XurgxFtMiSraKahI6oK4BMy2xCZTIzhExrWSg/d7
         JXAGNCrEv183BmDa48/eN3WMkSkZzZgMi0APGI9ICfG3u/HIx33Q/AIWmBvTBQ5Ztu+6
         EaUvlXJcnoDKQDgsbV2NTii0gre7MJDBvM9V8iLrP7egX7MbzDvgDF2Cs5oQZzDxjPTs
         RcGDpp6J63mniLFo8yzmYSBptbm26o89bOOYoqn+o1NgR4aYLVHB2tQg45+30DdJLWVt
         WylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=poB9ks1liIRkNngIEosjFHVtuthCvp7bjTuPa7y3tD4=;
        b=RMbWbEQkaV9rdWPCH9m/8GhxF0rMTBGt5PAMG2BkD9aT0qXr1wxH0OOT8ejFzVXx1u
         JRgen1dLcOt7AmRgrvkk29DK9HWRelxeQTAxxH1vXFi2vP7RrS5cr45yWh3ydL4tMVuQ
         liTVkji5DfBKsjYFeAQhgo7dwz817nhEN7sGnXFhO3BkTU0/1hnK+nD/ZB9cYVgAXErS
         v0gzSdHvvjf6r6TRwSqVX3zKt+rETE4aQUJqmDSloDpDZQD+We208ifQ0kUwHVqefQkS
         20U+FVKzWIben8FjMleqVi6akQQlypkiV9ycBG+fv4JvRWrkkxJaC9OJL7hbdvwap5BJ
         ciCg==
X-Gm-Message-State: AOAM530w9auvU2kJKXhnbWfV7Zyb32XgnwiNBCMotS5sENC0nwAVjKnS
        wgEQb6y+0tCV0zTZckQKro8gxg==
X-Google-Smtp-Source: ABdhPJySiVqeO8iQsRx/KiMnpyPGn60n4tndx+nA3COi8jm0ZCtBj53MhuRBv87YONHlvUgNO+xy3Q==
X-Received: by 2002:a17:906:a147:b0:6e8:46a4:25a9 with SMTP id bu7-20020a170906a14700b006e846a425a9mr4918442ejb.213.1650647360845;
        Fri, 22 Apr 2022 10:09:20 -0700 (PDT)
Received: from [192.168.0.233] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ah13-20020a1709069acd00b006e8a0b3e071sm926279ejc.110.2022.04.22.10.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:09:20 -0700 (PDT)
Message-ID: <5927a77f-a876-eddc-09a1-b3a336e7d35c@linaro.org>
Date:   Fri, 22 Apr 2022 19:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: stm32: Add compatible strings
 for Protonic T1L boards
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220422071034.2882199-1-o.rempel@pengutronix.de>
 <20220422071034.2882199-2-o.rempel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422071034.2882199-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 09:10, Oleksij Rempel wrote:
> This boards are based on STM32MP151AAD3 and use 10BaseT1L for
> communication.
> 
> - PRTT1C - 10BaseT1L switch
> - PRTT1S - 10BaseT1L CO2 sensor board
> - PRTT1A - 10BaseT1L multi functional controller
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index fa0a1b84122e..9628383a4779 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -78,6 +78,12 @@ properties:
>            - const: st,stm32mp157c-ev1
>            - const: st,stm32mp157c-ed1
>            - const: st,stm32mp157
> +      - items:
> +          - enum:
> +              - prt,prtt1a   # Protonic PRTT1A
> +              - prt,prtt1c   # Protonic PRTT1C
> +              - prt,prtt1s   # Protonic PRTT1S
> +          - const: st,stm32mp151

The entries look a bit unordered, maybe you could put it somewhere
ordered by st compatible?


Best regards,
Krzysztof
