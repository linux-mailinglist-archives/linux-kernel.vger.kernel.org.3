Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADDA505074
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiDRMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiDRMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:22:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAECB1EEFD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:18:23 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so26534794ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=304FwvbODPc/e7NTdlGUu0OxXKV91QMvJtVzbIwOzsY=;
        b=oauAcvfa+/M3D5189r4makzPKYi0gCRiGm46EFxvtnJHKSzGdOdw+IekjUokWg84mc
         /rr5jvl3u5ivgV3bvm3wQyLnaP5CfC36SOlsJU4Wevk5/RREie3FSqKEDgZS1TmOWAxH
         aJEwSBcXIiX0WBv/QSZqjCivrgFhZLNODCv9X4f2om5D3JhiJp87qgRGS7DMYfYcTUSQ
         pcoco8zBK29ToYbxN7NYkAzgTqL/G8njWL3GcEqAKChlRSwyFxORKmBbLMb0wJ42rvSS
         k5RX1MVZkQ5ZakdB2Tomatx5c2GrMwJubXZQwEVZV9Di+0O3WSTNWPBWRoz+8B+RSpxs
         +jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=304FwvbODPc/e7NTdlGUu0OxXKV91QMvJtVzbIwOzsY=;
        b=Hieznn84v1vf93LXt0pmdJ02A/Rt5IY3ROXaM2WUXvzQPR54pXRiF8yvFuc0HXsIUQ
         kbg5/BCC7IDeVLz8C5iihTQ1tPNjWdP8rGpjhfbZummmzrs9RXuZ4C0AxCHUxXKh8ZYs
         8Q5uaYxivcxRC0K8zfM5HRBZ191C5acYlDevO6IOB/8wp/SOVlyDRCpZCvRr7cEXr/ul
         tA8Wpe3EnWb2P8kF0yvZzbap4jCQbN+SiOfWPtPVYEBy1XPkN3fCJzweGqe6VqL4VeJJ
         sEIr67ZMVndGUjCKNHJDXZqKx99xMoq5meBRVEg+BUp90MMbgpMjICEPxw6S0XmwQ86L
         MdnA==
X-Gm-Message-State: AOAM532hOJmc1x2HSKhDLVEKY2NBXe61rH4DLfvRiSbN+RerF3HPm7XP
        PugwxByoI0GQWDdaft7YxiLA7g==
X-Google-Smtp-Source: ABdhPJwitUmBeZrL4/JQi7iDB4R8V82XjKuvEHdTLZYkZ4ZYC6c9hFCwam2fEu49tYxcY++zvLSjng==
X-Received: by 2002:a17:907:7206:b0:6ef:b47c:e5ec with SMTP id dr6-20020a170907720600b006efb47ce5ecmr3565212ejc.351.1650284301960;
        Mon, 18 Apr 2022 05:18:21 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h23-20020a0564020e9700b00420fff23180sm6441720eda.41.2022.04.18.05.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:18:21 -0700 (PDT)
Message-ID: <2f8d2f6a-32dc-15cc-321c-f75721edf8a2@linaro.org>
Date:   Mon, 18 Apr 2022 14:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/5] dt-bindings: clock: Document MA35D1 clock
 controller bindings
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ychuang570808@gmail.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, will@kernel.org, soc@kernel.org,
        cfli0@nuvoton.com
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-3-ychuang3@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220418082738.11301-3-ychuang3@nuvoton.com>
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

On 18/04/2022 10:27, Jacky Huang wrote:
> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
> 

You skipped the review tag, so I assume because of amount of changes.
Usually it is nice to mention it...

> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> new file mode 100644
> index 000000000000..d0d37c5e84af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Clock Control Module Binding
> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description: |
> +  The MA35D1 clock controller generates clocks for the whole chip,
> +  including system clocks and all peripheral clocks.
> +
> +  See also:
> +    include/dt-bindings/clock/ma35d1-clk.h
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  assigned-clocks:

What about clocks? This depends on clocks. What clocks do you want to
assign if they are not an input to the device?

> +    minItems: 5
> +    maxItems: 5

This is different than before. minItems should not be here.

Why do you need assigned-clocks in the binding at all?

> +
> +  assigned-clock-rates:
> +    minItems: 5
> +    maxItems: 5
> +
> +  nuvoton,clk-pll-mode:
> +    A list of PLL operation mode corresponding to DDRPLL, APLL, EPLL,
> +    and VPLL in sequential.

This does not look like a binding which was tested. Read
"writing-schema" and test your bindings.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 5

No need for minItems.

> +    maxItems: 5
> +    items:
> +      enum: [ 0, 1, 2 ]

You need to describe the values in description, what's their meaning.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> +
> +    clk: clock-controller@40460200 {
> +        compatible = "nuvoton,ma35d1-clk";
> +        reg = <0x0 0x40460200 0x0 0x100>;
> +        #clock-cells = <1>;
> +    };
> +...


Best regards,
Krzysztof
