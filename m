Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084CC4B299B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349885AbiBKQEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:04:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349786AbiBKQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:04:23 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607021A8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:04:20 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id g10so10819924vss.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2177MDBPIZL1asiHVf/tsGcpg3hhljXk+Tm8j7/No3k=;
        b=sA4/Wf+0wntyZPQ6IiqwzByik6CHGmnB7P2zQ8y8/xKYxL226mqIzNt4u7P56H4KIw
         I3cuY8rCvRlQCeEXc68tbz9TzLj3ZbPH/fUQXnAROZzhEuWOyBd7VtG8AsHR0rAPZ+JT
         Ngh/w4wAST9XeVQkPNeoMu4FiOQ89EH7W2oUZdA1Ce+iBw9qLOKVZBjEfteK7I1YjUQ5
         asTzjX2XTf8NG3mJpGQOdbCz+5SXw3h6Mor50ul3uOyqdm0nfK+wWbEt6TJlEKHF4dR/
         e6pop0pJpiX5Nv82BkrMTivpZUdt5plBXCg9L+inBFXHCFDXaXvrRNkig7q2nlXw7tVI
         bxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2177MDBPIZL1asiHVf/tsGcpg3hhljXk+Tm8j7/No3k=;
        b=cvO7oMct6kOl7afzu83dpOq9KdiODXDya7WKUwmwTxG54ZPfuzeIwrrfaMA+2fVbYl
         V31SRfvidbZ2qDjjV03KzH0WU3kvhVw/0Sf089arEEKjvkkxloA+FKp9MAdMWkessG1M
         m1gMN3+F4ah+ynzcoUtOifZFPkLXXGAxXUcRgUzw4rcK0mPYvS1Ga79vZ6ByKues406W
         dM22qOcJQgI0Xw0wqGb7bRimFSkRlYBsbdhjb2i4P+2jG8st0RRBeQu6QDKgdAx+TnNG
         o0o2zWHQlncjtIM74j5yPGEo3fnnOrhs3EeHQfyPeSJEBHiOpZNXVnbGr1od6GtV6+O9
         sxnw==
X-Gm-Message-State: AOAM531UAkcA6szd7J3homwryHSJZ+XYVsJYuAOdqn1bUj4MOZXchT3K
        Th3qvyZddF6wGL1aIAk2sZykhlE+ATM3DA5E5XWmWg==
X-Google-Smtp-Source: ABdhPJxFr2f3s+JC21d1a2/JiNCmvQEsxYrX2tqBKFp8IZsQA6946pHfR8OjMZf27/Y9k04rLB1h6uS7cwBpRlJa+O0=
X-Received: by 2002:a05:6102:ac8:: with SMTP id m8mr738550vsh.6.1644595459512;
 Fri, 11 Feb 2022 08:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20220208194119.46022-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220208194119.46022-1-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 11 Feb 2022 18:04:08 +0200
Message-ID: <CAPLW+4m9u4yFz84dQaMxNqCPauW6JTsOWRo5iJrkexHXOOsahw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: samsung: usi: refer to dtschema for children
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 at 21:41, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Explicitly reference the dtschema for USI children implementing specific
> serial protocol (I2C, SPI, UART).  The SPI schema is not yet accepted,
> so it will be provided later.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/soc/samsung/exynos-usi.yaml      | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> index 58f2e9d8bb0e..f3aae7e0e2e6 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> @@ -18,11 +18,7 @@ description: |
>    selects which particular function will be used.
>
>    Refer to next bindings documentation for information on protocol subnodes that
> -  can exist under USI node:

This whole paragraph doesn't make much sense now, because the doc
links it refers to are removed in this patch. Maybe it's better to
just remove the whole paragraph?

> -
> -  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
> -  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
> -  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
> +  can exist under USI node.
>
>  properties:
>    $nodename:
> @@ -75,10 +71,17 @@ properties:
>        This property is optional.
>
>  patternProperties:
> -  # All other properties should be child nodes
> -  "^(serial|spi|i2c)@[0-9a-f]+$":
> +  "^i2c@[0-9a-f]+$":
> +    $ref: /schemas/i2c/i2c-exynos5.yaml
> +    description: Child node describing underlying I2C
> +
> +  "^serial@[0-9a-f]+$":
> +    $ref: /schemas/serial/samsung_uart.yaml
> +    description: Child node describing underlying UART/serial
> +
> +  "^spi@[0-9a-f]+$":
>      type: object
> -    description: Child node describing underlying USI serial protocol
> +    description: Child node describing underlying SPI
>
>  required:
>    - compatible
> --
> 2.32.0
>
