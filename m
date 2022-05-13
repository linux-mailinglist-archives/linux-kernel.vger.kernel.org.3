Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53465525E63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378362AbiEMImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378317AbiEMImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:42:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BA5D67C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:41:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z2so14875964ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tUVDTqNL400xGsiM6SBVChaju3wq0r07sdLNoGIileY=;
        b=WFAHY9UNI7E1vBd3x6Z86jcf1HzjVtd/XYYc+xSt/Sb5xx3OzivKjIJUg9EkJzKLOP
         mjLmCid4bAxwpVtuI11sfDYSQjv+oxmfFHbff1xzECA0qYnQucWk7V+DWXMUWAF5QC7h
         B3voEnmjFRtogRduOA0G+ko5e8JqEavsidaaNq4R9Cc+y+dLdErpQLTPu1EMmPrKmVt+
         FjCShUSptK1iDckNe9kXmGj4tU8MaAXPDWAqHJHoD/VYk/GCG5qMRdh0g5BRR+77fi1S
         OMyTgShwMqhAJ9+LadVxtw/MMbGuP66SDSGXvrUZW7BoEQa/0Vq43azzntqrySSwHP27
         lKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tUVDTqNL400xGsiM6SBVChaju3wq0r07sdLNoGIileY=;
        b=Z6zLQspkA3qvFQCgMp6cLUcHSkejImaDEhjCWFmIOy/D1gYMeaXK0t0yVpkkCejaG/
         ySRIOA4rRfOqWvL7p3U/yQSW07AnX2+kiR5s/+VPAuLJ4t7z2j46YtaFkjM0yYkY9oRF
         7/D7z0XkpHmvpKaKl5aNVK1wDI5oR8kisodww4akFS2jkj9wvwD3vW5nLt/OnaNNoLIu
         v8V1PvbG34Y/RPmK7e3XvWs6AQgHP6Hf4UY/6bHlxoTrA278ExmnL/VfzgVg1PJ5niC2
         GTwaX0B4J9yz81lHt5LB19ayI8L6QIY9vrny6Z/vGiAv/glDm9gZDyR0VW1Edv/PObou
         AJXg==
X-Gm-Message-State: AOAM530Fak2De6IFwAUqc7Y4G57ROZP6XNczUMUBEs1hiiX88dDLe0RK
        hWoSalkJ52WLOvfGmGixOgFHBA==
X-Google-Smtp-Source: ABdhPJx+W4ZMdHItFus3RMWPsHPgwrKIJfpsU05rAl3XnL+R7BBhSF/WDxYSGR1is6uuMLW6JooO2A==
X-Received: by 2002:a17:906:3087:b0:6f4:2901:608a with SMTP id 7-20020a170906308700b006f42901608amr3331152ejv.646.1652431318425;
        Fri, 13 May 2022 01:41:58 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e2asm536046ejc.144.2022.05.13.01.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:41:57 -0700 (PDT)
Message-ID: <8895be18-dde8-e2eb-1738-faae8f368db6@linaro.org>
Date:   Fri, 13 May 2022 10:41:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 02/11] dt-bindings: marvell: convert Armada 37xx
 compatibles to YAML
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-2-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:48, Robert Marko wrote:
> Convert the Armada 37xx SoC compatibles to YAML.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---

> -
> - - compatible: must contain "cznic,turris-mox"
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> new file mode 100644
> index 000000000000..4460608ac1e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Armada 37xx Platforms Device Tree Bindings

"Marvell Armada 37xx Platforms"

> +
> +maintainers:
> +  - Robert Marko <robert.marko@sartura.hr>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Armada 3720 SoC
A nit, this should be rather: "Armada 3720 SoC boards"


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
