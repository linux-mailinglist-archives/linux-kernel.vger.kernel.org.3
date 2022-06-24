Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF51255978F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiFXKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiFXKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:16:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8117B7B34A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:16:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e40so2796313eda.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nCu6+FAEztI3iRzZoGu/7jx34/57ZWFzCmnwCEKEKG8=;
        b=dWqo5LyxZMlBrKbS9H0mIrtomRY/WUzSRblBMsuI/asWPYDAYlSRHf6ML2HQKDUp1Y
         B6WeLMY/3IBc6AsT2+jLgmcg6KmZToSz22V5ndz9MN0pusr3e3qXeCk8VUNVjihXiyCh
         r8q+upF95gOGUwBBjY6VEoDP74ZI+60bPoxrTSRq4HJYIYIxjnTj90pANjM735XbjZ2f
         YbiV0j2S7ayA6phqPPrP1VuJ/PdFvy26lz9kQ19rbqu1QRZrk+2N/wf3uIiJGkGUXBPp
         fNSr+YErNDJncHqKz9Jaf5dZ9766ZhcBzk2dQnzeuui8KJffE6KIgYEPnll4KSH6Buay
         adQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nCu6+FAEztI3iRzZoGu/7jx34/57ZWFzCmnwCEKEKG8=;
        b=s8TWomVa6IGv76dmTL18KFcG+qVaDJFcgTlwNSmtV9WewyYbAtPu2QcrRRUvpsjcf0
         40zDkiZDkdvN7wc6W4fzHQdQA7qaGiUlhNPDSqctPzmcFRCz1zAvzQYVbpp2Jrc2tSpQ
         fimdeFmX1mszT2WYiknGRmVxfI7hmwYrohQp2a6J+6f1Mc6J4+ICLXZsl4A9/7OSn0oN
         +xAH9UCYuvPhjc9o75L9rjI4JiAGRgODmZgaLHWFH6yv3xrnv8BcM/1wiNRKC/EDm3jm
         osMwXZMu7YWkq0lhZCMO4cHlHGCjldJFdiz9yVAzydbnt42Q2owJj8brbBnIPtcIr9Np
         i6Hg==
X-Gm-Message-State: AJIora+csbkao3EQKLEs1ARedxKrlULozk2c2ygU0pHCFgH9etVoiFeE
        UGQDDJib1yqend9Jvx866ikUTA==
X-Google-Smtp-Source: AGRyM1sV0Rqv2FM82XbzujrDkf6ZaBarXKNOOXluyUaVY1qP5wuXx3QrO3TrIokPTHWJCB7Sppn7Rg==
X-Received: by 2002:a05:6402:240e:b0:433:4642:f86a with SMTP id t14-20020a056402240e00b004334642f86amr16182271eda.313.1656065792045;
        Fri, 24 Jun 2022 03:16:32 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906b29800b0072629374590sm869853ejz.120.2022.06.24.03.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 03:16:31 -0700 (PDT)
Message-ID: <b22d67ac-9e84-d059-8068-3475b026c1ef@linaro.org>
Date:   Fri, 24 Jun 2022 12:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 06/14] dt-bindings: power: Add fsl,scu-pd yaml file
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
 <20220616164303.790379-7-viorel.suman@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616164303.790379-7-viorel.suman@nxp.com>
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
> separately the 'power controller' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/power/fsl,scu-pd.yaml | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> new file mode 100644
> index 000000000000..9d3cb51d7b37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/fsl,scu-pd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +  Power domain bindings based on SCU Message Protocol
> +
> +allOf:
> +  - $ref: /schemas/power/power-domain.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - fsl,imx8qm-scu-pd
> +          - fsl,imx8qxp-scu-pd
> +      - const: fsl,scu-pd
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    power-controller {
> +             compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";

Wrong indentation.

> +             #power-domain-cells = <1>;
> +    };


Best regards,
Krzysztof
