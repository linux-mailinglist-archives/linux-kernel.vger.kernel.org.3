Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07A45796BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiGSJxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbiGSJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:53:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA50286D0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:53:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z22so10218887lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XQOHjJ+3zxtuOF8mCcjcsJ/+VJ74QDVMJc+OIHk6Az8=;
        b=CmlHkgwvvNmjd4De+2D8dvvFgbMJEqokeH4JgS3l7KymGUP+Nuj/lMRQCO8BRjAfsl
         4Cwg4SBgXZDEQOCZZXOMAechiXVjs42PU+VdOZDUbI9reb6o5u/spPKhURs8eHm8lIrR
         f02YHUUqmbLLZ/YN15z+a7qOwu+w9/jVk6IenfgKfoZOTFvTVhX2Hdj/ZdqcxAUVwr4/
         niY91teEsFrdkI4R+18392g5QwkneZDlG/YJdMK0GbcgkdsALFHxkAk5TsQiGIsu2UCT
         YwPs8K7d9eIyYwAeYJNzqrU2DPE3wCQ9siFZHoL3i3UwnvehrQKD9mg4grGqrwl1cZV3
         2xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XQOHjJ+3zxtuOF8mCcjcsJ/+VJ74QDVMJc+OIHk6Az8=;
        b=LCVZjasxuoE0cEaS04QkqF4/PQiX/0/yPdtVlr0lo+RREahfIjozEoAn9WR804EOVa
         ajnLxiiDfkh4vti6FyB3/mcyFnSuIN2fHPImai65r6sTyYjBL0JRBKMaY/Hy5kBSc1ql
         KOV4kNJM2cEbxap9UvZVZDnkleYmcXr3otMj3FgHVL+e+bzuQ0BDpdNAGZFebioPrOq8
         IhD9EFok5s9aPQp7QiYNpcl1CJgRqajW3ry8V0csgR9fMRQBmbW+8gw3mPZIdOeotd1b
         HNAsr1VsRzGlCDEHslKlOdnpbzmq2RAGVdQaidsvRcHS1yI7gjQBDAHDsjgCdD7GNQdk
         nwTg==
X-Gm-Message-State: AJIora8wlrxWceAyQpWynmEKSqVzrXZ/2h5o+TG3bG2SlWlMYZTRG8Xh
        b3p7cDRfVjurF+8jIWAem8R8SA==
X-Google-Smtp-Source: AGRyM1uyhwwZGjju0i08K5sS4bSp1m4AwsUSBqU+/LuH1eh7BtQz/6Wxoob5Ar3YD3OcsvSWgw4tPQ==
X-Received: by 2002:a05:6512:224a:b0:489:db85:53c6 with SMTP id i10-20020a056512224a00b00489db8553c6mr16262369lfu.383.1658224429882;
        Tue, 19 Jul 2022 02:53:49 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id a14-20020a19e30e000000b0047f7bd03943sm3101279lfh.264.2022.07.19.02.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 02:53:49 -0700 (PDT)
Message-ID: <27ab24ec-61c7-cafb-6665-a16c58808649@linaro.org>
Date:   Tue, 19 Jul 2022 11:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
 <20220719055054.3855979-4-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220719055054.3855979-4-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 07:50, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
> the i.MX8MM VPU blk ctrl yaml file. And add description for the items.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 90 +++++++++++++++++--
>  include/dt-bindings/power/imx8mp-power.h      |  4 +
>  2 files changed, 85 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> index b3fb529b399c..14f92574286f 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
> @@ -30,20 +30,13 @@ properties:
>      maxItems: 4
>  
>    power-domain-names:
> -    items:
> -      - const: bus
> -      - const: g1
> -      - const: g2
> -      - const: h1
> +    maxItems: 4
>  
>    clocks:
>      maxItems: 3
>  
>    clock-names:
> -    items:
> -      - const: g1
> -      - const: g2
> -      - const: h1
> +    maxItems: 3
>  
>  required:
>    - compatible
> @@ -53,6 +46,85 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8mm-vpu-blk-ctrl
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: bus power domain
> +            - description: G1 decoder power domain
> +            - description: G2 decoder power domain
> +            - description: H1 encoder power domain
> +
> +        power-domain-names:
> +          items:
> +            - const: bus
> +            - const: g1
> +            - const: g2
> +            - const: h1
> +
> +        clocks:
> +          items:
> +            - description: G1 decoder clk
> +            - description: G2 decoder clk
> +            - description: H1 encoder clk
> +
> +        clock-names:
> +          items:
> +            - const: g1
> +            - const: g2
> +            - const: h1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8mp-vpu-blk-ctrl
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: bus power domain
> +            - description: G1 decoder power domain
> +            - description: G2 decoder power domain
> +            - description: VC8000E encoder power domain
> +
> +        power-domain-names:
> +          items:
> +            - const: bus
> +            - const: g1
> +            - const: g2
> +            - const: vc8000e
> +
> +        clocks:
> +          items:
> +            - description: G1 decoder clk
> +            - description: G2 decoder clk
> +            - description: VC8000E encoder clk
> +
> +        clock-names:
> +          items:
> +            - const: g1
> +            - const: g2
> +            - const: vc8000e
> +
> +        interconnects:
> +          items:
> +            - description: G1 decoder interconnect
> +            - description: G2 decoder interconnect
> +            - description: VC8000E encoder interconnect
> +
> +        interconnect-names:
> +          items:
> +            - const: g1
> +            - const: g2
> +            - const: vc8000e

Include interconnects+names in list of all properties and disallow them
for other variants.


Best regards,
Krzysztof
