Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C20523A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344820AbiEKQeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbiEKQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:34:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F69E239D98
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:34:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gh6so5269144ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X1iafU9w9HibEKsV7xZQm5z++dkHC0xXg4frhDarPh8=;
        b=B9Uw9wQQjPnoVHBln/eXPzgTlYXGEZ24QaSAUzzNYCocm/U8kan54zP85xdPM1eZAa
         milg5R9lfno9eKeJnwaQZt9oZ23h6xqEJOxXXHU/U9rQPvqny3eRi/bZ8HvTpDZskv6f
         sjTv+O28qv/u0uEzVOH1PEeJsiGbm5Dl9ntCKo2VxsG5mzvDxo2bJ1stJdtlxYrk/pV7
         7Fq5ueUTuY8Zs/B2NmLACKIAiMPKTq5eFnE+g7rpX8uZGBJaLlCESQThqbdTNmFCX8XP
         RxJ7Yg7UKEL+9eb6dm0G5FYx/WNO4e6QUgP8yGsGJLTQBC6tUShdelq3Q9RnVV9N3h43
         CjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X1iafU9w9HibEKsV7xZQm5z++dkHC0xXg4frhDarPh8=;
        b=EZXf9plq6Scr77YZ0h/jp0AOuusqpDwdR/8OhTqQtZgw9LARCwBmu1HEnZ6kB1yuYM
         pLi4n8dA7zBR1qAbA1VtegGy+ltipj/qSoKu1QzbMxRrVMagkpeK2HWCZnJCggTwd3IT
         AIbFyh4F69+IcFed5JSsSYS6YMpRzUkoKolBCxFcOr6YhQgDTtEIXBkZaIi5pupG/0JB
         4uLvS8+/mjiGhobbu7mWMIdwUhbWRm1qmF26BMPj9JJIFGRL259QEafxGddeZaAtVuLk
         LSXrDRoUl+LMCOdX6FtxL0CpBWHpnndewspTX9jcuF2vI6+Ncy/q0tW4NhCAy6EYbrXU
         VYLA==
X-Gm-Message-State: AOAM533xumqWdiUP7I492NMFJZWW0FahLWKC6i020snK2vmfHU+pm3DH
        zClMn6QUU1SMSGfoWKV+Hn+HuQ==
X-Google-Smtp-Source: ABdhPJzCPDgGc/RsgVEhqtsm8HLW56qr5flZ2YiMoJ2hgzHNSm3o2A11UbEsqX9Z5X9WejdqezUvEA==
X-Received: by 2002:a17:907:1c8e:b0:6f4:e24f:20e0 with SMTP id nb14-20020a1709071c8e00b006f4e24f20e0mr25175564ejc.227.1652286845508;
        Wed, 11 May 2022 09:34:05 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l9-20020aa7c3c9000000b0042617ba6388sm1391453edr.18.2022.05.11.09.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:34:04 -0700 (PDT)
Message-ID: <5c498985-64bb-b8ba-3e77-9cdb36dd1f16@linaro.org>
Date:   Wed, 11 May 2022 18:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Content-Language: en-US
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 01:10, Chris Packham wrote:
> Describe the compatible properties for the Marvell Alleycat5/5X switches
> with integrated CPUs.
> 
> Alleycat5:
> * 98DX2538: 24x1G + 2x10G + 2x10G Stack
> * 98DX2535: 24x1G + 4x1G Stack
> * 98DX2532: 8x1G + 2x10G + 2x1G Stack
> * 98DX2531: 8x1G + 4x1G Stack
> * 98DX2528: 24x1G + 2x10G + 2x10G Stack
> * 98DX2525: 24x1G + 4x1G Stack
> * 98DX2522: 8x1G + 2x10G + 2x1G Stack
> * 98DX2521: 8x1G + 4x1G Stack
> * 98DX2518: 24x1G + 2x10G + 2x10G Stack
> * 98DX2515: 24x1G + 4x1G Stack
> * 98DX2512: 8x1G + 2x10G + 2x1G Stack
> * 98DX2511: 8x1G + 4x1G Stack
> 
> Alleycat5X:
> * 98DX3500: 24x1G + 6x25G
> * 98DX3501: 16x1G + 6x10G
> * 98DX3510: 48x1G + 6x25G
> * 98DX3520: 24x2.5G + 6x25G
> * 98DX3530: 48x2.5G + 6x25G
> * 98DX3540: 12x5G/6x10G + 6x25G
> * 98DX3550: 24x5G/12x10G + 6x25G
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v6:
>     - New
> 
>  .../bindings/arm/marvell/armada-98dx2530.yaml | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml
> new file mode 100644
> index 000000000000..6d9185baf0c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-98dx2530.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/armada-98dx2530.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Alleycat5/5X Platforms
> +
> +maintainers:
> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +
> +      - description: Alleycat5 (98DX25xx)
> +        items:
> +          - const: marvell,ac5

This is confusing and does not look correct. The DTS calls AC5 a SoC and
you cannot have SoC alone. It's unusable without a SoM or board.

> +
> +      - description: Alleycat5X (98DX35xx)
> +        items:
> +          - const: marvell,ac5x
> +          - const: marvell,ac5

This entry looks correct except ac5x once is called a SoC and once a
RD-AC5X board.

It cannot be both. Probably you need third compatible, assuming AC5x is
a flavor of AC5.

items:
 - enum:
     - marvell,rd-ac5x
 - const: marvell,ac5x
 - const: marvell,ac5

> +
> +additionalProperties: true


Best regards,
Krzysztof
