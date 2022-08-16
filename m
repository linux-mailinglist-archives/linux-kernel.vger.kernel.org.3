Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F555958B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiHPKmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiHPKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:42:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0AD0236
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:59:42 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x9so9987340ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FUFa0tAMMh/TtMA4JL4AeBH252o6vhFi0++29Z10b24=;
        b=zVE9sjyWG25xLS+qfczRwgEvdChwcxYO9y9ThgToxbiD92NoriI2/CugHb+2TF3ZFF
         /VXzNtQOnWx3R0kfeyzg8WfW+5EUt9bgy1gW7Yegna+Po6NGdGDJgHl5Nxz6UXRqKqFP
         fTc++mSbFkWyzCFK0wXmxpUKsuOcNjJgDR39utT/D3NxyGfYnbhTWBdIuj6akm4Bzko7
         vz8sowWFwXLFNBVl4aaNXSw+3yD83buEjvoUZ2WYEtGbit0Tgtc5xyxrwWGU2kIA2HyZ
         y/47r3YT6oT3mH6gKYu00BulMGdQcHyDyBVfKhGRcfRG38Zqvj/ELALRHaU37DJ7c1MF
         Om0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FUFa0tAMMh/TtMA4JL4AeBH252o6vhFi0++29Z10b24=;
        b=66d6AnttEx2mDnbp3kru8VsX361h9TBAKZ3PTWbOodEhAmkTcH+uyrn/QO24p6QZzS
         tkFHO6bKMtih2S28xsF0EyKzasVYZGd+VngyALxWQ13DrNoPZqB+GByqsvisCO/7XZQu
         KqOltmvvYRXilNzIHO4kV+CfJdZ8pXI6j+eioyVxMAN2UKIstzDgOi0DF/+oRUTHl9AT
         BpdjIA8Ng1VfmmYwfq/kUNh58nF4tX5qcOAX35QxFgSpjNAYcD2+FQfXB3cAGFiSmAqu
         VLq8jb6fYnm/QG5ZdR6tR+WwomDvaHA9tmhsaJEqHFNTmLypD+l+lk6ikBc1CNaKMg9j
         ej7Q==
X-Gm-Message-State: ACgBeo2wPvJG+rqTsEnoCjaCagDncScYyuE5mgYncWlrB6BLG3+RQUbc
        Ci10UbgEoFLl/70CL1WASJzV/A==
X-Google-Smtp-Source: AA6agR6vA3wQXqUJnn2nYR4Cb7jBvUzx/9ftdty6xbOM/7CP2StR5ZpMn2Us3AJtLeblD6qmRz2oQg==
X-Received: by 2002:a2e:b74a:0:b0:25f:3f72:9210 with SMTP id k10-20020a2eb74a000000b0025f3f729210mr6307340ljo.8.1660643981080;
        Tue, 16 Aug 2022 02:59:41 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id o5-20020a2e9445000000b0025e0396786dsm1741897ljh.93.2022.08.16.02.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 02:59:40 -0700 (PDT)
Message-ID: <3e23c288-7065-a3fd-c326-8d66e168ba41@linaro.org>
Date:   Tue, 16 Aug 2022 12:59:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/4] dt-bindings: sram: sunxi-sram: Add optional
 regulators child
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220815043436.20170-1-samuel@sholland.org>
 <20220815043436.20170-4-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815043436.20170-4-samuel@sholland.org>
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

On 15/08/2022 07:34, Samuel Holland wrote:
> Some sunxi SoCs have in-package regulators controlled by a register in
> the system control MMIO block. Allow a child node for these regulators
> in addition to SRAM child nodes.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v3:
>  - Require the regulators node to have a unit address
>  - Reference the regulator schema from the SRAM controller schema
>  - Move the system LDOs example to the SRAM controller schema
>  - Reorder the patches so the example passes validation
> 
> Changes in v2:
>  - New patch for v2
> 
>  .../allwinner,sun4i-a10-system-control.yaml   | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> index d64c1b28fb61..915ca85c3f10 100644
> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> @@ -56,6 +56,10 @@ properties:
>    ranges: true
>  
>  patternProperties:
> +  "^regulators@[0-9a-f]+$":
> +    $ref: /schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
> +    unevaluatedProperties: false

unevaluatedProperties is not needed. Your other schema does not allow
anything else here.

> +
>    "^sram@[a-z0-9]+":
>      type: object
>  
> @@ -130,3 +134,28 @@ examples:
>          };
>        };
>      };
> +
> +  - |
> +    syscon@3000000 {
> +      compatible = "allwinner,sun20i-d1-system-control";

Your other example uses simple-mfd, syscon... A bit confusing.

> +      reg = <0x3000000 0x1000>;
> +      ranges;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      regulators@3000150 {
> +        compatible = "allwinner,sun20i-d1-system-ldos";
> +        reg = <0x3000150 0x4>;
> +
> +        reg_ldoa: ldoa {
> +          regulator-min-microvolt = <1800000>;
> +          regulator-max-microvolt = <1800000>;
> +        };
> +
> +        reg_ldob: ldob {
> +          regulator-name = "vcc-dram";
> +          regulator-min-microvolt = <1500000>;
> +          regulator-max-microvolt = <1500000>;
> +        };
> +      };
> +    };


Best regards,
Krzysztof
