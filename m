Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6A58F8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiHKH4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiHKH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:56:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347A1ADA6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:56:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u6so13155618ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HGD+mIOoUzZZibF46I+q3hJDknL0evsBnB4j8896RDE=;
        b=w2Ve8pp7kpZ5uxP6kONzTfBLYo+GLlwLTI7YboNcnwSUyzMvCwh29zN6fAO49uGDiN
         2VkGvu5lb5NoOGvCo9WLrxVNL2kkhkZIqJy4urwI/xgg+7eImhMqGsWALOoMnzCuQr5a
         bKphNe9iQ97fbwjNLqIGNqLFqimYiYA4/dLFxdeNGB77EkbPI0c/rV9Hivs6Z4wDlomk
         mQ/HBLn/W6xohgtVK02g79ptUnDbrLrzhBlbmIFRD9MiGsm31GZQ1IOFu1mw95/Nafxo
         H+2XTOYXnTJd9XCIgwRairgOHXj4qxGE/iMLiBsmwycAmo1lOFjZ/OQyThUyS/wqO6Gi
         L1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HGD+mIOoUzZZibF46I+q3hJDknL0evsBnB4j8896RDE=;
        b=Yui4mHD3MUPtmAGeRBm/k7C+8IT/+Nc2g8XJh+kKI+SQK9OE6NsHTXQAKgQUmAJC/w
         +fQHq6pGIzsC1u6lstmiGNq3BMz1Ayw16c45Mr/hGqjO4flQGGkRpwkkFhVwv/VbbhWw
         BA00u4dapaX0evy67AVfn6YgTpLAC9iXMkHtrOBiKP/JeA8Bm8vFDyBbSPMD7F1XkUEO
         gJYd2r2JhaYMqbqhGauT7hWQjFImm4b8ufPybZoDeUwr3y5v8PReoeEcXQe3JhzHnAgz
         S+WxSPkbTWsFoU/4nPtD1TlCAlGlPrIZu3h+xRkhDFqEHOZA0UBLbZ/gilX1937QAI8z
         Gjlg==
X-Gm-Message-State: ACgBeo0gOYe3Ow9cPtWO+aJtgr8gH6elRMewYuTE9RcJbNqflXux2yZ6
        6aoJyvuajUlhVaUwUC5R1l8kEg==
X-Google-Smtp-Source: AA6agR4c8fIm9+sSNAAoQ/CG7qvl6RSg1/y9svFJ1Yzku00jo7ICQImd2/4B1MH6UMreW6bzwNBm1A==
X-Received: by 2002:a05:651c:241:b0:25e:65bd:3a8a with SMTP id x1-20020a05651c024100b0025e65bd3a8amr10308517ljn.206.1660204567994;
        Thu, 11 Aug 2022 00:56:07 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id j2-20020a056512398200b0048b008844b8sm607407lfu.270.2022.08.11.00.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 00:56:07 -0700 (PDT)
Message-ID: <db9b74f9-1f65-5b88-1c81-0a3fd6dcf9a6@linaro.org>
Date:   Thu, 11 Aug 2022 10:56:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: display/msm: Add binding for SC8280XP
 MDSS
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811040121.3775613-1-bjorn.andersson@linaro.org>
 <20220811040121.3775613-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811040121.3775613-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 07:01, Bjorn Andersson wrote:
> Add binding for the display subsystem and display processing unit in the
> Qualcomm SC8280XP platform.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/display/msm/dpu-sc8280xp.yaml    | 284 ++++++++++++++++++
>  1 file changed, 284 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
> new file mode 100644
> index 000000000000..6c25943e639c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml

qcom prefix is needed (also when file is in msm subdir)

The file name should be based on compatible, so "qcom,sc8280xp-mdss.yaml"

> @@ -0,0 +1,284 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/dpu-sc8280xp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Processing Unit for SC8280XP
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  Device tree bindings for MSM Mobile Display Subsystem (MDSS) that encapsulates
> +  sub-blocks like DPU display controller, DSI and DP interfaces etc. Device tree
> +  bindings of MDSS and DPU are mentioned for SC8280XP.

s/Device tree bindings//
so just:

SC8280XP MSM Mobile Display Subsystem (MDSS) that encapsulates
sub-blocks like DPU display controller, DSI and DP interfaces etc.

> +
> +properties:
> +  compatible:
> +    const: qcom,sc8280xp-mdss
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    const: mdss

You do not need reg names for one item, especially if the name is kind
of obvious... unless you re-use existing driver which needs it? Then
maybe let's change the driver to take first element?

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Display AHB clock from gcc
> +      - description: Display AHB clock from dispcc
> +      - description: Display core clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: ahb
> +      - const: core
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true

I see other DPU bindings also specify both as "true". Why not a fixed
number (const)?

> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  iommus:
> +    items:
> +      - description: Phandle to apps_smmu node with SID mask for Hard-Fail port0
> +
> +  ranges: true
> +
> +  interconnects:
> +    minItems: 2

No need for minItems in such case.

> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: mdp0-mem
> +      - const: mdp1-mem
> +
> +  resets:
> +    items:
> +      - description: MDSS_CORE reset
> +
> +patternProperties:
> +  "^display-controller@[0-9a-f]+$":
> +    type: object
> +    description: Node containing the properties of DPU.

additionalProperties:false on this level

which will point to missing properties (e.g. opp-table)

> +
> +    properties:
> +      compatible:
> +        const: qcom,sc8280xp-dpu
> +


Best regards,
Krzysztof
