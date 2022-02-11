Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C914B26E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350494AbiBKNNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:13:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350485AbiBKNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:13:06 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA03E9A;
        Fri, 11 Feb 2022 05:13:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p15so22816805ejc.7;
        Fri, 11 Feb 2022 05:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5K0CikJXBqops03xFbHcLxJj6g75cZR54I23Dc+2jY0=;
        b=l8s74E1JJ3QZ6OYNOUN3fl/zyCp+rXEY5LJqIBBwUe/PCJs4g4aONzuIsljlm9HKRU
         nBbK9Nj/d0E+UoZTXZnSwJtKATSbLtnjlstFIlNsPBvWucyC/x/t7q2ERfCkOH5RcXl6
         QuN8WIS5n7EAyXV1JNdHQ5RHy0TEQK3QtunwPHjxIyyvlh1qAprfdnInacIh0uTdUegR
         QyacjWSvJZUFQ8qP5NnwP+KykSQvjo04F9xg9LSgKBy4u9uQFXa/D+jGtBkAwakUvuEI
         hY7nNZFmG7VfhUG2S2YUkIrakopXGJIyDvW1PEGPHJ/6IgBTuhjmwy8cKD0Ja0NcIFiG
         xC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5K0CikJXBqops03xFbHcLxJj6g75cZR54I23Dc+2jY0=;
        b=xuM0We3zhcUjTn6omWqd8533fxkprFri1xWtgOhqf6kZv9NRQHHCWre4CSzlH1Ml9V
         jbPVXovhowWtfmq9WYYl0IUSGSMFizwSbNROcHna35NE7i/eq5rqjBoxup4FIaxP0ueE
         JGFdzKF4ul0hm+Vnt7me/sxeO2r2Fycry62f9ZVSJ5pfqZiaeSo36KL0XtH6wiDtufKB
         Yq8wJoncDXbXmjfPz7pqX5mzOauZscRsinmSkdgS65whw8eT9Z6lNxoHUmfURQFdVgEw
         bxIEzIbbwWD66y0tv0V5FSrbMMi+8FA4okkZZxgKO9dYlugU+Lhns60124DSn0mi20bq
         Lf9A==
X-Gm-Message-State: AOAM533bxCYUaz+xxJTuDjk2893HdNvKg2DfglwUu+XXC1gEWuWAsk7/
        JYuBh+8ERKOWust1qPZCxdw=
X-Google-Smtp-Source: ABdhPJx2LUop1nYKtP4tB1ZVYUG0AibVEEV+9xZq++OZ26qZlReGU5qNcffLxXyYbNm/B/IcNi4RRw==
X-Received: by 2002:a17:907:6e91:: with SMTP id sh17mr1363464ejc.534.1644585181608;
        Fri, 11 Feb 2022 05:13:01 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id gt10sm4483811ejb.38.2022.02.11.05.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 05:13:01 -0800 (PST)
Message-ID: <dba5684a-1e5f-a4d4-604b-651751636cf3@gmail.com>
Date:   Fri, 11 Feb 2022 14:13:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220211115925.3382735-1-clabbe@baylibre.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220211115925.3382735-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/22 12:59, Corentin Labbe wrote:
> Convert rockchip-crypto to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixed example
> - renamed to a new name
> - fixed some maxItems
> 
> Change since v2:
> - Fixed maintainers section
> 
>  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  2 files changed, 66 insertions(+), 28 deletions(-)

>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt

There's more possible to this document:

dt-bindings: crypto: rockchip: add support for px30
https://github.com/rockchip-linux/kernel/commit/3655df1bc6114bda2a6417f39772a3cb008084ea

crypto: rockchip - add px30 crypto aes/des support
https://github.com/rockchip-linux/kernel/commit/ee082ae4f609f3b48f768420b31d8600448bd35a

> 
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> new file mode 100644
> index 000000000000..2e1e9fa711c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Electronics And Security Accelerator
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3288-crypto
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock data
> +      - description: clock data
> +      - description: clock crypto accelerator
> +      - description: clock dma
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: sclk
> +      - const: apb_pclk
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: crypto-rst
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/rk3288-cru.h>
> +    crypto@ff8a0000 {
> +      compatible = "rockchip,rk3288-crypto";
> +      reg = <0xff8a0000 0x4000>;
> +      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> +               <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> +      clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> +      resets = <&cru SRST_CRYPTO>;
> +      reset-names = "crypto-rst";
> +    };
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> deleted file mode 100644
> index 5e2ba385b8c9..000000000000
> --- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Rockchip Electronics And Security Accelerator
> -
> -Required properties:
> -- compatible: Should be "rockchip,rk3288-crypto"
> -- reg: Base physical address of the engine and length of memory mapped
> -       region
> -- interrupts: Interrupt number
> -- clocks: Reference to the clocks about crypto
> -- clock-names: "aclk" used to clock data
> -	       "hclk" used to clock data
> -	       "sclk" used to clock crypto accelerator
> -	       "apb_pclk" used to clock dma
> -- resets: Must contain an entry for each entry in reset-names.
> -	  See ../reset/reset.txt for details.
> -- reset-names: Must include the name "crypto-rst".
> -
> -Examples:
> -
> -	crypto: cypto-controller@ff8a0000 {
> -		compatible = "rockchip,rk3288-crypto";
> -		reg = <0xff8a0000 0x4000>;
> -		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> -			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> -		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> -		resets = <&cru SRST_CRYPTO>;
> -		reset-names = "crypto-rst";
> -	};
