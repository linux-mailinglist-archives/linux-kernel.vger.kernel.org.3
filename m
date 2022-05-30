Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A245D5374F1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiE3Gni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiE3Gng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:43:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41F43BBCA
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:43:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so5849147wmz.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gtO8Z2a0J80ts6vwBdzuUpB5ZM5wqbWf0RW3kLdDnho=;
        b=ywrfVQTd2uOPjB2of3zjWFQnXMt6cpaM0MPEuOKSwyyawy8tIH4E2zzXyZur9x/Rbu
         NMXD0p8ccYbVF2iL43/unXa1A720NPOEwXYMIRDA7rKMv9qZ5Mz3nJpg/0pkW4GhUxY+
         A3NGIgr3Oge2KilwviW5Bdz2wNXDkQSQvTfHoa/AGuQw8MZhhkKB3sOWGH+W0PzuDO5f
         h9ZEXqx9Pw7dkZOQhkdshnVArkY4WvRAeWcVttnpdST87Jh2Dxg7mDc3m7p40TLLkfnm
         z0Lfw+qclb5vZjrLaSHizHSDgWUlcAdVeBse3UPNe8PBUeWjSrac1aOnRm+MT4XPcn1r
         /zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gtO8Z2a0J80ts6vwBdzuUpB5ZM5wqbWf0RW3kLdDnho=;
        b=HzgDFBB9u7jlNEb1Fw470u5WMcE9F9jkqzVIvB2FN5524ZpMrBktZ2a2HuOR5AwjCW
         IK0HdPHvXyTVqg19Zw9dcCK0GYUq+NK4hIvpewBb/i87u6YgGCT4QV7EUqzN2YIqRbjL
         eqaccg9vdivr1txs3sb2Y9YJNu91+Kyk1BQK1G3eh4q6uQluXAG6WziS0eXeXgIHBq5H
         ca5BIChXP7d/8xZyb4eaqnO/r3V6fSp014Kg05CnkxmTfVZUC5mljHfUNFPRX/xrS71q
         4JMa3nGo13eT0yEhEXHMQY6h5tmOsZF4Nk5uaxm7UOABcoS+enqsP2uApR1/t4Y/7dTr
         KV1w==
X-Gm-Message-State: AOAM530xgZ7Syc3jgOGBflRgD5bNj/eP7AMudmlSFRmvsWgIdkcwKGiY
        feVwFMbnX/LsdxrcwwxokHLqOg==
X-Google-Smtp-Source: ABdhPJxSkzwdIOlEJLw3UsLKBXLQIbv3EDsgYcsEHMfrbKU+WtVOIYrdlIECCXjinw3wR9hbG3pAnA==
X-Received: by 2002:a7b:c08a:0:b0:397:5859:deb5 with SMTP id r10-20020a7bc08a000000b003975859deb5mr17413447wmh.121.1653893012451;
        Sun, 29 May 2022 23:43:32 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c0a0800b0039c15ff3200sm308823wmp.41.2022.05.29.23.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 23:43:31 -0700 (PDT)
Message-ID: <2e6c2995-9204-61fa-0aee-f4ea4cce084c@linaro.org>
Date:   Mon, 30 May 2022 08:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 1/7] dt-bindings: soc: add i.MX93 SRC
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220526123411.270083-1-peng.fan@oss.nxp.com>
 <20220526123411.270083-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220526123411.270083-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 14:34, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> resets and power gating for mixes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/soc/imx/fsl,imx93-src.yaml       | 96 +++++++++++++++++++

Still wrong location of bindings.

>  include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
>  create mode 100644 include/dt-bindings/power/fsl,imx93-power.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> new file mode 100644
> index 000000000000..c20f0bb692fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-src.yaml
> @@ -0,0 +1,96 @@
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
> +    type: object
> +    description: list of power domains provided by this controller.

Continuing our discussion, I think I see the point of having the node
grouping subnodes, just the name confused me. Please make it plural, so
"slices".


Best regards,
Krzysztof
