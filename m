Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB355A0D60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiHYJyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiHYJyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:54:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120EAE846
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:52:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z6so27487109lfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/Xjm3zsGuKOlz7T50ivA2r0C2gPq3B5LrNzOmebJTKc=;
        b=VoKHBwr6XgeoBUP6orl2mDo0itQeZmtAVL7Ce3/QulBkW6wNNWoRjUMaGIGARvBgMZ
         jjdcSQybfLV+KDtA6/6UtdmwCJmeFJMREsXmTnpdBvukHBkITbl6+mCagHzFCDdmzCzy
         FhSFnmp9W+2uIi55Y/kJaxDeuIj79/AjCZ479t6WvmpB84Ypj7do2hR6yeLDGsX8SElG
         bx4GIw1T+rAktwui5kZpomK9zs7qvfa5uOmkXfnd78w7ayASPRfRTOpSTL+vgz8dMKVD
         r02UbVYozeSkKtfGDUgQmG+nwDMNHcUjRbgENUf95iD1HK41kmiYNS7GhImPde9CYNjI
         RMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/Xjm3zsGuKOlz7T50ivA2r0C2gPq3B5LrNzOmebJTKc=;
        b=RXUhyN0EIITPFBpXMRP3++d879w3pz2kMSApTB9LoQ7GeNRTmsxYRklTb4xWsCA42n
         1ZyHV0inXz9pJD1qTQnvzD8fkOcc8T6VQOvR0W0u0NWdtpqlXQXglaV6h4Kzd+A/QNyG
         SM8fFN41cnRvRMYHOeoYECv9dPIdKZx3+19rQrOS6ypERYfnyYVXxSjQS7PiQCqNdpwU
         1huucLfTwGYJbGooVKWkvpRmEbMKoYMZLxCl/yRqGu5wvXprvF6ewMiYOIcGCkIMfFq2
         60wKU6JTvPuZdGSb8giZV3hkeTSK5LwhQARJzXcoAMgI5ejZqHbAofm+ZwnJke+k1FCu
         6Gkw==
X-Gm-Message-State: ACgBeo0mr+i6e15t6Q1FQFy2CHzRjCB5wY4f3BicyB+cUXuxFCa8YWvB
        80WiTv0nwVW5rd94qY3HHaFWwoYk/HeB/nqPmEM77A==
X-Google-Smtp-Source: AA6agR6DhLp3M8c7w7bIMGuhp2NG6eDLu/F6OQp/nGH+cyEvLm4tf0Rmr/KNhBxMXmjxcratFTKQEiipPgKwSCTojGU=
X-Received: by 2002:a05:6512:6ca:b0:492:ef21:c085 with SMTP id
 u10-20020a05651206ca00b00492ef21c085mr938731lff.71.1661421104640; Thu, 25 Aug
 2022 02:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145649.3118479-15-robh@kernel.org>
In-Reply-To: <20220823145649.3118479-15-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Aug 2022 11:51:08 +0200
Message-ID: <CAPDyKFriYXh2EwqyPH7MMbt-2FAYZFrBhNFTFvNrPn=W_5VEKg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: Add missing (unevaluated|additional)Properties
 on child nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 at 16:57, Rob Herring <robh@kernel.org> wrote:
>
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  .../bindings/power/domain-idle-state.yaml          | 10 ++++++++++
>  .../devicetree/bindings/power/fsl,imx-gpc.yaml     | 14 ++++++++++++++
>  .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   | 14 ++++++++++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> index 6a12efdf436a..4ee920a1de69 100644
> --- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> @@ -20,6 +20,7 @@ properties:
>  patternProperties:
>    "^(cpu|cluster|domain)-":
>      type: object
> +    additionalProperties: false
>      description:
>        Each state node represents a domain idle state description.
>
> @@ -44,6 +45,15 @@ patternProperties:
>            state will yield power benefits, after overcoming the overhead while
>            entering the idle state.
>
> +      arm,psci-suspend-param:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          power_state parameter to pass to the ARM PSCI suspend call.
> +
> +          Device tree nodes that require usage of PSCI CPU_SUSPEND function
> +          (i.e. idle states node with entry-method property is set to "psci")
> +          must specify this property.
> +
>      required:
>        - compatible
>        - entry-latency-us
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
> index a055b3e819d8..777e1d852ddd 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
> @@ -43,11 +43,21 @@ properties:
>
>    pgc:
>      type: object
> +    additionalProperties: false
>      description: list of power domains provided by this controller.
>
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>      patternProperties:
>        "power-domain@[0-9]$":
>          type: object
> +        additionalProperties: false
> +
>          properties:
>
>            '#power-domain-cells':
> @@ -78,6 +88,10 @@ properties:
>            - '#power-domain-cells'
>            - reg
>
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> index 747622bdc57b..3b161e01f920 100644
> --- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> @@ -42,11 +42,21 @@ properties:
>
>    pgc:
>      type: object
> +    additionalProperties: false
>      description: list of power domains provided by this controller.
>
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>      patternProperties:
>        "power-domain@[0-9]$":
>          type: object
> +        additionalProperties: false
> +
>          properties:
>
>            '#power-domain-cells':
> @@ -85,6 +95,10 @@ properties:
>            - '#power-domain-cells'
>            - reg
>
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
>  required:
>    - compatible
>    - reg
> --
> 2.34.1
>
