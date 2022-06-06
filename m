Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0AE53E6C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiFFND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiFFND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:03:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8782036B57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:03:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h19so18771547edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9OxRTMOPQcoWtDJkrs/ws60KmhDcry5eiLie80rsiV0=;
        b=xoxeEc83WssMlenazqEebhL7ESdnn2WRPAKXcSsM1JgAPUMh85wEYEivR3T+D2TVMn
         vj1fhc9ErRY1A4NtIfYOtMrAB1C5/qlXZ7VyDuT1ERDuuE/Hhzu59eyNRZbQ5QXZaioB
         F70Uqz3Ej8KAxIrj1b6NXy9gOvDixOvxzV8X2hU1GGg385WBeT5ldpcakEZMrGwOF2Ya
         JlfE98zdHlnEMyvEJUDWxNrMtR8Wv1uto71QAHC6Zqh33wcrl888XzOy/YtuMZxevRWt
         OEF81cX4qBKpiEP6mkMx9ixt3bxEMKGWD7je8bHkKHUM3lUTBXGzJLDdUv11zR9MOrDU
         0DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9OxRTMOPQcoWtDJkrs/ws60KmhDcry5eiLie80rsiV0=;
        b=MemTkFpl6SZtVfeSbGnztqL2VEIzkwImGDMRNK1P+tffCvNt56AjvP/SYZyh+Dxzai
         KQJu8GEazJqfYEimh+0CTycPyYtP4DG5ARnLf9sND7u5gfdO23k9NYrzr7FGOYx9qqe+
         3rtUmVk8Kx/ldJjf0VkqgGlIENcBUeZyaYVeyDX3XS+zOLYdQzjQPljpFcDducSKxoEP
         TQDkhOZLIHPl8LbNgaWtEaA/o13aRUpUU7cm9knYuo6qd+H2SWtV7LxkL1WUVOVYRJvZ
         +d1gmJ4OlP4KaxWPgaBs6S2CNWpRGimUhXhWnLUldr4STHZra5xW6a0Cc/gh4O4dmA4L
         WeVw==
X-Gm-Message-State: AOAM530UULNi9WYaYW4hP2jZtUSSHBH2p2QPN1MlPz5tIoCU+/BrzzEX
        agQf+3CXG/kpXPMcTXauZAg7/Q==
X-Google-Smtp-Source: ABdhPJyIJ0g5jgaKC+UYSyfG1jno/pBLV87i2zkT42j9LvLZ9rhebxwHb50RHOMeIEFNkou/TJJ7zQ==
X-Received: by 2002:a05:6402:438a:b0:42e:985:4944 with SMTP id o10-20020a056402438a00b0042e09854944mr25827674edc.283.1654520600280;
        Mon, 06 Jun 2022 06:03:20 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906071800b006feed200464sm6356249ejb.131.2022.06.06.06.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 06:03:19 -0700 (PDT)
Message-ID: <1764f3ce-608f-e55c-d977-18fb95e4a0fe@linaro.org>
Date:   Mon, 6 Jun 2022 15:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible
 string for lan966x
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, UNGLinuxDriver@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220603121802.30320-1-kavyasree.kotagiri@microchip.com>
 <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603121802.30320-3-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 14:18, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1 in
> flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  .../bindings/mfd/atmel,flexcom.yaml           | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> index 221bd840b49e..6050482ad8ef 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> @@ -16,7 +16,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: atmel,sama5d2-flexcom
> +    enum:
> +      - atmel,sama5d2-flexcom
> +      - microchip,lan966x-flexcom

Your new v1 is here worse than old v2, where this was just simple
extension of existing enum. Why did you change it?


Best regards,
Krzysztof
