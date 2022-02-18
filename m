Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1D4BB813
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiBRLaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:30:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiBRLaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:30:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D882AF92E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:29:58 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A7F234025B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645183796;
        bh=5vu8Aw1W8wtoUUoiu3zrUlU5vDSdum5E40oXQSHrvFY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=oyqHD8G5sahpxXlb/GRpyzFsmr5MOliYiV0SlwBgcsuvs85zpZAanqmL/vHc0mZHu
         RLcEotbvxCX7NZln0rqS8Zg06WhDnntkc4N0zIqxzQcVPbFxu1E9s9g8z3t6xv6S6n
         G6wgrP1dMTGggyW7cW1pJM2xX9ZuiqB6LixArR62JlU0pjT7MRZY8+BpWPUglOUt0o
         zI9Fx2e3U98gMHnPUAuLay29j4h7T6nBA+Q+IECHklCDzipiRGljs8XML8u3htSjIN
         M+U63Jceq3jv9Lq7y2YMaGAV1opKfLVej2fkr6lltyg+YhxdhgzPFVgyDdsbJB659x
         qf77MhyluY95w==
Received: by mail-ed1-f70.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so5373081edz.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5vu8Aw1W8wtoUUoiu3zrUlU5vDSdum5E40oXQSHrvFY=;
        b=a1vpYZYXwOn9Sd40TlRnYwIABYnoUcruqJnHvaH56jGQTHQOIKUHi1XzA6mf+aGmal
         z/24Rb6E5AIqg/BrDKOz8q2OSmYJ/VCQ6SBilFWI823HPxsxgL8KMeW/619dmRXWX2sq
         IzOMGPx9/hpPByqdTJwYEbc21wJuB0zzQVP4+yIZbik3t3kkAXuX55IlirYaSLUHt4+N
         KL6wKyPo3Jpw1C/ucoRMtq0pg7z1A7hE9TvQuw7dZTDSUCW/ox6cqlr41i4uGL9MRjci
         Jq4Xj0QikFxh8reei9H6kbdhEYwb05C/vS/4V3R3d4sj7qsAnN+5fVrRK24wmK0V12Gm
         Z9nw==
X-Gm-Message-State: AOAM531YgCiQGP9QD0cdLlSNRcodiwwM/i78bh4Rmsp9scQQa+znecbS
        5Xd5xV/xXYubspwBoSy3kkJA84eokcRSU7i05e6RXL0hSqkHPswrxm1JDH3cmeksVNq8PKuLYgJ
        px8fsXiFjqCsplHJI6imTQLsxIzxwkYVHJufE9V0ieQ==
X-Received: by 2002:a50:d9ce:0:b0:410:f199:56ab with SMTP id x14-20020a50d9ce000000b00410f19956abmr7555703edj.182.1645183795973;
        Fri, 18 Feb 2022 03:29:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx15pzi/Z1NawSn2EWE5GK+1O9N+/OnokCiUugNjZZzD6iKk05cmwfAS1/FuQrIi+oq2rOcxA==
X-Received: by 2002:a50:d9ce:0:b0:410:f199:56ab with SMTP id x14-20020a50d9ce000000b00410f19956abmr7555679edj.182.1645183795698;
        Fri, 18 Feb 2022 03:29:55 -0800 (PST)
Received: from [192.168.0.114] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b17sm2142489ejd.34.2022.02.18.03.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 03:29:54 -0800 (PST)
Message-ID: <d4fcf76c-5d43-d8fc-bdc7-1a04ab517678@canonical.com>
Date:   Fri, 18 Feb 2022 12:29:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: nvidia,tegra20-kbc: Convert to json-schema
Content-Language: en-US
To:     Max Buchholz <max.buchholz@gmx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220218101011.22988-1-max.buchholz@gmx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220218101011.22988-1-max.buchholz@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2022 11:10, Max Buchholz wrote:
> From: Max Buchholz <Max.Buchholz@gmx.de>
> 
> This converts the Nvidia Tegra keyboard controller bindings to YAML
> and fix them up a bit.
> 
> Acked-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Max Buchholz <max.buchholz@gmx.de>
> ---
>  .../bindings/input/nvidia,tegra20-kbc.txt     |  55 ---------
>  .../bindings/input/nvidia,tegra20-kbc.yaml    | 114 ++++++++++++++++++
>  2 files changed, 114 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
>  create mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> deleted file mode 100644
> index 1faa7292e21f..000000000000
> --- a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -* Tegra keyboard controller
> -The key controller has maximum 24 pins to make matrix keypad. Any pin
> -can be configured as row or column. The maximum column pin can be 8
> -and maximum row pins can be 16 for Tegra20/Tegra30.
> -
> -Required properties:
> -- compatible: "nvidia,tegra20-kbc"
> -- reg: Register base address of KBC.
> -- interrupts: Interrupt number for the KBC.
> -- nvidia,kbc-row-pins: The KBC pins which are configured as row. This is an
> -  array of pin numbers which is used as rows.
> -- nvidia,kbc-col-pins: The KBC pins which are configured as column. This is an
> -  array of pin numbers which is used as column.
> -- linux,keymap: The keymap for keys as described in the binding document
> -  devicetree/bindings/input/matrix-keymap.txt.
> -- clocks: Must contain one entry, for the module clock.
> -  See ../clocks/clock-bindings.txt for details.
> -- resets: Must contain an entry for each entry in reset-names.
> -  See ../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - kbc
> -
> -Optional properties, in addition to those specified by the shared
> -matrix-keyboard bindings:
> -
> -- linux,fn-keymap: a second keymap, same specification as the
> -  matrix-keyboard-controller spec but to be used when the KEY_FN modifier
> -  key is pressed.
> -- nvidia,debounce-delay-ms: delay in milliseconds per row scan for debouncing
> -- nvidia,repeat-delay-ms: delay in milliseconds before repeat starts
> -- nvidia,ghost-filter: enable ghost filtering for this device
> -- wakeup-source: configure keyboard as a wakeup source for suspend/resume
> -		 (Legacy property supported: "nvidia,wakeup-source")
> -
> -Example:
> -
> -keyboard: keyboard {
> -	compatible = "nvidia,tegra20-kbc";
> -	reg = <0x7000e200 0x100>;
> -	interrupts = <0 85 0x04>;
> -	clocks = <&tegra_car 36>;
> -	resets = <&tegra_car 36>;
> -	reset-names = "kbc";
> -	nvidia,ghost-filter;
> -	nvidia,debounce-delay-ms = <640>;
> -	nvidia,kbc-row-pins = <0 1 2>;    /* pin 0, 1, 2 as rows */
> -	nvidia,kbc-col-pins = <11 12 13>; /* pin 11, 12, 13 as columns */
> -	linux,keymap = <0x00000074
> -			0x00010067
> -			0x00020066
> -			0x01010068
> -			0x02000069
> -			0x02010070
> -			0x02020071>;
> -};
> diff --git a/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> new file mode 100644
> index 000000000000..076b347a6f07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/input/nvidia,tegra20-kbc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Nvidia Tegra keyboard controller
> +
> +maintainers:
> +  - Max Buchholz <max.buchholz@gmx.de>

Maybe also add TEGRA KBC DRIVER maintainer? He was not CC here...

> +
> +description: >
> +  The key controller has maximum 24 pins to make matrix keypad. Any pin
> +  can be configured as row or column. The maximum column pin can be 8
> +  and maximum row pins can be 16 for Tegra20/Tegra30.
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra20-kbc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:

maxItems: 1

> +    description: Interrupt number for the KBC.

It's fairly obvious, so description can be skipped.

> +
> +  nvidia,kbc-row-pins:
> +    description: >
> +      The KBC pins which are configured as row. This is an
> +      array of pin numbers which is used as rows.

You basically duplicate the property name in description. "Row" is
obvious from property name. "Pins" as well. "Array" from the type below.
Please document the field without repeating the type and property name.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  nvidia,kbc-col-pins:
> +    description: >
> +      The KBC pins which are configured as column. This is an
> +      array of pin numbers which is used as column.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  linux,keymap:
> +    description: >
> +      The keymap for keys as described in the binding document
> +      devicetree/bindings/input/matrix-keymap.txt.

1. The file is empty.
2. Reference matrxi-keymap.yaml instead with allOf.

> +
> +  clocks:
> +    maxItems: 1
> +    description: >
> +      Must contain one entry, for the module clock.
> +      See ../clocks/clock-bindings.txt for details.

Skip description, it's obvious and no need to reference old TXT.

> +
> +  resets:
> +    description: >
> +      Must contain an entry for each entry in reset-names.
> +      See ../reset/reset.txt for details.

maxItems
Skip description.

> +
> +  reset-names:
> +    const: kbc
> +
> +  linux,fn-keymap:
> +    description: >
> +      a second keymap, same specification as the
> +      matrix-keyboard-controller spec but to be used when the KEY_FN modifier
> +      key is pressed.

Does not look like standard property, so you need type.

> +
> +  nvidia,debounce-delay-ms:
> +    description: delay in milliseconds per row scan for debouncing
> +
> +  nvidia,repeat-delay-ms:
> +    description: delay in milliseconds before repeat starts
> +
> +  nvidia,ghost-filter:
> +    description: enable ghost filtering for this device
> +    type: boolean
> +
> +  wakeup-source:
> +    description: configure keyboard as a wakeup source for suspend/resume
> +
> +  nvidia,wakeup-source:
> +    description: configure keyboard as a wakeup source for suspend/resume
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - nvidia,kbc-row-pins
> +  - nvidia,kbc-col-pins
> +  - linux,keymap
> +  - clocks
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    keyboard: {
> +        compatible = "nvidia,tegra20-kbc";
> +        reg = <0x7000e200 0x100>;
> +        interrupts = <0 85 0x04>;

0 is GIC_SPI?
0x4 is a speficif flag? Use defines for these.

> +        clocks = <&tegra_car 36>;
> +        resets = <&tegra_car 36>;
> +        reset-names = "kbc";
> +        nvidia,ghost-filter;
> +        nvidia,debounce-delay-ms = <640>;
> +        nvidia,kbc-row-pins = <0 1 2>;    /* pin 0, 1, 2 as rows */
> +        nvidia,kbc-col-pins = <11 12 13>; /* pin 11, 12, 13 as columns */
> +        linux,keymap = <0x00000074
> +                0x00010067
> +                0x00020066
> +                0x01010068
> +                0x02000069
> +                0x02010070
> +                0x02020071>;

Align with 0x0000074 in first line.

> +    };
> --
> 2.35.1
> 


Best regards,
Krzysztof
