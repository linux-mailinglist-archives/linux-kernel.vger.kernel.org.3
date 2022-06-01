Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9FF53A568
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiFAMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353085AbiFAMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:47:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DED64D9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:46:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z13so1847046ljn.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyyhorHqYhRzxEyqIbi/Zswxz0+oi9F21Ok1yg1RhLA=;
        b=ZH9WrW/SwuFpI0VP8M8Zc+awMiZ94uKV8XXHRXo02sxphluQkud6/bWPTPeHxT6DYH
         +KlddEaCrGu4aFj3bipnxYbruluqtcgSmkck5dIl/2tbrvcMOp+vJS5CcD6a+yVITzb+
         nJr3OLE8xMQ6hncurf80YJ3Dx49D28uu1nkToksJG86y1qVvCeDrzqER9okktApqd0zI
         tW8Kqmzw4lp4BQnL8S2vFpE9wTC3adLGT+SB0eccRmww4tz3FSSk2sbg6kbRPTKPHE2A
         gSNctdP9b5staF+2bTWH4s8IZh1KdT2zZsSDh1LFzgNSBc1KcT203rI9fNR1HqsEOlc5
         LpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyyhorHqYhRzxEyqIbi/Zswxz0+oi9F21Ok1yg1RhLA=;
        b=h8mBjEi7eLQ+WhB+xM4b7ZAgbXB3clt2jJaPWs4C5H0pI+6ETuuOO6Un1351VUj52r
         esjEVk5ewvSdl1uSHMxg0subK+Ug9dHZwE6gqL4Jm2KApLm21qPFog3f90ag9lziUSsS
         XgY7WaPG9rOlNOfxgxMvEvjfeRY5d2NQl+1oGn7qB45rwuMKzVq9sfgeKci/Z7YTWl5U
         VUGx2zrm9C1do5eDw3Sko5+O646l33AlSwjsgJ7xTUfSPTU1tyN2UEWU83GNeDP25UGe
         F0ffSQijz0dGTMDf0BK26l0egeO7fxbYOFCYNKd+EZAJyVuzMp93+vjMJS4402pyuRTB
         d0Dg==
X-Gm-Message-State: AOAM530etXfgSb4lP69w4TG/r5hkyxCLKWWbIptFl7pvaR/yNtD4m2s0
        NBA27k7a5EbXYKUlICxunWjCMQ84jKcQRhnh+Ghptg==
X-Google-Smtp-Source: ABdhPJwt9gvrgwBFEfOMg53Brjr6mPeHznMhGr3I+MHKcTP0xi6t5Xs94b+k8tX0FX5KWt8rkYMl56bGgfyVkbUqQnI=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr40059816ljk.16.1654087617409; Wed, 01
 Jun 2022 05:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220526014204.2873107-1-robh@kernel.org>
In-Reply-To: <20220526014204.2873107-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:21 +0200
Message-ID: <CAPDyKFoh5FyRDxr22XnkOd76MG4YjkvqL039=+qHGZKwfdFquw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Fix unevaluatedProperties warnings in examples
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hu Ziji <huziji@marvell.com>, Al Cooper <alcooperx@gmail.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, 26 May 2022 at 03:42, Rob Herring <robh@kernel.org> wrote:
>
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples. Fix the warnings by removing
> spurious properties or adding a missing property to the schema.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml  | 2 --
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index b672202fff4e..5ecdac9de484 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -75,7 +75,6 @@ examples:
>        sd-uhs-sdr104;
>        sdhci,auto-cmd12;
>        interrupts = <0x0 0x26 0x4>;
> -      interrupt-names = "sdio0_0";
>        clocks = <&scmi_clk 245>;
>        clock-names = "sw_sdio";
>      };
> @@ -94,7 +93,6 @@ examples:
>        non-removable;
>        bus-width = <0x8>;
>        interrupts = <0x0 0x27 0x4>;
> -      interrupt-names = "sdio1_0";
>        clocks = <&scmi_clk 245>;
>        clock-names = "sw_sdio";
>      };
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index c79639e9027e..aca1a4a8daea 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -56,6 +56,9 @@ properties:
>        - const: core
>        - const: axi
>
> +  interrupts:
> +    maxItems: 1
> +
>    marvell,xenon-sdhc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
> --
> 2.34.1
>
