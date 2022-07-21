Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD24857C4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGUGqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiGUGqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:46:23 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A053D5E827
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:46:21 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id z13so300524ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6ebqScyVCL5xtjaYG+MWDobiZU7shkrkf2/xCeYnqTo=;
        b=cnNPNF6p5XEVyBPgnDIoPk2a55l5wVTjYAGOx9lKKj+nLyGm/ggYZMxUHnMR8u+QcT
         1N61AswMKoA1NNRB/BvUZ/k5WXPko0h8u6ojHSM51BHJXeQTiJkSH41em82J3CPZUzCc
         5AQJK6GpA9EAUTZRDsYOmpM1o6bvpE2MZrXHLObG57mLY6yPmpZyItDJb5XbCKcXFnhD
         IWwoAe9TvwIjeCUSX8519cufzESYT6aLzhRkFRFEzmpwk7RODzxaM8Fwqw8EE3I9aJ2v
         8rzGknfknGjRPNpY7Jn927hi1IU1vsbcFeuvrPNRluErWnMzPHZcOxodjBIFR1P0LtL0
         EYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ebqScyVCL5xtjaYG+MWDobiZU7shkrkf2/xCeYnqTo=;
        b=V8Oa2wCRPYGNyEcwhPPVbb2nk9NSeZ4n+NyckyNiKdwFtpIJM7+qCUj1GZhxdoT91R
         Bbv6MYolqR8swiIOM2knkOOFXW8CeB1I5rFpvOuJr3dcnHBNeg32b4UnLcyXrbLPBke+
         y3pxEHYki6kW7zu8T/VZ+DhxJ21sRYGwyuzm/t5en09+IZEWmJJQP8/nilGQec80Ez2T
         L5FNrPl3Vh2CRjQPjaINIlreEFIrFtTwgxcO/d3duLqYcM2xUH2YXHPSY7uJVrP5mpgL
         CjK4IKl+DZqZ5wQtmpO0jbgxFxsbfyOiWHh/iCk2Dd9kY0mB2oejfOw7yAmLkipaeCKI
         FiWA==
X-Gm-Message-State: AJIora+5MxH4KD8F7lulFK76KNjpzfXHkgfN8HHGEyrSG8op1XGTGRZL
        7tlVOSYBYtHyrrZ9zPlqDVJRjA==
X-Google-Smtp-Source: AGRyM1sYM/moheTL9vxo8wPQwgwFru+XwB8ZKQ7WV6dGO46MCFpk7mzsGMi5V3SSFRP0Dify8FztGQ==
X-Received: by 2002:a2e:8705:0:b0:25d:da25:e7c2 with SMTP id m5-20020a2e8705000000b0025dda25e7c2mr1491219lji.139.1658385980013;
        Wed, 20 Jul 2022 23:46:20 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id k3-20020ac257c3000000b00478de10cf5esm239195lfo.247.2022.07.20.23.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 23:46:19 -0700 (PDT)
Message-ID: <d66aae55-1615-1bbc-4f56-2b4806635db4@linaro.org>
Date:   Thu, 21 Jul 2022 08:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: at91: add lan966 pcb8309 board
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
 <20220720194904.2025384-2-horatiu.vultur@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720194904.2025384-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 21:49, Horatiu Vultur wrote:
> Add documentation for Microchip LAN9662 PCB8309.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 4e495e03264b..9dc9ad81193a 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -169,6 +169,12 @@ properties:
>            - const: microchip,lan9662
>            - const: microchip,lan966
>  
> +      - description: Microchip LAN9662 PCB8309 Evaluation Board.
> +        items:
> +          - const: microchip,lan9662-pcb8309

This and other lan9662 boards should be just an enum. You grow the file
needlessly... Unless it is clear preference of maintainer. Other boards
follow normal enum approach, so it seems there is no such preference.


Best regards,
Krzysztof
