Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1002A532712
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiEXKHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiEXKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:07:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FDF79824
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:07:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v9so11009208lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=62u0OdiZGmktFTh3AqaIrUZUI/D7c2ipqL+QehY9CTA=;
        b=kjYAiJhl1gZx0UVhGbW3xraCltid4zvCU7U7jlILyDeNpk7RL49N9xtrUzHCfqHoyE
         0XskJ1LUFzgrNk1/eqwsOYLzzjwxM1QDz9JKf0v4WMoZ3iri9Z5VR0vtLFbRx/jlYvpI
         4PcuqrljaltA6MiNhRaO3YvHfeBOXAkXaYjIoQGdxc/rxBZaSHLaX+SLqkgsW+z3oybW
         eTlEO9kIgs13OkWITy/zdISSacu6gFPW6CbOobcpLKBzOALKXmLqWdms6B7yXEQ62lpK
         pg6O42tiNAohq9S55rRoO7Ye686vP3pXDO1JM2PhyKL8vRnFMNgKbGf8htaUHW5v9WnG
         RUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=62u0OdiZGmktFTh3AqaIrUZUI/D7c2ipqL+QehY9CTA=;
        b=gsWM3tAWSm+Fl536JeEEmrkEmpU5gzo9y6caWD0MiXhcZQLivI/xU/Un3hfcFtuRR3
         9TYWZE0kGPKqiuCENSkuoB+QDqZDDxBBlostrSCCgRd9rOsvPW8B74Ms1Y6fIe9h91EC
         0sjuGybnkimCBC8g6gLtHTOkQSTb5rUWPGWENh5rA2jIAH/cgWPFB21O6Rmdf1Wv+sQT
         EeVizzZH46e0mnacgRUKEFl1HTofYovmTBh7LksB+Ll+GlggeasVIePd+NOEEVox8ySV
         Zb/tE9M45JvGRZaP5eLcgEvthP+rNhChtgDZ9vriGdkTyAM1iqtvzR+XLIMeNEGo4Hwg
         a+Lg==
X-Gm-Message-State: AOAM533HhGnAC9PYiYCs6mG+J4M/v5x03G7+4xoZlpYsNv9hUALEUZwK
        /fKLX5Xf2zz2sKN7tBCfSXyuzA==
X-Google-Smtp-Source: ABdhPJy9L8ZYpXgX23qTOsfzdXeE19zccHaN4htCW5tI6QmMZjSGG6wzVErzNA91bPLofI0APu1QhA==
X-Received: by 2002:a2e:391a:0:b0:253:c3e8:9387 with SMTP id g26-20020a2e391a000000b00253c3e89387mr15179864lja.156.1653386857129;
        Tue, 24 May 2022 03:07:37 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id j30-20020ac2551e000000b0047255d211a2sm2451930lfk.209.2022.05.24.03.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 03:07:36 -0700 (PDT)
Message-ID: <c2882212-aa1e-4614-c982-43e6c793b34a@linaro.org>
Date:   Tue, 24 May 2022 12:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/7] dt-bindings: soc: add bindings for i.MX93 SRC
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
 <20220523113029.842753-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523113029.842753-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 13:30, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> resets and power gating for mixes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 88 +++++++++++++++++++
>  include/dt-bindings/power/imx93-power.h       | 11 +++
>  2 files changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml

File should be in respective subsystem, so probably power/reset?

>  create mode 100644 include/dt-bindings/power/imx93-power.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> new file mode 100644
> index 000000000000..d45c1458b9c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-src.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX9 System Reset Controller
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  The System Reset Controller (SRC) is responsible for the generation of
> +  all the system reset signals and boot argument latching.
> +
> +  Its main functions are as follows,
> +  - Deals with all global system reset sources from other modules,
> +    and generates global system reset.
> +  - Responsible for power gating of MIXs (Slices) and their memory
> +    low power control.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx93-src
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  slice:

Why do you need this subnode, instead of listing domains here?

> +    type: object
> +    description: list of power domains provided by this controller.
> +

Hm, what about address/size cells? Is syscon schema bringing these?

> +    patternProperties:
> +      "power-domain@[0-9]$":
> +        type: object

Missing ref to power-domain.yaml

> +        properties:
> +
> +          '#power-domain-cells':
> +            const: 0
> +
> +          reg:
> +            description: |
> +              Power domain index. Valid values are defined in
> +              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
> +            maxItems: 1
> +
> +          clocks:
> +            description: |
> +              A number of phandles to clocks that need to be enabled
> +              during domain power-up sequencing to ensure reset
> +              propagation into devices located inside this power domain.
> +            minItems: 1
> +            maxItems: 5
> +
> +        required:
> +          - '#power-domain-cells'
> +          - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - slice
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx93-clock.h>
> +    #include <dt-bindings/power/imx93-power.h>
> +
> +    src@44460000 {

reset-controller
or some other generic node name.

> +        compatible = "fsl,imx93-src", "syscon";
> +        reg = <0x44460000 0x10000>;
> +
> +        slice {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                mediamix: power-domain@0 {

Best regards,
Krzysztof
