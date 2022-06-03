Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3653C62B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbiFCH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiFCH3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:29:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E0831926
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:29:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h23so11304338lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8cBUqrsGxB4XcVoi60hXgapYNgMM6ASO6X8ICu7KKU=;
        b=JvmvI66BY5PdeX47FaqqIHw7mLqXqItCJI2ocvGECxB3NYXCHtB5RhhuHVSyqk3wjb
         yTciGHdf3j7QPV9BDxQA5C1ivbsKedkgbnMOoLa0pmnmIiogdalvylr5eNkLPH+5F50O
         F5IOCgST9a2GkFdKbp8IJvC1sPoNKbqXmy98OzXGd7po39VQOiOAMkmDJbGr/E3TbBoi
         SB0af/lCJH2f5gIYHJRppKrpnuz3d4gnBwh13Pc2gh5nyZlsVx5eeXw76n1ej34rJ2Cu
         yNHH/dPQk1WXojTN6IE8Wm09Uhm4zBLgAiUr99fduVZ4kbhYgSzCbel5NsQWXqkw4SWN
         EwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8cBUqrsGxB4XcVoi60hXgapYNgMM6ASO6X8ICu7KKU=;
        b=h6l9cD+aFQ1RqvQtAaDaJyagQGU0+d/LvvQGhbdB+4Z6PELJ3WQVI5Ro41NZBuFchq
         Ea3rq3NZyF2+JWLlg86zFYPVnx5xl0dEKGjVYzvsUCfaYgqrNmeVDXxNH5f7yOaIq0aK
         qc4rHC2ZK8b+qeAtpSC1S0TZCdu2ML5jhZkjO90LaUX/FAG21wcPrZuM+IOSwcsRArse
         GpVR8o37EAZHr8EKUFfpiv/CdMisJwjovisJfKrJpiJLYl8uFayynvA6cJPKS5oVro+e
         411+/8MYoDegFHNtzHxl50r/v+k66PxOE08zquoc8ep2lvuRR3T30aUqnrREP6R6+sYq
         aijA==
X-Gm-Message-State: AOAM533mBJNdHa4FT5ty56bUoUp/3PwfyfXMLVnhCbSke3k5vSbRFgxf
        3dYGlqyP68twnAcZHGnC8N83p09xFc2FUSFgrNwUXw==
X-Google-Smtp-Source: ABdhPJzxpMb+QpO2Y7L876DSFjPQ47OzOcrUerdHXU9ipXkXHCtJ7nzmEOMWqo0jbtrVkxxqENpbmvJz6nh0gPZePWs=
X-Received: by 2002:a05:6512:403:b0:479:1627:a9b7 with SMTP id
 u3-20020a056512040300b004791627a9b7mr2887343lfk.233.1654241354405; Fri, 03
 Jun 2022 00:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220525015140.384-1-axe.yang@mediatek.com> <20220525015140.384-2-axe.yang@mediatek.com>
In-Reply-To: <20220525015140.384-2-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Jun 2022 09:28:37 +0200
Message-ID: <CAPDyKFr25qbAb9DdCpu6Cp9NyK35YAv745Duw_ht7BQc+pQF=A@mail.gmail.com>
Subject: Re: [RESEND v12 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
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

On Wed, 25 May 2022 at 03:51, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 50 ++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 2a2e9fa8c188..e83bf10281d6 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -72,12 +72,27 @@ properties:
>        - const: ahb_cg
>
>    interrupts:
> -    maxItems: 1
> +    description:
> +      Should at least contain MSDC GIC interrupt. To support SDIO in-band wakeup, an extended
> +      interrupt is required and be configured as wakeup source irq.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: msdc
> +      - const: sdio_wakeup
>
>    pinctrl-names:
> +    description:
> +      Should at least contain default and state_uhs. To support SDIO in-band wakeup, dat1 pin
> +      will be switched between GPIO mode and SDIO DAT1 mode, state_eint and state_dat1 are
> +      mandatory in this scenarios.
> +    minItems: 2
>      items:
>        - const: default
>        - const: state_uhs
> +      - const: state_eint

Don't you need something along the lines of the below instead? I mean
the "state_eint" isn't always needed, right?

oneOf:
  - items:
      - const: default
      - const: state_uhs
    - items:
        - const: default
        - const: state_uhs
        - const: state_eint

>
>    pinctrl-0:
>      description:
> @@ -89,6 +104,11 @@ properties:
>        should contain uhs mode pin ctrl.
>      maxItems: 1
>
> +  pinctrl-2:
> +    description:
> +      should switch dat1 pin to GPIO mode.
> +    maxItems: 1
> +
>    assigned-clocks:
>      description:
>        PLL of the source clock.
> @@ -208,4 +228,32 @@ examples:
>          mediatek,hs400-cmd-resp-sel-rising;
>      };
>
> +    mmc3: mmc@11260000 {
> +        compatible = "mediatek,mt8173-mmc";
> +        reg = <0x11260000 0x1000>;
> +        clock-names = "source", "hclk";
> +        clocks = <&pericfg CLK_PERI_MSDC30_3>,
> +                 <&topckgen CLK_TOP_MSDC50_2_H_SEL>;
> +        interrupt-names = "msdc", "sdio_wakeup";
> +        interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_LOW 0>,
> +                     <&pio 23 IRQ_TYPE_LEVEL_LOW>;
> +        pinctrl-names = "default", "state_uhs", "state_eint";
> +        pinctrl-0 = <&mmc2_pins_default>;
> +        pinctrl-1 = <&mmc2_pins_uhs>;
> +        pinctrl-2 = <&mmc2_pins_eint>;
> +        bus-width = <4>;
> +        max-frequency = <200000000>;
> +        cap-sd-highspeed;
> +        sd-uhs-sdr104;
> +        keep-power-in-suspend;
> +        wakeup-source;
> +        cap-sdio-irq;
> +        no-mmc;
> +        no-sd;
> +        non-removable;
> +        vmmc-supply = <&sdio_fixed_3v3>;
> +        vqmmc-supply = <&mt6397_vgp3_reg>;
> +        mmc-pwrseq = <&wifi_pwrseq>;
> +    };
> +
>  ...
> --
> 2.25.1
>

Kind regards
Uffe
