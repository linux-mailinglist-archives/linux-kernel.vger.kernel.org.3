Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483FB4B2D17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiBKSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:46:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiBKSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:46:41 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF6B337
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:46:38 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id p7so238632vsg.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGzEnxcEEJBItkLvm908OZgOUF/bpGsxAyLCbIgSN18=;
        b=Qm1kB1q1h9+UE7rWQk/Vj+7KFeLmVi6kvurff0SEHTX89SWZ/Z6VNtgJd0punbm0ka
         3cVDODze7YEll7dPaeXMUxalRgbgJkcvzXlEr9mKKe+iiCc4ph3hd1kq0t7OLrxYAXig
         QcQKltEn5cUrRJ9GO60f/zBb4Sg8QDHrVZUBLHlSHY7S3HUCBx11exCehkMawjfpeXc0
         cmrKnvavnYr+QlwwHkoWzUrv9MKwRA8i+4Jhk1TaOH/trrKacV9adEtTFoGVrVdSAeAZ
         rmJlDsycRqn7LzeOgn6b3qvcaG/xRtZ4nWsiBePNqMRq8wjnrT0cJgKxGzUes+WqjA45
         0fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGzEnxcEEJBItkLvm908OZgOUF/bpGsxAyLCbIgSN18=;
        b=OO/6n3rCZhliW1di6azn9XLDgicTg748HC8PaTITm7Sx1tOPPOO3n5AOkibBXN4gI9
         J+4X/Aj0QdPku6kTNwxRTXsyOKnuOdQo7xRdsKCMK1h6cDMOnCceIT0CNisYCAEzDVCi
         SLz39iIEaqkWz6lkK3xhUSf6X6UBocd+b9zKFaLOh70+N3UCDHuc8aU6p/4LP5H5Y9V3
         V46D04aLx2ECb+SWKdN06UcJvy8KZR4mMyMXtxFo3l/LRmyhMkuZY/wCBRP7DeKs62sL
         VWMUD/rbQmuGGXXoV8SM6NG5oYrbw4XojzKh8Hdl5n0/L+90v4BX7cYiw9QpvmrmBw5k
         447w==
X-Gm-Message-State: AOAM531SMB7LFDtoLoR/6yHr/BOVDsYpU03Xn+R+isuiNfmESjMLN4av
        yXwTMXMjG7vaxngVspHwLDgScbzl0HXunV4xKbGVow==
X-Google-Smtp-Source: ABdhPJzQaCXfowUgoTps/aDsF9udVr66a7ww5AZbBipuAmwwwu+hPtXGefPD67zj5K1i7Xsv76oDUlBzwrRECxRLPIs=
X-Received: by 2002:a67:df83:: with SMTP id x3mr1003966vsk.86.1644605197315;
 Fri, 11 Feb 2022 10:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20220211164716.120880-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220211164716.120880-1-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 11 Feb 2022 20:46:26 +0200
Message-ID: <CAPLW+4kcm06SCpPoZm5PnsFF3AeWSp5bk6KKyMihSNmfvJ758Q@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: soc: samsung: usi: refer to dtschema for children
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

On Fri, 11 Feb 2022 at 18:47, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Explicitly reference the dtschema for USI children implementing specific
> serial protocol (I2C, SPI, UART).  The SPI schema is not yet accepted,
> so it will be provided later.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> ---
>
> Changes since v1:
> 1. Drop entire paragraph about USI nodes.
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../bindings/soc/samsung/exynos-usi.yaml      | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> index 58f2e9d8bb0e..a98ed66d092e 100644
> --- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> +++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
> @@ -17,13 +17,6 @@ description: |
>    child nodes, each representing a serial sub-node device. The mode setting
>    selects which particular function will be used.
>
> -  Refer to next bindings documentation for information on protocol subnodes that
> -  can exist under USI node:
> -
> -  [1] Documentation/devicetree/bindings/serial/samsung_uart.yaml
> -  [2] Documentation/devicetree/bindings/i2c/i2c-exynos5.txt
> -  [3] Documentation/devicetree/bindings/spi/spi-samsung.txt
> -
>  properties:
>    $nodename:
>      pattern: "^usi@[0-9a-f]+$"
> @@ -75,10 +68,17 @@ properties:
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
