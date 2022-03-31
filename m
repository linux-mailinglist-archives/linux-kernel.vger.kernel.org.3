Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFBB4ED3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiCaG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCaG3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:29:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2262C1ED04B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:27:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bh17so6445470ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hnWdlmqxMOaLiEjonagZkR7OoglUhQY9jRtY4sA56yg=;
        b=TQGgkFMOMKjrhzhg1buAAt2dln2/Y76JCQKayw3/AFBjl/55VPEBjFtHJqvwUHABYk
         zx4NjQmIc+cYgyHYx8xMqr2J0u3y1FHnplY9mYqctDMDmYAmLsvETVP667ksLnSEaDyk
         4J+FT5x58ISqcbHNsc4f8ddXZ5H98q4AjI1NK63c7XiJUoTyAp/LIWuNdehwxpzTwVf0
         VsEfqqHBCDcJdln/X1o345dU1335IvQ4VHOEZUeNan3PtDj6FK0L2EbpidUsNX2qRCiX
         611Fe7bLspzdEEnWuHjeSxsE+Y9JWeO2xkeTxyZyy5k+JCfL94rKKOXkri7kenKsiFlF
         aqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hnWdlmqxMOaLiEjonagZkR7OoglUhQY9jRtY4sA56yg=;
        b=EqsnKexBZs5JcjyLRuOeVlp7uxXOtptaG1UN+EpFcp9b6sc+fVtH1OdbJNJ3DCmyTe
         3MQTl6aAtgSqxULdSZm96TkggWLn3XZhOcEW4r2POcEny+06lN2pnhBkyCHQtND7fjGF
         b1FKh+sdKR5jwElbXqNiWSowDvBsqfxk2P8Y65LPPaPCPvOzbqKOiQUJPxs/1hcn7O2O
         s7uoYsEflurBXofpTkg1pF1BvvdVM7i9SBv6CM+nc9V9ywp527SRkl2XFw/MmJjg9yFc
         eF59uyYHNKt6OjUDRdr6oSkKTxwq7p9Zldkm0hM2VtLNrAKqx0Yx/51B/XsinWfI8tNw
         LMsA==
X-Gm-Message-State: AOAM532NPDswI0RTbPa2h1ojR1R9HlOMQSUkNiFvnouHRXAFIE0WqjBa
        h/mNqntb75YnigrAh++dVQ1qFA==
X-Google-Smtp-Source: ABdhPJznK1yc+Q8z09lYsKMyARLvyV/F5B8LDTxytJ3B10ASFD6OyJpaHp5kCShMKGp4w4XQ85EeeA==
X-Received: by 2002:a17:907:a422:b0:6e0:238c:4f44 with SMTP id sg34-20020a170907a42200b006e0238c4f44mr3526205ejc.257.1648708056576;
        Wed, 30 Mar 2022 23:27:36 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm9017489ejz.199.2022.03.30.23.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 23:27:36 -0700 (PDT)
Message-ID: <6be6ffd1-a303-f3f2-0424-0ce622de197f@linaro.org>
Date:   Thu, 31 Mar 2022 08:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller
 bindings
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, cfli0@nuvoton.com
References: <20220331024256.14762-1-ychuang3@nuvoton.com>
 <20220331024256.14762-3-ychuang3@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220331024256.14762-3-ychuang3@nuvoton.com>
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

On 31/03/2022 04:42, Jacky Huang wrote:
> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> new file mode 100644
> index 000000000000..bf5474b10420
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> @@ -0,0 +1,59 @@
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
> +    dt-bindings/clock/ma35d1-clk.h

Full path needed.

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
> +  clocks:
> +    maxItems: 1
> +
> +  assigned-clocks:
> +    maxItems: 4
> +
> +  assigned-clock-rates:
> +    maxItems: 4
> +
> +  clock-pll-mode:
> +    maxItems: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  # clock control module node:

Useless comment, remove it.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
