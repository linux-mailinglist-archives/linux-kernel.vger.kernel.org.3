Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A9B46E629
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhLIKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhLIKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:09:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDCC0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:06:11 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z7so10915910lfi.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1owymgiCbwjtMOY3GwDKTTRv4aRJ4ddqlYjVacAxeY=;
        b=IEAlki6D4NihEbGixc0ZB8q1mWKYeVyBm450yjRD6H+nFTePjftgbNP1DSbjKJC/wn
         aA6G1S7zyTmWIk2wnFu1f0vt67RzKqsiulULcMDgUC+z69q+XtVhP3Eu0UC0yezAwjNB
         vX82i6L0vOPMOqpqTVSvYYCMeFCK7iTHxJMGDkkT5ZH+GnHs9SODYR5MYMhq1DGi4GzO
         jzkp592RVDVKnCu1VIpNL7vqWdE78LfoQ/N7ed/l18v1uQfKPEjZBRH2eRUjtNTKCBPA
         nWa9O+uPUfVM+lsrddwkRKNoYhpf4nu+XyMW4JWKq2CaEyoOmsYKC8jQgxIh6QFH8/oT
         jcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1owymgiCbwjtMOY3GwDKTTRv4aRJ4ddqlYjVacAxeY=;
        b=Ff5I+H1MuCD+TluLunWt2cI/8CMfDnvc6f36jkLDD+ti97RCHY5GGl6D3/IKXrmDHP
         pAATpoWFMUuo0DYbiENOhSsjgx3toyetM8C+xt2m8GmJTXoocsMeA4eUkjjMMf1QSmQ7
         Ag5UrYg+vkF1vcvvwF+nK85R3pQUjPOpd5AQqu81Qj8kTgP8aBIrIIv2Tlj+0X82ghf8
         7m1q040tBgkDlav6WMBwRVuRkUgf1wAp/yaNRRMXHCg/B/Jxaxk/CAhqunLwt4a7zQbr
         TZgpwuJDoChjjE4OJbs/hqhTWGN74Xo0XmT4rxGQmZcnnG/jB0Z0WGeN9w3DJ2t1F3ih
         GKEA==
X-Gm-Message-State: AOAM530j12VHGx8ldmTp8rjlNQ3b2ARByeEFfqUO/KW9HaLTIvmYCFU1
        gPHcF068MSc4yhe33fbB2FQbSDVV75S3pYYuMbJmDA==
X-Google-Smtp-Source: ABdhPJwOXRN/8lU2AYgTrJejBXDpm4hFI6pejaLy27VCQ/luFqzDGRy/0PN4sedVg8qGNEQznzbU3QCdxNwh1mp0znQ=
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr4875603lfg.373.1639044369640;
 Thu, 09 Dec 2021 02:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20211206174201.2297265-1-robh@kernel.org>
In-Reply-To: <20211206174201.2297265-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 11:05:33 +0100
Message-ID: <CAPDyKFpd=bdMOCe2cScdLjhr97bZ+VLFr7yn8j48d4KCcHaqtw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Add missing properties used in examples
To:     Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <Kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 at 18:42, Rob Herring <robh@kernel.org> wrote:
>
> When 'unevaluatedProperties' support is enabled, the following warnings
> are generated in the mmc bindings:
>
> Documentation/devicetree/bindings/mmc/mtk-sd.example.dt.yaml: mmc@11230000: Unevaluated properties are not allowed ('reg', 'interrupts' were unexpected)
> Documentation/devicetree/bindings/mmc/sdhci-am654.example.dt.yaml: mmc@4f80000: Unevaluated properties are not allowed ('sdhci-caps-mask' was unexpected)
> Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.example.dt.yaml: mmc@5a400000: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
> Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: Unevaluated properties are not allowed ('dmas', 'dma-names' were unexpected)
> Documentation/devicetree/bindings/mmc/arasan,sdhci.example.dt.yaml: mmc@80420000: Unevaluated properties are not allowed ('resets' was unexpected)
> Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>
> Add the missing properties as necessary. For pl18x, drop interrupt-names
> as there isn't any use of it when there are 2 interrupts.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wenbin Mei <wenbin.mei@mediatek.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml  | 3 +++
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml     | 9 ++++++++-
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 +++
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml        | 6 ++++++
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml   | 2 ++
>  .../devicetree/bindings/mmc/socionext,uniphier-sd.yaml   | 6 ++++++
>  6 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index de6f076e0ece..83be9e93d221 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -118,6 +118,9 @@ properties:
>    phy-names:
>      const: phy_arasan
>
> +  resets:
> +    maxItems: 1
> +
>    arasan,soc-ctl-syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 47595cb483be..fbc866d9bb2f 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -60,6 +60,14 @@ properties:
>      minItems: 1
>      maxItems: 2
>
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
>    power-domains: true
>
>    resets:
> @@ -213,7 +221,6 @@ examples:
>        arm,primecell-periphid = <0x10153180>;
>        reg = <0x52007000 0x1000>;
>        interrupts = <49>;
> -      interrupt-names = "cmd_irq";
>        clocks = <&rcc 0>;
>        clock-names = "apb_pclk";
>        resets = <&rcc 1>;
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 19621a2f8beb..8d5cef0d3039 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -116,6 +116,9 @@ properties:
>        - const: ahb
>        - const: per
>
> +  power-domains:
> +    maxItems: 1
> +
>    pinctrl-names:
>      oneOf:
>        - minItems: 3
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 82768a807294..faf89b0c918f 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -36,6 +36,9 @@ properties:
>            - const: mediatek,mt8195-mmc
>            - const: mediatek,mt8183-mmc
>
> +  reg:
> +    maxItems: 1
> +
>    clocks:
>      description:
>        Should contain phandle for the clock feeding the MMC controller.
> @@ -62,6 +65,9 @@ properties:
>        - const: axi_cg
>        - const: ahb_cg
>
> +  interrupts:
> +    maxItems: 1
> +
>    pinctrl-names:
>      items:
>        - const: default
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 224303f5b913..9fbf16b3bc8d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -48,6 +48,8 @@ properties:
>        - const: clk_ahb
>        - const: clk_xin
>
> +  sdhci-caps-mask: true
> +
>    # PHY output tap delays:
>    # Used to delay the data valid window and align it to the sampling clock.
>    # Binding needs to be provided for each supported speed mode otherwise the
> diff --git a/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
> index 56f9ff12742d..a586fad0a46b 100644
> --- a/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
> @@ -26,6 +26,12 @@ properties:
>    clocks:
>      maxItems: 1
>
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    const: rx-tx
> +
>    reset-names:
>      description: |
>        There are three reset signals at maximum
> --
> 2.32.0
>
