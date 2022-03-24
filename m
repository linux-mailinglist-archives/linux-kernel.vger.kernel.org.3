Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46754E689E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352628AbiCXS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCXS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:26:29 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA416A7764;
        Thu, 24 Mar 2022 11:24:56 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id i64-20020a1c3b43000000b0038ce25c870dso307053wma.1;
        Thu, 24 Mar 2022 11:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OSMRMGJIbC2C7MmSEVIz7xmNnY44imVmj50ReOAokX8=;
        b=cNxTnFSY0z4/r7En30CYp5cOiHFTVbgaXrJUZ3iJjnXjJPIC576JjEud1IVQNHxFP7
         5FKH7lk62OI35PP3O/G9Z1OOaDqvt773/3ybj5YYCaC4Wy6FFMfgF1mni8LWehnP8kkP
         LqnTZ+6vs1LFiTaQAx/DFNIpVXyBIsN0VhKDKEyWkZN6JVQlGotMNekqsfK1N4p1dHlS
         jT99Lu0GdBJvahlk9OzVtR+kEyTeK0gw+CJyIQnSbALGd9vJxTwbiXEuIyiQl7WRyi6Y
         4zjlcKNqslIFqgg4JBa5zfUdM6KS4M565fkihWNPjFtYZnKCjBxryiwRbd4/WlOZJ5Gb
         O5lg==
X-Gm-Message-State: AOAM5302Dg0EiGSwYamyNdq1gGsZ0aWSPHtNQe1nJlat3bqK9KQQJxya
        nMhYyKAff7BAndjFZSwo408=
X-Google-Smtp-Source: ABdhPJw/rF4r9nj7mbhYkVwCX7Am9nyFPeXI9rzmEK5DHmc29JhjK+K5TqRBneG0OxI0IImKNt+b6Q==
X-Received: by 2002:a1c:4e18:0:b0:38c:bd8d:6bd9 with SMTP id g24-20020a1c4e18000000b0038cbd8d6bd9mr5945883wmh.94.1648146295269;
        Thu, 24 Mar 2022 11:24:55 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id l13-20020adfbd8d000000b002040daf5dffsm4763014wrh.18.2022.03.24.11.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:24:54 -0700 (PDT)
Message-ID: <622e5de3-12b3-0f5f-1c1b-6e062c39a626@kernel.org>
Date:   Thu, 24 Mar 2022 19:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: mtd: ti,elm: Convert to yaml
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220323111851.4699-1-rogerq@kernel.org>
 <20220323111851.4699-2-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220323111851.4699-2-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 12:18, Roger Quadros wrote:
> Convert elm.txt to ti,elm.yaml.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/elm.txt | 16 -------
>  .../devicetree/bindings/mtd/ti,elm.yaml       | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/elm.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,elm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/elm.txt b/Documentation/devicetree/bindings/mtd/elm.txt
> deleted file mode 100644
> index 59ddc61c1076..000000000000
> --- a/Documentation/devicetree/bindings/mtd/elm.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -Error location module
> -
> -Required properties:
> -- compatible: Must be "ti,am3352-elm"
> -- reg: physical base address and size of the registers map.
> -- interrupts: Interrupt number for the elm.
> -
> -Optional properties:
> -- ti,hwmods: Name of the hwmod associated to the elm
> -
> -Example:
> -elm: elm@0 {
> -	compatible = "ti,am3352-elm";
> -	reg = <0x48080000 0x2000>;
> -	interrupts = <4>;
> -};
> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> new file mode 100644
> index 000000000000..24ed0fb84204
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/ti,elm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Error Location Module (ELM).
> +
> +maintainers:
> +  - Roger Quadros <rogerq@kernel.org>
> +
> +description:
> +  ELM module is used together with GPMC and NAND Flash to detect
> +  errors and the location of the error based on BCH algorithms
> +  so they can be corrected if possible.
> +
> +properties:
> +  compatible:
> +    items:

No items, just const.

> +      - const: ti,am3352-elm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,hwmods:
> +    description:
> +      Name of the HWMOD associated with ELM. This is for legacy
> +      platforms only.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    deprecated: true

It was not deprecated before. Could you explain it in commit msg because
it is not a conversion only.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    elm: elm@0 {

This is error correction, right? So generic node name "ecc"?

> +        compatible = "ti,am3352-elm";
> +        reg = <0x0 0x2000>;
> +        interrupts = <4>;
> +    };


Best regards,
Krzysztof
