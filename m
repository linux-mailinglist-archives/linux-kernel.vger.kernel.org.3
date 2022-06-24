Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19655974D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiFXKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiFXKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:05:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6070E6F49C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:05:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e40so2756507eda.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vT/m4Tsbd8efm3hJuxbD4cqK3IhssJw6vrlwpvAa4b0=;
        b=UakZorhpkKl5ALlrNDpU9jBka/t7cECYvhFhzj+zFDtScfLk4YgEeyOfo8DFWO15pX
         acdIkWuEWtfqRecdqSXnO6RuScer29NgRYGQi6w2b3AevrhtqGV4PyqFV7a7iCvnY+sz
         II+sI7Sn35mv1L55DCt78FSqkyddA8r13goTTMrWr2P/zMq2OgymKpeV3LuqffvPPV0c
         gxsfp8H+kd9rdXlBWi6P+ycPP0PrQm9hqjXMR9R6ZkONPE3AWNqGgVc8xBeaoZoOqwa/
         m2oC2JqyOnyHMotqqqMJK9RbyXsMfJD8qnSgV+hHzIj49dnboun3MfivtpYLc97L4VwU
         ge9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vT/m4Tsbd8efm3hJuxbD4cqK3IhssJw6vrlwpvAa4b0=;
        b=yFyKE8GspsJ7Fhs3Rqs4oW+WCNTMZSekeF95NTSI4xC+BVtlcWcPTf+/xtYfRQW6lx
         dAXXLtlm30gxF8ohUuufz5YE7qD9nORMQYMJA97t1fsidf6G5AMNtNPwIp6pnGcdmw9Q
         OVAi3+CzwdPDzDrShCW4X63EZOKprA77KWteyxg4BkQscm1TAG1SHy1IdG7UByPVjpky
         KPXLly+JYZgKrozXZ9Z+BbPnEnLpHBY/42d5sYJXrYlRQvIJcR2gr+rGzD6XBH7h25S+
         ztZNrwTqVmTQlBwqtsS6SvAEym99p4/92UBU0HiWPlaacV3y6B9xqNZMn9mA0TCzwm7M
         YoEA==
X-Gm-Message-State: AJIora+feKUq6yxTPRFI3C4yBDPxwC1utdu21tDckgTdiuKtQfme+/7j
        y3JoZUiJ71dWbIPGJa8Ww+2M3A==
X-Google-Smtp-Source: AGRyM1uaOjXwhg5I8X289/Baaww5kJzfDpSLWW9kaNvjsU7L/qEOz6gkCuSWZSjiQSEuXlbmDZ+EFQ==
X-Received: by 2002:a05:6402:11cb:b0:435:75ed:f12f with SMTP id j11-20020a05640211cb00b0043575edf12fmr16487090edw.305.1656065130928;
        Fri, 24 Jun 2022 03:05:30 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm845519ejm.107.2022.06.24.03.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:05:30 -0700 (PDT)
Message-ID: <3db6ca83-1fa0-0a6d-5af9-4dd0ba38b9a6@linaro.org>
Date:   Fri, 24 Jun 2022 12:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 02/14] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Content-Language: en-US
To:     Viorel Suman <viorel.suman@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
 <20220616164303.790379-3-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616164303.790379-3-viorel.suman@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2022 18:42, Viorel Suman wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'clock' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/clock/fsl,scu-clk.yaml           | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
> new file mode 100644
> index 000000000000..8b59758eee4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,scu-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +  This binding uses the common clock binding.
> +  (Documentation/devicetree/bindings/clock/clock-bindings.txt)
> +  The clock consumer should specify the desired clock by having the clock
> +  ID in its "clocks" phandle cell.
> +  See the full list of clock IDs from
> +  include/dt-bindings/clock/imx8qxp-clock.h
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8dxl-clk
> +          - fsl,imx8qm-clk
> +          - fsl,imx8qxp-clk
> +      - const: fsl,scu-clk
> +
> +  '#clock-cells':
> +    const: 2
> +
> +  clocks:
> +    items:
> +      - description: XTAL 32KHz
> +      - description: XTAL 24MHz
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      enum:
> +        - xtal_32KHz
> +        - xtal_24Mhz

No, this does not match your clocks property and allow any combination.
Are you sure that hardware can have entirely different clocks connected?

> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - '#clock-cells'

Why the clocks are not required?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {
> +           compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";

Wrong indentation. 4 spaces for DTS example.

> +           #clock-cells = <2>;
> +    };


Best regards,
Krzysztof
