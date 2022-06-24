Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9E5597B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiFXKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiFXKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:19:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197BB7B37D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:19:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eo8so2858760edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q/ovqEoOD+hVmnJ1ZaktfSaUD+tCfL6g1YxFd7nkrg4=;
        b=AKgStJX5Aau9B4NUvSQeYUqMYzsnwzORpUESXepLAMWshgDtfR1h9wQGbrnGlM+QCB
         vt/StFAHYfiJHl7quv14FjPTSXfj4s5bB+NjgxOXHZkhl2ovoAkMTjmC/icHtVZj835F
         HUc4UhiI85m9PhoIjx9iAVsisdH5E7hpDwWugls9+m7vMvBsZ0HeE8GeUOQ+FbIBTDv6
         FLnJ+dVTJVRDDE28sx3jtdy+/KCF83vz2ty+q+4iG8bzC+VM4EpWAuyoBC7FE//UckJY
         gKlmt3yjVmxXSYS5/L9+Fw+g90aI3TobVPTkJN2D/QguySH9FwGVnYuQd2mozR/ho8cO
         c2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q/ovqEoOD+hVmnJ1ZaktfSaUD+tCfL6g1YxFd7nkrg4=;
        b=nio+rraxzsHktt20hIYUeEP02sKjm14Qh5tcbhXIVQfzuXtNxQDohuBMn4qO3YRaRW
         pTntdE/x8UGQ8vgj2Gg9UfG5tqWueK2CWl9RY70ktTPN8oESAtviAxZfrXW8b3YCnuSz
         kFtM3HFViYTyac1KNLqK/9RwKmD8YJfA/sV8M6lFvgybTCg0FSL5DsJPeK67HN16BRG3
         u6M1qnH5gbBTWk4EMG8YplItGM28Bau3NFXeDC2Th+q531NacmcbhOWC+B4H7V5Z2R6L
         HSsdeEo5yDOIAL+/I8LPjdMnNY8/1AxVob3flXZlp4sE80cXdSLbM9BlDIqY9VafwGCy
         d9Yw==
X-Gm-Message-State: AJIora8gPdtz12dZmdc1jbHD4ACtPL5Gcg49xTpbZpAiM2CqiOU19oMd
        f9i8ggfignbWbxWZhwzJqSgQFw==
X-Google-Smtp-Source: AGRyM1vuu58Df44GqIbPYw7kKBGPJa+EM9ddo6TMqN8wrNwFBXS4pW3xOw33Lo5nwodAZ32L02wywA==
X-Received: by 2002:a05:6402:2753:b0:431:9c8b:5635 with SMTP id z19-20020a056402275300b004319c8b5635mr16567506edd.152.1656065989588;
        Fri, 24 Jun 2022 03:19:49 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7db83000000b0043580ac5888sm1621695edt.82.2022.06.24.03.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:19:49 -0700 (PDT)
Message-ID: <6df3bcd8-10a9-55a1-330b-19ef0d5603a5@linaro.org>
Date:   Fri, 24 Jun 2022 12:19:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 09/14] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
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
 <20220616164303.790379-10-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616164303.790379-10-viorel.suman@nxp.com>
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
> separately the 'watchdog' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/watchdog/fsl,scu-wdt.yaml        | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
> new file mode 100644
> index 000000000000..c5d3063a4130
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/fsl,scu-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +allOf:
> +  - $ref: /schemas/watchdog/watchdog.yaml

Blank line

> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8qxp-sc-wdt
> +      - const: fsl,imx-sc-wdt
> +
> +  timeout-sec: true

Drop it.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    watchdog {
> +             compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";

Indentation...

> +             timeout-sec = <60>;
> +    };


Best regards,
Krzysztof
