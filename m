Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694FA5B195D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIHJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiIHJxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:53:13 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD3E9877B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:52:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a8so5234014lff.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MbAZZ7ImXCnAcX5j6c0OQ0QrifKC4P6NeZBSY/zCSx0=;
        b=WB6zbmxVadcxx+HMpPhfMGJ27YOZ9tqaqpHpkNY2q/yJ3tdIjYxihvgxQ3UVOwQE6E
         Th6aMRCdXhR8h+JQN/CE0zJ3kyoqqyrlLFH4OVVGE2XMkvJJPcPBptE6DiWa0CG7OIrt
         5xgUrnGC/8IJbBK2p332HaMYn3wDK/RVm3ontNqr+CiWveggtsDeFtkBzQqGD8IGcYfa
         1TF+eMa03ymKwcA45z3h0nuLSboJINw3u2GjU8pXXSYWYDVyTNYxls3QZ5Sertr7Gape
         OA+0d+ldAFy4OiGWNKwZYCVV1m+Rf6TFBFrcg2I4uOUtegxhW6OO1EylDmW3b0jm5bDl
         sZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MbAZZ7ImXCnAcX5j6c0OQ0QrifKC4P6NeZBSY/zCSx0=;
        b=jhMrmwBfAvX1V4bVfqFMgrfUeUEXzZLIJ+K4axk9YhpR9J5o+R7sHyrNPC8Uuappwl
         tpRCfo48qTOD7FebNW+PEKYmzOS2Q7/UL29fqZ7RyPZ58zGUc4ufn7kfN0ejiwPp6uSc
         ENKaqksUOAFtbBUIrYRUYA7X/IMKr5YVXm5f2rIYQepWioARF7HOZIGgxPmMbFJvXJbD
         891iXavUYbEf3hAWWSBw/MRJZ/hY0E9Fh1HfnoN9UM1BEVL71vw4F6VeD/deT7TMQSbr
         guJ89Fql20wKGowbemTDd92V9cSvZqPYjTJ9/XsGinzpaSs+9nKZhYPUVDBWEs+KPhkS
         SSrQ==
X-Gm-Message-State: ACgBeo2eXj69W+Roag1vN/k7WdkyqgZ+YB/+e5aS8beL/2G6bCOW1bq7
        r2A7X1b4Z3+mGLct5wVe3bhN2w==
X-Google-Smtp-Source: AA6agR4uIUy5M7yq+F2/csoUmcip3so7/aFAX2d6wiRe2HX9qa7VrFl3Pf3YfRp26nUrJMxDAnBTcg==
X-Received: by 2002:a05:6512:ad1:b0:498:f052:3a18 with SMTP id n17-20020a0565120ad100b00498f0523a18mr483600lfu.348.1662630770805;
        Thu, 08 Sep 2022 02:52:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p7-20020a05651211e700b0049487818dd9sm2958665lfs.60.2022.09.08.02.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:52:50 -0700 (PDT)
Message-ID: <8a593e0b-99e0-b1f4-20ab-ab2df2940518@linaro.org>
Date:   Thu, 8 Sep 2022 11:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: clock: add i.MX8M Anatop
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220906090013.3724305-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906090013.3724305-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 11:00, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8M Family features an anatop module the produces PLL to clock
> control module(CCM) root clock. Add the missing yaml file.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/clock/imx8m-anatop.yaml          | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8m-anatop.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8m-anatop.yaml b/Documentation/devicetree/bindings/clock/imx8m-anatop.yaml
> new file mode 100644
> index 000000000000..e247a5774d17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx8m-anatop.yaml

Filename: fsl,imx8m-anatop.yaml

> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx8m-anatop.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Family Anatop Module
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  NXP i.MX8M Family anatop PLL module which generates PLL to CCM root.

Description suggests it is a clock controller (you literally write it
generates PLL), but bindings are for system registers (syscon). If it is
PLL, you should make it a real clock provider.

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-anatop
> +              - fsl,imx8mq-anatop
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - fsl,imx8mn-anatop
> +              - fsl,imx8mp-anatop
> +          - const: fsl,imx8mm-anatop
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    anatop: anatop@30360000 {

Node name: syscon or clock-controller if it is a clock provider.

> +        compatible = "fsl,imx8mn-anatop", "fsl,imx8mm-anatop", "syscon";
> +        reg = <0x30360000 0x10000>;
> +    };
> +
> +...


Best regards,
Krzysztof
