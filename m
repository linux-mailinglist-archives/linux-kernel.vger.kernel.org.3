Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FC53714B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiE2OOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiE2OOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:14:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B3341FB7
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:14:05 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x17so2497653wrg.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mEuzltOk2SmlGSQoqUcCT04p3+aPKT7KL50TqW1hRU4=;
        b=UrnO8f1QXH1qGHpCRUSKoFvu/FvQ8QlP10lVWoqZUsLito8SIDvlVhINjkqKDA5P5E
         u5vdr414ln4wHUmBBWmb8ebNEwKujcycoBAcIisho7ngUdTAaBCVxqMR3MAD/o3mxQlg
         YNI28n5tVbNcgooN6FgXd8pPqHwQmnjrLE/Ou14ESY9Kf6lfmJW/MnhnBzlDI1x9cNfg
         xH8EfULSEoWoK8EMuaQlO7Ruu+h/ilK2G/ItdkcFZd4R9Y2ImijelxU44UMRqeUGTLSa
         xl6Uzks02RdwsTl3JK3z8O+/v+SvUgR65VqnSEnGBcoIH2hk6glLwGyPp/rCFMyIteLb
         VjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mEuzltOk2SmlGSQoqUcCT04p3+aPKT7KL50TqW1hRU4=;
        b=yTgw6FyhUXEHuOxJxZEDw+f9/5fa59NXhfwJc5cd6wcwveNrUzpNv72YSU+qzvtdfk
         XiF1REGvRv3emDTgCcAHEWTq+uK43s+cb6KcTjBfng+vJp9FYvJyl7Gi/AOR4gPTZMJI
         xcLpVntKJ0cAcpG1Y5ej59Qv4qAqUkZmhYoYBUwQlporoOu+fTAPtd+I9B0W3z7ned87
         W5LMahpXhwQkvT83lH9WpIIg/m1unD6RIrkQ5enOQz2Fyv0HDGkJbpaFjqguoD1gXwBB
         QQmXuFY8E+4ddGWJXDYWpKR/Vx1tYZ6fPhN5GsxLHomgmBOgGy5fzYh9EmXz7aX8gUcH
         +8jQ==
X-Gm-Message-State: AOAM532Os7t8T113drSEZsJhqjiMUdnL0lZChYEjc3LTZ93AHf6FtYhi
        EccgdYh70RL5NcLU/G5WBFHzT4F3pcJk+26O
X-Google-Smtp-Source: ABdhPJwYOdrRmjwrty8tNcdSD6hDUv6WqLcalA3F1RhO5KCZKjsFICiDObrIV2x5hSlBPgeIYNg1mg==
X-Received: by 2002:a5d:47a8:0:b0:20f:c57e:3e0b with SMTP id 8-20020a5d47a8000000b0020fc57e3e0bmr34977878wrb.305.1653833644120;
        Sun, 29 May 2022 07:14:04 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bi27-20020a05600c3d9b00b00397122e63b6sm7457298wmb.29.2022.05.29.07.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 07:14:03 -0700 (PDT)
Message-ID: <0b561964-5718-ab1e-34c3-07eadae5b04e@linaro.org>
Date:   Sun, 29 May 2022 16:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add
 clock property
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, robh+dt@kernel.org, nm@ti.com,
        vigneshr@ti.com, kishon@ti.com, krzysztof.kozlowski+dt@linaro.org
Cc:     lee.jones@linaro.org, rogerq@kernel.org,
        devicetree@vger.kernel.org, kristo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com
References: <20220527083556.18864-1-r-ravikumar@ti.com>
 <20220527083556.18864-2-r-ravikumar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527083556.18864-2-r-ravikumar@ti.com>
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

On 27/05/2022 10:35, Rahul T R wrote:
> Add a pattern property for clock, also update the example with
> a clock node
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/mfd/ti,j721e-system-controller.yaml     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index fa86691ebf16..e774a7f0bb08 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -48,6 +48,12 @@ patternProperties:
>      description:
>        This is the SERDES lane control mux.
>  
> +  "^clock@[0-9a-f]+$":
> +    type: object
> +    $ref: ../clock/ti,am654-ehrpwm-tbclk.yaml#

Full path please, so /schemas/clock/.......

> +    description:
> +      This is TI syscon gate clk.

Don't use "This is". Just describe it without need of full sentence.
"syscon gate clock" is a bit unspecific and actually looks like you
describe "clocks" property...

> +
>  required:
>    - compatible
>    - reg
> @@ -79,5 +85,11 @@ examples:
>                  <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
>                  /* SERDES4 lane0/1/2/3 select */
>          };
> +
> +        ehrpwm_tbclk: clock@4140 {

No need for label.

> +                compatible = "ti,am654-ehrpwm-tbclk", "syscon";

Messed up indentation.

> +                reg = <0x4140 0x18>;
> +                #clock-cells = <1>;
> +        };
>      };
>  ...


Best regards,
Krzysztof
