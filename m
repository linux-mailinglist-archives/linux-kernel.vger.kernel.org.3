Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669704B9C51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiBQJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:45:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiBQJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:45:13 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84301704A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:44:59 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 70D393F4BA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645091098;
        bh=/6BRQwo9F2YRhb8CCreWYd07yVTpbMqy24rXfG8Cqa0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wExrARZiqKQ2l55eNJt6LginpSvSUiNa7sdSc54N+PuLrxRv4v1xMJX0yp/HJmcU7
         yEWd3NYQ31osq9nV9sP3+0nUjte1g1D0mPiW1pAHmDCDbAQZ2nG4QehwjEqYfddfio
         dmraQpFTtO11X9f9CUyGOoWRUBxwUufeOWlRBBYADP+S4JeMSgOqB+rkdfN7NiIH8k
         ibXw3QYI5hWJwBQhUK39eWzcWg6sfToFF6H3EQRbPZfikulXEFBqI/YWJvDLbDo3U8
         AmD84Di6E0Bc0c4J4sfVAGlARBwf/BS4r+CUMQ75ad90p2V+oJ5cR0sS0pIMe9jRm/
         gHZkevolbTAXQ==
Received: by mail-ej1-f72.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso1237128eje.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/6BRQwo9F2YRhb8CCreWYd07yVTpbMqy24rXfG8Cqa0=;
        b=09ql49N+i7vVVMUrYsTy0Js6YTi8a+aewqHNfgOicw2HCGfqF2jDmjh1AohFGA7Ku5
         PrChL6MwEDLSQQJ4zCKXqUMVfMp9MpGJ9JI11aA5boAEXgbNhicX1CZedwr9gZeX0sEj
         c6EozeOIjGjL1F1dpyVktPdkj+oPAN/Dmw6pY/AvN/iRPndwkKKhUzELUDOU7+/EOvTQ
         FNvjiGbCSl+/ZweXLPXljEL2gomkHcAv0Ssd137A9fu3LTqxWCaYmi37P27Q89rZdm7C
         qebE12JwBkIvscbqxRycT/5g+tRXFDv0/hSgDsUBs33GBB29l7MnVInJ83TArdLOzfd/
         q53A==
X-Gm-Message-State: AOAM5313NkNLjRfxLdW9Swi5vEvBqjHcUvcHsutveuoYcF69hsmA+Xyf
        /a2NFUYahpkxlvDqHSGE/geTSJWqr88152GjkHQnfkpIZPrcEczhAXRBYoo0CQWlC84IK7mGNql
        7GFfQn9MBqHEnTG3BW9QL6Ox3HxedzWO03IYblWozVg==
X-Received: by 2002:a50:fc05:0:b0:408:4d18:5070 with SMTP id i5-20020a50fc05000000b004084d185070mr1687912edr.365.1645091095451;
        Thu, 17 Feb 2022 01:44:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4HEhNYvN/1dbYjwwFvdfSqvPJagGu9NoMyYbc/Z0Rqg0vqOwN6P+MvYMdO9RtArG/+LyFyw==
X-Received: by 2002:a50:fc05:0:b0:408:4d18:5070 with SMTP id i5-20020a50fc05000000b004084d185070mr1687899edr.365.1645091095209;
        Thu, 17 Feb 2022 01:44:55 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l7sm3171222edb.53.2022.02.17.01.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 01:44:54 -0800 (PST)
Message-ID: <dde7c475-e44f-c464-ee4f-afe9346f16e3@canonical.com>
Date:   Thu, 17 Feb 2022 10:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [v1] dt-bindings: watchdog: Add HPE GXP Watchdog timer
 binding
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <nick.hawkins@hpe.com>
 <20220215184039.41882-1-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215184039.41882-1-nick.hawkins@hpe.com>
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

On 15/02/2022 19:40, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Description: Creating binding for the GXP watchdog timer to be used in
>  the device tree. This along with the
>   dt-bindings: timer: Add HPE GXP Timer binding patch will be used to
>    create the basic dts and dtsi for GXP.
> Information: GXP is the name of the HPE SoC.
>  This SoC is used to implement BMC features of HPE servers
>   (all ProLiant, Synergy, and many Apollo, and Superdome machines)
>    It does support many features including:
>         ARMv7 architecture, and it is based on a Cortex A9 core
>         Use an AXI bus to which
>                 a memory controller is attached, as well as
>                  multiple SPI interfaces to connect boot flash,
>                  and ROM flash, a 10/100/1000 Mac engine which
>                  supports SGMII (2 ports) and RMII
>                 Multiple I2C engines to drive connectivity with a
> 				 host infrastructure
>                 A video engine which support VGA and DP, as well as
>                  an hardware video encoder
>                 Multiple PCIe ports
>                 A PECI interface, and LPC eSPI
>                 Multiple UART for debug purpose, and Virtual UART for
>                  host connectivity
>                 A GPIO engine.

All this commit msg looks irrelevant, obfuscating and duplicating the
same message.

> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/watchdog/hpe,gxp-wdt.yaml        | 37 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> new file mode 100644
> index 000000000000..6044496b4968
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/hpe,gxp-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP Controlled Watchdog
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-wdt
> +
> +  reg:
> +    items:
> +      - description: WDGRST register
> +      - description: WDGCS register
> +

Quite ascetic bindings - no clocks? no power-domains? interrupts?

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog0:  watchdog@c0000090 {
> +      compatible = "hpe,gxp-wdt";
> +      reg = <0xc0000090 0x02>, <0xc0000096 0x01>;
> +    };
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f41088418aae..8c96f4db900c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8385,6 +8385,12 @@ L:	linux-efi@vger.kernel.org
>  S:	Maintained
>  F:	block/partitions/efi.*
>  
> +GXP WATCHDOG TIMER
> +M:	Nick Hawkins <nick.hawkins@hpe.com>
> +M:	Jean-Marie Verdun <verdun@hpe.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml

If you have the same maintainers for each of your drivers, it's actually
easier to keep them in one entry - HPE GXP ARCHITECTURE. There is little
benefit in having per-block entries which are the same as your main entry.

Best regards,
Krzysztof
