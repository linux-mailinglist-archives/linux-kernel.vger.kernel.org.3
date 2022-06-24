Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7EF559798
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiFXKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiFXKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:17:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB767B35F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:17:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so3672971ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ullTUOvMiVSdvGdIuWHNgvXtRKcK4bxEb08ZurHoSio=;
        b=QGkMXUXZ6aqBO8n+Jf/Ti5m8LPRJSQhKBhNKwqRP9wIa8E3Z6/3YMqUCw4elhGfxYy
         gkmBp9r2qj9j0zuK6DbtxqdbUTNWY+DZuSAukNNf/R9fM5lsTqpihvlaru/Wb4WRKA4S
         q+7+xZEhuWQmNrBa4d0+lonxwrPULsTcAZ5TNMh5oI+8iYW8iCZmjxihlcDVawfkfUuG
         t+1qzo2YnMFn6rKN17XL32nd5lzQFZyoygvMZMOusU2jfmDdPM4BIj1VYhzMnX9eLdvk
         cfS8RMXFG/INQjibbPXSLEDa1dFTbBCKmKMlQY2nqh72ncY3K1l9tML3DHVYXAtUMa1n
         aRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ullTUOvMiVSdvGdIuWHNgvXtRKcK4bxEb08ZurHoSio=;
        b=FudZe8RYYk190SAicwFs+1+cPsT8fqwcWMDN5Lk48Una2nxVrqp0x3HH7NMAvgeMDl
         p6zGlmjAaXaRtqU7rs2f761l2mt48b9Htiq/va+XD1nKcaiRpvmLAmqaiiH25b0eTH7z
         kPKsupT8mzkEQUhNAVRSa9FpdJ57TFftJE0jDXQDW5QYDf/NMfk+dIkDZjA0Bc2sEJbN
         PZcc4B6G3fsTfGOdGvK+Uy8y5B6nlXHflLw5dUdCT2hv2w1U5KdO/Hk4gnld0QdiMENq
         Gvg7BkS9ko4y7Mh2nR5yKNIYSufrVwxlgjWFYGPSCtB82+BpDLXr+45mVHqfz1Ya3h6G
         bkcA==
X-Gm-Message-State: AJIora+gwCRjp0xt9Y7LT1iJSawXZfsLkwtshoy0LSBcM7iFaoXF+wOc
        NSufhdWpTM8cKdaGgcgJFEFwyw==
X-Google-Smtp-Source: AGRyM1uksiks+ZulHe65GwzPHKFrMx1m/IKF+g/TcHqeK07CC9Rcw3hV2RJdvumMmNHpYQfN7csLvw==
X-Received: by 2002:a17:907:97d3:b0:720:fab0:79bd with SMTP id js19-20020a17090797d300b00720fab079bdmr12418076ejc.191.1656065824041;
        Fri, 24 Jun 2022 03:17:04 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7dbd1000000b0043586bee560sm1605725edt.68.2022.06.24.03.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:17:03 -0700 (PDT)
Message-ID: <6a5e5675-1f00-ca86-b9ad-07068f356d0c@linaro.org>
Date:   Fri, 24 Jun 2022 12:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 07/14] dt-bindings: rtc: Add fsl,scu-rtc yaml file
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
 <20220616164303.790379-8-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616164303.790379-8-viorel.suman@nxp.com>
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
> separately the 'rtc' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> new file mode 100644
> index 000000000000..a2594fdd486f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qxp-sc-rtc
> +
> +required:
> +  - compatible

Missing allOf with ref to rtc.yaml.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtc {

Wrong indentation.

> +             compatible = "fsl,imx8qxp-sc-rtc";
> +    };


Best regards,
Krzysztof
