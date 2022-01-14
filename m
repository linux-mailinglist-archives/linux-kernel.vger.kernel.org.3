Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9240C48F092
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiANToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiANToO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:44:14 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:44:14 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id m90so18840162uam.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 11:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJwo/s0+Rc0eQOHKUUuPigE1fDH9XGzotavYCOzNXD8=;
        b=VU4KUwt/Tr60y5OcD7lGeZ4iqhOuQpB0rJIp+JJDe9auj39wn0SNCqzCbSHPZZvZcm
         KzzpLJAUph0oIQtHvzda9jYDtk7yarbxgwScNzwthEuQSSAOs+8A1Tz7kOGBwqJeWBvS
         8dxhsHVYZIUExjtrEz0jY2P6BRb9x6epZ/BCRM8RXUbuvqHOl4DRqEJAahzd12JhkbaM
         POQV/yAlb2eeZ8UrptPQRPyRCOj6D8O67lE5/jOhxOqZmjvOX4O311JM+518DkLY3VBX
         QgsGERpDbu3N1QZ6+XTgBVdbKmzbRlwAARQeqGVctyZxpPa2P3EX4Y6DgAxuye3QlCFS
         pdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJwo/s0+Rc0eQOHKUUuPigE1fDH9XGzotavYCOzNXD8=;
        b=H71FQ2nRqv6VLnmNCLwI2eFiT3pODSBmNsKX9sw23RwPJJ/qV1pw3UREIEGvInb0PO
         29tuD1RMWwooGZa2z3xXvd9988QXR8CNkuRhumLtCwWZxEeVcQBecnptBMgWkRdj3vej
         OESJ1BWHIrPTPKu+AgJFuR3YUTOI1tF0vEy0JzrMfjnV5H2xMcREwypfij33Xxd2cmWn
         RUrQC1C7HeKpWFqfkjOQ3C4x1xzLefZI0IDgXsvkoWmVvfe3857TLU+p+rvb92PJ65AP
         lXMAT0QJohkFhEVP9Qa6uT9wF4lI36nrTzpjbhHFHnrgDu6Fsy2QfptpZ5Sx2EKDHtF3
         Q83Q==
X-Gm-Message-State: AOAM533FX2Tle9LQ+GhQqaMrGF/kEM4L5mPwx2hPS8GWtxQYO9tzzQFJ
        Gjm/DA4QzxjNlVYsgyG8vSBKTpBX+IH6pxRGa5muxw==
X-Google-Smtp-Source: ABdhPJzvX1gfxrvD0KqCKoIZ0gtEGerrArvAnqtuAR9K17w7Zmq/f6VA7N0SrwIXOGieZ8tG75VjrE+70/sbOWCKB84=
X-Received: by 2002:ab0:13ee:: with SMTP id n43mr4749955uae.9.1642189453386;
 Fri, 14 Jan 2022 11:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com> <20220111201722.327219-19-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111201722.327219-19-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 14 Jan 2022 21:44:00 +0200
Message-ID: <CAPLW+4=FGEuaMYWXewkhzsPz1GgCsPJQAg5WKm_OOSxNmP-Uxg@mail.gmail.com>
Subject: Re: [PATCH v2 25/28] dt-bindings: pinctrl: samsung: describe
 Exynos850 and ExynosAutov9 wake-ups
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 at 22:18, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Older Samsung Exynos SoC pin controller nodes (Exynos3250, Exynos4,
> Exynos5, Exynos5433) with external wake-up interrupts, expected to have
> one interrupt for multiplexing these wake-up interrupts.  Also they
> expected to have exactly one pin controller capable of external wake-up
> interrupts.
>
> It seems however that newer ARMv8 Exynos SoC like Exynos850 and
> ExynosAutov9 have differences of their pin controller node capable of
> external wake-up interrupts:
> 1. No multiplexed external wake-up interrupt, only direct,
> 2. More than one pin controller capable of external wake-up interrupts.
>
> Add dedicated Exynos850 and ExynosAutov9 compatibles.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../samsung,pinctrl-wakeup-interrupt.yaml     | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> index 6b684a53119b..a822f70f5702 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
> @@ -16,9 +16,12 @@ description: |
>    controller.
>
>    External wake-up interrupts for Samsung S3C/S5P/Exynos SoC pin controller.
> -  Only one pin-controller device node can include external wake-up interrupts
> -  child node (in other words, only one External wake-up interrupts
> +  For S3C24xx, S3C64xx, S5PV210 and Exynos4210 compatible wake-up interrupt
> +  controllers, only one pin-controller device node can include external wake-up
> +  interrupts child node (in other words, only one External wake-up interrupts
>    pin-controller is supported).
> +  For newer controllers, multiple pin-controller device node can include
> +  external wake-up interrupts child node.
>
>    See also Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml for
>    additional information and example.
> @@ -32,6 +35,8 @@ properties:
>        - samsung,s5pv210-wakeup-eint
>        - samsung,exynos4210-wakeup-eint
>        - samsung,exynos7-wakeup-eint
> +      - samsung,exynos850-wakeup-eint
> +      - samsung,exynosautov9-wakeup-eint
>
>    interrupts:
>      description:
> @@ -41,7 +46,6 @@ properties:
>
>  required:
>    - compatible
> -  - interrupts
>
>  allOf:
>    - if:
> @@ -56,6 +60,8 @@ allOf:
>          interrupts:
>            minItems: 6
>            maxItems: 6
> +      required:
> +        - interrupts
>
>    - if:
>        properties:
> @@ -67,6 +73,8 @@ allOf:
>          interrupts:
>            minItems: 4
>            maxItems: 4
> +      required:
> +        - interrupts
>
>    - if:
>        properties:
> @@ -81,5 +89,18 @@ allOf:
>          interrupts:
>            minItems: 1
>            maxItems: 1
> +      required:
> +        - interrupts
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynos850-wakeup-eint
> +              - samsung,exynosautov9-wakeup-eint
> +    then:
> +      properties:
> +        interrupts: false
>
>  additionalProperties: false
> --
> 2.32.0
>
