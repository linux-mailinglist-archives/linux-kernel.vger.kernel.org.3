Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6BD4EBC73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiC3IPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiC3IPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:15:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A131122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:13:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bq8so25932609ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nRZKA6T0jUNwrROUPd9y6kJn8BOQ62nOT4hk3Y6l+nI=;
        b=EkzvN6fKET4X8OB7uUgPomYkRESjApXJvSKKV9YFpJ7q0S/OIjgJpwC59/N3w8I2yd
         Z9uBcC8dBFxJG3DaaJUdts5eeaUNLzbE56rCAUSmVRpgOjwsn7J+NE1rcRZupNrNdvH4
         AeCDDBfMq0UYFBp2XFuuXy1ux1xKh6j153LU2FFNCVlo3yme3QPVg2cVswRtrMGcUtd+
         96CX3ey1nTiAmKddLc1YGCKdD6jNc/EuI9SnmmGorLZiqv9+GVj2Dz1BKq9aZ6HJ++qc
         1gPjT7/nBYeo96B/ml3qMSYq9OW5xs2lqJCEZqfuukOzyNiX70DIWhoUS0ba9WKT4lJJ
         uHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nRZKA6T0jUNwrROUPd9y6kJn8BOQ62nOT4hk3Y6l+nI=;
        b=XUb6V2yT1g0RXvlHQxKHmXVnEcdh042DAMmw0cPsKsdlukCN5inPPPWTpENR/K7tOM
         UczuUSpUF8RRH525r9uC7sCyceaeuLvSWOaUtSQoznO6KdhvCEdk7yxwAqyOlj3eTHne
         5dTS4N56yIFH+icnZdCURFBx5DY349+Jk+OawLeqOP/QBtIRI+5yCAkLM9y8s5IsP8HI
         WmNg0wTzC97kemQsLQoHRKFGUFREJyOxUNn2v4lwRykK0qt+LOm+/kkZE9JfIBTZTGje
         N5rO5E0eMwwIQxXVEbuao64M2iSmgdhb+aVH1bKNufywHNxgNw1RTyqXRKZ6be6gC+77
         It1Q==
X-Gm-Message-State: AOAM531ayjj/fGDG1tKkNN0MLjAsPqpvqY6zsprCH44hHH2Vs6RPkM0G
        UrharkXpBVLk6djCA/Av7NPvMg==
X-Google-Smtp-Source: ABdhPJzF1fmIp0//f/EtnkUm/3SZLsTw7eMteeHdAxAYHa6r7GpwayTjwmaRzCHyvhuZECOCqICiAA==
X-Received: by 2002:a17:906:c1c6:b0:6d5:cc27:a66c with SMTP id bw6-20020a170906c1c600b006d5cc27a66cmr39754951ejb.650.1648628006852;
        Wed, 30 Mar 2022 01:13:26 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b006ceb043c8e1sm7968551eja.91.2022.03.30.01.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 01:13:26 -0700 (PDT)
Message-ID: <ecc821cb-4dd0-48e6-668d-45c178efbbf0@linaro.org>
Date:   Wed, 30 Mar 2022 10:13:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 5/5] dt-bindings: phy: uniphier: Clean up clock-names
 and reset-names using compatible string
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648617651-9004-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648617651-9004-6-git-send-email-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648617651-9004-6-git-send-email-hayashi.kunihiko@socionext.com>
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

On 30/03/2022 07:20, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clock-names
> and reset-names that can be taken by the compatible string.
> 
> The order of clock-names and reset-names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../phy/socionext,uniphier-ahci-phy.yaml      | 73 ++++++++++++------
>  .../phy/socionext,uniphier-pcie-phy.yaml      | 37 ++++++---
>  .../phy/socionext,uniphier-usb3hs-phy.yaml    | 75 +++++++++++++-----
>  .../phy/socionext,uniphier-usb3ss-phy.yaml    | 77 ++++++++++++++-----
>  4 files changed, 188 insertions(+), 74 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> index 14f7579e7daa..61d9306e1852 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> @@ -30,33 +30,62 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> -  clock-names:
> -    oneOf:
> -      - items:          # for PXs2
> -          - const: link
> -      - items:          # for Pro4
> -          - const: link
> -          - const: gio
> -      - items:          # for others
> -          - const: link
> -          - const: phy
> +  clock-names: true
>  
>    resets:
>      minItems: 2
>      maxItems: 6
>  
> -  reset-names:
> -    oneOf:
> -      - items:          # for Pro4
> -          - const: link
> -          - const: gio
> -          - const: phy
> -          - const: pm
> -          - const: tx
> -          - const: rx
> -      - items:          # for others
> -          - const: link
> -          - const: phy
> +  reset-names: true
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: socionext,uniphier-pro4-ahci-phy
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: link
> +            - const: gio
> +        reset-names:
> +          items:
> +            - const: link
> +            - const: gio
> +            - const: phy
> +            - const: pm
> +            - const: tx
> +            - const: rx

Constrain also everywhere clocks and resets, so here should be:
  resets:
    minItems: 6
    maxItems: 6

etc.


Best regards,
Krzysztof
