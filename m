Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52D1505C74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346197AbiDRQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbiDRQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8930549
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:28:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z12so18031139edl.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4yPTlVlLrAtb5ubCvcP4U4+7QXnkxKWR0UVrepyNJpM=;
        b=QaHk3OpnRI+GMML9KqP/qt5NXCI4C+qJpASzvokxyJkaSQB1Al9OeLTsIejsgFrWgp
         O1Ye6fS2NfQX8qyIHsGcwty5uChlluEc1OI5+U229C+1ifF3clKgDPQPcP0YW4u1vBpp
         98Mx1Jq/HE9TRU47fLp+Dz7kbDYFpiLRs9quNdDsGYXhNWCmqjQpToYxdSUKAxcQg9lv
         kceamZ3h3W/JFjM3cwDX9EG+X6ZIDQqNGMa5HJg5s79PnOIt3sVG4kjF6qxnG7XREPPT
         0UFFi1aHTgcZ4jOjQgbazElStMOb2tiupGQXWANM3yuhyl2e+zteeidKzFreNozeGbAb
         Okkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4yPTlVlLrAtb5ubCvcP4U4+7QXnkxKWR0UVrepyNJpM=;
        b=wP5oZBrv0Tnz/jjEpUR/7wOtm3EwEniGHruQ7GT4omsJjDM22LTGe8pxvY42DqztWV
         WUvzFxW7uPMxyR4OgrWfRa4FpZIeTQ6RpifpWSc5G1H03puuoOwKXVkaPJAPUN2wZ0Yc
         mj12RwIusC6Nsfa/8O7qKrTPIjDlOWVBT4+Wp6J/dah8SLmMRTuZkm0YV58B0mtOD7Pi
         t5iJo3BCOAQ03HP/YmYSpf/dFAAxKxqWhukEom8FW00fcqXXmpL55PR2qrul4004WQ3Q
         8cOkLM2jHCKaWU/XH97xWYS/3K0cR5CupErJztMNfE3FiBykASlFvl2XKfmEdGYfc4s6
         I/QA==
X-Gm-Message-State: AOAM533eEs0pds+N34IwHqhul5q7PhXb8B/B7nEMYa5RlgRBlcICbwVh
        JDtLKeeC+33x/qp+Yvav8yLANw==
X-Google-Smtp-Source: ABdhPJzbY/tvva7InOdIOBWrWDxopvksQkCJD5VW1MEQSl2Qv+XCV2wAAU00+IBN4QYrLSm0YG2DQA==
X-Received: by 2002:a05:6402:51d2:b0:419:7d2e:9d0 with SMTP id r18-20020a05640251d200b004197d2e09d0mr13150983edd.82.1650299321410;
        Mon, 18 Apr 2022 09:28:41 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id fd22-20020a1709072a1600b006ef95031de4sm1859969ejc.77.2022.04.18.09.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 09:28:40 -0700 (PDT)
Message-ID: <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org>
Date:   Mon, 18 Apr 2022 18:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220418125630.2342538-1-gengcixi@gmail.com>
 <20220418125630.2342538-2-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220418125630.2342538-2-gengcixi@gmail.com>
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

On 18/04/2022 14:56, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Add a new bindings to describe ums512 clock compatible string.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> new file mode 100644
> index 000000000000..89824d7c6be4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: UMS512 Clock Control Unit Device Tree Bindings

Remove "Device Tree Bindings". You could do the same also in the
subject, because you repeat the prefix ("dt-bindings: clk: sprd: Add
ums512 clock controller").

> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  compatible:

Put the compatible first, by convention and makes finding matching
bindings easier.

> +    oneOf:
> +      - items:
> +          - const: sprd,ums512-glbregs
> +          - const: syscon
> +          - const: simple-mfd

Why do you need simple-mfd for these? This looks like a regular syscon,
so usually does not come with children. What is more, why this "usual
syscon" is a separate clock controller in these bindings?

> +      - items:
> +          - enum:
> +              - sprd,ums512-apahb-gate
> +              - sprd,ums512-ap-clk
> +              - sprd,ums512-aonapb-clk
> +              - sprd,ums512-pmu-gate
> +              - sprd,ums512-g0-pll
> +              - sprd,ums512-g2-pll
> +              - sprd,ums512-g3-pll
> +              - sprd,ums512-gc-pll
> +              - sprd,ums512-aon-gate
> +              - sprd,ums512-audcpapb-gate
> +              - sprd,ums512-audcpahb-gate
> +              - sprd,ums512-gpu-clk
> +              - sprd,ums512-mm-clk
> +              - sprd,ums512-mm-gate-clk
> +              - sprd,ums512-apapb-gate
> +
> +  clocks:
> +    minItems: 1

maxItems needed

> +    description: |
> +      The input parent clock(s) phandle for this clock, only list fixed
> +      clocks which are declared in devicetree.

The description does not make sense. These are bindings for a clock
controller, but you say here "for this clock", so what does "this" mean
here?

> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: ext-26m
> +      - const: ext-32k
> +      - const: ext-4m
> +      - const: rco-100m
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#clock-cells'

Isn't reg also required? Always? Do you have examples where it is not
required? How do you configure the clocks without "reg"? I see you
copied a lot from sprd,sc9863a-clk.yaml but that file does not look correct.

You have nodes with reg but without unit address ("rpll"). These nodes
are modeled as children but they are not children - it's a workaround
for exposing syscon, isn't it? The sc9863a looks like broken design, so
please do not duplicate it here.

> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - sprd,ums512-ap-clk
> +        - sprd,ums512-aonapb-clk
> +        - sprd,ums512-mm-clk
> +then:
> +  required:
> +    - reg
> +
> +else:
> +  description: |
> +    Other UMS512 clock nodes should be the child of a syscon node in
> +    which compatible string should be:
> +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> +
> +    The 'reg' property for the clock node is also required if there is a sub
> +    range of registers for the clocks.
> +
> +additionalProperties: true

false

> +
> +examples:
> +  - |
> +    ap_clk: clock-controller@20200000 {
> +      compatible = "sprd,ums512-ap-clk";
> +      reg = <0x20200000 0x1000>;
> +      clocks = <&ext_26m>;
> +      clock-names = "ext-26m";
> +      #clock-cells = <1>;
> +    };
> +
> +  - |
> +    ap_apb_regs: syscon@71000000 {
> +      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";

So here is the answer why you added MFD, but I still don't get why do
you need it for one child? It is quite a dance here and in your drivers,
instead of adding "syscon" to your clock controller.

This also pollutes the actual bindings because you did not add
properties required for clock controllers, because of describing here
the syscon part.

> +      reg = <0x71000000 0x3000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      #clock-cells = <1>;
> +      ranges = <0 0x71000000 0x3000>;
> +
> +      apahb_gate: clock-controller@0 {
> +        compatible = "sprd,ums512-apahb-gate";
> +        reg = <0x0 0x2000>;
> +        #clock-cells = <1>;
> +      };
> +    };
> +
> +...


Best regards,
Krzysztof
